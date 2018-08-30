Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60C92082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jlRYLnxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60C92082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeH3OzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:55:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34901 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeH3OzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:55:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so1549887wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 03:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=CKrJWVZjt+m43B/o4oVpcN4jEyC0Mugy3enMuOZhC1A=;
        b=jlRYLnxYtRKkxxLvEjudpwfszESxOYsTm8Npj69TP0cnt9w5nn8A1Xv4LjUgju8vc2
         tv4V2tuA/0OlCp0okjsVuRDocSJbNTLt5goAfnXNwDnjBYShfrmlJLR86m8NBd8mcPr6
         jW38wqnUJ69iclHmAC+EUKcz7GsFM1yAoFzuNO7IaY7JfM988wj22yzy22eJgDzFqC8t
         eRsM2MDgm45EhX4Z9DZvr6eZokr47fLyHGPM+d01ylKAwMM+Gys2BRCX7Ou5tnUqHvIh
         KxrwZsECsSIpaMtBk2DveSuHQ0liIX2SodL1NlKprHfvgUheO1y8dsyha/R9RtXRb+8u
         Skcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CKrJWVZjt+m43B/o4oVpcN4jEyC0Mugy3enMuOZhC1A=;
        b=OSSFfGHVkEO4NUyBwJfdSNOp+GYRh3o6CagBLzBiU4+EE8wENVrOBgVN4anEkgWOr/
         GRLW/4GJ+w9VzYTgADL4nHvU5HRCk3Dseev7NtO4UZcIGVV29qCDcONPgXaA9Cfeg9QL
         uSOrk2UKHhcl27Ovd8eq/XupGS14+bb0v/IrkbVFmQbnSp2ywcauVrtanAfPzrjtYjyz
         DpNbZtkt97yqbfgtWuKGaSr3uU3+Gsx/4L0WuHoUeSZYAesFgO9kM7yw05K5GohD2TuX
         9q651qW6vB1z6wycLHZCgMmO2iJBdZqBE+r0zbb3VqeX1R5EqphA/d+JQEpvWEfflAS8
         XcQQ==
X-Gm-Message-State: APzg51CEyNfqV5dz9mvQUSgnOLRq0UGfmVBsCvUlxZprXEaJMNVO3FD6
        lOiyB6SAkv7fhFGyVFFTG6Fzaw==
X-Google-Smtp-Source: ANB0Vda3lCLphi4na13oO2ImufOIcuIgoP+VxlFvnrNJMtDN0dhc1ktS/lNqjyw9OCRvHj+oWQJmoA==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr1395294wmc.80.1535626409286;
        Thu, 30 Aug 2018 03:53:29 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 66-v6sm2646121wmw.34.2018.08.30.03.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 03:53:28 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: meson: libretech: update board model
Date:   Thu, 30 Aug 2018 12:53:17 +0200
Message-Id: <20180830105317.9337-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is actually several different libretech board with the CC suffix
so the model name is not appropriate here. Update to something more
specific

Reported-by: Da Xue <da@lessconfused.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index f63bceb88caa..90a56af967a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -13,7 +13,7 @@
 
 / {
 	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
-	model = "Libre Technology CC";
+	model = "Libre Computer Board AML-S905X-CC";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.17.1

