Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A385ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457562086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="S/Av1QpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457562086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeIKGpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43494 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeIKGpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so17970997edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WXetIM1/lmNecOHkXeBY+Gy+oRJw1y5k0ELpXc/Nnl8=;
        b=S/Av1QpKoF3hQ12FTFdBFEctrX20kQUinYqvk90OgYgmTOQcKZLtNkGJAmQGuPVtdi
         dhNYJ95adI0OGKfNjTpTs1nRFJNRAXAtPD7gjO2CCNX9p0Urn8dbU9LdhEDxCwZqX7hM
         hrkSEElJdD5CWoHK3BhsDoA+RfUKsn8TO5wx+vv5ZxN90/jfdhfBVqAGTSDEVtEbUMi7
         oaqglYs6gzoCWUhLQ/e8fKIy1i4sRLpyaBOMLodMCaE2UkPMgEkreab0R1/bd+hZurVR
         NwlgeWG7o8boCnhQVKgeydcu0N2pl7FozI4MVMLIwj++mNZsfKtNgumG7edIHW/dSJ7k
         rCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WXetIM1/lmNecOHkXeBY+Gy+oRJw1y5k0ELpXc/Nnl8=;
        b=IKFiBeNnV1dWxn1+b9Si0xqrqqig71q0xOvorp5yHF+DgOI7j5RmHYZTS5kxaNEsvA
         wur5QbbwJ+1fg/WhDizJCx4bOfmqK8Cufc/TuxHRuBCatfg9XAhJrFUS4G8PAu7dgo9f
         czLCyhM7uM1WQlnlHmhYONqXzejlQUIjp24b5IkpFH612lnyF/lLUo/IH9kgBE3oGAlB
         ekX8IFYkFT7W1/FyP+vaXCky/iNB4XOclRRWAS+uHI7twLcv86avYWcNVUBD691TFIDJ
         /YryzsjMZ0wsPoVEhuRVoJS9p++ud5cZYp16XIQPLtb69HnviBB/iU+LlJU0aitUMdzO
         20Jw==
X-Gm-Message-State: APzg51DxwyBMcwF/J/EBVtB7KdC/5vPlq+eHS76Si0nrs4EpEpL3B9up
        pdm3cnxs48Xqag++gKnGCRE06+xGKBM=
X-Google-Smtp-Source: ANB0VdYT1bFvSeKiFPDdzOmau5SqWT95rmC3A0laLuodxeK8PW/01re+r190DJ+I9AXzzQBeN7Hj6w==
X-Received: by 2002:a50:b2a6:: with SMTP id p35-v6mr24946876edd.215.1536630507802;
        Mon, 10 Sep 2018 18:48:27 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:27 -0700 (PDT)
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
Subject: [PATCHv3 3/6] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Tue, 11 Sep 2018 02:48:18 +0100
Message-Id: <20180911014821.26286-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
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

