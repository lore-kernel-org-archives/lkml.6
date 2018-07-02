Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CF1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4A2075E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933621AbeGBIVV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:21:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53040 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbeGBIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:21:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZu5E-0004zV-K6; Mon, 02 Jul 2018 08:21:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hpet: remove redundant pointer hpet
Date:   Mon,  2 Jul 2018 09:21:16 +0100
Message-Id: <20180702082116.13991-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer hpet is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'hpet' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/char/hpet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index be426eb2a353..4a22b4b41aef 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -579,7 +579,6 @@ hpet_ioctl_common(struct hpet_dev *devp, unsigned int cmd, unsigned long arg,
 		  struct hpet_info *info)
 {
 	struct hpet_timer __iomem *timer;
-	struct hpet __iomem *hpet;
 	struct hpets *hpetp;
 	int err;
 	unsigned long v;
@@ -591,7 +590,6 @@ hpet_ioctl_common(struct hpet_dev *devp, unsigned int cmd, unsigned long arg,
 	case HPET_DPI:
 	case HPET_IRQFREQ:
 		timer = devp->hd_timer;
-		hpet = devp->hd_hpet;
 		hpetp = devp->hd_hpets;
 		break;
 	case HPET_IE_ON:
-- 
2.17.1

