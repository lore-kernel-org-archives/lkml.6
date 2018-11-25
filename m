Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5858C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975C92082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975C92082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeKZJNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:13:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36890 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeKZJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:12:59 -0500
Received: by mail-qt1-f195.google.com with SMTP id z16so15572823qtq.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=DrPmspBRem/5sI9r3VfghWV3hSgYfzEMFwY2Pvb9ctA=;
        b=B2RSDAL7wtlwrjvH8wg06J+HkaR7MQoVsi4Ay6ZyhJ92zOWvs3mLVENseSGLWVSmbF
         4XSbg52jtGhdFD4ho13DOG65aDhAROKanXQfPhCpba1twYAHq3A7rEjfbaop/vspaPsf
         c6Xa0VFXscEpSR0jZtzRdMIAkk2k+IIpLA4bUhzm2Fgl49MPYyd76a3O27v5p1ZCMwFW
         IZUiD3TWGm057cC6LYIhnmVUbbGxak8VJ/x3kCo1hv5b8xx0g+wFgtRUvK5W7D3V7B3w
         +aH0ValvE8xRDLZE9EbELaXUmseMOve+X6MBs/6FjH6kOfNGEsgxaRVtiZkigxCPgBL9
         IIRg==
X-Gm-Message-State: AA+aEWYDVZIK+zi922/IIJXGaOl+wFaIb3FX9xNdBQQWT0AlPqtb64gW
        SSUhGHR+8pFyJhbYddk1OO4=
X-Google-Smtp-Source: AFSGD/W6yuZYm4ZMIYHhCW11sUlvJH1obbRk2xIb6mprDr0Xezu34rrgo/MNJ0uiUgaH7Bp0/n133w==
X-Received: by 2002:a0c:872a:: with SMTP id 39mr23689747qvh.1.1543184451549;
        Sun, 25 Nov 2018 14:20:51 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id v2sm26331751qte.75.2018.11.25.14.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 14:20:50 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 20:20:44 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andreas=20M=C3=BCller?= <schnitzeltony@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v3 3/3] ARM: imx_v6_v7_defconfig: Enable USB_ANNOUNCE_NEW_DEVICES
Date:   Sun, 25 Nov 2018 20:20:27 -0200
Message-Id: <20181125222027.22071-3-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181125222027.22071-1-otavio@ossystems.com.br>
References: <20181125222027.22071-1-otavio@ossystems.com.br>
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

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v3: None
Changes in v2: None

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
2.19.2

