Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F57BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF5A206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2aD1E/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF5A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeGRMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727657AbeGRMdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:33:02 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E189206B7;
        Wed, 18 Jul 2018 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531914928;
        bh=ARLBPSRED19opX/J5eG6aiA/T6T/uv0X9w4JnvWddPQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=e2aD1E/GJfHln7HyZyaDHe574sZttBHET7be7t/MALp4OlAR0DDybTp5PljxN6Pbm
         vUdxWTAKZ5JgouBuBkN6c+DyBYtOj8c5N+loT7RLN9x/B6sxg0ftFW/lgORbaWXPN+
         Sv98p+J0zNbBA2LDS9d78bZM1zMb1CkAllK2FIWc=
Received: by mail-wr1-f52.google.com with SMTP id t6-v6so4385730wrn.7;
        Wed, 18 Jul 2018 04:55:28 -0700 (PDT)
X-Gm-Message-State: AOUpUlFahsI7CzeyISOoshFqOe6O5WFPL5xSqArVX0TA/pzCzmzRRm9h
        +Cs2oKnHFPeSGuoXT1i+W/CClWUofa2Dv6N3dV8=
X-Google-Smtp-Source: AAOMgpeTm+h9bVv4/2anacZUNr3UKQxXMsYU35an/7VSEnj4pHLda9RHCqnBzh6lUKEnHq9ErsoDc6fxIKdtItIw1fc=
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr4339474wre.12.1531914926736;
 Wed, 18 Jul 2018 04:55:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 04:55:26
 -0700 (PDT)
In-Reply-To: <CANAwSgSaU1kTW3j0OZGwmOWo=p2uHFP8toLUe9FHYEkCJsuLFg@mail.gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
 <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com>
 <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com> <CANAwSgSaU1kTW3j0OZGwmOWo=p2uHFP8toLUe9FHYEkCJsuLFg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Jul 2018 13:55:26 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcwjNoZh+sOooCsUECXVAVraMmj2yHfrg22m=3mbQtVnQ@mail.gmail.com>
Message-ID: <CAJKOXPcwjNoZh+sOooCsUECXVAVraMmj2yHfrg22m=3mbQtVnQ@mail.gmail.com>
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

On 18 July 2018 at 12:50, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> On 18 July 2018 at 16:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 18 July 2018 at 12:30, Anand Moon <linux.amoon@gmail.com> wrote:
>>> Hi
>>>
>>> On 18 July 2018 at 15:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>> Add missing GIC interrupts property for pwm nodes.
>>>>>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>>>>  1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>>>>> index 5d2f0a0..9406108 100644
>>>>> --- a/arch/arm/boot/dts/exynos5.dtsi
>>>>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>>>>> @@ -169,6 +169,11 @@
>>>>>                 pwm: pwm@12dd0000 {
>>>>>                         compatible = "samsung,exynos4210-pwm";
>>>>>                         reg = <0x12DD0000 0x100>;
>>>>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>>>>
>>>> Indentation here looks weird - spaces used after tabs but not aligned
>>>> with first entry. Please indent it properly and align it.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> I ram checkpatch before I submit this patch it shown no error.
>>>
>>> # scripts/checkpatch.pl --no-signoff -q
>>> 0001-ARM-dts-exynos5-add-missing-interrupts-for-pwm-node.patch
>>
>> That's good, thank you. Still when I look at it in patchwork the
>> indentation is wrong:
>> https://patchwork.kernel.org/patch/10531753/
>> However it can be patchwork's fault, so are you sure that this is
>> properly indented and aligned?
>>
>> BR,
>> Krzysztof
>
> I prefer vim and I use following plugin
>
> https://github.com/vivien/vim-linux-coding-style
>
> root@odroidxu4:/usr/src/odroidxu4-4kr-devel# wget -nv
> https://patchwork.kernel.org/patch/10531753/mbox/ -O pwm.patch
> 2018-07-18 10:48:09
> URL:https://patchwork.kernel.org/patch/10531753/mbox/ [1460] ->
> "pwm.patch" [1]
> root@odroidxu4:/usr/src/odroidxu4-4kr-devel#
> root@odroidxu4:/usr/src/odroidxu4-4kr-devel# scripts/checkpatch.pl
> --no-signoff -q pwm.patch
> root@odroidxu4:/usr/src/odroidxu4-4kr-devel#
>
> Is their any other way to test checkpatch please let me know.

This is trivial thing and should be fixed after my first reply. But
clearly we need to waste some more time... so I applied the patch to
check whether patchwork shows it properly or not... and it is the
same. Indentation is wrong.

Please fix the weird alignment. You have existing examples in the DTSI
file (rtc node) how to do it. Current indentation is clearly wrong -
why using spaces after tab if this is not aligned properly?

Best regards,
Krzysztof
