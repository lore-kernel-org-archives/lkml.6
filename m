Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE7AECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9C02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ixaCXTTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9C02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeGRMSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:18:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34860 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbeGRMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:18:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id y22-v6so2552187wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=izcyTHjVSvupM88B7jzkZYtB2wlViVYkqS9+G9yAw+M=;
        b=ixaCXTTlfxE3WAU9rDq5QLpNj3zrnMxEr+R1xWcg2ZtlrLxmx5YlkPYKBr3dVondOf
         EsWgJ2QiRUqE/DwNGDDHdGKWSkGKMDAI8QCJj3dWwGK9k3fZCB5TlryvrLS8LH2InDYC
         aij6igP8q6dklKtcYzTm71XNdyImtvdbYFZYHbGxYzlW9Ub8af0TPDqoF/365FWQ4c1J
         KtuzkO3n+vpTnlNpwr8OvFzmDv2EbIufsGSQ1ZvYbJxxZhi550Gk174ic4NSk4jWveCS
         Uelwygk4Hxeh8CaAj3wntvU8AlBZB/mUTsPgkduTZmG1Cv9V0negtTNdhLld6gvvLF9E
         pGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=izcyTHjVSvupM88B7jzkZYtB2wlViVYkqS9+G9yAw+M=;
        b=goMAXNeqZ0+ujcSRdTm0zFIIEKU/kPh5AoKgWmxAiG+BXCuzGTx6C6WSCY/LKl/BsT
         5rJjRG7+2GPMp9LXHd43s0X9yHzB+NoCIlI1wpRVJ6bTlxWZE/UiobxRcVdjuyo/8noS
         u07MFUZfzQTRxzONLfsl16y1YsN126Qt6mDoMrikEsyIANo43pGwQwJeYjRwE8DGXXCP
         SLNIW2CA6TxG7INPTt3sGntnC2WZwYHUQBaOmBV5RI6dVflvUj9aKw5TKH5GAWlcHeoi
         LfGX3tUfdzT3FosYTDrI/kkIU2xnoq+FjwmHaOTZNBB9UCAhiAnCNX7mYcj7j7fZ/GA5
         aCfA==
X-Gm-Message-State: AOUpUlGkfvN7fQewfNuobG+z56X7DB4zs6klmX+v71ensmYXvPVRQnNI
        EvHoWpTAXvIcPBSrR7FbuuF8Cw==
X-Google-Smtp-Source: AAOMgpf76TA/Jf4yugylffWxRV51h1/qtcgL3NtcPHWB60CdxjH0DXoKZa1/2YJvHB7w6sysLiBydA==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr1365466wma.63.1531914051232;
        Wed, 18 Jul 2018 04:40:51 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y102-v6sm3805129wmh.9.2018.07.18.04.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 04:40:50 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 0/5] ARM: dts: sunxi: Remove unused address-cells/size-cells of dwmac-sun8i
Date:   Wed, 18 Jul 2018 11:40:36 +0000
Message-Id: <1531914041-14751-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Changes since V1:
- splited patch

Corentin Labbe (5):
  dt-bindings: net: dwmac-sun8i: Remove unused address-cells/size-cells
  ARM: dts: sunxi-h3-h5: Remove unused address-cells/size-cells of
    dwmac-sun8i
  ARM: dts: sun8i: a83t: Remove unused address-cells/size-cells of
    dwmac-sun8i
  ARM: dts: sun8i: r40: Remove unused address-cells/size-cells of
    dwmac-sun8i
  ARM64: dts: sun50i: a64: Remove unused address-cells/size-cells of
    dwmac-sun8i

 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
 arch/arm/boot/dts/sun8i-a83t.dtsi                     | 2 --
 arch/arm/boot/dts/sun8i-r40.dtsi                      | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                    | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 --
 5 files changed, 16 deletions(-)

-- 
2.16.4

