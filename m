Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E78C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A332124FAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A332124FAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeGBH3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:29:36 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:46034 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752607AbeGBH3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:29:35 -0400
Received: from rdostal-desktop.sue.net (vpn.streamunlimited.com [91.114.0.140])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41JzR13QB4z5tlL;
        Mon,  2 Jul 2018 09:29:33 +0200 (CEST)
From:   =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>
To:     gregkh@linuxfoundation.org
Cc:     thomas.petazzoni@free-electrons.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radek=20Dost=C3=A1l?= <radek.dostal@streamunlimited.com>
Subject: [PATCH v2] staging: fbtft: indent fbtft_device_display - last entry - pdev - dev
Date:   Mon,  2 Jul 2018 09:28:49 +0200
Message-Id: <1530516529-4443-1-git-send-email-radek.dostal@streamunlimited.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180629182349.GA17091@kroah.com>
References: <20180629182349.GA17091@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev section was opening curly bracket, but not adding ident, which
resulted in two times "}," after each other with same indentation. Add
ident at the right place fixes this problem.

This formatting issue is not detectable by checkpatch.pl

Signed-off-by: Radek Dostál <radek.dostal@streamunlimited.com>
---

Changes in v2:
- Extended commit message.

 drivers/staging/fbtft/fbtft_device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft/fbtft_device.c
index ec84776..22ba81d 100644
--- a/drivers/staging/fbtft/fbtft_device.c
+++ b/drivers/staging/fbtft/fbtft_device.c
@@ -1223,14 +1223,14 @@ static struct fbtft_device_display displays[] = {
 			.name = "",
 			.id = 0,
 			.dev = {
-			.release = fbtft_device_pdev_release,
-			.platform_data = &(struct fbtft_platform_data) {
-				.gpios = (const struct fbtft_gpio []) {
-					{},
+				.release = fbtft_device_pdev_release,
+				.platform_data = &(struct fbtft_platform_data) {
+					.gpios = (const struct fbtft_gpio []) {
+						{},
+					},
 				},
 			},
 		},
-		},
 	}
 };
 
-- 
2.7.4

