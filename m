Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09734ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49D92064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IjMLk3J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49D92064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKAJZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40426 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeKAJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id z12-v6so9411255edp.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXTWl8A4VzfUjFkIUP0VHJzOn4CYUXUd72JEuznvemU=;
        b=IjMLk3J0onJR0Bao6zT9Kbt1uO+SQMVmt/vWGvjqkhnksytozcJkH1M2YfLykRk0f3
         8LyTYcUvGuzPWmHFHVYjwDyN2hpGFkLhFTKgHqtJqklYCrnkmSKQWPM9PjSdL/ibufoi
         2Sq+xRC9JYro14l6rfXHPhZusEOqGbtNVSpT89zfobP3Y6rT0CRHaJWLGBkaQPItszvn
         5Vy9NDwKdmfUVbhLPcpvOPncZoNUlMViBDb6nRhdGxlG68c0Ewzjs8xrw0EEC379MmpE
         x0AfrRyPBbqRhQLPU+P6MW16McROmEUcB16m/wQnYGRrwPAw/MgNT3S1IXmoXKZZOUL/
         8NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXTWl8A4VzfUjFkIUP0VHJzOn4CYUXUd72JEuznvemU=;
        b=PPfHO9jg/TDqmyPTq9LeatWj7j9+VP7u7UR5EuYyugwZAELgxrO2kKqQh7DDYIrM9W
         8I0m2nIUh1NMOw+zq3+JuP9bUEeJ/x3vm3Kwp1FWqTMy7vFljUPuQkzVBCr3IlVORMlq
         alp7B0uJRwvQgHkvN9uGwwTUB7AHimA/FdYdDkuVdrpWgzyjgwPO7ydFlWX6ILdrflMy
         WHqL456qbuEro7e6Sg9SeQenLgrxFDbrbbipsUOF6oYWFe8gdy+wUTvm/iXtWyZV1gsB
         ugwlHfk6k2ai9QAPWaUJAS9QkdFjaBukA9LGu8NJIhDK4vZjbYQJ4Jn8ofQA5JQwXT7i
         vG4g==
X-Gm-Message-State: AGRZ1gKSb1pUH/5yoTaFg6bvXTFiaW9cFWmGLi1BHbUJai2zPvn/TF0G
        arN9PmOSJqGX6mXMN7zRw/07SLPKtdY=
X-Google-Smtp-Source: AJdET5dD2NwSh10eluYpYS2gBTP/NwW5Zb6pyQiTmPtqsFve3pH3wJgzDANANaSslSm7ubypCWXczg==
X-Received: by 2002:a50:b0e5:: with SMTP id j92-v6mr3625632edd.294.1541031899757;
        Wed, 31 Oct 2018 17:24:59 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:24:58 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv6 3/7] tty: Don't block on IO when ldisc change is pending
Date:   Thu,  1 Nov 2018 00:24:48 +0000
Message-Id: <20181101002452.5483-4-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There might be situations where tty_ldisc_lock() has blocked, but there
is already IO on tty and it prevents line discipline changes.
It might theoretically turn into dead-lock.

Basically, provide more priority to pending tty_ldisc_lock() than to
servicing reads/writes over tty.

User-visible issue was reported by Mikulas where on pa-risc with
Debian 5 reboot took either 80 seconds, 3 minutes or 3:25 after proper
locking in tty_reopen().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/n_hdlc.c    | 4 ++--
 drivers/tty/n_r3964.c   | 2 +-
 drivers/tty/n_tty.c     | 8 ++++----
 drivers/tty/tty_ldisc.c | 7 +++++++
 include/linux/tty.h     | 7 +++++++
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index dabb391909aa..99460af61b77 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -612,7 +612,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 		}
 			
 		/* no data */
