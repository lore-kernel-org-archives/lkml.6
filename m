Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBHSTY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:19:24 -0500
Received: from fllnx210.ext.ti.com ([198.47.19.17]:62453 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:19:22 -0500
Subject: Re: [PATCH] gpiolib: suppress error message on EPROBE_DEFER
To: Linus Walleij <linus.walleij@linaro.org>,
        David Lechner <david@lechnology.com>
CC: <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1516566774-1786-1-git-send-email-david@lechnology.com>
 <CACRpkdbKWrdnbBp2e1kFd_3fYZxtWKnWPPgOd_FXSvXcOetLwA@mail.gmail.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <ee9d3352-6575-9e7b-d8d2-20caf609e0ef@ti.com>
Date: Thu, 8 Feb 2018 12:18:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbKWrdnbBp2e1kFd_3fYZxtWKnWPPgOd_FXSvXcOetLwA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.59.147]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2018 06:57 AM, Linus Walleij wrote:
> On Sun, Jan 21, 2018 at 9:32 PM, David Lechner <david@lechnology.com> wrote:
> 
>> This suppresses printing an error message during probe of gpio drivers
>> when the error is EPROBE_DEFER.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> I'm not sure about this.
> 
> GPIO can be very basic system components. If we don't
> print this, defer a few times (for some reason) and then
> the kernel gives up on retrying, silently (as it happens)
> there is no trace in dmesg of what happened. That makes
> things hard to debug.
> 
> This happened to me with some other driver, so it is not
> a made up example.
> 
> What about an explicit deferral message for now?
> 

The DD has debuging prints for all cases, so in general it can be used
for boot debugging (really_probe()). So, in my opinion it make sense to 
print gpiolib specific message only in case of !EPROBE_DEFER.

5c

-- 
regards,
-grygorii
