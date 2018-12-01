Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A6C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64082081C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 19:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64082081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725760AbeLBGw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:52:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33785 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeLBGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:52:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so9718469qtp.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 11:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=/ajnalSAA6pd9cW5HRXqO/GPHHuYdwVc+EbjogDyZtI=;
        b=OH0+F4ajKnO/S+oLNL1WQ4MgU9IxSdZ81i5tHykOZXYGyYFLYt3O53VV28+Dkr9LIX
         d5SSbYWvcj7IUvq1hg7eOrryNUvAST43vVPrw1Yv85c3KRfmmbMnyEWMi6eiSJDq/dPD
         0IuY8ryhHZeedJjoetYFmagCn6BIVbfZ84IJPWr1HrW3xYv54DO8XO1+WOUc+7w3A1M8
         fkRCeN9KR1GQdL74QYFZsQ8RQ1rYig2DgxPvq+2CELcmOSJKOwNgCXdcfGTIhmwnw8X5
         6+819ErVEU+V9MFvL/BdzarkYe+OcHchKMpvfUlAIEVUljVFu1V3T3LLF38KY0sO+hbW
         ZJWg==
X-Gm-Message-State: AA+aEWau6tCxO4DGaQgl02sJeFzPvZAuRui1hZdXofVzoJQ87UNG2C5h
        My1waiCS4BCi1Z9QTl6/JPo=
X-Google-Smtp-Source: AFSGD/VPt0mp7nkAy3KLr5rj3bVYHTGTfmpkxYTtFIP9ppgFTeptsxFd70aTN3hwGzwFH1XeXdEbrg==
X-Received: by 2002:ad4:40c9:: with SMTP id x9mr10295990qvp.165.1543693151188;
        Sat, 01 Dec 2018 11:39:11 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id r1sm5386421qte.28.2018.12.01.11.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 11:39:10 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sat, 01 Dec 2018 17:39:04 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable ATH10K SDIO support
Date:   Sat,  1 Dec 2018 17:38:58 -0200
Message-Id: <20181201193858.20738-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of ATH10K WiFi is becoming common in i.MX based boards,
especially on new designs, so enable the driver support as module so
it can be used out of box.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index beba46d2ec13..d36a606d6205 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -159,6 +159,8 @@ CONFIG_USB_USBNET=y
 CONFIG_USB_NET_CDC_EEM=m
 CONFIG_USB_NET_SMSC95XX=y
 CONFIG_USB_NET_MCS7830=y
+CONFIG_ATH10K=m
+CONFIG_ATH10K_SDIO=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
 CONFIG_MWIFIEX_SDIO=m
-- 
2.19.2

