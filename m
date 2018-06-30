Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2CAC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 07:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141927402
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hWieqLhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5141927402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeF3HbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 03:31:21 -0400
Received: from [103.7.29.155] ([103.7.29.155]:42668 "EHLO smtpbg64.qq.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932448AbeF3HbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 03:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1530343855;
        bh=RBr1071ko4IwJgfzJJoUaa6G3em2HVRmoP3YqzhR+88=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=hWieqLhuNahwxdz2AaHvTaZxlRjUXSsh8E8bGnEszwMwZz86wKyeaBW6yVK/fWw7X
         XtuOvNOll3rEfdOoPboJfeeXkrfN/PgN/0UGVSZotcNuyu9fGQjv9eeT5ePLCuAc5P
         ZIcaDd30U8GhLstHTv9OXj7SAnMnrT0H+F0MqP0o=
X-QQ-mid: esmtp2t1530343853t10uxykqw
Received: from localhost.localdomain (unknown [218.72.0.54])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sat, 30 Jun 2018 15:30:51 +0800 (CST)
X-QQ-SSF: B100000000000090FG120000000000V
X-QQ-FEAT: uLC2yWZT8bGAnGEem8AMUgeHcOSfi4TEg2OjN+MMWzgdAIwwpUYet8SCZgLL7
        /TB0SY+Xk6k1i/eqWOFaRqTdG+1htk6notLit8GBpBugXc5moUPr556KNGYS/8ycjqHopTi
        6V8Wza5jzzOCROOCUg9q3GH5wRQ34S91ZmnB7hbQpZ1eZwtQJGty+Ts+7p4Y4on6vOq2Z/S
        SMUn6XXK0/juSjG6r8wfCVj2C7PCGpfJqt26BtisxOraWjs84CTVhrmtmah+G/UFNftSrP/
        vMezJLoeLS5A9lzQZ0JEt5JoOOVbfZFDdETQ==
X-QQ-GoodBg: 0
From:   Yisheng Xie <ysxie@foxmail.com>
To:     b.zolnierkie@samsung.com, keescook@chromium.org,
        j.w.r.degoede@gmail.com, david@lechnology.com
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH v2 fbdev-for-next 2/2] fbdev: fix typo in comment
Date:   Sat, 30 Jun 2018 15:30:48 +0800
Message-Id: <1530343848-4344-1-git-send-email-ysxie@foxmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change beeng to being and occured to occurred.

Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
---
v2:
 - new add one.

 include/linux/fb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index fd31e6f..3e7e753 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -126,7 +126,7 @@ struct fb_cursor_user {
 
 /*	The resolution of the passed in fb_info about to change */ 
 #define FB_EVENT_MODE_CHANGE		0x01
-/*	The display on this fb_info is beeing suspended, no access to the
+/*	The display on this fb_info is being suspended, no access to the
  *	framebuffer is allowed any more after that call returns
  */
 #define FB_EVENT_SUSPEND		0x02
@@ -159,9 +159,9 @@ struct fb_cursor_user {
 #define FB_EVENT_FB_UNBIND              0x0E
 /*      CONSOLE-SPECIFIC: remap all consoles to new fb - for vga_switcheroo */
 #define FB_EVENT_REMAP_ALL_CONSOLE      0x0F
-/*      A hardware display blank early change occured */
+/*      A hardware display blank early change occurred */
 #define FB_EARLY_EVENT_BLANK		0x10
-/*      A hardware display blank revert early change occured */
+/*      A hardware display blank revert early change occurred */
 #define FB_R_EARLY_EVENT_BLANK		0x11
 
 struct fb_event {
-- 
1.9.1

