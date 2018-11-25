Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC44C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2CE20850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2CE20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeKZHJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:09:49 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46837 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKZHJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:09:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so15366940qtm.13
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=QnL2OremohOEUPldTDZtDEOowFjMCnmFdnBBXp000dM=;
        b=aFRQNQsmVfJSiQfWHSk6NupvSq5NqfzW0dVAgv48GSoyTardaMG7oV8YaXjDdTSTvl
         6oCZ1QDb0rtZ/yhAnhgGXaiOSuChOG0Pzp9wWBaPdkMaWhqvP1s8HZGvlVYxwOnAMbD0
         nm/KRsFwvLONQ/IQuhEQ5/ww5rMK5cv+2o4ytNwjNGPcSPhaqyA3pwwyeJVc4eF6SL9S
         nHj5Usp8zI0qMjQUVrAvhPqF1aMky9s32xGONpwnSDYjY0+slVudhw0MSDBb6KqJeDNG
         o3ndvQNaTUlxgVT4F0UasQthN8zw9svUwOVJXa8lvYQNBlQlH0R8PD39vpSbyCf3XSo0
         wMqQ==
X-Gm-Message-State: AA+aEWZ7jEtOVwVIo/gfkwqFAEBV72BkA0jBZc8CKEJ8vwZBMrDizQ4i
        PYn3rM9ifeQz6ubi+FJe+5c=
X-Google-Smtp-Source: AFSGD/XWAJXLYLEHTtw3s6s44VIr44fUqn+ntAO91CeS3XeTg3Xaf3VviZl4J3xeUb78cywuVYYp/Q==
X-Received: by 2002:a0c:f90e:: with SMTP id v14mr20932143qvn.199.1543177076569;
        Sun, 25 Nov 2018 12:17:56 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id f189sm19022207qkb.4.2018.11.25.12.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 12:17:55 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 18:17:50 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andreas=20M=C3=BCller?= <schnitzeltony@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable USB_ANNOUNCE_NEW_DEVICES
Date:   Sun, 25 Nov 2018 18:17:29 -0200
Message-Id: <20181125201729.19836-3-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125201729.19836-1-otavio@ossystems.com.br>
References: <20181125201729.19836-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Müller <schnitzeltony@gmail.com>

This is very helpful debugging USB issues.

Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 22ad2d7a1cf2..d339913845fa 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -305,6 +305,7 @@ CONFIG_SND_SOC_WM8962=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_STORAGE=y
-- 
2.19.1

