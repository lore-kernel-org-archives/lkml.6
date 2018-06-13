Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6109DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E84208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAgFeKtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E84208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935626AbeFMWHP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:07:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45776 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935320AbeFMWHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:07:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so4278521wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f6l9yr9JlSw7cERWR4Z64M+8MjRoW8W6SwMmqHoeltU=;
        b=kAgFeKtPfcORz//JBte6hr8ZqH3nck1t2HtrwQUz0K39p+4nbyNXAgBWX+IYPRIxcL
         9grGJ/NnnSA4wdHMsNXXEv+bRNI1aQXukLx0p9POQTDaUzbP3kMpKDzthfUE49oySTiB
         TmPj4ENdt9nCV6gq6inZw8tCUdQmbJFPbPs1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f6l9yr9JlSw7cERWR4Z64M+8MjRoW8W6SwMmqHoeltU=;
        b=TE5CvMXT5LMCef9j2mWNcvMsI2HCaDRKjveRRl5uA13Res2iLvlkiXwR6VadvTR3S1
         u5d1FJFxU6MUPAxExrAW3Be/OA3vD+XlPEUMBjQ8bY9+6jEMCrX3h4l3YQIDbt8+zFA+
         vyxTFzSIywT1VAfXhJJiDFVSwlnwzfxPISdq5GylPtWAjYZl90i8fjRGBUQcIw3YzPbT
         JQU1Nwof1jrVzfUiDHj+4cpdi7koS6grSKQQ2GYNDAnSuxl6C8Jbh3+MIs1DFdj6r/zI
         g9kDElwvXFh3EFhNeEvcwehwp4PGfaYk7blFUR6q9Bc+1Ny9mmSKChF+dXi7PDA/brrE
         8MUQ==
X-Gm-Message-State: APt69E2sSmj6WDejQkToUYotlYEGyZmgsSxFTpiq2XnF0uQheOH/ICaK
        JgPjzcNgxH2ptbGYw68uD/ziodAjVrejBDDMCcaV6w==
X-Google-Smtp-Source: ADUXVKINDGKGy3J8RCWe3CFGfclraqbRr1RjbnNUtlIK8n2X44v/nHHL6xwgvUr5QAWuLbv/iS2BtgV3EvyQsjt63a4=
X-Received: by 2002:adf:9405:: with SMTP id 5-v6mr6028332wrq.283.1528927631558;
 Wed, 13 Jun 2018 15:07:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:47d1:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 15:06:51
 -0700 (PDT)
In-Reply-To: <0bf3c57c-dac8-8ece-6b8a-3b4d024140fc@broadcom.com>
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com> <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
 <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
 <f20222ea-47ac-ca05-a8d3-69f28932de94@gmail.com> <0bf3c57c-dac8-8ece-6b8a-3b4d024140fc@broadcom.com>
From:   Rob Herring <rob.herring@linaro.org>
Date:   Wed, 13 Jun 2018 16:06:51 -0600
Message-ID: <CABGGiszcTNw23e_qA7EiGb_2hc6kHfVQJq02pQjbpTnv1CNksg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 2:18 PM, Scott Branden
<scott.branden@broadcom.com> wrote:
> Hi Rob,
>
> Thanks for comment - reply inline.
>
>
>
> On 18-06-13 12:31 PM, Florian Fainelli wrote:
>>
>> On 06/12/2018 03:54 PM, Rob Herring wrote:
>>>
>>> On Thu, Jun 7, 2018 at 12:53 PM, Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> Could you please kindly comment on change below.
>>>>
>>>> It allows board variants to be added easily via a simple define for
>>>> different number of SATA ports.
>>>>
>>>>
>>>>
>>>> On 18-06-04 09:22 AM, Florian Fainelli wrote:
>>>>>
>>>>> On 05/18/2018 11:34 AM, Scott Branden wrote:
>>>>>>
>>>>>> Move remaining sata configuration to stingray-sata.dtsi and enable
>>>>>> ports based on NUM_SATA defined.
>>>>>> Now, all that needs to be done is define NUM_SATA per board.
>>>>>
>>>>> Rob could you review this and let us know if this approach is okay or
>>>>> not? Thank you!
>>>>>
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>>> ---
>>>>>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> index 8c68e0c..7f6d176 100644
>>>>>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>>> @@ -43,7 +43,11 @@
>>>>>>                          interrupts = <GIC_SPI 321
>>>>>> IRQ_TYPE_LEVEL_HIGH>;
>>>>>>                          #address-cells = <1>;
>>>>>>                          #size-cells = <0>;
>>>>>> +#if (NUM_SATA > 0)
>>>>>> +                       status = "okay";
>>>>>> +#else
>>>>>>                          status = "disabled";
>>>>>> +#endif
>>>
>>> This only works if ports are contiguously enabled (0-N). You might not
>>> care, but it is not a pattern that works in general.
>
> Correct - all board designs that include this dtsi file follow such
> commonality (ie. design with SATA0 first, etc).  By having common board
> designs it allows for commonality in dts files rather than duplicating
> information everywhere.  If somebody designs a bizarro board they are free
> to create their own dts file of course.
>>>
>>>   And I'm not a fan
>>> of C preprocessing in DT files in general beyond just defines for
>>> single numbers.
>
> The use of a define to specify the number of SATA ports in the board design
> meets our requirements of being able to maintain many boards.  We need a
> method to specify the number of ports in the board design rather than
> copying and pasting the information in many dts files.  If you have an
> alternative upstreamable mechanism to manage the configuration of many
> boards without copy and paste that would be ideal?

Is this really the only problem with maintaining lots of boards? What
about all the other nodes that are conditionally enabled? Really, I
don't see the problem with 3 lines per node.

Does having an unused port enabled cause problems? If not, you could
handle it all at run-time and just shutdown ports which have no link.
You'd want to do that anyway for boards with a port, but is not
connected to a drive (except for hotplug capable ports).

Maybe we could add a property in /chosen that is a list of nodes to
enable and either the bootloader or kernel could update their
'status'. Or It could even be done in dtc perhaps with some
/directive/.

Rob
