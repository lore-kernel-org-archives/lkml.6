Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD93ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A1420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AOE454XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A1420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbeGXN7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40495 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388577AbeGXN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so4023417wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZoW7tDEHOwM7FMVB/pZ2Q+lx/K2BNqjMFw7CiedEjxk=;
        b=AOE454XWr42iUS6OtAcMoi118Duje0TQBsA4drZSzUd+3uFxbzHRSgMDcdFdFy7CiN
         EVQcATOf6GtlDdrO5x0kNfI8w4Yj0wb/obAWNW462Hnii2s49EvgEweXjiZeOjPo8KSr
         TJQArFri53XeLy1f4TiDj+2MSieKC6aKKuSLHKwkHVGN2SLz+TgKRARwLib6qXwMEKPk
         QWLO+QnNclUOguMi0zZtQe4ez3CNbYs/KQtOWdyTnxtYLeRSGeS88M+YjUMPUGT1B8xx
         9z2h44q8cNEAmexI+ptW2VVkS7qFGXSE2oZqNvWjCAQsiG4An9egYiv8b/SnzKMaegi9
         ZKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZoW7tDEHOwM7FMVB/pZ2Q+lx/K2BNqjMFw7CiedEjxk=;
        b=FDulqa9KfYpxmtHXh0rguzE8EZUhOTG1Yy2L+KYUU9fNttarbAdwYgq0QlUDvdkxKE
         ITgjq6y/MJyytC9P+5q2VEKGxIL6WQMlrEu/13m074IxrTuIvUC0M6tQJcPFadtg7Vla
         h5yECNHoa6MjjYeWg6xV4YmPRV5rUDayKgmohy05XbatW2Pu+M2XIMt59u8SjoP5DoUh
         fcoZkps1/awMzMlFBARIEEaa90Z4G48vuUVOK4lCdX7r55opOeYe2zEd76Lyu38cdW91
         xKP+ADHe24vhGV+arXx03La1YwPqAgM3sxPDqDP3aTG2uOok2rB6TuolVIpc3ZUIlbds
         PRNA==
X-Gm-Message-State: AOUpUlG1/Gcv3+VwORrq6tCU4W2z8W9VWtRSo5XeRN2BRtaAXhf/aq/I
        531ttuGCYDQKgfvPti3UNPbMPQ==
X-Google-Smtp-Source: AAOMgpczwN2pQxACdTcr9H4c0DYWKJmeAxCDL7GdPAh7unI9hFI/1EZwZ54ftpFsT/wh9ZaL1GgLjw==
X-Received: by 2002:a5d:550a:: with SMTP id b10-v6mr12029208wrv.228.1532436783016;
        Tue, 24 Jul 2018 05:53:03 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:53:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] arm64: dts: meson-axg: add lineout codec
Date:   Tue, 24 Jul 2018 14:52:35 +0200
Message-Id: <20180724125238.14567-12-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the es7154 digital to analog converter which supplies the
lienout jack of the s400

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index fb101a1c6660..d318647c86a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -188,6 +188,15 @@
 		status = "okay";
 		sound-name-prefix = "Linein";
 	};
+
+	lineout: audio-codec@1 {
+		#sound-dai-cells = <0>;
+		compatible = "everest,es7154";
+		VDD-supply = <&vcc_3v3>;
+		PVDD-supply = <&vcc_5v>;
+		status = "okay";
+		sound-name-prefix = "Lineout";
+	};
 };
 
 &ethmac {
-- 
2.17.1

