Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B6920868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B6920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adamwong.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeK3Eoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:44:37 -0500
Received: from mta-10-3.privateemail.com ([198.54.127.62]:63316 "EHLO
        MTA-10-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeK3Eog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:44:36 -0500
Received: from MTA-10.privateemail.com (localhost [127.0.0.1])
        by MTA-10.privateemail.com (Postfix) with ESMTP id 00B3860048;
        Thu, 29 Nov 2018 12:38:28 -0500 (EST)
Received: from mylittlepwnie.uwaterloo.ca (unknown [10.20.151.247])
        by MTA-10.privateemail.com (Postfix) with ESMTPA id AEFBF60041;
        Thu, 29 Nov 2018 17:38:26 +0000 (UTC)
From:   adam@adamwong.me
To:     dmitry.torokhov@gmail.com
Cc:     benjamin.tissoires@redhat.com, kt.liao@emc.com.tw,
        dshanty@protonmail.com, robh@kernel.org, jackxviichaos@gmail.com,
        ben.hutchings@codethink.co.uk, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Wong <adam@adamwong.me>
Subject: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621 touchpad.
Date:   Thu, 29 Nov 2018 12:38:24 -0500
Message-Id: <20181129173824.7980-1-adam@adamwong.me>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Wong <adam@adamwong.me>

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

