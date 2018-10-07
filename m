Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04281C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC26620882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 12:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC26620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJGTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 15:17:45 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47317 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJGTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 15:17:45 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42Sj4b478Fz1qtfG;
        Sun,  7 Oct 2018 14:10:39 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42Sj4b3WbWz1qqkR;
        Sun,  7 Oct 2018 14:10:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MBFM1MsJIr6a; Sun,  7 Oct 2018 14:10:38 +0200 (CEST)
X-Auth-Info: PJbux57IreIQdtilU0Zv9F1N2yUmu53ww6xpckRAaxw=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  7 Oct 2018 14:10:38 +0200 (CEST)
Subject: Re: [PATCH 13/13] clocksource/drivers/dw_apb: Add reset control
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
 <1538750143-4282-13-git-send-email-daniel.lezcano@linaro.org>
 <alpine.DEB.2.21.1810061433170.5454@nanos.tec.linutronix.de>
 <5ebc1d90-2067-8cb5-0c93-1c9f0677abc5@linaro.org>
 <alpine.DEB.2.21.1810061907030.5454@nanos.tec.linutronix.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <d27e6960-5f59-4a81-09c2-8606f0bce344@denx.de>
Date:   Sun, 7 Oct 2018 14:10:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810061907030.5454@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2018 07:07 PM, Thomas Gleixner wrote:
> On Sat, 6 Oct 2018, Daniel Lezcano wrote:
> 
>> On 06/10/2018 14:34, Thomas Gleixner wrote:
>>> On Fri, 5 Oct 2018, Daniel Lezcano wrote:
>>>
>>>> From: Dinh Nguyen <dinguyen@kernel.org>
>>>>
>>>> Add code to retrieve the reset property from the dw-apb timers and if
>>>> the property is available, the safe operation is to assert the timer
>>>> into reset, and followed by a deassert of the timer reset (brings the
>>>> timer out of reset).
>>>>
>>>> This patch is needed for systems where the bootloader has left the timer
>>>> not used in reset.
>>>>
>>>>  - Trivial conflict with commit a74bd1ad7a:
>>>>     "Convert to using %pOFn instead of device_node.name"
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>>>
>>> Ingo just noticed, that this SOB chain is wrong. How is Marek involved
>>> here? Can you please fix that up and send me another pull request?
>>
>> Thomas,
>>
>> I will fix it as soon as possible but I would like to give the
>> opportunity to Dinh to explain why he sent the patch with Marek's SOB.
>>
>> Dinh ?
> 
> No rush.

I reported this to Dinh and gave him some prototype patches to start
with, since I didn't have the time to write a patch. You can change it
to Reported-by: if you want.

-- 
Best regards,
Marek Vasut
