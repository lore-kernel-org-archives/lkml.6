Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A6EECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF1E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Khbsyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF1E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeGRLHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:07:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39853 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbeGRLHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:07:40 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so7809263oib.6;
        Wed, 18 Jul 2018 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xbqe8WWR50Hiwt5LXmoYXyHFNgGwsepoXpwpxu9+MXU=;
        b=c+KhbsyyhA60DzoysuC3pSx4XE5EeLfLoxS5iJ+II3/qUJW51evM7wtV0oOZ4Shk+A
         QNSq1WWOFpG9d+KKG4yXQO0SYQxEpCaQJdLyuWV8nFvo0sgMoHgPGLYKmag7bD1ZghEc
         +oYcdBs2usioEs3HWvNrBnM8RrXmpqL/4wDQoqlrjDKMvtUPk4UGkvZ01Sf5vK0nkvSx
         g1apst1KjkznH+W0YwD6BDAZ+Rzq/sjhIvuDLkm7sXcctIfWnWfymZnCPABgJzmei0L+
         TguNNtjlzglurbWNmnuOX2c2nEr3BxeLphKdoCngd8O5s4ZZn/bwmAowDUnP+lXsVQ+w
         kGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xbqe8WWR50Hiwt5LXmoYXyHFNgGwsepoXpwpxu9+MXU=;
        b=UIfZm6/wTcTxy262R2l7Lkr/QGo23e8nrqbQ/SBTiETByxQJ++rW6shrLDczsrWq+r
         bKPSG4r0BVztRvc1OLerlGTRu0UxfYKvck9MBqegpFBAx/S4NZeoKF8uv06Au5EQICRA
         Z3iXOPVSSB6HJoADvLHF+WOuQHM8VjTArAlqhFvN2kwHHczz89RCz+mAwXf/diIlLVTs
         3BgtKgvoyomPFnBou6Tuywv0mEU4ecWFwGINnvUhyZXPdOoLFS3i7x+NVML7gh6MIudO
         bgkcWtWg3vh4J7OlVIGLzrEi+lixKgQu3q54e0BQyKg6jZ3WzNs1s5Q9lBJvEmlH55oK
         RPwQ==
X-Gm-Message-State: AOUpUlFb2beMPn5KVepFzgFPFdbr2jEEfRoedj7ZH4hrheNfqEORgrtR
        ATremU0d/Gx+zpM/QK8pqTfTLeJ/rslvXpYgUYg=
X-Google-Smtp-Source: AAOMgpc6Rz6qxHO6B3s3gf1RhW4YF/fBMtw2kLaWNHP6L01MIcBPEjAInRKIDIH5hTsxxKtS+UvcNNRUylhdE5LQZLE=
X-Received: by 2002:aca:bf07:: with SMTP id p7-v6mr6087373oif.285.1531909825118;
 Wed, 18 Jul 2018 03:30:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:30:04
 -0700 (PDT)
In-Reply-To: <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
References: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com> <CAJKOXPdeRvt4YG9Doziq-_oQ9DeUffvTB53OOaq-q2UpkBGpgQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 16:00:04 +0530
Message-ID: <CANAwSgS8z-TQ=nK7dy5YeA8QJV+7cCctZKJT7qn8macQQkyKqg@mail.gmail.com>
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

Hi

On 18 July 2018 at 15:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 18 July 2018 at 11:34, Anand Moon <linux.amoon@gmail.com> wrote:
>> Add missing GIC interrupts property for pwm nodes.
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos5.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
>> index 5d2f0a0..9406108 100644
>> --- a/arch/arm/boot/dts/exynos5.dtsi
>> +++ b/arch/arm/boot/dts/exynos5.dtsi
>> @@ -169,6 +169,11 @@
>>                 pwm: pwm@12dd0000 {
>>                         compatible = "samsung,exynos4210-pwm";
>>                         reg = <0x12DD0000 0x100>;
>> +                       interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>
> Indentation here looks weird - spaces used after tabs but not aligned
> with first entry. Please indent it properly and align it.
>
> Best regards,
> Krzysztof

I ram checkpatch before I submit this patch it shown no error.

# scripts/checkpatch.pl --no-signoff -q
0001-ARM-dts-exynos5-add-missing-interrupts-for-pwm-node.patch

Best Regards
-Anand
>
>> +                                  <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
>> +                                  <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
>>                         samsung,pwm-outputs = <0>, <1>, <2>, <3>;
>>                         #pwm-cells = <3>;
>>                 };
>> --
>> 2.7.4
>>
