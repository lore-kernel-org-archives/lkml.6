Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F760C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F54A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F54A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbeKADmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:42:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56747 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbeKADmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:42:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gHvRx-0003P1-U4; Wed, 31 Oct 2018 18:42:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: mediatek: clean up indentation issues, add missing tab
Date:   Wed, 31 Oct 2018 18:42:41 +0000
Message-Id: <20181031184241.5439-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation issues, add one level of
indentation on two if statements.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c | 4 ++--
 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 3133ec0f2e67..aa1068d2867f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -310,8 +310,8 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			if (hw->soc->drive_set) {
 				err = hw->soc->drive_set(hw, desc, arg);
-			if (err)
-				return err;
+				if (err)
+					return err;
 			} else {
 				err = -ENOTSUPP;
 			}
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d2179028f134..50e68b1e9065 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -282,8 +282,8 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		if (hw->soc->drive_set) {
 			err = hw->soc->drive_set(hw, desc, arg);
-		if (err)
-			return err;
+			if (err)
+				return err;
 		} else {
 			return -ENOTSUPP;
 		}
-- 
2.19.1

