Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E959DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B522420859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDM6sTRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfBTWMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:12:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37677 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfBTWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:12:18 -0500
Received: by mail-it1-f194.google.com with SMTP id z124so19629316itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIhUNTqE9+X9/WPHOgD7Xikea9cN0w1/itVCWJ5rtDs=;
        b=SDM6sTRXRO5ikdNmd1WXITSak2cLwOesjCPne/o+7dYgeHzWK7Klv6AgxiJllQz46j
         ACpV85S6i8Y5KbSrDZf9hjIWhcW7maKuRqRCOBhmv8+vZcpJGcqrpUoiwXi7PvSdwYE/
         8XsgwnRn8FsuEqP9TCErD6mi1CjqkB+nkiMc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIhUNTqE9+X9/WPHOgD7Xikea9cN0w1/itVCWJ5rtDs=;
        b=d9B4KJ4cShtPyd0RzRfqjUSeh6ikswLyxRBAv9JHqo9MCFfS00iDcwSd06WvbCug5r
         tlrpP/BbbVQ5nkTL0bgbp65YKymnO0e/vamF/TeHWFNYYYWUxVnZT80K+WyMF/+rlTSj
         JnNsPali7wgQbxDhaTWoQ6OUsZCfHTvWNmKSvTXjc5VryfmZ8agm4VaAXxUN2fL0qOLF
         cCYSgZJpbQ13CsLRcqIhfe0rNdMQaQ2SOenBivQUGrXQj4FSk/2v58fiRQtgXrR++7Ti
         KJWQ11BvTq+e7UsKgJJHr5mutsujdNRLA+/C4vPDr6Wd2IcQ8veK7S8k/Zii2nHYr/pN
         Ulcg==
X-Gm-Message-State: AHQUAuYcKgp4fkUFDyPlQMsedFEGiLRIVbLfrsZk9HixpLO97MnEQgiO
        wbuP69cFF5/O5OnEIsOV5ft7QQ==
X-Google-Smtp-Source: AHgI3IYGAUl+Nx7SmBb2dzSDt2Y8DaYnlVpXm17DaH3IjK7dirT3On5wNsb5RsAz5kHUfhCbnyvIEA==
X-Received: by 2002:a6b:8b04:: with SMTP id n4mr20408545iod.296.1550700736944;
        Wed, 20 Feb 2019 14:12:16 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id x128sm3437143itb.8.2019.02.20.14.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 14:12:16 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        ncrews@chromium.org, rdunlap@infradead.org, sfr@canb.auug.org.au
Subject: [PATCH -next] platform/chrome: Fix Kconfig dependencies for wilco_ec
Date:   Wed, 20 Feb 2019 15:11:29 -0700
Message-Id: <20190220221128.48476-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initial version of the Wilco EC Driver, the
dependency order was wrong. It before was possible to
select CONFIG_WILCO_EC and CONFIG_CROS_EC_LPC without
having CONFIG_CROS_EC_LPC_MEC. This was wrong, since
WILCO_EC depends upon CONFIG CROS_EC_LPC_MEC, not the
other way around.

Fixes: 1733c32834e5d1 ("platform/chrome: Add new driver for Wilco EC")
Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/Kconfig          | 2 +-
 drivers/platform/chrome/wilco_ec/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 462eb9dfa4f2..b69561050868 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -95,7 +95,7 @@ config CROS_EC_LPC
 
 config CROS_EC_LPC_MEC
 	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
-	depends on CROS_EC_LPC || WILCO_EC
+	depends on CROS_EC_LPC
 	default n
 	help
 	  If you say Y here, a variant LPC protocol for the Microchip EC
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index 20945a301ec6..c6bc4e8f3062 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -1,7 +1,6 @@
 config WILCO_EC
 	tristate "ChromeOS Wilco Embedded Controller"
-	depends on ACPI && X86
-	select CROS_EC_LPC_MEC
+	depends on ACPI && X86 && CROS_EC_LPC_MEC
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
 	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol

