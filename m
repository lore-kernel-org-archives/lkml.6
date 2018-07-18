Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C79CECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE92C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PtICQxvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE92C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeGRAuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:50:52 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:54317 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGRAuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:50:52 -0400
Received: by mail-yw0-f202.google.com with SMTP id c67-v6so1553551ywc.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=JghNQHeW5xr/NbQnvbPN+t1UI1NfcYUpukHrR5J4tV4=;
        b=PtICQxvPN1iAlcxcklMN2xkG7pWxFkWTgW9gLCe/r61++fUJeV0cN+6oBfmXZVvs7G
         qCU8TsNqpu2Qg91KcpMv/Sku3u63awJ8qLZvLreJ/VHvOuHgZnA6wcfYY2f/IXe9Bcxh
         iP0Z0xYt7m+j+a0lfwrWlUNn8sWScPnGCT+gWpKSlf70UBe+9xNw4DJFNZLBIxiC/vzq
         pIjJDNRRG9uGqQfuCYyDX30Lf7Gm6DhxMtbIoOAyTnbNo+GqUmRcSdWuY62qzWG7hHck
         hRIc9Boy3AyzVz2yINHnxnSL7Gz2VKunSFoOU7FLhXo4X4jOeFK206U9i+CXkZ02yel+
         +twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=JghNQHeW5xr/NbQnvbPN+t1UI1NfcYUpukHrR5J4tV4=;
        b=RlcpPGo7g/RxODzlmKwnKfyQCzO2qFFX6WMGvMhyay7tzYUhFMCxI9IQ4S2WvllIZE
         kL1h/3GQG0N6RfaYRQ6/gflcLvzErh8/cZY3wKFhAiRZ+pV3sAo42XbURPGdRagW5nlf
         F//nZK6+SVq9NI+kbhQ43g8qQn668f+npBo86hov8mDrKJl5ESK5Zq9HEgN9bJoyJjk9
         fC9gpTEji4EkhjyMNaXuIefV7TwNgZwaBAMa7jMBs2mCeOa9ZBIGW4Tqu8yEVT/FJ3CW
         U6zVO+LO4/vyHks5Cc5dCDT4gQ+ZHR1cmEOrq3WEholGGnatP9UplTdN0Y7mn9RyB5U9
         9/zA==
X-Gm-Message-State: AOUpUlEYtM0J4i1stX6lBhhQJVJbFj84csEHPS4O7gZusUnkVN+m29Ix
        19Cl+joAiqbg2pDI9DN1z5IhuGBO
X-Google-Smtp-Source: AAOMgpc/upH3MJfAODolwM3Ep+TmORDPOkIBIgZRP1S9JCxHdsEM9fKBNVV4/EgHZBau9L0zRoO5702O
MIME-Version: 1.0
X-Received: by 2002:a25:918e:: with SMTP id w14-v6mr1141009ybl.71.1531872946870;
 Tue, 17 Jul 2018 17:15:46 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:14:53 -0700
Message-Id: <20180718001455.140575-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 1/3] tty: Address checkpatch warnings in goldfish.c
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

To make further maintenance easier.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
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
2.18.0.203.gfac676dfb9-goog

