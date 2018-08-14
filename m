Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02CBC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BEE216F9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="w/cgflmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BEE216F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeHNOpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 10:45:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35053 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeHNOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 10:45:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id g1-v6so16989173wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Isxb/gF2fOU6ZDtTeLSDFj2cxJadUmGrdteaOoCW+6g=;
        b=w/cgflmgSjRpJVTY448y3oDI7e/RMlDEV30GvzLic3DCbiuigISo8xKiUQbUH3MDLZ
         AZMly5AYEptHU2h3Xwi/Fzv/UDiHwUYuttt07VTOixpMrAcCd6CS/FfTwNi4J6UytH8L
         7rAr2M82pFA+sXb+u8rZHAElvQNdUeHl4RyDP478x9MLNaIy3gLw+D5LptIk/grVgq5x
         xAZKz8yWZ37/Dvu9zj9HIX/1Zt4GipMbmYDvunhARP/Z4ZQX4sXoVD8RVXntk0U8843w
         XqqTAP4OMt+JSCXCGNOqzp3LfdLaG1tIe9Ty6ci+PuxwSrY794nkB5vAj3A2S2CeQTMI
         XyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Isxb/gF2fOU6ZDtTeLSDFj2cxJadUmGrdteaOoCW+6g=;
        b=GXTo44+a5T5WWG5hcUOwmAuAuXL0shrOrfVy61HycNq/mnhuU7r5Lf2VhGQG8wtJcQ
         p54/GO0YTT2svvKuJBO1fUeDYFBVV6Glc9chzSmuCHAiYnw6DH7/vRRHUcZn/fBULZwf
         N0QEzkkAL2GghwuQsMIQC7FXQ332X6cDp0e91nRz0PN3NLQH0yUvwH6jye2G3tIaMUaX
         rZ/2WUNL7dAcnMJvq+kG3dmg1Os6UCZcI/0YQCH9m35kINttuielMLCP8aszwAw0A44O
         GUUFR8PzGeAeDqUkoi5MTqA1jgppT49X6v9z2g4YuWTZ6WirxIAxs7TlaB51vaj4lbU/
         vZpA==
X-Gm-Message-State: AOUpUlFi8/a4HfKCCzNsTUfPTbSEMFW/xzccvjKcE7PnNGtU4n8VePFq
        MwOEwXCqCqg+QVu1IgWoVN7ceQ==
X-Google-Smtp-Source: AA+uWPz1TVrEZyinn1WWDJCJ3kSR5nFHR5OwyMGJo7/tBlDZh1gqYnH0D+wn+/4B9wYLRmb683Z8+g==
X-Received: by 2002:adf:84e5:: with SMTP id 92-v6mr13273129wrg.56.1534247923364;
        Tue, 14 Aug 2018 04:58:43 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f6-v6sm22701125wrw.78.2018.08.14.04.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 04:58:42 -0700 (PDT)
Message-ID: <170648ffb748c7b3890f5d7293920873efd16e30.camel@baylibre.com>
Subject: Re: [PATCH v3 0/2] arm64: dts: meson-g12a: Introduce new DT files
 for Meson-G12A SoC
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Aug 2018 13:58:41 +0200
In-Reply-To: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
References: <1534243121-33589-1-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 18:38 +0800, Jianxin Pan wrote:
> This attempt will try to add new DT files to support Meson-G12A SoC.
> 
> 1) first, Please notice that, in this patch series, the DT node about 16M reserved
> memory for hwrom is removed, since it's not needed by G12A SoC.
> 2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
> merged. In this version, it rely on bootloader to enable the pclk gate which 
> belong to AO clock domain. Please add clk_ignore_unused to bootargs.
> 
> Changes since v2 [1]:
>  - reorder subnodes
>  - collect Rob's Reviewed-by
> 
> Changes since v1 [0]:
>  - fix signoff typo
>  - order subnodes by addresses when there is one and alphabetically when there is none
> 
> [0] https://lore.kernel.org/lkml/1533802951-49919-2-git-send-email-jianxin.pan@amlogic.com/
> 
> Jianxin Pan (2):
>   dt-bindings: arm: amlogic: Add Meson G12A binding
>   arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support
> 
>  Documentation/devicetree/bindings/arm/amlogic.txt |   6 +
>  arch/arm64/boot/dts/amlogic/Makefile              |   1 +
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts   |  22 +++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 172 ++++++++++++++++++++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> 

Series looks good as far as I can tell

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

