Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeBRDri (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 22:47:38 -0500
Received: from vern.gendns.com ([206.190.152.46]:56200 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbeBRDrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 22:47:36 -0500
Subject: Re: [PATCH] gpiolib: suppress error message on EPROBE_DEFER
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1516566774-1786-1-git-send-email-david@lechnology.com>
 <CACRpkdbKWrdnbBp2e1kFd_3fYZxtWKnWPPgOd_FXSvXcOetLwA@mail.gmail.com>
From: David Lechner <david@lechnology.com>
Message-ID: <7efffc52-1332-5d98-e6b8-634d5ee9082e@lechnology.com>
Date: Sat, 17 Feb 2018 21:47:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdbKWrdnbBp2e1kFd_3fYZxtWKnWPPgOd_FXSvXcOetLwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

so you mean something like this?

if (err == -EPROBE_DEFER)
	dev_info(dev, "deferring probe\n")
else
	dev_err(dev, "... failed to register\n")
