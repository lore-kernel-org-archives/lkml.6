Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40B24C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018C220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 11:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018C220896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965801AbeFOLL7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 07:11:59 -0400
Received: from muru.com ([72.249.23.125]:47372 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965689AbeFOLL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 07:11:57 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 54A5281A3;
        Fri, 15 Jun 2018 11:14:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 5/5] pinctrl: core: Remove broken remove_last group and pinmux functions
Date:   Fri, 15 Jun 2018 04:11:41 -0700
Message-Id: <20180615111141.37184-6-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615111141.37184-1-tony@atomide.com>
References: <20180615111141.37184-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With no users left for these functions let's remove them.

Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/pinctrl/core.h   | 6 ------
 drivers/pinctrl/pinmux.h | 7 -------
 2 files changed, 13 deletions(-)

diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -218,12 +218,6 @@ int pinctrl_generic_add_group(struct pinctrl_dev *pctldev, const char *name,
 int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
 				 unsigned int group_selector);
 
-static inline int
-pinctrl_generic_remove_last_group(struct pinctrl_dev *pctldev)
-{
-	return pinctrl_generic_remove_group(pctldev, pctldev->num_groups - 1);
-}
-
 #endif	/* CONFIG_GENERIC_PINCTRL_GROUPS */
 
 struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -150,13 +150,6 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 int pinmux_generic_remove_function(struct pinctrl_dev *pctldev,
 				   unsigned int selector);
 
-static inline int
-pinmux_generic_remove_last_function(struct pinctrl_dev *pctldev)
-{
-	return pinmux_generic_remove_function(pctldev,
-					      pctldev->num_functions - 1);
-}
-
 void pinmux_generic_free_functions(struct pinctrl_dev *pctldev);
 
 #else
-- 
2.17.1
