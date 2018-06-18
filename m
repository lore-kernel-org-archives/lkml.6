Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281EFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C729E20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIhotTdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C729E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936020AbeFRTF3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935857AbeFRTF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:05:28 -0400
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com [209.85.128.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4242086A;
        Mon, 18 Jun 2018 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529348727;
        bh=q+JCc3nCOeQU5YreKVd1Uppc4/n6kfwqaBdrnhIJBKI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QIhotTdKukWIE9HFlZc4mVi2RQ+J5eOMq2duU6JOP+P31haYiUYwJmerrAW2QO7tt
         KtCrX0ObHwT8jBNi9U8rRittZWQwt6J9Pu58z+4UV697bs79iRiZdybNGy7pmkPaK9
         kp0R9w2ltlpGrSM5z1Z7Gf2pkTyW/SEjmn1KkkoQ=
Received: by mail-wr0-f179.google.com with SMTP id a12-v6so17979675wro.1;
        Mon, 18 Jun 2018 12:05:27 -0700 (PDT)
X-Gm-Message-State: APt69E0H6vb8B17FhV7IKqk+nFR/ZCnlz/fqJi4Xyrn/mE9PBnmLA6W8
        Zw6cMKHoh9lwn+G2dunqyq67mtg9XxEDxDY8L6A=
X-Google-Smtp-Source: ADUXVKKpuV9pCdsEd0Qv3N6KmQU64Q8zCNpN6rHKYnEBDXuJl7dVCKLmAZdZsfam7mY475eDtyQdUuDpadB9wgL/trU=
X-Received: by 2002:adf:ea0f:: with SMTP id q15-v6mr12311512wrm.9.1529348725584;
 Mon, 18 Jun 2018 12:05:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 12:05:25
 -0700 (PDT)
In-Reply-To: <6755acb72649a712bd16cee4cab92f1aa63b70b9.camel@perches.com>
References: <20180618174216.24801-1-krzk@kernel.org> <6755acb72649a712bd16cee4cab92f1aa63b70b9.camel@perches.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 18 Jun 2018 21:05:25 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdBA=GR=ymtmULRghCO22jsDLw-49O1Yq6F6dk1oNZ=_w@mail.gmail.com>
Message-ID: <CAJKOXPdBA=GR=ymtmULRghCO22jsDLw-49O1Yq6F6dk1oNZ=_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: Remove leading 0x from unit
 addresses in Exynos5433
To:     Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2018 at 19:57, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-06-18 at 19:42 +0200, Krzysztof Kozlowski wrote:
>> Remove leading 0x from recently introduced unit addresses to fix DTC
>> warnings:
>>
>>     Warning (unit_address_format): /soc/sysmmu@0x15040000: unit name should not have leading "0x"
> []
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> []
>> @@ -1171,7 +1171,7 @@
>>                       power-domains = <&pd_gscl>;
>>               };
>>
>> -             sysmmu_scaler_0: sysmmu@0x15040000 {
>> +             sysmmu_scaler_0: sysmmu@15040000 {
>>                       compatible = "samsung,exynos-sysmmu";
>>                       reg = <0x15040000 0x1000>;
>>                       interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
>> @@ -1182,7 +1182,7 @@
>>                       power-domains = <&pd_mscl>;
>>               };
>>
>> -             sysmmu_scaler_1: sysmmu@0x15050000 {
>> +             sysmmu_scaler_1: sysmmu@15050000 {
>>                       compatible = "samsung,exynos-sysmmu";
>>                       reg = <0x15050000 0x1000>;
>>                       interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
>
> Presumably these 3 other entries too?
>
> $ git grep -P "\b\w+:\s+\w+@0x" -- "*.dt*"
> arch/arc/boot/dts/abilis_tb10x.dtsi:            spi0: spi@0xFE010000 {
> arch/arc/boot/dts/abilis_tb10x.dtsi:            spi1: spi@0xFE011000 {
> arch/arc/boot/dts/vdk_axs10x_mb.dtsi:   uio_ev: uio@0xD0000000 {

True. That's an "arc" but  I can fix it as well with your reported-by.

Best regards,
Krzysztof
