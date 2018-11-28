Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EB82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EB82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adamwong.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeK2IaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:30:13 -0500
Received: from h1.fbrelay.privateemail.com ([131.153.2.42]:39137 "EHLO
        h1.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbeK2IaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:30:13 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2018 03:30:12 EST
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com [68.65.122.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id AFA95815F9;
        Wed, 28 Nov 2018 16:20:09 -0500 (EST)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
        by MTA-06.privateemail.com (Postfix) with ESMTP id 1476C60049;
        Wed, 28 Nov 2018 16:20:06 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.221])
        by MTA-06.privateemail.com (Postfix) with ESMTPA id 97E3760045;
        Wed, 28 Nov 2018 21:20:04 +0000 (UTC)
From:   adam@adamwong.me
To:     dmitry.torokhov@gmail.com
Cc:     benjamin.tissoires@redhat.com, kt.liao@emc.com.tw,
        dshanty@protonmail.com, robh@kernel.org, jackxviichaos@gmail.com,
        ben.hutchings@codethink.co.uk, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        TheWongGuy <adam@adamwong.me>
Subject: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621 touchpad.
Date:   Wed, 28 Nov 2018 16:20:01 -0500
Message-Id: <20181128212001.20839-1-adam@adamwong.me>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: TheWongGuy <adam@adamwong.me>

Added the ability to detect the ELAN0621 touchpad found in some Lenovo
laptops.

Signed-off-by: Adam Wong <adam@adamwong.me>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index b0f9d19b3410..a84362d0c99d 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1348,6 +1348,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }
-- 
2.17.1

