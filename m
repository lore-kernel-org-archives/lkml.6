Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E2EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792AE20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gJBdRqMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792AE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeICVN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46313 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbeICVN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so1214704edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHs5nPsCs9uvHVOBwfAqH+S8GyHzjtIhAK2oeqfZ/B4=;
        b=gJBdRqMW/0B7BTGBMxY/ZfhvF/cSUCzGnqTVhkPdCNYJFOYeAnaQ8mWYorDrwuNWUm
         VAk8uT4iALMT06ESQ30l0BVnkbzXJhn+irhbGznFp8d1l9gIyNDqnZD/45PHefFZutvD
         jkzLtNcMWmBYiVVtZGYnDJZ1OTPNJyc6l5l0ADXlBJj/XreMeSvfwx7XaPtmgFLz+JQn
         vUpmftN0E8tPpuaRhc2ExZ6ATSihYYb03snag1P4DJi3/uKY1GQjVxPD2udUcYti8zVC
         O3k7eqCRNo7/XdjvXGiRRCt1X/GXC6CNqLxbxdcrYtppHDJfnWwDeBPDqyOuowKBj/9p
         H5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iHs5nPsCs9uvHVOBwfAqH+S8GyHzjtIhAK2oeqfZ/B4=;
        b=H9roZhWe5tU4Lh2Tn57fI3vUHvkcsL+E0r2YnkO556nKPsyQjFA3JUXnmFRRTCATxM
         aJwrMyAGaJRTXLzEVHosO6gFDPc6+HAJnpTkHKCyqVGnvNjv0r7ZsuwP8Q25EqS9Uqmc
         DPoZPQ8wuBLidnoD71Z+IWtxAkicZXgRh1sCyQZwswiCQS3yIU3kyeBxErn6/MWttlqy
         7B8MGL+sdEAHTN+GRoUdDg8UmcCso/47lbmHp6j9FfT2IXySeDjIn2fhhto3qkIm/TBM
         YzUAeAuSR6SvrYEjR6arzO0bHjgYSM/8KSfrtU3irlxuKVabWRMAjLn+/WPSRCz6xlPP
         fgfg==
X-Gm-Message-State: APzg51ALmeT21rseqdoyEcneyGXOd2cev7QTZYavXTRxAI+57fk9vbjd
        j/ty5iQZbHrjc7eGxEDDwzxMuBo8QWM=
X-Google-Smtp-Source: ANB0VdaWYXnhKvY/8PaPjiZQMs3mIg5m8BsGbRUwyydqKEnjE9MOSb7DGyu9gl5ueIcCq6iGo1uC8w==
X-Received: by 2002:a50:b8a6:: with SMTP id l35-v6mr33259979ede.273.1535993581231;
        Mon, 03 Sep 2018 09:53:01 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8085745ede.14.2018.09.03.09.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:53:00 -0700 (PDT)
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
        Jiri Slaby <jslaby@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCHv2 1/4] tty: Drop tty->count on tty_reopen() failure
Date:   Mon,  3 Sep 2018 17:52:54 +0100
Message-Id: <20180903165257.29227-2-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180903165257.29227-1-dima@arista.com>
References: <20180903165257.29227-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of tty_ldisc_reinit() failure, tty->count should be decremented
back, otherwise we will never release_tty().
Tetsuo reported that it fixes noisy warnings on tty release like:
  pts pts4033: tty_release: tty->count(10529) != (#fd's(7) + #kopen's(0))

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: stable@vger.kernel.org # v4.6+
Fixes: commit 892d1fa7eaae ("tty: Destroy ldisc instance on hangup")
Tested-by: Jiri Slaby <jslaby@suse.com>
Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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

