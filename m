Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E1EECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B357020C0E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="b9kLMgSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B357020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeIRFWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:22:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34542 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbeIRFWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:22:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id u1-v6so403130eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 16:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ECZjS3XHs+09wR5Lf3NBLD9krvZo43u8X49D9BHsa7c=;
        b=b9kLMgSyX5AdD+CXIWxZHUFeLAjic5XLFdFIe7tLHNMI15Xuv2AatL7x9fkdqJ/Mup
         W4L3+r0otZBlbaYf9VMPgnMud255EJJoCYsZPpeCBC/NHn+1rU2X2UCXsU1vKKizadYk
         dURJDsjK9OUW1zDXMDbDpeeVOvzYasUbHs0+nwXOjgkw+PHBU+ku8GBYz1tSKw8axjlL
         RehXWF12B5CyBASpJARHd7pveLYvpPTtXoMl5Jc0XNeJfK5gN2jTRh+8gHHYWhvc8jRn
         zyoCOdFfi2G+Npo6ZvSKNRez4tsoNISmwf946ovt00tIOq8jjjCDkqyaiN5tE/6fnjLR
         oRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ECZjS3XHs+09wR5Lf3NBLD9krvZo43u8X49D9BHsa7c=;
        b=RQF4UhBFv7CsCYE2kQ57uwK/pX35qfDAX9J3vKTyllvJVaQDcccwFMxft8sSLRuew5
         yn703gVE6/gUGc8kxQNsiz22us0/r995uNs55AoBYO1/T1kck5WMhhFaZ3tGGB674Tnj
         pfoSlb2+G3OIZoJ7gS6ERnlQzuQIsaQ051aLEO84yQl6Iz4Tc6uXkZplbXtsyhOdaNlO
         wlLP8aHeG83u0BS/feyCoXyW5FeWotVwZum9og7y7Soa72IrukUWu5stbXSTBE87vxK1
         76XVUPpIJxM07VDrOHxuJB05zrkZEEf9IF0J1C0eox99ANSXQSe6Qyq9e3+3fhzqeuEW
         yAhw==
X-Gm-Message-State: APzg51BJKCEpa69l2Mk40QxXn1Gt20o3VrgTPYBWYvhHaD2NUZX7dGj6
        pztGzQMfgcy1yvNZH3WNYHcUnL1R9LM=
X-Google-Smtp-Source: ANB0VdbVYDMOkeleKXsbB9WAxHrVQuaz0Le32H3NhLGi5V4jBbsngpzO2sQmKXNyWJ3r6mibKmHo2Q==
X-Received: by 2002:aa7:d056:: with SMTP id n22-v6mr36453063edo.42.1537228388964;
        Mon, 17 Sep 2018 16:53:08 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r35-v6sm7193912edr.59.2018.09.17.16.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 16:53:08 -0700 (PDT)
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
Subject: [PATCHv5 6/7] tty/ldsem: Add lockdep asserts for ldisc_sem
Date:   Tue, 18 Sep 2018 00:52:57 +0100
Message-Id: <20180917235258.5719-7-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180917235258.5719-1-dima@arista.com>
References: <20180917235258.5719-1-dima@arista.com>
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

