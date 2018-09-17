Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CA3ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792DC20C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="NVqy7+8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792DC20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeIRFXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:23:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33619 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbeIRFWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so411622edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dcu5K2A3gkhR5xavIBmd5tcJGwCobJLSptYeQ9hDahw=;
        b=NVqy7+8l2Se1UnsAobAEbwMv+NUphoij58ArZHoXjjtnd+TvVlVRmNZ5ZD9CIkWHuf
         9UOay+bREjg2IMtN4Rk/YwUm78Hxy0yYx0m35SLSE/ksv4ODOQa8VdwWtrfAGhifyA3H
         726/vKhmQyTaS4d/L/3DCZL/2a7tBkls5tpcRvGVTg15rlNj2frvgzmHCvfPULDm7t/4
         lhjLMhdz/pxO14QdYaZn0QPLxjS9Wqvn3YewmUjVBXI6nl4v6CYDg/E/CRTUx+13FXXK
         5K8/7gJVGbcwTjPNLLTdRIWG40Z1AKXGPFy+aW3t5znVkSQi8c5QjfItsbnCLPI95Yql
         5OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dcu5K2A3gkhR5xavIBmd5tcJGwCobJLSptYeQ9hDahw=;
        b=XSlRKRhdNz6jruu1o2LvpLHWbpXBIbmIYyftk3OLaTxUmEYGxfTdq6qkriDDU6/Umq
         ZLGSlsrkGR9/zwkLHbgKfNYWhCm+K81/zpvVq9EqVpoDyk5ZYiTRoqo46koatvK2FRun
         oPeglkYoLrGMCB7HxMsEIv+Q1ovrY0m/X180JmWT8u8cvEdiftYxwveZ59cuzztQ+tXW
         4tQsMMw37nMWvEpBrad+hDrn8/HiGNC1qNyUF7cp277m4F4Zod0kbPakPvjmMDm78xS4
         BWjOzvZAsdFC/NF68zDO+tcFH8U2S6FHEHiG1G2dz3aA2EVFxRq/brM3wflRGJMN24YW
         6Hrw==
X-Gm-Message-State: APzg51Aa1uezFGZ6PtrtwJaMeZetyRfjTCCwA2i/ULsyJEgrcCc537JW
        btqgze52PVZjpw8zWy9vIBkVQ6VnHsc=
X-Google-Smtp-Source: ANB0VdZo0j5UI32eo7/Sw2L5tTb9k7De92W3PbQYrkxliA3Cgeew7uAowMgM3wReCCijTmdRptR3LA==
X-Received: by 2002:a50:fd10:: with SMTP id i16-v6mr9074482eds.253.1537228384796;
        Mon, 17 Sep 2018 16:53:04 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:04 -0700 (PDT)
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
Subject: [PATCHv5 3/7] tty: Hold tty_ldisc_lock() during tty_reopen()
Date:   Tue, 18 Sep 2018 00:52:54 +0100
Message-Id: <20180917235258.5719-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
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
 drivers/tty/tty_io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5e5da9acaf0a..3ef8b977b167 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1267,15 +1267,20 @@ static int tty_reopen(struct tty_struct *tty)
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
2.13.6

