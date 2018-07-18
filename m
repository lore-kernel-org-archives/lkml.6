Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3042075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+OOI/CC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbeGRNm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:42:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42440 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeGRNm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:42:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id n84-v6so8587363oib.9;
        Wed, 18 Jul 2018 06:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sSVEHYUmsVrybpMB+wBIp2il+XXiP8KsV8SHPRv7vzo=;
        b=Y+OOI/CCY31AfHSV0Wd297WYBup5KBJM3MRsNSVpIvo2JYOuQHHBqK012nWesJsuHc
         IuOUynCLeD1JdwGFwYQAXTepEkFSGnO5/cE+OuZl38kUALCyvyKl1Xw8CQPIU0OWwOU2
         gVQUy6hQf7n2ixHvfPDKFYB1dwRGn6/MUb/o3KSve5zCgV+IatT0NqsxD01voe2Kg38s
         B9HK2I6zm5wTUBCtjs4GSytk6axHbmcSAoGmX2QnLSb+V7sYXb7tPQw+LLmVwS+kKHCG
         C8bgcsWREOQo5+B4e27+KZ1M0RzBdBgH6tak4gEHVJewenbunkzb5+nfuApZeg44CGON
         HdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sSVEHYUmsVrybpMB+wBIp2il+XXiP8KsV8SHPRv7vzo=;
        b=F0YavwJjv4PGZUZ+g1tjDAyjxNOUx7F10lj83p7A4mHt7d1sT/DBJk5NN5NHOMvIv8
         FwdM/b2iRszPUQfa0ogGemj4j/c/ia36+0De0GeciuIi+qkRBbz69dauw+0+PsrvFmB2
         NiVALfE/vHDgr5PU2ByaRnyIoFywzk8Y4eqtybv8ILUKy96iRriGealVzOuEo1EeicME
         J2hI7otNZfxbEwIZN0MeVxDsWiV/cGbclM/9f4INww4MAp4OJzWSbeVaNiP2nvkuF/wc
         zwm5IP7EWxMphTR5KtJpxRR99ZrffF/o7iPxUG4B9xHVWmkjXRNEAmFy4plv2tSGZf68
         Q6zg==
X-Gm-Message-State: AOUpUlHDs2nrS25Kddof/JVEry7F+UYxNk4JhilCuzVYEfqTmx3tOnhY
        k3oZQL1kcWCSkJvRjCvIMNdPKEtwYhM/ZtAXHPQ=
X-Google-Smtp-Source: AAOMgpfSya7MpWwZxKLOclBWm2o7txvd1DjVwgQMBSmf/t7qwGCA4h36sCBWC7GZuv7IxVKLq4U3NfoqUr/BgNVxg7Y=
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr5714237oif.165.1531919107292;
 Wed, 18 Jul 2018 06:05:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 06:04:46
 -0700 (PDT)
In-Reply-To: <CAJKOXPcwjNoZh+sOooCsUECXVAVraMmj2yHfrg22m=3mbQtVnQ@mail.gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
 <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com>
 <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
 <CANAwSgSaU1kTW3j0OZGwmOWo=p2uHFP8toLUe9FHYEkCJsuLFg@mail.gmail.com> <CAJKOXPcwjNoZh+sOooCsUECXVAVraMmj2yHfrg22m=3mbQtVnQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 18:34:46 +0530
Message-ID: <CANAwSgTCcKyVaE_HoKMP8hN_iQacZMtWZgWyjR8=mkwVZyEzaw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos5: add missing interrupts for pwm node
To:     Krzysztof Kozlowski <krzk@kernel.org>
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

Hi Krzysztof

On 18 July 2018 at 17:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18 July 2018 at 12:50, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof,
>>
>> On 18 July 2018 at 16:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On 18 July 2018 at 12:30, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> Hi
>>>>
>>>> On 18 July 2018 at 15:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>>> On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>>> Add missing GIC interrupts property for pwm nodes.
>>>>>>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>> ---
>>>>>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>>>>>  1 file changed, 5 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>>>>>> index 5d2f0a0..9406108 100644
>>>>>> --- a/arch/arm/boot/dts/exynos5.dtsi
>>>>>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>>>>>> @@ -169,6 +169,11 @@
>>>>>>                 pwm: pwm@12dd0000 {
>>>>>>                         compatible = "samsung,exynos4210-pwm";
>>>>>>                         reg = <0x12DD0000 0x100>;
>>>>>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>>>>>> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>>>>>
>>>>> Indentation here looks weird - spaces used after tabs but not aligned
>>>>> with first entry. Please indent it properly and align it.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>> I ram checkpatch before I submit this patch it shown no error.
>>>>
>>>> # scripts/checkpatch.pl --no-signoff -q
>>>> 0001-ARM-dts-exynos5-add-missing-interrupts-for-pwm-node.patch
>>>
>>> That's good, thank you. Still when I look at it in patchwork the
>>> indentation is wrong:
>>> https://patchwork.kernel.org/patch/10531753/
>>> However it can be patchwork's fault, so are you sure that this is
>>> properly indented and aligned?
>>>
>>> BR,
>>> Krzysztof
>>
>> I prefer vim and I use following plugin
>>
>> https://github.com/vivien/vim-linux-coding-style
>>
>> root@odroidxu4:/usr/src/odroidxu4-4kr-devel# wget -nv
>> https://patchwork.kernel.org/patch/10531753/mbox/ -O pwm.patch
>> 2018-07-18 10:48:09
>> URL:https://patchwork.kernel.org/patch/10531753/mbox/ [1460] ->
>> "pwm.patch" [1]
>> root@odroidxu4:/usr/src/odroidxu4-4kr-devel#
>> root@odroidxu4:/usr/src/odroidxu4-4kr-devel# scripts/checkpatch.pl
>> --no-signoff -q pwm.patch
>> root@odroidxu4:/usr/src/odroidxu4-4kr-devel#
>>
>> Is their any other way to test checkpatch please let me know.
>
> This is trivial thing and should be fixed after my first reply. But
> clearly we need to waste some more time... so I applied the patch to
> check whether patchwork shows it properly or not... and it is the
> same. Indentation is wrong.
>
> Please fix the weird alignment. You have existing examples in the DTSI
> file (rtc node) how to do it. Current indentation is clearly wrong -
> why using spaces after tab if this is not aligned properly?
>
> Best regards,
> Krzysztof

Opps sorry I have send v2 patch
https://patchwork.kernel.org/patch/10532443/ with proper fix.

I will do strict check next time before sending the patch.

Best Regards
-Anand
