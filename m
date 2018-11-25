Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC39DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C52082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755C52082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeKZIOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:14:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35862 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKZIOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:14:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so15486567qtn.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:22:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=rGEsnptS+A0TDUNi43q8Zo7aNENIrVtw77UXPlpzpUk=;
        b=NRNIH/t7TRGVBxJiw2nXP5rx3i1nWBO7o7+J4PQ/XqqaFWV3sEyZZNDUXHIPmw2Xvm
         VA/clFATBSulXBxjox8d4l3xlijc6zNxPouYS57Le7jxao2P9qtw1X8bKdThC1kqEmYY
         YqqGVo2hjx3Kg7QNV+GFXl9tndZi7PPVks8bI1yfXjz6Xr66YU1k8q/fg7vvn05ohCzk
         Sa5DjspAt4J/YmydoWXzlkqxzkrNwpeVpcbmjRFT3UUHhRBWPGZiQz2eT7izsKI/hvmM
         99MFSoYbAkzJm8vciybB0/80iwOklzJ4Q5/3OrLE6q79L700aFlKk8tiOGV5vIIbskrh
         F8yw==
X-Gm-Message-State: AA+aEWa6tBwiSLlSE+OVvczK6GyATamH/uqZKD0jnuQUlMEhFgUxz+or
        DYEkX6Lxu6ub9ccFjMLJoTY=
X-Google-Smtp-Source: AFSGD/VW5dyjIQH/GI41BkuyP3iAeUySY8EY8ulMTCA9SmxeiyDp4S8dtqM7T+z88nb4k6PiDucFFQ==
X-Received: by 2002:ac8:4901:: with SMTP id e1mr22759729qtq.244.1543180927471;
        Sun, 25 Nov 2018 13:22:07 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id q70sm33925163qkq.10.2018.11.25.13.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:22:06 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:22:01 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 1/3] ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND disable
Date:   Sun, 25 Nov 2018 19:21:57 -0200
Message-Id: <20181125212159.11590-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ARM_UNWIND is removed when running 'savedefconfig', but
selected by the Kconfig logic.  This is done in preparation to making
further changes to this defconfig cleaner.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

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
2.19.1

