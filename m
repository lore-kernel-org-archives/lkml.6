Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF60ECDFC0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822AC20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XbMM+QW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822AC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeILFSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:18:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35779 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILFSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:18:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so362479edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG4AuSRFxAsZ+FcIpFPikBp4Rr2AKaPnrBwREdUxh6U=;
        b=XbMM+QW6ciCaxAiqFWIxd8390CymJPUDnfKBG1ERTGt9/51OvvkKnpuO6K9PNQRoM0
         3uoRKdJftyJ6Ls7lb79s0slSG0vhjDJ3E6Ww5a11YdyqMC0mbLoY1ZtDfmx/D6Lcta7a
         ctLKTVeL/eLEJbiBGAd3Kpds627xruwPZVs1r6V6MM3fuFreZO1vElmOt7yQEWKwE/Qa
         6meAmmJWofsr4gwHRj/RERYnEG0Plg3oGI5jfsLZPNDiOEzzB5Ro9ULxuCcl/RF2uqOz
         QDv8+cJU2KdUkELQtfq/ykI7UoTJNllLcEQZGWzoYfTM/Xp6tWT+KBDR/cT0tIbZgSH7
         TiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG4AuSRFxAsZ+FcIpFPikBp4Rr2AKaPnrBwREdUxh6U=;
        b=XLbWdv/9OAc6vCkvT0U5vDMPJpVL/NdhWEwEbV+ddJmIoFljuRW4LXL52PgPpdDSXp
         /nwiwSDp0Z/4k90kb72a0Vpr45OkWg5SJSzuCQryDU7J0ItyvXkz2dkN8VMtRjaqIqoX
         vKVRDx9LaSkRYvOOgGVg4f8b3P9oHC90xj7HWVBfK5hfGYC6HoKT6zUHt7h379VTVacy
         HEqVAm3FhVu4kma2v0kAg6FRlRtGinh8e80P7XGvLDKiOm9qjlCbJMYO+pZyTNw34U+G
         OSu/ra7gsB0HD1CpoyNX4wmZFg2zPzI7ReNJQpJFUiO0llI4kRtIpkWK/vzaUrrLMuhE
         Wlfg==
X-Gm-Message-State: APzg51CgF6XsZ4c5Tz8t8KS4BESknNwrv1qYwAegyyH7eUXIRWNgdwSz
        dX+SsHt3otgrMxumYqzwf9UMg9DZBas=
X-Google-Smtp-Source: ANB0VdbswXIEGtOdnnbc3DC9ySwkr5SzcWpV5pSn9XDFibb51QS+2yo6meBsWFmmXa7enMADue3vng==
X-Received: by 2002:a50:cf42:: with SMTP id d2-v6mr31526449edk.242.1536711428577;
        Tue, 11 Sep 2018 17:17:08 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jiri Slaby <jslaby@suse.cz>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv4 2/7] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Wed, 12 Sep 2018 01:16:56 +0100
Message-Id: <20180912001702.18522-3-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
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

Backport-first: b027e2298bd5 ("tty: fix data race between tty_init_dev
and flush of buf")
Cc: stable@vger.kernel.org

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Tested-by: Mark Rutland <mark.rutland@arm.com>
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

