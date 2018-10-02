Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB7C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA092089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n9FCU1qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA092089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeJBP0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:26:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38192 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJBP0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:26:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so1309209wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pS2sZN7Q59sh8X96tfZBc9kwSl+jTGdPA860nux7XN0=;
        b=n9FCU1qrVBmX7yQKuZcBMhPsby8uQzkk+ojuTq/SFgxuu6NPb2zoa3vE4XHhcgRms+
         olYdwqBSKooS9Q4hrHr4cLBOQ5EkmJLtZF99+aY1ujTvDGbo2W55Usl8WO8DDdB7MXhs
         Df2r9szSKDED1Xma6c3UMECAAAgpGSZ7wVs8Co+KwJKPMO9BJYl3gjZ08A7ouMZhoqud
         qJi7sYzursU0sy016mGXEfMOSnSYv+RuZt4K51AMNEEHhSZe1QrIyVHLdJ6nqTzc+sft
         FIlLtno66u+z3hFFV+g3HgRfeyRdfmpJTmUA5Gt32axzchALFVDj5u7hpetZ4t7wjPDX
         iKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pS2sZN7Q59sh8X96tfZBc9kwSl+jTGdPA860nux7XN0=;
        b=r1p4NFNFmru8RVScABrtLer16gwP/k8YTWpeQNaFCvAMR3ryan02ktu0GQ1i8gtUNi
         uWRNXSkHW3UAU780bG/63274KFsTwxJ24a+FuVlFpx+uk8AHwDSfAWb8mE1RP6ScRHf4
         bvoESc4Sg74J6d9z2mXYbhMWxu76t+MrsgomCakIm+T2Ox6aefVf/IAH5WRzYDlkLAVR
         KwKzDnb5mIT9K3Gm4n020g+veuXR222X+mSZk4T6HlzkyOJINRqUky+lWVor2iA9oOFH
         tt8SWmzoNVVQXLKeGXq4g5lid/EMx4VLak0jmF8lI8eVF9Efkaj9OKv1dtx8RffucGMC
         ktjw==
X-Gm-Message-State: ABuFfohfQ2G4KuKHqhZHjaBBiau94YDKNWAYHVoVWQg4hD2KzVvTkGoq
        Uz6GF6NDG6mTHW5eDst83AArgF+1C48=
X-Google-Smtp-Source: ACcGV63mYUMTBIi0NSP36N+RoVqQeqbagJzAMl0E9Z5fc/GEubQa/FkjDz/DllZtDciSweHeggHEfA==
X-Received: by 2002:a1c:a015:: with SMTP id j21-v6mr1211791wme.78.1538469830094;
        Tue, 02 Oct 2018 01:43:50 -0700 (PDT)
Received: from boomer.baylibre.local ([2a01:e34:eeb6:4690:3146:aafc:91d9:4b96])
        by smtp.googlemail.com with ESMTPSA id 198-v6sm16162298wmm.0.2018.10.02.01.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:43:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] arm64: dts: meson-axg: s400: add missing emmc pwrseq
Date:   Tue,  2 Oct 2018 10:43:40 +0200
Message-Id: <20181002084341.5487-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002084341.5487-1-jbrunet@baylibre.com>
References: <20181002084341.5487-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eMMC pwrseq is defined in the s400 dts but not used in the emmc node.
This is probably just a copy/paste error

Fixes: 221cf34bac54 ("ARM64: dts: meson-axg: enable the eMMC controller")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d6467ac333ec..166ab598395e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -493,6 +493,8 @@
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 
+	mmc-pwrseq = <&emmc_pwrseq>;
+
 	vmmc-supply = <&vcc_3v3>;
 	vqmmc-supply = <&vddio_boot>;
 };
-- 
2.17.1

