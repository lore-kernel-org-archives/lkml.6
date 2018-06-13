Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D81F6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC74208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CdZlWwGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC74208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935717AbeFMUSq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:18:46 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43309 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935448AbeFMUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:18:45 -0400
Received: by mail-qk0-f193.google.com with SMTP id g126-v6so2319093qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p0rkZQmjU9x5Ctl1ta2mMSuAJuxsEwkNWeoLb+2oulU=;
        b=CdZlWwGNRoqzPC4TTElsoTT6vp5xKcA6uMtFR8U3ZW7lTv76ZkUJJVWgPjJ57RZob+
         x3qLHKOCMmJI1FKe7sJITnNWaGzHVd5/HzeEsu3hW7U4Lw3iW1B1FLyHSl0VsrWyO+gF
         KnE8PRt1bh3vQanXmeIrD0aaOs11lrgugMSsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p0rkZQmjU9x5Ctl1ta2mMSuAJuxsEwkNWeoLb+2oulU=;
        b=LjUe8EpXvDry/+iFdpxWcTr4ag558uw2lIe9wZZb+e7HW/T3zOdiGK2Ox6TrlsGv52
         wqV2xUw1Wh4hINfXO3P3XydJT5IsFPGaHvV1OgoQVAt+tWY1scLmqNBNXrudGT/wnp/L
         HCOCQJ1a+6BhF8vwpyhzUrCChNoza9vERCN3LGw+LP/WGzdiZ9Ox+OfXZTnH4sIi6h8s
         4BRfnx6ySpYRIdOfogbwNKlB7XCa4L1OX8/XcTYG8sNEPCLUC3FbjBFge3ZrHRvFVGWX
         LN0Co6mRYf0y9w5cTrV5CtFZX/0eTpnGxKmiXVe/lcWNkI0fesdzvjEW0N9Iaw1Ceb/b
         Huwg==
X-Gm-Message-State: APt69E2ljXCdVjxU85h2ejaWf3IxR5Uol3t7dYn9reqpy4SIOJPsIng7
        3ugrU6h57FEYHf+Rky2Tb5Ktd7Px
X-Google-Smtp-Source: ADUXVKI9o96qjT9IA317ukNuF9AQO/hTM+DAqRYsXQ9tAGBGT9O2A3I50Vt5rw6lZ9sriXacTn6TTA==
X-Received: by 2002:a37:9486:: with SMTP id w128-v6mr5915686qkd.119.1528921124126;
        Wed, 13 Jun 2018 13:18:44 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z135-v6sm3391798qkz.82.2018.06.13.13.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 13:18:43 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: stingray: use NUM_SATA to configure number of
 sata ports
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1526668446-20048-1-git-send-email-scott.branden@broadcom.com>
 <d35afa1f-e0fd-84f1-7d42-60595e22cc77@gmail.com>
 <395f1fe8-76f1-8310-d09e-63e25bca23d2@broadcom.com>
 <CAL_JsqJEFLXFf-Vq9c9XC41vBpisQwxkd06_v8Fmt6X=gp=2_g@mail.gmail.com>
 <f20222ea-47ac-ca05-a8d3-69f28932de94@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <0bf3c57c-dac8-8ece-6b8a-3b4d024140fc@broadcom.com>
Date:   Wed, 13 Jun 2018 13:18:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f20222ea-47ac-ca05-a8d3-69f28932de94@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for comment - reply inline.


On 18-06-13 12:31 PM, Florian Fainelli wrote:
> On 06/12/2018 03:54 PM, Rob Herring wrote:
>> On Thu, Jun 7, 2018 at 12:53 PM, Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>> Hi Rob,
>>>
>>> Could you please kindly comment on change below.
>>>
>>> It allows board variants to be added easily via a simple define for
>>> different number of SATA ports.
>>>
>>>
>>>
>>> On 18-06-04 09:22 AM, Florian Fainelli wrote:
>>>> On 05/18/2018 11:34 AM, Scott Branden wrote:
>>>>> Move remaining sata configuration to stingray-sata.dtsi and enable
>>>>> ports based on NUM_SATA defined.
>>>>> Now, all that needs to be done is define NUM_SATA per board.
>>>> Rob could you review this and let us know if this approach is okay or
>>>> not? Thank you!
>>>>
>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>> ---
>>>>> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>> b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>> index 8c68e0c..7f6d176 100644
>>>>> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
>>>>> @@ -43,7 +43,11 @@
>>>>>                          interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
>>>>>                          #address-cells = <1>;
>>>>>                          #size-cells = <0>;
>>>>> +#if (NUM_SATA > 0)
>>>>> +                       status = "okay";
>>>>> +#else
>>>>>                          status = "disabled";
>>>>> +#endif
>> This only works if ports are contiguously enabled (0-N). You might not
>> care, but it is not a pattern that works in general.
Correct - all board designs that include this dtsi file follow such 
commonality (ie. design with SATA0 first, etc).  By having common board 
designs it allows for commonality in dts files rather than duplicating 
information everywhere.  If somebody designs a bizarro board they are 
free to create their own dts file of course.
>>   And I'm not a fan
>> of C preprocessing in DT files in general beyond just defines for
>> single numbers.
The use of a define to specify the number of SATA ports in the board 
design meets our requirements of being able to maintain many boards.  We 
need a method to specify the number of ports in the board design rather 
than copying and pasting the information in many dts files.  If you have 
an alternative upstreamable mechanism to manage the configuration of 
many boards without copy and paste that would be ideal?
> Should we interpret this as a formal NAK?

