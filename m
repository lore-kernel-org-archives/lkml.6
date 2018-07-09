Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C7C20846
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aWqOcYFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C7C20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933445AbeGITxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:53:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932812AbeGITwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:52:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so12147836wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=iRJvUo7y+trIw6Ij6xaQA9BX+C2BP/pIePWrUmIBS5o=;
        b=aWqOcYFBqQNdZcWMowwUvyrFlngUSsRdnAleiF0DL6nweH+ANwFrijOSks514yEdZb
         LtS2QVaXWL9mJPFeuHmP9Ytyoc9RyFcGbG9XeLBh5V6QrPHClauJ3l30OXvqoAFoDzzi
         p9V390jo4X+IAAzXS6cwl6LITVGcLTundoYCmKepeh9nPq98ihFRI7XGCiZsYQ5uHeJL
         qo3ybrem3rv9GbnqTqgJ5VxmQ/OAW37uAQ6vPsUvVisTAxP4mfoOWIpQ4SIz60jX9vN9
         UT140w6XkmX/6rUOhZ92DQJ76TTfKswLT910snYQU7PRY4ClCeQLoH0xjCG/9ccBeVW5
         hkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iRJvUo7y+trIw6Ij6xaQA9BX+C2BP/pIePWrUmIBS5o=;
        b=ePznVMYKafMSWEnoiUKvAYGoHadXVoPuTHd8WAYwtEr+GhwIMYR7hNUlFyEZ4Ee8aX
         iVnzuVKvCuWFMjop2u+64VnEerL0gHOqjpY9MAjuuLDbxHrFp/WfE0uCqJ+BdAip18cx
         8NB/lxjbr5H2br4JUCc1lvFGZhFmZr3rYiskxV1Nby1sRWT6MFWmcH+52inLbvmwkKci
         67eGAGWR33OqCz0ZzSgugXOb3/c8laEkzIO4wnArGu3A3qNK+sPgrcaBjqkqKoTfsvwA
         9aBW4vwjWFD9xzLvUVLC6EysKJ+cn/+oUbf5qSFw1kiK6Z75iI1bJPq3j0b4zsdMrMRR
         EoMQ==
X-Gm-Message-State: APt69E0XhyMEXzfaTxDE3w33+Y/AcESlWbncREPMtShcDiVO78jiAQrk
        WdaMWlTuPk8w1O9oCvEaCa3+zw==
X-Google-Smtp-Source: AAOMgper02JhoQEtuwOPHHR8W4EvgL96hLcPe8ds4l3TmXnmSy5L7H0/v4PJon1KjvqGd1ZTxOwHMA==
X-Received: by 2002:adf:d181:: with SMTP id h1-v6mr15269652wri.198.1531165920327;
        Mon, 09 Jul 2018 12:52:00 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm22427203wrf.40.2018.07.09.12.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 12:51:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: sun8i: sun8i-a83t-bananapi-m3: enhance vcc-pd to 3.3v
Date:   Mon,  9 Jul 2018 19:51:54 +0000
Message-Id: <1531165914-29760-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes")
my BPIM3 no longer works at gigabit speed.

With the default setting, dldo3 is regulated at 2.9v which seems
sufficient for the PHy but d7c5f6863550 drop it to 2.5 which is insufficient.
Note that this behaviour is random for all BPIM3 (some works with 2.5, some not)

Finnaly, someone from bananapi confirmed that this regulator must be set to 3.3

Fixes: d7c5f6863550 ("ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index c7ce4158d6c8..f250b20af493 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -309,8 +309,8 @@
 
 &reg_dldo3 {
 	regulator-always-on;
-	regulator-min-microvolt = <2500000>;
-	regulator-max-microvolt = <2500000>;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-pd";
 };
 
-- 
2.16.4

