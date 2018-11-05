Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D42720827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/byX9g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D42720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbeKEXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:18:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34195 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeKEXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:18:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so9658601wre.1;
        Mon, 05 Nov 2018 05:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6RAs5aD4iXQg+kqYwWqQq8sMSvMKqEkoLr8Ekuk71o=;
        b=d/byX9g+GV7JUPtjt5cIYEtoGCgTVW7PEHdW9trGsA8jZFOJdJ920Vp+40TuzHLbRT
         x9gasup53fbtZ0GJYxLT86i9sSpbri6g5c8XLmkbHDWinLNSKGPrVumQMAx1+nyOhzt1
         6zCaA7Kgji0C52eAWNBVfq/y/YMFyma1G8JphlDI7NwS21IXAoy9xouHCIlUaC0+oRCn
         gSZJjG4mX6bZpc4CMV1glacAraPOepVygjjGvSA9Lbuz79R4VBQ3BV5zLdAQ1HFMeyyq
         AlGkBU/QaQQOPLTKApcg0C1brGrXgrzGHyHBGoQG74QhCtvDUGj2Jjs9y8re/IOYYXNv
         vefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y6RAs5aD4iXQg+kqYwWqQq8sMSvMKqEkoLr8Ekuk71o=;
        b=MZg/Qf2E5zkYcyhtD+5ee4z5sA39kpaDZqeHRfOapPtHnYSOZ7JXgXYtOPVOER4dyI
         lP1TlRHX0bmqfDfvNyRCZ2CC4ElAR1rieLDLe04XNsnH+zsBkHCYao/F7Y4lVSIyS7HK
         HbUkVvmBxpx1QA4FKAhf5XqzsHy21/en2dOj9NuaQODkgqBTv747N5Rp/425X/bl9Mcp
         fMueEsX6SnYYIJRyAVfVHq5hFBIHwy2pZ5pamze3NXAyPAd9jffaCu5rhi7hMkVoPGng
         OLuHbHjiN9nPxS5DpWH/c9f1UJyqJk2Vi4lyaT6wjPwzVQngvM/onip4wkZA7/NP9ByO
         gslA==
X-Gm-Message-State: AGRZ1gJNdkhcT8UMhVKczvptu/YW74td0T4BVzNjr6ad//zAfv+jX8nS
        vunx+Oss9tjiA3vcybuKk6rDgZSHqBz6Fw==
X-Google-Smtp-Source: AJdET5c+/x5Nk/S+Y3yhZygAXZZ8iEycGbRJioVtNpIkbgvvDkHcbcgzw/6kDnyjHjg/XY66u8PRTw==
X-Received: by 2002:adf:fb12:: with SMTP id c18-v6mr19898319wrr.200.1541426290237;
        Mon, 05 Nov 2018 05:58:10 -0800 (PST)
Received: from localhost.localdomain (static-css-cqn-141161.business.bouyguestelecom.com. [176.149.141.161])
        by smtp.gmail.com with ESMTPSA id i10-v6sm9812243wrr.69.2018.11.05.05.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 05:58:09 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     NXP Linux Team <linux-imx@nxp.com>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Colin Didier <colin.didier@devialet.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
Date:   Mon,  5 Nov 2018 14:58:02 +0100
Message-Id: <20181105135802.30486-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

The MX6 Audmux differs from MX51.

This patch adds the audmux for i.MX6 family.

Signed-off-by: Colin Didier <colin.didier@devialet.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 include/dt-bindings/sound/fsl-imx-audmux.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/sound/fsl-imx-audmux.h b/include/dt-bindings/sound/fsl-imx-audmux.h
index 15f138bebe16..a1d0741d9ed1 100644
--- a/include/dt-bindings/sound/fsl-imx-audmux.h
+++ b/include/dt-bindings/sound/fsl-imx-audmux.h
@@ -25,6 +25,14 @@
 #define MX51_AUDMUX_PORT6		5
 #define MX51_AUDMUX_PORT7		6
 
+#define MX6_AUDMUX_PORT1_SSI1		0
+#define MX6_AUDMUX_PORT2_SSI2		1
+#define MX6_AUDMUX_PORT3		2
+#define MX6_AUDMUX_PORT4		3
+#define MX6_AUDMUX_PORT5		4
+#define MX6_AUDMUX_PORT6		5
+#define MX6_AUDMUX_PORT7_SSI3		6
+
 /*
  * TFCSEL/RFCSEL (i.MX27) or TFSEL/TCSEL/RFSEL/RCSEL (i.MX31/51/53/6Q)
  * can be sourced from Rx/Tx.
-- 
2.19.1

