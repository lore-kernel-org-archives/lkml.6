Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2382084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2382084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeKZILR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:11:17 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33083 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:11:16 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so11229514qko.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :organization:content-transfer-encoding;
        bh=NgPVpSWcwB90ObPRF/c1AagXrsN5eYDApJ9opL9uxQo=;
        b=AIya/KqOb1U2GR3Ux4rha7tl4KebIp756o84/Z1p1I+e8w/ixqBznNZROSkF8WpXaI
         8dR+p6l7K/cDk5XZxsrhrRC/5QaTH7gjb/6gyMhE4rJ6FNgd0lwU6s72QtqeKBFboyOl
         vRnncpFXxQ+5OL+CPW+PEsN0fvnKDx0ott3BfItXqEkr6SVTIspgZLxQUJJ2cy/TkKMw
         kV7Kb1kBQ1zCUpV6ps3k31WizQ+t1UgZ5LQoZcltjXge6ExLoQ9wxCOyLZK5lUlzh2eW
         AkE5OI5mR0YMQH3TSg/x55YqYnOaJYMLCRrD3qDvnwXhd3cMF+lbKlEsKIY12CTVIhq8
         JS9w==
X-Gm-Message-State: AA+aEWb4AZqcj+5uDSvf6er7pYwUFfQR0FvEXiaHnazSB21kNf44J0/I
        C5RjPxFUaZnxGe1afos05PYrA+PE
X-Google-Smtp-Source: AFSGD/WgJGdA67CRzE7LBo4PpT/gWdzDddxIhV0PPxfYgNnLqPWpAc4kFhosS4kjIw3A6orryxOw5Q==
X-Received: by 2002:a37:3753:: with SMTP id e80mr21678504qka.207.1543180757055;
        Sun, 25 Nov 2018 13:19:17 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id 126sm24953760qkj.70.2018.11.25.13.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:16 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:09 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
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
Subject: [PATCH 01/13] ARM: multi_v7_defconfig: Select PHY_ROCKCHIP_INNO_USB2
Date:   Sun, 25 Nov 2018 19:18:55 -0200
Message-Id: <20181125211907.9895-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
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
2.19.1

