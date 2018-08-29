Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4BDC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FDE20684
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="isqoiePY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FDE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeH2GSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:18:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40557 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeH2GS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:18:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so2774748edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2rsiF9P7p4ynflggwgQAjCIBGcKV6Izc/9GngY6csc=;
        b=isqoiePYDPMoVP/o8d00tZRP2sQ/VhKkInY30WDLQEPiDInVt1wvjSXMc0MJrWuo52
         4U6PFk+AJzsfyJo4sj0rwZ6NHITnJDl4aukOdDCl/Ge52V7NsE1pXIqLTuD/MCcuTSlH
         4lo04m9LeQYTm6NBIMDgtrejHvezq77Ycq5mraSpljPR2iVVinH+s+DnMxtx1QDWVkgm
         AlePicT4FBJK27EZlxIl/roh0EuS9oJ8D86tXq2WsAOpX/j8jznwKmt0C3Al6UFv9W1z
         AOK+BHWS53Q8gGOI6CGA52IMfLTlfqlmdGRl9wDXNP/slbtRDxT2XpMf5LjzmNNFIzeN
         9nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2rsiF9P7p4ynflggwgQAjCIBGcKV6Izc/9GngY6csc=;
        b=VN6OF56tICt5K8YKCE6gEX8odoJhBCruUDBLxtX5fH6IjRklyrkU8l/BKo+/9leWER
         oPkcI80FFrruwfVrzGo0ZevTsFGSb7dqCt4ZNkVzZBQ2xoLKABYYlF/DChvlULdjLPBk
         n9qVYaCpGt3oh5Bd/XvZhe1C9pmIi/bD0ooBr2p/qAbNfw9L5ot0r6uN9rlLVgWwyd9Z
         imKJIPKvEOj8KS5WKsVb0PoKm2RrB5xSNDZpDIncBsUl93+E4iMHrFKEW3tYKz+BkQYO
         k5+TSmJTo1ecJU4VJsAHbNkIFj70j7w5uWaOjd29kZrITSBIDiVp6LK1yES99pgvh4bQ
         VJyw==
X-Gm-Message-State: APzg51B9Arxc8QfIPfBrGQdIai+fCc7lCR4Kg35o+43qAXOoFTHVzyTc
        Li9fcy5Mr7mE0OzRC9rlMvDjM5T9TWE=
X-Google-Smtp-Source: ANB0VdZPPNJxRzqD0vTiWY3Ezb/N0x1I9xIz1hVA6fevpcssiRUlCNzrd4Wzo1GUf02/+cPJhg5Fog==
X-Received: by 2002:a50:aa3b:: with SMTP id o56-v6mr5199849edc.23.1535509436176;
        Tue, 28 Aug 2018 19:23:56 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1236367edb.28.2018.08.28.19.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 19:23:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: [PATCH 1/4] tty: Drop tty->count on tty_reopen() failure
Date:   Wed, 29 Aug 2018 03:23:50 +0100
Message-Id: <20180829022353.23568-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180829022353.23568-1-dima@arista.com>
References: <20180829022353.23568-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of tty_ldisc_reinit() failure, tty->count should be decremented
back, otherwise we will never release_tty().
Never seen it in the real life, but it seems not really hard to hit.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3fe4d3..5e5da9acaf0a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1255,6 +1255,7 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
+	int retval;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1268,10 +1269,14 @@ static int tty_reopen(struct tty_struct *tty)
 
 	tty->count++;
 
-	if (!tty->ldisc)
-		return tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (tty->ldisc)
+		return 0;
 
-	return 0;
+	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
+	if (retval)
+		tty->count--;
+
+	return retval;
 }
 
 /**
-- 
2.13.6

