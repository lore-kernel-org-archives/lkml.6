Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA68F208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ag8YXgH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA68F208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGaPTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:19:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46322 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732206AbeGaPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:19:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so9088013pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arRYX+faxIVWKV6ncBx8cRCRNTaQptImg6E9dYZpUa0=;
        b=ag8YXgH+g8XODe7c5oSBEzRNUNRhIzDV9A/zMH896OroBl039Wl6o7mam1OJfgWB7b
         r3rVefDFoX7nvJgPfWlfd/ISJvXS9ssWixlPad/rtLn4JJ42aBJDP9zzUrjnxTbeMe4S
         /+Pt6uFs7BIAHfSUAgrHscUWPSgHZED+GX/EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=arRYX+faxIVWKV6ncBx8cRCRNTaQptImg6E9dYZpUa0=;
        b=sRMW+yVItpHjxk3XxVuiKcnDu+fDQqHpTW2pKdKo3QDTRbVOaDjGAUDLKQaiKmsxhT
         iGaZEmPJqYWlcNqrPCcU4RVmgEzD3qyCnelOLJGudkVi0aKMTK4eIEUDk91AtlUDuI70
         2GTHKD998o6o/Z8zzu6RydVukPqJefqlZBkGAmM8/PcS99myHkH7KRl2ym89veaiyebv
         2/FwmdSQLQ6gERw7Wqmt6UxtQjhdA5bvsWqkUNwYL/dxM8cosvpLtRYLzCewuKnhzd1d
         BjAJz/9U5cc4NOYUSsv+vffXT98R/BIMlCx7Ui07keTYwTYGLr6ddAAOAcXh8f3YeKsT
         AKfQ==
X-Gm-Message-State: AOUpUlGWXUHKEGqu0q5zlTdvZ9HSkKsFXgVKU2ik7uy3PPN0mWLTkeQq
        ly5nDXptsNdDdebSb/GPw8/SwA==
X-Google-Smtp-Source: AAOMgpeDsT1YjzJkYIQ4Lqw/dOeevVJN5+Ume6/WC/eLnZaOXK2IBKHQO+MnJgPhWl4kEEwxI7igcg==
X-Received: by 2002:a65:5288:: with SMTP id y8-v6mr20271907pgp.284.1533044326838;
        Tue, 31 Jul 2018 06:38:46 -0700 (PDT)
Received: from localhost.localdomain ([115.97.182.108])
        by smtp.gmail.com with ESMTPSA id b20-v6sm38633408pfc.178.2018.07.31.06.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 06:38:46 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
Date:   Tue, 31 Jul 2018 19:08:28 +0530
Message-Id: <20180731133828.2582-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
connected via I2C.

Enable the driver for this PMIC.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9a186f6af8a..2fdf01f11af8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -370,6 +370,7 @@ CONFIG_MESON_WATCHDOG=m
 CONFIG_RENESAS_WDT=y
 CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_I2C=y
-- 
2.18.0.321.gffc6fa0e3

