Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3E3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ED320869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61ED320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeIGLrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:47:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 07:47:08 -0400
Received: from [125.35.49.90] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1fyArV-0005pC-TG; Fri, 07 Sep 2018 07:07:36 +0000
From:   Aaron Ma <aaron.ma@canonical.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaron.ma@canonical.com
Subject: [PATCH] Input: elantech - enable middle button of touchpad on ThinkPad P72
Date:   Fri,  7 Sep 2018 15:06:51 +0800
Message-Id: <20180907070651.6916-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding 2 new touchpad IDs to support middle button support.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 44f57cf6675b..2d95e8d93cc7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1178,6 +1178,8 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
 static const char * const middle_button_pnp_ids[] = {
 	"LEN2131", /* ThinkPad P52 w/ NFC */
 	"LEN2132", /* ThinkPad P52 */
+	"LEN2133", /* ThinkPad P72 w/ NFC */
+	"LEN2134", /* ThinkPad P72 */
 	NULL
 };
 
-- 
2.17.1

