Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA4AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5D220656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XMPW9bh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfANLNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:13:39 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46154 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfANLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:13:39 -0500
Received: by mail-lf1-f67.google.com with SMTP id y14so15244568lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rYIMl9/h9EZOQmMPk92EhDxxI1xRjILmyoLT4QeKm3M=;
        b=XMPW9bh3DkgBuWhCBgRf9IkQTrK+wVhTFd+AFtB3ndn8y/TiHX2q8CYSqQ1hXgMX/b
         +klvYxQDL3TPW5r0Zf4tvyznotCCQSDseZqthkQOy1pOnXBJi79E/j12mkybq5uSsLIc
         LlfKi+9E3sRbqy5q10nbTOdtGF5/ZlXaHlCBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rYIMl9/h9EZOQmMPk92EhDxxI1xRjILmyoLT4QeKm3M=;
        b=nrO4w1o5RGZ2/Z7+O93ZsfVXKFwYsCzXMPcfstsX4ALolGABZYUuimwGKl4bR+9Fgj
         reTubFy6ph2oAH01WCFZFxr9Dj/UwjAU7C8R2wGk+J6sA9B6NTZvvrnH8mij6DRWzTSm
         b3LZPgplJMJWDja6h3jGSYVLaR5jmmJNkaWBybQPUUjhTcxdgnzwjcHmNZ8tX6MnB9pW
         B3Rx1WF1euvJyFwgOD1wApzdifOzYbVEw6lpfI3QRTFS6GMkoRRd90GSbwuRVve8dY2o
         Qf6CUeQKVnv2abkQ3Cm5U6a+UH4pTYUp9Fy7CmI9EbiaVXnj607YCDpacmfGfhYqGQ+A
         WJng==
X-Gm-Message-State: AJcUuke2V3gY7ZAAzrWJMpoI204/+hpstLrNrqPHN3zvDdkpOILSy9XY
        enM44m2Plb6jS2rDZ24+rlUF2w==
X-Google-Smtp-Source: ALg8bN7mnRGfGd66Gt0OgAl1u4uweJdL8s+qMAgEAC5+Mgg0jcqoochKvxv/DDS3RjHLWar7SAujlQ==
X-Received: by 2002:a19:7006:: with SMTP id h6mr13729987lfc.147.1547464416777;
        Mon, 14 Jan 2019 03:13:36 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id h3sm28169lfj.25.2019.01.14.03.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 03:13:36 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        stefan@agner.ch, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] pinctrl: freescale: fix link errors
Date:   Mon, 14 Jan 2019 12:13:27 +0100
Message-Id: <20190114111327.27272-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link errors when PINCTRL_IMX_SCU, PINCTRL_IMX8QM or PINCTRL_IMXBQXP
is enabled as a module and the dependent module is built-in.

ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinctrl_sc_ipc_init':
pinctrl-scu.c:(.text+0x10): undefined reference to `imx_scu_get_handle'
ld: pinctrl-scu.c:(.text+0x10): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_scu_get_handle'
ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinconf_get_scu':
pinctrl-scu.c:(.text+0xa0): undefined reference to `imx_scu_call_rpc'
ld: pinctrl-scu.c:(.text+0xa0): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_scu_call_rpc'
ld: drivers/pinctrl/freescale/pinctrl-scu.o: in function `imx_pinconf_set_scu':
pinctrl-scu.c:(.text+0x1b4): undefined reference to `imx_scu_call_rpc'
ld: pinctrl-scu.c:(.text+0x1b4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_scu_call_rpc'
ld: drivers/pinctrl/freescale/pinctrl-imx8qxp.o: in function `imx8qxp_pinctrl_probe':
pinctrl-imx8qxp.c:(.text+0x28): undefined reference to `imx_pinctrl_probe'
ld: pinctrl-imx8qxp.c:(.text+0x28): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `imx_pinctrl_probe'

Rework so that PINCTRL_IMX_SCU and the config's that 'select
PINCTRL_IMX_SCU' depends on IMX_SCU=y.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pinctrl/freescale/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescale/Kconfig
index b318c24b61be..a599b72b350a 100644
--- a/drivers/pinctrl/freescale/Kconfig
+++ b/drivers/pinctrl/freescale/Kconfig
@@ -7,7 +7,7 @@ config PINCTRL_IMX
 
 config PINCTRL_IMX_SCU
 	bool
-	depends on IMX_SCU
+	depends on IMX_SCU=y
 	select PINCTRL_IMX
 
 config PINCTRL_IMX1_CORE
@@ -131,14 +131,14 @@ config PINCTRL_IMX8MQ
 
 config PINCTRL_IMX8QM
 	bool "IMX8QM pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on IMX_SCU=y && ARCH_MXC && ARM64
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qm pinctrl driver
 
 config PINCTRL_IMX8QXP
 	bool "IMX8QXP pinctrl driver"
-	depends on ARCH_MXC && ARM64
+	depends on IMX_SCU=y && ARCH_MXC && ARM64
 	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8qxp pinctrl driver
-- 
2.19.2

