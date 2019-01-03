Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED160C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA11217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HGabXCDW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="naRRG8wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfACMXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:23:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfACMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:23:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B51D06034F; Thu,  3 Jan 2019 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546518186;
        bh=2nvMDgbJ5HiVhx5IP5Vy/JFtFgrGVBS/dPaHd4VB2xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HGabXCDWEX19/J3zHd0ftaOTSxqVWrs9ic8OQ3Dd/6X4hmZ1OsHZOiI7GRpZQoIG4
         IXIOJhB0bKNnA4jYNE5SmlmKsfR9UQYOwHtHA6qKMdM6HFSR/FH4ZQ99nREP/Q8Ncr
         6k3X3OnEsr1wqaluQwJwv1Ot2rojWHwDQ4/rmzmY=
Received: from [10.242.6.12] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 092776034F;
        Thu,  3 Jan 2019 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546518185;
        bh=2nvMDgbJ5HiVhx5IP5Vy/JFtFgrGVBS/dPaHd4VB2xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=naRRG8wJ6MgtdtW2kZ8GWBMlRssZh2y7Zc1osF2M8QMNBLr6KwdPlx6oL18SG/P1l
         x8h06IyuAQZ8Bp/TyRHdkyCbSxbXQ3/g0MWC0i2vFYU7hrd+w+fDvdjYpZWhdIdEXQ
         1TD1mQuX1pl+V8tdaUpt+eBTg93UkxEvX0bVeaaI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 092776034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm
 SoCs
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
 <20181221115946.10095-4-rplsssn@codeaurora.org>
 <154546438942.179992.14851496143150245966@swboyd.mtv.corp.google.com>
 <504cae51-0f35-beb8-496b-a335863a9071@codeaurora.org>
 <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <b97937a0-68ff-ded7-d63b-680981818114@codeaurora.org>
Date:   Thu, 3 Jan 2019 17:52:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <154603310752.179992.9262815873457262616@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/29/2018 3:08 AM, Stephen Boyd wrote:
> Quoting Raju P L S S S N (2018-12-26 01:44:43)
>>
>>
>> On 12/22/2018 1:09 PM, Stephen Boyd wrote:
>>>> +If an RSC needs to program next wake-up in the PDC timer, it must specify the
>>>> +binding as child node with the following properties:
>>>> +
>>>> +Properties:
>>>> +- compatible:
>>>> +    Usage: required
>>>> +       Value type: <string>
>>>> +       Definition: must be "qcom,pdc-timer".
>>>> +
>>>> +- reg:
>>>> +    Usage: required
>>>> +       Value type: <prop-encoded-array>
>>>> +       Definition: Specifies the offset of the control register.
>>>> +
>>>>    Example 1:
>>>>    
>>>>    For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
>>>> @@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
>>>>                         <0x179d0000 0x10000>,
>>>>                         <0x179e0000 0x10000>;
>>>>                   reg-names = "drv-0", "drv-1", "drv-2";
>>>> +               #address-cells = <1>;
>>>> +               #size-cells = <1>;
>>>> +               ranges;
>>>>                   interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>>>>                                <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>>>>                                <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>>>> @@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
>>>>                                     <SLEEP_TCS   3>,
>>>>                                     <WAKE_TCS    3>,
>>>>                                     <CONTROL_TCS 1>;
>>>> +
>>>> +               pdc_timer@38 {
>>>> +                       compatible = "qcom,pdc-timer";
>>>> +                       reg = <0x38 0x1>,
>>>> +                             <0x40 0x1>;
>>> I don't understand this whole binding. Why can't the pdc timer be
>>> programmed within the rpmh driver? This looks like a node is being added
>>> as a child just to make a platform driver and device match up in the
>>> linux kernel. And that in turn causes a regmap to need to be created?
>>> Sorry, it just looks really bad.
>>
>>
>> There are two RSC devices in SoC one for application processor subsystem
>> & other display subsystem. Both RSC contain registers for PDC timers
>> (one for each subsystem).
> 
> When is the timer programmed on the display subsystem's RSC? It's hard
> to give advice without all the information.

For display subsystem RSC, hardware sleep solver takes care of timer 
programming for wakeup when the subsystem goes to Power collapse.

> 
>> But only for application processor the PDC
>> timer needs to be programmed when application processor enters
>> sleep/suspend. As the driver is common between both RSC devices, this
>> approach is taken. Do you have any other suggestions to distinguish
>> between the two? Perhaps, by additional compatible string?
>>
> 
> Maybe compatible? I sort of doubt it though. Do all RSCs have a PDC
> timer?

Yes. all RSCs have their own PDC timer.

> 
> I would think that it would make sense for the application processor's
> RSC timer to be programmed from the broadcast timer mechanism in the
> kernel so that timers during idle work and suspend turns off the timer
> appropriately with a shutdown hook. I guess the PDC can't tell you the
> time though? It looks like a shadow (and limited) version of the ARM
> architected MMIO timer that we already program for the broadcast timer
> mechanism. Is that because even the MMIO timer can't wakeup the system
> in deep idle?  Assuming that's true, it means the ARM MMIO timer can't
> always be used as the system wide broadcast mechanism because we need to
> augment it with the PDC timer to get the actual wakeup.
> 

Yes. this is correct.

> Maybe we should be adding hooks into the broadcast timer mechanism to
> program this wakeup event hardware in addition to the ARM MMIO timer. Or
> we should stop using the ARM MMIO timer on these systems and read the
> system register based physical time in the RSC timer driver and register
> this 64-bit PDC register as the broadcast timer. So the time reading
> would be through sysreg and the wakeup programming would be done by
> writing the PDC timer. The assumption would be that we have access to
> the physical time registers (which sounds like the assumption we have to
> make).

There are no physical timer registers available in RSC for this purpose.

> 
> Do we get an interrupt somewhere from the RSC hardware when the timer
> fires? Or does that just cause a system wakeup event without any pending
> irq and then another irq (like the ARM architected timer) just happens
> to be pending around the same time? If we get an interrupt somehow then
> I would prefer to drop the ARM MMIO timer and do this hybrid broadcast
> timer approach.

There is no interrupt for PDC timeout. It just causes system wakeup 
without a pending irq. ARM MMIO is necessary for irq.

> 
> How the RSC is used in general by other devices, like display, is not
> clear to me. We don't have a "wakeup event" framework in the kernel that
> device drivers like the display driver can grab a reference to and
> program some system wide wakeup for. That sounds like something new that
> could be handled entirely in the display driver with direct register
> writes, or it could be some qcom specific API/framework that eventually
> calls down into the same RSC driver that knows what offsets to write
> into in the display RSC's register space, or it could be an entirely
> generic framework like clk or regulator frameworks that could be used by
> anything. BTW, are we using the display RSC yet?
> 

Only display subsystem RSC is programmed along with CPU RSC in Linux. 
display RSC instance is not present in upstream but it is present in 
downstream and used for resource communication purpose only.
