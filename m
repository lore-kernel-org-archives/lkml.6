Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7750DECDFBB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3247820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZGKMHQAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3247820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbeGXN70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38419 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbeGXN70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so4041702wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mVRCK+7cWQFa/gNtCERWlH7JS/Y1WJliUSLYPLdXC1A=;
        b=ZGKMHQADoxsS5yZfBWMMj3HQ+Ui4rI2Vo7dbRmCzvo02TNyhsechoUv91qItmczhO+
         as9ztn2aXI7HLwZx/nFsggPs6DVvwf28R9P247qreXb7GPsnr5njUNphuaRbwR3bFOqA
         fGohZRGt0sf90bZBH3/yNHSzirbXzcwCDeWIORX5VvknYwHV7eGV06rGzS9kQt17+Xt6
         TR4F3y/C6DMVh3sMfnh1PSOBaoFhRMi2Gr4f/FORVV2hSYlhcihZ7lK1Rhw8pBaXC4XK
         E6tCnzujFEqKvShKzMrXFtmTNynY9VXX66B+rYrlIQo05dBJs+O0nc0ryAxa3VYSVWpY
         pctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mVRCK+7cWQFa/gNtCERWlH7JS/Y1WJliUSLYPLdXC1A=;
        b=G2LfsaiGC3iLTFFMMpURa/K0+Huxmjz2AM6UCOHU/k6vF0o55+qGf10CvVNRzZojCS
         78f5f+tkjfcGrc/BfCIw9Po/yDcx1uMI+0re3EaPfhseIOON4EdtOvFsWlnZdOUZRWmz
         rAaAf4GrbV0k4L+o0g2CUhWhbdO/BjKrVyKXGIjk2qeJuzgwCRwhptqCN4mTqa6EBDbI
         NTsfQupocZjlCxU9SPg6o+NpcomtzXJ15FKThoijNQUqM9PGT6L+M5HYCU81B7R8/wQ1
         txwaDDc0qup7Y4CIyKPJIZRe4zOh52/a4PH9Ngnh9icbYDkANfewtULI74z05/kFX+2L
         TmzA==
X-Gm-Message-State: AOUpUlE7SUy2AfX0zIHQ9dKmHRYQw8JOx58YSMnRGTRelzGnQi0cthxL
        leUmGli70VBqrm+kiQOC/3fGcg==
X-Google-Smtp-Source: AAOMgpff/wTKlsZDKBN0khbOl8oUSJkBiPbDuMXrZmeGNnJSukoAyB4jeMo01QoBJ6gmBTZjX8WIJw==
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr11378417wri.199.1532436784156;
        Tue, 24 Jul 2018 05:53:04 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:53:03 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] arm64: dts: meson-axg: add spdif-dit codec
Date:   Tue, 24 Jul 2018 14:52:36 +0200
Message-Id: <20180724125238.14567-13-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDIF playback codec to the axg s400 board

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d318647c86a7..d5c01427a5ca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -197,6 +197,13 @@
 		status = "okay";
 		sound-name-prefix = "Lineout";
 	};
+
+	spdif_dit: audio-codec@2 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
 };
 
 &ethmac {
-- 
2.17.1

