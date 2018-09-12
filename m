Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ADAC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B2920882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="O0Qx/oze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B2920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeILFTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:19:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41348 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbeILFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:19:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id f38-v6so334728edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ECZjS3XHs+09wR5Lf3NBLD9krvZo43u8X49D9BHsa7c=;
        b=O0Qx/ozedU6JZ7YBPxdsdAuVn5Niu7vkkhFkvik9pJLiPlZbnYbcgKRYX1YVN1HwQT
         faXEKmS0oGph9zqDs2d4373RRTMPmvWEbDuZJ90Mh2E67uqRGemoFPcJlEKXkRye/9su
         /2CvIQ5VBWJ8fsNEICWJ8sS6gii8p3CE5jXk3n0e8S6cLX6O8yaZ/9UT/K8HKqFxJLIG
         yYOcwH8Z/ytvjgOGvmyKPl6MDtyuzhGfSLzB1mSkfqPMN3HBseAawhSJ2r0ufh3DJDdH
         aZBdsVD404WANibv0VnMVoxNlqoSpSVnd3f7LhghaAF/15zAAPChh499APK5JckO9DRC
         NGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ECZjS3XHs+09wR5Lf3NBLD9krvZo43u8X49D9BHsa7c=;
        b=E7DEKYBlD7RrjDfGxhv2Cgg5aKP+lECl12bj1t1xgemeeUe3fkKP3r7hLmoA270VSa
         ZMrBm8K2OrzziQ6gZXHIXwzoOLvGjHUvQ9wrRAFxW9SIJcUEDfK4Z8hwluz6LTfTESOj
         AF6qKu2vXvWEFr19KTkwV4TbcJfL83JixeKH/wh04eHridonVWk0/MkuGKjqUZEuQki+
         cWR2fuCNH+DiQ63bH9n7k/t9VM/lLbzkjc6F0xI4M5p/X4MxkVtFLIkNIcaIP9yHucbD
         orYxXpBDuT4hquCSFZgnY4ybxnB1Obt0g7wRaI877iWndtpf1hY8LXQ0CzBeGA9ZsGNM
         vnTw==
X-Gm-Message-State: APzg51Bh93hMx/ePcHFDg3a7zdfcoGz+gkNGsQNTCVr2xvSC0sNnVcc8
        ilcXuoNKe5I+DLnPZsDTLCm8YDluWmw=
X-Google-Smtp-Source: ANB0VdaG2lpRxM3SH6tRXQQ7Z3xY5jzYj8AHCI/h1s1IReNkndhrg9XPUNdS0PHTFiFsBrN/gbElXg==
X-Received: by 2002:a50:91da:: with SMTP id h26-v6mr30728661eda.87.1536711434045;
        Tue, 11 Sep 2018 17:17:14 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l16-v6sm10380593edb.41.2018.09.11.17.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 17:17:13 -0700 (PDT)
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
Subject: [PATCHv4 6/7] tty/ldsem: Add lockdep asserts for ldisc_sem
Date:   Wed, 12 Sep 2018 01:17:00 +0100
Message-Id: <20180912001702.18522-7-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180912001702.18522-1-dima@arista.com>
References: <20180912001702.18522-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure under CONFIG_LOCKDEP that each change to line discipline
is done with held write semaphor.
Otherwise potential reader will have a good time dereferencing
incomplete/uninitialized ldisc.

An exception here is tty_ldisc_open(), as it's called without ldisc_sem
locked by tty_init_dev() => tty_ldisc_setup() for the tty->link.

It seem valid as tty_init_dev() will call tty_driver_install_tty()
which will find ops->install(). Install will establish tty->link in
pty_common_install(), just after allocation of slave tty with
alloc_tty_struct(). So, no one should have a reference to slave pty yet.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldisc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fc4c97cae01e..bc0171f984a1 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -471,6 +471,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
 	clear_bit(TTY_LDISC_OPEN, &tty->flags);
 	if (ld->ops->close)
@@ -492,6 +493,7 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
 	int r;
 
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	if (IS_ERR(disc))
 		return PTR_ERR(disc);
 	tty->ldisc = disc;
@@ -615,6 +617,7 @@ EXPORT_SYMBOL_GPL(tty_set_ldisc);
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	if (!tty->ldisc)
 		return;
 	/*
@@ -662,6 +665,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 	struct tty_ldisc *ld;
 	int retval;
 
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	ld = tty_ldisc_get(tty, disc);
 	if (IS_ERR(ld)) {
 		BUG_ON(disc == N_TTY);
@@ -760,6 +764,10 @@ int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 		return retval;
 
 	if (o_tty) {
+		/*
+		 * Called without o_tty->ldisc_sem held, as o_tty has been
+		 * just allocated and no one has a reference to it.
+		 */
 		retval = tty_ldisc_open(o_tty, o_tty->ldisc);
 		if (retval) {
 			tty_ldisc_close(tty, tty->ldisc);
@@ -825,6 +833,7 @@ int tty_ldisc_init(struct tty_struct *tty)
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
+	/* no ldisc_sem, tty is being destroyed */
 	if (tty->ldisc)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
-- 
2.13.6

