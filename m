Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A63ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC302075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ84vEKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC302075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbeGRLKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbeGRLKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:10:30 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D77920852;
        Wed, 18 Jul 2018 10:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531909995;
        bh=Xa+3wS0rqsulZ0B4tlI/1ECjIKhqtc8b+TSD452PNAk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=BZ84vEKMAv+hRkny63m46eN+8R2sbpOqseWJ92GKY4d7C4xwenHHvveRmyFPnzq3v
         g4f2Y+a2TS5l1RMhpMqPjw3+HToasOAM74byIVyFkEc/2Wu8tkYmgZiiLZPEmT1jts
         IVhTmJ1jGy+CDrsB1Jt5JqldCA9MC2P0kaiTl8pA=
Received: by mail-wm0-f45.google.com with SMTP id z13-v6so2306724wma.5;
        Wed, 18 Jul 2018 03:33:15 -0700 (PDT)
X-Gm-Message-State: AOUpUlGra/GyBKeNTcb9Ad3ylSx3r/BhrH9Lgh+eqAVxVnjG4/4clown
        MrAYelD5Y5BJWnEfuVhRJmMDC1mA2MCpi1MYfkU=
X-Google-Smtp-Source: AAOMgpdgmaGAWM1UngZccURC9ae8oKgVzKP5V6PToG0lb3IoZfEFlDzga7IKK1v6Ywn6G43WjfaIEVnVVgJsPME473Y=
X-Received: by 2002:a1c:588d:: with SMTP id m135-v6mr1200237wmb.118.1531909993977;
 Wed, 18 Jul 2018 03:33:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:33:13
 -0700 (PDT)
In-Reply-To: <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com> <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 12:33:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
Message-ID: <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos5: add missing interrupts for pwm node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 12:30, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi
>
> On 18 July 2018 at 15:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
>>> Add missing GIC interrupts property for pwm nodes.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>>> index 5d2f0a0..9406108 100644
>>> --- a/arch/arm/boot/dts/exynos5.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>>> @@ -169,6 +169,11 @@
>>>                 pwm: pwm@12dd0000 {
>>>                         compatible = "samsung,exynos4210-pwm";
>>>                         reg = <0x12DD0000 0x100>;
>>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>>> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>>
>> Indentation here looks weird - spaces used after tabs but not aligned
>> with first entry. Please indent it properly and align it.
>>
>> Best regards,
>> Krzysztof
>
> I ram checkpatch before I submit this patch it shown no error.
>
> # scripts/checkpatch.pl --no-signoff -q
> 0001-ARM-dts-exynos5-add-missing-interrupts-for-pwm-node.patch

That's good, thank you. Still when I look at it in patchwork the
indentation is wrong:
https://patchwork.kernel.org/patch/10531753/
However it can be patchwork's fault, so are you sure that this is
properly indented and aligned?

BR,
Krzysztof
