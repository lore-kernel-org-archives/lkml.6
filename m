Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E30FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D33220672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D33220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeK0Gy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:54:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36833 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Gy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:54:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so13159598qkf.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=H2kmrqXm8apdqeuKLsfvmLcPwjvxUpG0rkzcf0WU0yY=;
        b=FDHJ1Ya5Q3l3ODgq1HJBnzU1He+SoWln4MQuGs7BymBQsx7UgxAubXTvGyJrlxv5WS
         bDd9ORukGYffkS3HQMpuqvzHviQM7KgKqdrNb7ly3xkJ/cm6N0OQao0GT0noPL7VO8LR
         1Q0nDy6gy5pL5gam9b9mVlB8WSo8u6azMaHgnXB9B8PTe9n48CZyrjveaB1eM0d8DWBq
         759tXEyrurBQJAwXvaeShEfo/5wh1xaJyQfRLMaM1mYJNT4fDj59P+pSosJeBGV87/XE
         12XlPjKZwAAbfaaLXY8CNV3E3fFdo3k0SwFzuOOPV5wa6k5lWYkbinl1dRgqxQ4793ue
         LTgg==
X-Gm-Message-State: AA+aEWZFAdWhKWLyOBljeHL420vgR3Mv+nDwjEsd14kSavXuQhi1DHOU
        cdQf//TDlCr42P179PgWMNun3X+g
X-Google-Smtp-Source: AFSGD/VMQG4tQRkuF3SpAzmgdny2j79RvBberIX81GzSrRSHGUnNvmFUhtkbgYMJNgCo9vnnFoKkzw==
X-Received: by 2002:a37:1054:: with SMTP id a81mr25589621qkh.150.1543262355233;
        Mon, 26 Nov 2018 11:59:15 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id f31sm897967qtc.42.2018.11.26.11.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 11:59:14 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Mon, 26 Nov 2018 17:59:06 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        =?UTF-8?q?Yannick=20Fertr=C3=A9?= <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 1/2] ARM: multi_v7_defconfig: Select PHY_ROCKCHIP_INNO_USB2
Date:   Mon, 26 Nov 2018 17:59:04 -0200
Message-Id: <20181126195905.5427-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select the CONFIG_PHY_ROCKCHIP_INNO_USB2 option by default, so that
USB can be functional on RV1108.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af6234c1b6..a8ec309d182a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -947,6 +947,7 @@ CONFIG_PHY_CPCAP_USB=m
 CONFIG_PHY_QCOM_APQ8064_SATA=m
 CONFIG_PHY_RCAR_GEN2=m
 CONFIG_PHY_ROCKCHIP_DP=m
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_USB=y
 CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_MIPHY28LP=y
-- 
2.19.2