-		if (file->f_flags & O_NONBLOCK) {
+		if (tty_io_nonblock(tty, file)) {
 			ret = -EAGAIN;
 			break;
 		}
@@ -679,7 +679,7 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 		if (tbuf)
 			break;
 
-		if (file->f_flags & O_NONBLOCK) {
+		if (tty_io_nonblock(tty, file)) {
 			error = -EAGAIN;
 			break;
 		}
diff --git a/drivers/tty/n_r3964.c b/drivers/tty/n_r3964.c
index 749a608c40b0..f75696f0ee2d 100644
--- a/drivers/tty/n_r3964.c
+++ b/drivers/tty/n_r3964.c
@@ -1085,7 +1085,7 @@ static ssize_t r3964_read(struct tty_struct *tty, struct file *file,
 		pMsg = remove_msg(pInfo, pClient);
 		if (pMsg == NULL) {
 			/* no messages available. */
-			if (file->f_flags & O_NONBLOCK) {
+			if (tty_io_nonblock(tty, file)) {
 				ret = -EAGAIN;
 				goto unlock;
 			}
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3ad460219fd6..5dc9686697cf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1702,7 +1702,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 
 	down_read(&tty->termios_rwsem);
 
-	while (1) {
+	do {
 		/*
 		 * When PARMRK is set, each input char may take up to 3 chars
 		 * in the read buf; reduce the buffer space avail by 3x
@@ -1744,7 +1744,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
 			fp += n;
 		count -= n;
 		rcvd += n;
-	}
+	} while (!test_bit(TTY_LDISC_CHANGING, &tty->flags));
 
 	tty->receive_room = room;
 
@@ -2211,7 +2211,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 					break;
 				if (!timeout)
 					break;
-				if (file->f_flags & O_NONBLOCK) {
+				if (tty_io_nonblock(tty, file)) {
 					retval = -EAGAIN;
 					break;
 				}
@@ -2365,7 +2365,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 		}
 		if (!nr)
 			break;
-		if (file->f_flags & O_NONBLOCK) {
+		if (tty_io_nonblock(tty, file)) {
 			retval = -EAGAIN;
 			break;
 		}
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fc4c97cae01e..9434d20cf3ca 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -327,6 +327,11 @@ int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
 {
 	int ret;
 
+	/* Kindly asking blocked readers to release the read side */
+	set_bit(TTY_LDISC_CHANGING, &tty->flags);
+	wake_up_interruptible_all(&tty->read_wait);
+	wake_up_interruptible_all(&tty->write_wait);
+
 	ret = __tty_ldisc_lock(tty, timeout);
 	if (!ret)
 		return -EBUSY;
@@ -337,6 +342,8 @@ int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout)
 void tty_ldisc_unlock(struct tty_struct *tty)
 {
 	clear_bit(TTY_LDISC_HALTED, &tty->flags);
+	/* Can be cleared here - ldisc_unlock will wake up writers firstly */
+	clear_bit(TTY_LDISC_CHANGING, &tty->flags);
 	__tty_ldisc_unlock(tty);
 }
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 414db2bce715..80ae5528ef8e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -366,6 +366,7 @@ struct tty_file_private {
 #define TTY_NO_WRITE_SPLIT 	17	/* Preserve write boundaries to driver */
 #define TTY_HUPPED 		18	/* Post driver->hangup() */
 #define TTY_HUPPING		19	/* Hangup in progress */
+#define TTY_LDISC_CHANGING	20	/* Change pending - non-block IO */
 #define TTY_LDISC_HALTED	22	/* Line discipline is halted */
 
 /* Values for tty->flow_change */
@@ -383,6 +384,12 @@ static inline void tty_set_flow_change(struct tty_struct *tty, int val)
 	smp_mb();
 }
 
+static inline bool tty_io_nonblock(struct tty_struct *tty, struct file *file)
+{
+	return file->f_flags & O_NONBLOCK ||
+		test_bit(TTY_LDISC_CHANGING, &tty->flags);
+}
+
 static inline bool tty_io_error(struct tty_struct *tty)
 {
 	return test_bit(TTY_IO_ERROR, &tty->flags);
-- 
2.19.1

