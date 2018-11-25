Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0492082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0492082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKZJMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:12:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42604 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:12:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so15568647qtq.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=VMnN7Lw1c7HEijTmvpgaS708qpHw3I3iydCWLLFq+AI=;
        b=tsvGJkZ8YZh1YQ00Wh5u6M+Sv0fwxg6FoXAFc0BkPLFl4yxtCSEJ5viTz7HPoYsnBx
         W/D34OxK8KUDY0yli+slcRE5zMdQc7aDUOsmfT0FXxdcPTwzmU4T5MsKxZ7zrJcxosnO
         X0DZzn+HDdxC+wYpaW67c4eX2H5FOanISS1jhT6biNiwcnOvxeVCtZNI2zh5NilMeo7/
         1u0OwrhZchNy/ybsNepqfISSBqYcg205hxOwRfqeU1JUriMCfaCCHgidgkXlHjs9KkBQ
         aRSFceIwuoQj9k31h2xT0XIqvPKhguK5Dv552Mxq6oh1hdnGCLDRUHrem66dxo57r7Gs
         JfzA==
X-Gm-Message-State: AA+aEWbXJv84sgamdATMo3ZDWrw/aCvKIBAp7R+E1avK903u0OLUur1D
        x/y1w5YqM/UpN8CmyoG2TsE=
X-Google-Smtp-Source: AFSGD/VKXOlsMETOzXiqzSfaX/qs8mw77i59L601VwK8VhTqae8O799v0qod1I+h0z5y21uuE9DsAA==
X-Received: by 2002:ac8:28d2:: with SMTP id j18mr23077488qtj.191.1543184436479;
        Sun, 25 Nov 2018 14:20:36 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id d45sm15148897qtd.56.2018.11.25.14.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 14:20:35 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 20:20:28 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v3 1/3] ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND disable
Date:   Sun, 25 Nov 2018 20:20:25 -0200
Message-Id: <20181125222027.22071-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
selected by ARM EABI (AEBI) support.  This is done in preparation to making
further changes to this defconfig cleaner.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v3:
- mention it is enabled by ARM EABI support (Arnd Bergmann)

Changes in v2:
- rework commit log (Fabio Estevam)

 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index aa02d18f44d1..0c887a059df3 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -445,4 +445,3 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_PROVE_LOCKING=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_FTRACE is not set
-# CONFIG_ARM_UNWIND is not set
-- 
2.19.2

