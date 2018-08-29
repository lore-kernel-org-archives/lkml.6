Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC33DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941332087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Iqqlx2ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941332087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeH2GSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:18:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41059 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeH2GSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:18:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so2776160edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 19:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S7Gdz8f+d0QRuXH4m3CGrNUsSVTAMq0zSrFsieVgUec=;
        b=Iqqlx2ieNdVj7kcLcAcpLdtO9s1PlSPd9tDi0q5CVokbqYOZJBXc0Dpzp0B0nj2JjS
         LG2oCL8qKSuQejTVCNuWPUgZ1UV7JaDpvuaEYchgSu0+t4TViGx+i0OxH48T+V+EpuVK
         I9FwTLZ6x7H/7DHxldnMFPvzHbiHP7NUxlwjC+ub9yW56IzRKSvpwLgjRvt5tHVFFBMi
         MZcq9V5wOTirRS8b/1R+eK0sZiIS2/mExKlgnl7rEien2fNoj6E50FSF6ExFT4qSNed6
         XBsTNyxHY32PijoaWkCgNNQOYhlseUAKJEn5NJHtI4FFnGZT03Q2/zWDj7sSXYXjDkP1
         23Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S7Gdz8f+d0QRuXH4m3CGrNUsSVTAMq0zSrFsieVgUec=;
        b=FFQgANP9npClvvtIyd8nTYPsDe26VZ1EUCk7IloKYXoQMErMfhua2wwTEsijQ1r0ml
         zs45vInZif8zS9oZEtfwhBX98jLfeFcSeF9QU83w1LObgSQrv6dd+KRtHFoSNtWDmHzk
         7msO6eyyX+MH/GhQy26Vv/A3z2QFZR85KZDW04KHUONM/JABGAtopwKWoyto74gcxoBP
         DxEAhz6CGGQQZ0AjWVd95/524LUDgePWXEG1Vf8bwKeibMYJffJr42kuudWosR2wCn/s
         zC7fcvCCKM1wgxOA7cJPYM/emtko/XmBxvaMdmAG+hwPUAXSnmxtu1cdVK2yMkS+c52j
         HxVw==
X-Gm-Message-State: APzg51D1+o4XHHhgD5nNdJ4rmWRJFeFBO/qmykMPDxwi7YEQ1nte+ZHY
        d74EUrEUXxbL7LPVRuWbqcxj23ewioM=
X-Google-Smtp-Source: ANB0VdYZq0SwRE5kR9QvyoUBLOSoi1ZQxawYlj0xA6/uYFpH6iqYAEs3hjVcK/Wcky8VaOuJBpF06A==
X-Received: by 2002:a50:c8c3:: with SMTP id k3-v6mr5035754edh.193.1535509438765;
        Tue, 28 Aug 2018 19:23:58 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1236367edb.28.2018.08.28.19.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 19:23:58 -0700 (PDT)
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
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 3/4] tty: Lock tty pair in tty_init_dev()
Date:   Wed, 29 Aug 2018 03:23:52 +0100
Message-Id: <20180829022353.23568-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180829022353.23568-1-dima@arista.com>
References: <20180829022353.23568-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's safe to not lock both here - done to silence attempt lockdep assert in
tty_ldisc_open(), which will be added with following patch.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_io.c    | 5 ++---
 drivers/tty/tty_ldisc.c | 6 ++----
 include/linux/tty.h     | 4 ++++
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3ef8b977b167..a94005f915b3 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1342,7 +1342,7 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
 			__func__, tty->driver->name);
 
-	retval = tty_ldisc_lock(tty, 5 * HZ);
+	retval = tty_ldisc_lock_pair_timeout(tty, tty->link, 5 * HZ);
 	if (retval)
 		goto err_release_lock;
 	tty->port->itty = tty;
@@ -1353,9 +1353,9 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	 * to decrement the use counts, as release_tty doesn't care.
 	 */
 	retval = tty_ldisc_setup(tty, tty->link);
+	tty_ldisc_unlock_pair(tty, tty->link);
 	if (retval)
 		goto err_release_tty;
-	tty_ldisc_unlock(tty);
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
@@ -1368,7 +1368,6 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 
 	/* call the tty release_tty routine to clean out this slot */
 err_release_tty:
-	tty_ldisc_unlock(tty);
 	tty_info_ratelimited(tty, "ldisc open failed (%d), clearing slot %d\n",
 			     retval, idx);
 err_release_lock:
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fc4c97cae01e..b72266461c00 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -340,8 +340,7 @@ void tty_ldisc_unlock(struct tty_struct *tty)
 	__tty_ldisc_unlock(tty);
 }
 
-static int
-tty_ldisc_lock_pair_timeout(struct tty_struct *tty, struct tty_struct *tty2,
+int tty_ldisc_lock_pair_timeout(struct tty_struct *tty, struct tty_struct *tty2,
 			    unsigned long timeout)
 {
 	int ret;
@@ -381,8 +380,7 @@ static void tty_ldisc_lock_pair(struct tty_struct *tty, struct tty_struct *tty2)
 	tty_ldisc_lock_pair_timeout(tty, tty2, MAX_SCHEDULE_TIMEOUT);
 }
 
-static void tty_ldisc_unlock_pair(struct tty_struct *tty,
-				  struct tty_struct *tty2)
+void tty_ldisc_unlock_pair(struct tty_struct *tty, struct tty_struct *tty2)
 {
 	__tty_ldisc_unlock(tty);
 	if (tty2)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e3978b00f..5efb8f87ffdc 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -409,6 +409,10 @@ extern void tty_kclose(struct tty_struct *tty);
 extern int tty_dev_name_to_number(const char *name, dev_t *number);
 extern int tty_ldisc_lock(struct tty_struct *tty, unsigned long timeout);
 extern void tty_ldisc_unlock(struct tty_struct *tty);
+extern int tty_ldisc_lock_pair_timeout(struct tty_struct *tty,
+		struct tty_struct *tty2, unsigned long timeout);
+extern void tty_ldisc_unlock_pair(struct tty_struct *tty,
+		struct tty_struct *tty2);
 #else
 static inline void tty_kref_put(struct tty_struct *tty)
 { }
-- 
2.13.6

