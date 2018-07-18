Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F45ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE52075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Td9WMxiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCE52075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeGRL2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:28:08 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33265 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:28:08 -0400
Received: by mail-oi0-f67.google.com with SMTP id l10-v6so7924720oii.0;
        Wed, 18 Jul 2018 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IvOEaa9J33iQNTIg0S9j2eVP/OZiEaPalHl/G/zfs8g=;
        b=Td9WMxiBbNZIBtIh8+N9hf3DnbJXP7+madERMsWykRBWuBwNOUZB8+RDYDuQ4Lm83j
         poqOwRqe1XhCn9YJrY9JZNSu+mdCFwQcAmznDJmPV1cfBvC1WExNFoPhYP92LM7/vnP4
         7wd6mtHCPDaN5jmFXxq6ck3CG0LdHmRUSRZ89KQDGWH86ZnRPSeGtdW6vl55q74gYiSc
         fQJ7h1y3FCuv48Z5SlxN25Yi9Cgd2ZV3aYp+6SSCNEgc3bIduiu+sm5r9+jyFp2hvr7z
         c9kOerZRzAyGOz4SxoBhQIOaQipOs52dSAJBAYwArGtnrbr814P002l4NYM6tRUtA1YF
         eW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IvOEaa9J33iQNTIg0S9j2eVP/OZiEaPalHl/G/zfs8g=;
        b=p39BLVSCHJU2OXDliXFJZrTXuaRzAyCgNuzwo9ET56xMmFpbIP9+l5NNbsdaCnN6py
         Yg45uZPW35EV9ARY6COPecP0Aek1mtEe2HbHNPg8fz5eJK3W2tWTGpCbMYXEOXLhBKnq
         /04QQSDiVTt3WLjo/q9HutP8ZJRrpXqfo4aHQyX80xD7F4iE9lwEhXk5rYyDQmugnM1C
         IeurrimYS1Cf4CBgvngZzB5O0xqC+Z3spFhShPLoNZmv9lmSh2o9dsXmQ68UVNNmGri4
         TMYcXOZltl6Y9ZZyCDh/bBzSwxftSgDFu8uvVqtRetFP+9gaITILALSFWyP3YhUTfzZd
         wUvw==
X-Gm-Message-State: AOUpUlFBX4G7ndNe/VV3tBnncI8jXPyHlU74a/o1/oXosOesRH4zWrLr
        gIcCMc79WaIv31QSBPNU2GUt5rlCRyjugJv5KNE=
X-Google-Smtp-Source: AAOMgpfHMkrlDceSETNHtv12HSLJg8ixvo2uQl7SGoVT7i9vfTdSGC5twd5PBQb/vBzJlo/aSoL94EzhscrgPNanbnQ=
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr5283627oif.165.1531911048924;
 Wed, 18 Jul 2018 03:50:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:50:28
 -0700 (PDT)
In-Reply-To: <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
 <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com> <CAJKOXPez6cuLyrxBkAKtyx2xiqG7VLWFCBYXkBX_537A=bDpsg@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 16:20:28 +0530
Message-ID: <CANAwSgSaU1kTW3j0OZGwmOWo=p2uHFP8toLUe9FHYEkCJsuLFg@mail.gmail.com>
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

Hi Krzysztof,

On 18 July 2018 at 16:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18 July 2018 at 12:30, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi
>>
>> On 18 July 2018 at 15:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
>>>> Add missing GIC interrupts property for pwm nodes.
>>>>
>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>> ---
>>>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>>>> index 5d2f0a0..9406108 100644
>>>> --- a/arch/arm/boot/dts/exynos5.dtsi
>>>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>>>> @@ -169,6 +169,11 @@
>>>>                 pwm: pwm@12dd0000 {
>>>>                         compatible = "samsung,exynos4210-pwm";
>>>>                         reg = <0x12DD0000 0x100>;
>>>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>>>
>>> Indentation here looks weird - spaces used after tabs but not aligned
>>> with first entry. Please indent it properly and align it.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I ram checkpatch before I submit this patch it shown no error.
>>
>> # scripts/checkpatch.pl --no-signoff -q
>> 0001-ARM-dts-exynos5-add-missing-interrupts-for-pwm-node.patch
>
> That's good, thank you. Still when I look at it in patchwork the
> indentation is wrong:
> https://patchwork.kernel.org/patch/10531753/
> However it can be patchwork's fault, so are you sure that this is
> properly indented and aligned?
>
> BR,
> Krzysztof

I prefer vim and I use following plugin

https://github.com/vivien/vim-linux-coding-style

root@odroidxu4:/usr/src/odroidxu4-4kr-devel# wget -nv
https://patchwork.kernel.org/patch/10531753/mbox/ -O pwm.patch
2018-07-18 10:48:09
URL:https://patchwork.kernel.org/patch/10531753/mbox/ [1460] ->
"pwm.patch" [1]
root@odroidxu4:/usr/src/odroidxu4-4kr-devel#
root@odroidxu4:/usr/src/odroidxu4-4kr-devel# scripts/checkpatch.pl
--no-signoff -q pwm.patch
root@odroidxu4:/usr/src/odroidxu4-4kr-devel#

Is their any other way to test checkpatch please let me know.

Best Regards
-Anand
