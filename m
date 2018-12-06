Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9019C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699CA21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699CA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbeLFJTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:19:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34419 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:19:39 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gUpon-0002Js-3b; Thu, 06 Dec 2018 09:19:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][misc-next] misc: cardreader: fix spelling mistake "invailid" -> "invalid"
Date:   Thu,  6 Dec 2018 09:19:36 +0000
Message-Id: <20181206091936.11871-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in a couple of dev_dbg messages, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/cardreader/alcor_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 6872b8e29b4d..bcb10fa4bc3a 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -105,7 +105,7 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
 	while (1) {
 		pci_read_config_dword(pci, where, &val32);
 		if (val32 == 0xffffffff) {
-			dev_dbg(priv->dev, "find_cap_offset invailid value %x.\n",
+			dev_dbg(priv->dev, "find_cap_offset invalid value %x.\n",
 				val32);
 			return 0;
 		}
@@ -116,7 +116,7 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
 		}
 
 		if ((val32 & 0xff00) == 0x00) {
-			dev_dbg(priv->dev, "pci_find_cap_offset invailid value %x.\n",
+			dev_dbg(priv->dev, "pci_find_cap_offset invalid value %x.\n",
 				val32);
 			break;
 		}
-- 
2.19.1

