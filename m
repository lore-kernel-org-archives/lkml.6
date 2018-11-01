Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF94C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E732064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="J8RsfFya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E732064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeKAJZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:33 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44891 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKAJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id n19-v6so4213254edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KTTxNUpzV2y7L2vECJT+5rBRgLaIPcy7D5Gk0Z/6hQE=;
        b=J8RsfFyaPnyYR+lv7UzQBtIzVlaXudg3v88jCXiwvaYQJgaXo3FW1BkNrHLCkfyat/
         dHXoW/bXr/JQcRHXDJMlHsXliISk22f4gSR8fXST7wUsQ+u2fMv+D62JNbwZI7oWQPDa
         8ilquwE44ZPeAxBU7s1fAw/0nWvNky0f7hzf70iATlTO+jPeNBgLUd/zQPPN9LuD8Cx0
         jogkLs2i9NrkXume9b+3CT+e71wC7WmgyDQdbH7fhoaLmG/aEnmTNk3kaR0egp1TdoaB
         1FJS4Zg9YrbcsfxvcDuQy8fx5e5OLtxnCF7+gdc/lwp4aHZEZnpBLTT7C6rpQbXOla0K
         Qz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KTTxNUpzV2y7L2vECJT+5rBRgLaIPcy7D5Gk0Z/6hQE=;
        b=GxHQ3orcc2OtP9+d6NWbb7RDPv+C71oH6t2Y2gQ5c0cEhYoZD1aTAzQnVrma0Z28L4
         DA6jhG29Lf3wtrc/b3mvGk58gm1ejEwhvv6KoG6515QEKkx9BNrDV1gDJZd3666wMT19
         xX10IIYZptYYHRxJa3oplZ8n+UIu+yOymvCspg9IVl0NfgiNJRsIdc1WiTiMhDVf8S46
         +TLNkq9q47OFsxxcTCITmp2ds2S3su2X0mOh5yK9couy+y8CxSGiu+XfM0p/mM4utXUs
         LhVpRrQxghtEUoXpn1uTjlGzzo6uRFkAHgUajR24CgkP+IIrV6X6ZmClEZi3/dUmRJXn
         rR8Q==
X-Gm-Message-State: AGRZ1gLuBBGSMASuBSnhw+vpwy9ki+YbLyfbpFnWHmyLE/2DN8OHehxv
        KoJYXflKo++dWke4qwnHCKJB+DsZrgk=
X-Google-Smtp-Source: AJdET5fCZPOl2FydWzaVSktfugyxwnORlD8YHAtmD0D3QaOeH1sYR3pZybSHlZGK5Um08eIJcBw3pA==
X-Received: by 2002:a50:e68d:: with SMTP id z13-v6mr3538147edm.275.1541031898177;
        Wed, 31 Oct 2018 17:24:58 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:24:57 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: [PATCHv6 2/7] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Thu,  1 Nov 2018 00:24:47 +0000
Message-Id: <20181101002452.5483-3-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: stable@vger.kernel.org # b027e2298bd5 ("tty: fix data race between tty_init_dev and flush of buf")
Reviewed-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Tested-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ee80dfbd5442..f73d8fa7f02b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1268,15 +1268,20 @@ static int tty_reopen(struct tty_struct *tty)
 	if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
 		return -EBUSY;
 
-	tty->count++;
+	retval = tty_ldisc_lock(tty, 5 * HZ);
+	if (retval)
+		return retval;
 
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
2.19.1

