Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D945C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5181720855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5181720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKZIOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:14:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36748 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKZIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:14:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id o125so11208797qkf.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=7GU1ianqOvacnqv3EsVe2ZsLdU5eaOe871PisCnhtew=;
        b=ll6SRf9FSuYpOVoIRsR0pLsCISJn5OwSpEjhCm58RzciPWTXRRXy5fa2uKxhj4Yd1Q
         bXvxotUQcbz/C8blQZgWs+x7l0StT7KhHTYvahJPTUiIgTlTZBmN44RAHyyP7jqTMHzo
         QC3Ni+kUigSP+QGRPIFQUK+g8l+wRKBbd2ogOlO8G21jjCqq65AznksP7l+YFiMdzorZ
         m6VZV3qf+3O+QKMSZaU6BiS7E+txx/vIv7p0DdhBOKq+hOP3Yd7BZQftIkI1XxNKkPQZ
         oAFrOAW0+aptXFIMNDQfLE+sMSBMTINY+BW6Jawee7YXAKkN3Tcl+sSNyiv7A5w6bYx3
         fWaw==
X-Gm-Message-State: AA+aEWYmnf1NkomXeUEjRnrqZNaevQNAvbAht5s4lonlIlWB1Hvz+JM7
        Xcr7hPqSCtwzEIh/mmdVIV8=
X-Google-Smtp-Source: AFSGD/XHc14BRzJvg5cIKRMKSV0w+ghQ7ywD0FLcFQHPE6JVQyhN3Q0KQfBnMFqnuIDG5M6GzUHFgQ==
X-Received: by 2002:a37:3388:: with SMTP id z130mr21303292qkz.51.1543180934362;
        Sun, 25 Nov 2018 13:22:14 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id x41sm9246393qth.92.2018.11.25.13.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:22:13 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:22:07 -0200
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
Subject: [PATCH v2 2/3] ARM: imx_v6_v7_defconfig: Enable BT_BNEP
Date:   Sun, 25 Nov 2018 19:21:58 -0200
Message-Id: <20181125212159.11590-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125212159.11590-1-otavio@ossystems.com.br>
References: <20181125212159.11590-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Müller <schnitzeltony@gmail.com>

This is necessary to support network over bluetooth:

| Sep 11 15:36:33 imx6qdl-variscite-som bluetoothd[281]: kernel lacks bnep-protocol support
| Sep 11 15:36:33 imx6qdl-variscite-som bluetoothd[281]: System does not support network plugin

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0c887a059df3..22ad2d7a1cf2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -81,6 +81,7 @@ CONFIG_NETFILTER=y
 CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
+CONFIG_BT_BNEP=m
 CONFIG_BT_HCIUART=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
-- 
2.19.1

