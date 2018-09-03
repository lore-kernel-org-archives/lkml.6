Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6597C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF862086E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="g9nzNJfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF862086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeICVOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:14:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37881 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeICVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:14:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20-v6so1239985edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/xDAv4nmvZM6/MSUvhwMtYq6DkyvBAstjsxswpf2i0=;
        b=g9nzNJfh9mHewg/e6MdLX7nSvvdht7dtf6cFFA6JT9J6yMrw5iDNqdbYiTp0/fZeHB
         tvke5/ey3IGv0CgL/4uRQ33rOozi47VdN2bR3EusgQA/Bp0QRG6J78t750VM2O6nfQkc
         K06qNAww4Nr8HmgUbYOys8NQAjt0lFRKsZjNMn9nyYe9Gln8stL/p8TkP8HtStWd5bxY
         Rmf7HwW49qRfV/Re9+xgqjZ8Hvyil/GDA4N2ZxLSpgr/JRqhYuMAiJ/FP8hhKn3MzU9L
         uJKEwJtzqkqQVeW7HX0qIbP9hc5HbTxKNuH7qsW15fxIZyG8bWSodUJrjl4AAEBURrne
         aOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/xDAv4nmvZM6/MSUvhwMtYq6DkyvBAstjsxswpf2i0=;
        b=HwUNpHaPzoFJuUV612vm3HWzDEmsUfsKycH+Zid7/+vHSUNF3+4qk1UB8999Sr23q1
         OEOzMujU98wFhyvrjBikMFFUgKn3/3srhk/e0vXC0VfAJzf205ZhsIfj06NmYvh70Kjw
         Nch+pLbzF06zf5r8qLzPPZsVHjHMr+AWzKUWLOwiyuXLVDOXhQ4oxwVH+G0pY84YL3P+
         IApvKHf0nacaGsJzS4r3rxUCp81I6kaY9064fSy+9F364Fp4l33BY/qyw058gbcxp2a6
         ohZR1s38CwfJxjHl3QuY8qub9iPoU1hYfQgatXu2MHx5ZT6y78wJTYfOeBMqkBqD3pbc
         lLkw==
X-Gm-Message-State: APzg51BFmpiGYi4Z0mI58YOjFne0W2RGOaT6HMRLNVN0bak6U0V4I61Y
        rLNsfdFvPoZezL4zjqQ4KBFz2WNTt44=
X-Google-Smtp-Source: ANB0VdZAsJjUjiijKxoHtSsXyhoW1q6/VNwQYuGdJB+OQ+Z86BHGi269oWw8o7NDNjQUdwJ+Xy+m6g==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr33437770edm.40.1535993582809;
        Mon, 03 Sep 2018 09:53:02 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8085745ede.14.2018.09.03.09.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:53:02 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: [PATCHv2 2/4] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Mon,  3 Sep 2018 17:52:55 +0100
Message-Id: <20180903165257.29227-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180903165257.29227-1-dima@arista.com>
References: <20180903165257.29227-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_ldisc_reinit() doesn't race with neither tty_ldisc_hangup()
nor set_ldisc() nor tty_ldisc_release() as they use tty lock.
But it races with anyone who expects line discipline to be the same
after hoding read semaphore in tty_ldisc_ref().

We've seen the following crash on v4.9.108 stable:

BUG: unable to handle kernel paging request at 0000000000002260
IP: [..] n_tty_receive_buf_common+0x5f/0x86d
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 [..] n_tty_receive_buf2
 [..] tty_ldisc_receive_buf
 [..] flush_to_ldisc
 [..] process_one_work
 [..] worker_thread
 [..] kthread
 [..] ret_from_fork

tty_ldisc_reinit() should be called with ldisc_sem hold for writing,
which will protect any reader against line discipline changes.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: stable@vger.kernel.org # depends on commit b027e2298bd5 ("tty: fix
data race between tty_init_dev and flush of buf")
Reported-by: syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5e5da9acaf0a..a947719b4626 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1255,7 +1255,7 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
-	int retval;
+	int retval = 0;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1267,15 +1267,18 @@ static int tty_reopen(struct tty_struct *tty)
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	tty->count++;
+	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
 
+	tty->count++;
 	if (tty->ldisc)
-		return 0;
+		goto out_unlock;
 
 	retval = tty_ldisc_reinit(tty, tty->termios.c_line);
 	if (retval)
 		tty->count--;
 
+out_unlock:
+	tty_ldisc_unlock(tty);
 	return retval;
 }
 
-- 
2.13.6

