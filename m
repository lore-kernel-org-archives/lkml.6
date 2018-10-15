Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7373CC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D101208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q1xQdC63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D101208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeJPAOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:14:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56027 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJPAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:14:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so19572443wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 09:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+DyCxkj+D/g7NE4kKGpBjPKPVkzXiIpmqo3AIhGxDvM=;
        b=Q1xQdC63nkv6Lh/d80Fpmmwk8rPAcqvT2R4JV4asJhxrT5+680VrX463iwZQPcc3bN
         HHrKEfRhP6Yjm2s8AVXSpkqdtoaDoE9Bl1RJkr+rAfjEwneBrFxIhU50+67dmlpIs+5+
         69BZ8FIQd4k+aO0pPqxtmaIqbYjRRT5mJDsxnOmzXGu5TwLzjCRn5FI5d3C/kmkEj8II
         25ik4hFFAIaf0B/Js+N6nx1Owe2/JlNNTlUtxtd6i5Ua2Wbh5qOPmFNIhJ+i0k7NYcF2
         vs9mczhvEV4BniFaFakU1bvvjMDR4019JC3L79E15NGuEgKGlhiAdQkK+KjyAL5pWfRq
         +w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+DyCxkj+D/g7NE4kKGpBjPKPVkzXiIpmqo3AIhGxDvM=;
        b=eGoEUsHhLiQcLaMz6QteP6BGxhmQ/x3nJjtQpF5iMjzQaYl5hjrs0sfDSKFYqKgJve
         1Vl9EwK8o95oeYaz9TvaY7Ae2nWFAHkunzTHqJZdQ/P5k+pupn7I+pXoHZ0bFctP1Zqo
         gqfeHI7EM5KBWRYfyiAvjb2wDaObUDUJqxdbrr1njycHOGORkO04vCeRrJXQea12M/AK
         UC//n04QFqrQ4YNWs9s6FYsKzPpsYN7XAYOvSOlAU84isqvoTy3hnOzvgbKnbR7Jde1E
         vWzU61nSvCg/z+wch/QZx6IU7TEMCHLD4kD0rX+tqq3E2DgR5jPvvIQQBm2DbbAe9t5d
         SFNw==
X-Gm-Message-State: ABuFfohtVv8SVqf7qdYMEMf/3C0FafROcuXcbqEBSL6KDKIC1B7iLpY4
        gd4R1oKGBEYP5pqVakQGp57c82+rU7E=
X-Google-Smtp-Source: ACcGV62HkoxUQ52H1Yx+hYWGE8YWRM+J61hf8qEgi6ROI98JdikzSqYHqzy7yNxJkTXhrgJ2D+6sjw==
X-Received: by 2002:a1c:1dc8:: with SMTP id d191-v6mr13325599wmd.27.1539620921040;
        Mon, 15 Oct 2018 09:28:41 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c8-v6sm14045926wrb.6.2018.10.15.09.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 09:28:40 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] arm64: dts: meson-axg: drop FW reserved memory
Date:   Mon, 15 Oct 2018 18:28:33 +0200
Message-Id: <20181015162833.7544-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181015162833.7544-1-jbrunet@baylibre.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axg does not require the FW memory region for all we know.
This seems to be something we carried for the gx family for no
reason.

Fixes: 9d59b708500f ("arm64: dts: meson-axg: add initial A113D SoC DT support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 06a06f11f114..d1beedc4fb0e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -13,9 +13,6 @@
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
-/* 16 MiB reserved for Hardware ROM Firmware */
-/memreserve/ 0x0 0x1000000;
-
 /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
 /memreserve/ 0x05000000 0x300000;
 
-- 
2.17.2

