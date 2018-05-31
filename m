Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754924AbeEaMYS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:24:18 -0400
Received: from smtps.newmedia-net.de ([185.84.6.167]:58141 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754850AbeEaMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:24:14 -0400
Subject: Re: [PATCH 4.16 269/272] pinctrl: msm: Use dynamic GPIO numbering
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100302.722883806@linuxfoundation.org>
 <7c34ccef-2fa8-8b53-2677-29f6fbe71a04@dd-wrt.com>
 <20180531114553.GB11598@kroah.com>
 <d2ed4f7c-f97c-ba51-6f33-d329da69dbc6@dd-wrt.com>
 <510e5f2c-718a-de42-8274-9345d13e7797@codeaurora.org>
 <20180531121251.GA13561@kroah.com>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <59adffbd-117b-754f-af8d-e1188b4ceb17@dd-wrt.com>
Date: Thu, 31 May 2018 14:24:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531121251.GA13561@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 31.05.2018 um 14:12 schrieb Greg Kroah-Hartman:
> On Thu, May 31, 2018 at 06:55:55AM -0500, Timur Tabi wrote:
>> On 5/31/18 6:53 AM, Sebastian Gottschall wrote:
>>> i checked initially 4.9 with latest patches and 4.14 and reverted this
>>> line to get back to the old behaviour but a which view in the current
>>> 4.17 tree shows
>>> that the same patch has been included in 4.17. it was introduced in the
>>> kernel mainline on 12.feb 2018
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/pinctrl/qcom/pinctrl-msm.c?h=v4.17-rc7&id=a7aa75a2a7dba32594291a71c3704000a2fd7089
>> I believe that this patch should not be applied to *any* stable kernel.
>>
>> It completely breaks legacy GPIO numbering, and it does so intentionally.
>> That may be okay for future kernels, but IMHO it's wrong for older kernels.
> Why is it somehow ok for "future" kernels?  You can't break the api in
> the future for no reason.
>
> So this needs to be the same everywhere.  If it is broken in 4.17-rc, it
> needs to be reverted.
>
> thanks,
>
> greg k-h
i agree. i understand the reason why it was introduced, but the reason 
was a very special case which can be handled in a different way or 
specific for the affected architecture / device
and this patch alone cannot be introduced without further changes to 
device tree files which may assign those gpio numbers
i2c, leds etc. (a quick review of the current device tree files for qcom 
already showed me that they are likelly broken because of this change)

Sebastian

>
