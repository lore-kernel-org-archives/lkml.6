Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3449C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABB520850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 20:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABB520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeKZHJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:09:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45773 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeKZHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:09:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so15388122qtr.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 12:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=Gzb5SI2iipIeU/gxEe6Ho36R9xXKBcIksKjSUrshL8s=;
        b=flFG+VmKfK5iVhACxAB7IkDu8bOXx/DVD7imwRxK2rSmdKrTueo5BSs3B0dKz+bcpA
         VvbIhzf/gD63N/eq7CBQixZDdKCJjkXNeSvla0X9BDx2y3YWMPtmlRLbrtF0YwPpO5Z7
         6M/M6+/pAUQx8HLdq9svVA4FOgHKvCZkrEYiZJdUcRttr1+jmnVN8k8sxhiY/ICu1zCL
         3xyBn/hcD8o9B4HFJr3uesD5o0vKhcK7LXanKDBQgSUJCuLdbKdBLDkq1A23xk8yw+q2
         KMO85tZovvoM1TbKuirHf3hGBm6FwNQjlGkK4ljLCNaF9xLwOXVItPqx3sNbtT/O8R7t
         FeOw==
X-Gm-Message-State: AA+aEWbWN1NMeZHNQcjCrrDdjyClL1qXqjhTS1xl5GXtrhw3ghNA55ZX
        JpF3TudPPPx8LSgopajG8Og=
X-Google-Smtp-Source: AFSGD/WOXy17nlxUbFy1inr5LMRoiXdIHNkudJvDpVGRpVmpLsZQw9d9XGchW39XL8UCm1UPrGqzKQ==
X-Received: by 2002:aed:26a3:: with SMTP id q32mr6539461qtd.106.1543177062848;
        Sun, 25 Nov 2018 12:17:42 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id z30sm47576585qtz.26.2018.11.25.12.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 12:17:42 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 18:17:35 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 1/3] ARM: imx_v6_v7_defconfig: Remove CONFIG_ARM_UNWIND
Date:   Sun, 25 Nov 2018 18:17:27 -0200
Message-Id: <20181125201729.19836-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting is removed when running a `savedefconfig` using the
current setting set. It is being applied in preparation to some
patches making changes to this defconfig.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

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

