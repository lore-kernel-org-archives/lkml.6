Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CA220858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CA220858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeGMKJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:09:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59683 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeGMKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:09:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdunS-0007RL-Mq; Fri, 13 Jul 2018 09:55:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Winischhofer <thomas@winischhofer.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb-misc: sisusbvga: remove redundant variable modey
Date:   Fri, 13 Jul 2018 10:55:30 +0100
Message-Id: <20180713095530.23720-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable modey is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'modey' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/misc/sisusbvga/sisusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index f92c5df26320..3198d0477cf8 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -1750,7 +1750,7 @@ static int sisusb_setup_screen(struct sisusb_usb_data *sisusb,
 static int sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
 		int touchengines)
 {
-	int ret = 0, i, j, modex, modey, bpp, du;
+	int ret = 0, i, j, modex, bpp, du;
 	u8 sr31, cr63, tmp8;
 	static const char attrdata[] = {
 		0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
@@ -1773,7 +1773,7 @@ static int sisusb_set_default_mode(struct sisusb_usb_data *sisusb,
 		0x00
 	};
 
-	modex = 640; modey = 480; bpp = 2;
+	modex = 640; bpp = 2;
 
 	GETIREG(SISSR, 0x31, &sr31);
 	GETIREG(SISCR, 0x63, &cr63);
-- 
2.17.1

