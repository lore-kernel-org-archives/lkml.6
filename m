Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFB420835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFB420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeJKNSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 09:18:48 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:57810 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbeJKNSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 09:18:48 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CE45F1E727696511D213;
        Thu, 11 Oct 2018 13:53:00 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w9B5qrrk049030;
        Thu, 11 Oct 2018 13:52:53 +0800 (GMT-8)
        (envelope-from zhang.xianwei8@zte.com.cn)
Received: from localhost.localdomain ([10.75.9.60])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018101113532264-3776416 ;
          Thu, 11 Oct 2018 13:53:22 +0800 
From:   Zhang Xianwei <zhang.xianwei8@zte.com.cn>
To:     ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, zhang.xianwei8@zte.com.cn
Subject: [PATCH] platform/x86: thinkpad_acpi: Change the keymap for Favorites hotkey
Date:   Thu, 11 Oct 2018 13:59:31 +0800
Message-Id: <1539237571-28926-1-git-send-email-zhang.xianwei8@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-10-11 13:53:22,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-10-11 13:52:41,
        Serialize complete at 2018-10-11 13:52:41
X-MAIL: mse01.zte.com.cn w9B5qrrk049030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keycode KEY_FAVORITES(0x16c) used in thinkpad_acpi driver is too
big (out of range > 255) for xorg to handle.
xkeyboard-config has already mapped KEY_BOOKMARKS(156) to
XF86Favorites:

keycodes/evdev:
    <I164> = 164;   // #define KEY_BOOKMARKS           156

symbols/inet:
    key <I164>   {      [ XF86Favorites         ]       };

So change the keymap to KEY_BOOKMARKS for Favorites hotkey.

Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index fde08a9..a86cf47 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3457,7 +3457,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
 		KEY_UNKNOWN,
 
-		KEY_FAVORITES,       /* Favorite app, 0x311 */
+		KEY_BOOKMARKS,       /* Favorite app, 0x311 */
 		KEY_RESERVED,        /* Clipping tool */
 		KEY_CALC,            /* Calculator (above numpad, P52) */
 		KEY_BLUETOOTH,       /* Bluetooth */
-- 
2.9.5

