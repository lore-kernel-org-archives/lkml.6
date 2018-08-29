Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BB2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAD520868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAD520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbeH2Ss1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:48:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47088 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeH2Ss1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:48:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fv1oI-0005Uq-RO; Wed, 29 Aug 2018 14:51:06 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sameer Nanda <snanda@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] power: supply: cros_usbpd: remove unused pointer 'dev'
Date:   Wed, 29 Aug 2018 15:51:06 +0100
Message-Id: <20180829145106.9847-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'dev' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable 'dev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: change subject to include 'cros_usbpd' and also send to Sameer.

---
 drivers/power/supply/cros_usbpd-charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 688a16bacfbb..f2b8de502b82 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -378,12 +378,10 @@ static int cros_usbpd_charger_ec_event(struct notifier_block *nb,
 {
 	struct cros_ec_device *ec_device;
 	struct charger_data *charger;
-	struct device *dev;
 	u32 host_event;
 
 	charger = container_of(nb, struct charger_data, notifier);
 	ec_device = charger->ec_device;
-	dev = charger->dev;
 
 	host_event = cros_ec_get_host_event(ec_device);
 	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU)) {
-- 
2.17.1

