Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008C520844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDWcqJ0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008C520844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGYCAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 22:00:51 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:35113 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388420AbeGYCAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 22:00:50 -0400
Received: by mail-it0-f73.google.com with SMTP id r184-v6so4221784ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=IXFWQrif5lHpzEaGyI+7rOwxQNASxjZB/sxJ05/r6js=;
        b=LDWcqJ0l7W8ki2dr7nHpmi1rLDW8gjsL6Bjz0ruAhSHQ3mepwfEB247rGoPHzXjVDF
         +28GC+uJ64f4ZtqrngWclEGo/UurKT/aq8cVjqejsAgtjB0e3FQsiBljcPeoU9HOUHgS
         VAwoppHAZtcxjO8AZwMzCOAyOxE9NY3NxbMAxE3eEnguwNkYrzLip0N5NsMRRbm9N2+j
         aHOFtvU8AmgrgRpscSC4KSxbAuQ9A9c0meVZtwq1KxITCigYAtmgE/nxPupALRMT/9oH
         88/U/L1zoYdhVoieV5kitgi4b07eMDTK1luY90FlvCgwuiJVhUaQVNokH971sTAhEGtv
         nc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=IXFWQrif5lHpzEaGyI+7rOwxQNASxjZB/sxJ05/r6js=;
        b=lnRUFES5MmQeL+ikvYHizcJ39BHjb+1Wz+QhHltBvCV+Fx4njSUS2hAbHJlNQOjBOT
         KLU3YkQNpKR4SKps6R2EbKbJJk7isDEmYQYlmIB+Gvj5ZUsAdPLYQyYlipdjLb1yOhW9
         DVkaA2VYloYBg8vccLjnPWqKpYLXIkqqzpLE4DJ93xjH+wMMe+SWieCyd8bRIjmbO5AQ
         aDrXeZjAdvkgvi4DN8DwBUORsYrPEb6Xj0jH/njhkjUsiEr5BnBk7a+Uk+S0n/vqzEly
         64NGb95R78bmh2nEQNH8u6FyE3CRhOw0xbtzfYQ3dyRaV4VG+BCoATNWXNofC2uT1GNw
         Rc8g==
X-Gm-Message-State: AOUpUlEPaLkeByXgLYr248PWxr35G7l3Z7qzdvm24g/uLyyMhdH4L+km
        vY8pizd5NfJsRRCEB098eouR2nAi
X-Google-Smtp-Source: AAOMgpfuAoL6KXJ0nW4kyj1a9a+PeRJcHLNyrat3Fy2dZdFcR34MVz/pc5nKO2/wi8yYsJr6epx1XvwZ
MIME-Version: 1.0
X-Received: by 2002:a6b:3805:: with SMTP id f5-v6mr7212046ioa.40.1532479905620;
 Tue, 24 Jul 2018 17:51:45 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:51:31 -0700
Message-Id: <20180725005133.107823-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH v2 1/3] tty: Address checkpatch warnings in goldfish.c
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

checkpatch.pl complained about missing blank lines
(between variable definitions and executable code)
and using just "unsigned" instead of "unsigned int".

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - Updated the commit message.

 drivers/tty/goldfish.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 37caba7c3aff..a92fcb2b0002 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -172,6 +172,7 @@ static void goldfish_tty_shutdown(struct tty_port *port)
 static int goldfish_tty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
+
 	return tty_port_open(&qtty->port, tty, filp);
 }
 
@@ -201,11 +202,12 @@ static int goldfish_tty_chars_in_buffer(struct tty_struct *tty)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[tty->index];
 	void __iomem *base = qtty->base;
+
 	return readl(base + GOLDFISH_TTY_REG_BYTES_READY);
 }
 
 static void goldfish_tty_console_write(struct console *co, const char *b,
-								unsigned count)
+				       unsigned int count)
 {
 	goldfish_tty_do_write(co->index, b, count);
 }
@@ -219,7 +221,7 @@ static struct tty_driver *goldfish_tty_console_device(struct console *c,
 
 static int goldfish_tty_console_setup(struct console *co, char *options)
 {
-	if ((unsigned)co->index >= goldfish_tty_line_count)
+	if ((unsigned int)co->index >= goldfish_tty_line_count)
 		return -ENODEV;
 	if (!goldfish_ttys[co->index].base)
 		return -ENODEV;
-- 
2.18.0.233.g985f88cf7e-goog

