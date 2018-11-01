Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D6AECDE44
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3001B20830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FAyHIiOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3001B20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeKAJZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:25:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34423 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeKAJZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:25:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so15187396eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 17:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yBpMe8bZONmbG+T6QYM7RuhqpeWJdERGMTR2wSH4X8=;
        b=FAyHIiOGvbazTRsu8glKhqADCozbrQTW0r30QiOJbpyIALehTsMCIwuTRgvc4nbk2c
         DNX5ovXwmKUYJ1hDOe8m2bbYkoujGdSgmYYRPdh+fdRvDpdUqBNU2yvi9UGKHcuUAKZX
         Rxs2hyY/wKulkoG/9xX7mLZ9NoJfU2l+Q6ck1sY79KaxvCdIj5nEQWxLTRrCCm05gV8n
         h5YJ23k9PEQsUxJXOuBsrjVuF3TVuAXp8wZ/7MhpcJ6ILiaLp1Su14RJTuOnDpa6CPgu
         91G4wtW7GyYLZuf8A7eg8YaAqT1vRjNZQl6mWbzR0wCZxNJqXuT65+8UUry3AZD4WC+A
         UPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yBpMe8bZONmbG+T6QYM7RuhqpeWJdERGMTR2wSH4X8=;
        b=Txi7t440vXAbK+ZPYAPZz9zmTFvU0Gx81JIphUaSWuE5icDgcNqzGCwm8uMXa3oQ3w
         Edhhc5YPfA55hfvtoT+0QlQCmFYB1g1h4ecjL7C8dfx/LhYyeTlfoaOau/E3jtJ9ZdNg
         QukpgZLSTnWlh8L4s+2LhsqQHaasXyYXOXSwmS8Vi0P4TRHuWQ9OZhlobSnj9bF7v9jS
         KPY2wAghSrFx6cvJXNDdqBrqJMHPkTwnuXvR065sJsJqBo2nko/7369ROfFP1AIb/e01
         RY2UIcmPMfeu9O+WLX656WrKPZBtTWRT3N52Rik8N0Q0Mq8E+6/B/KKAIO1bukAzwGwG
         tciA==
X-Gm-Message-State: AGRZ1gKF7Uy/0bdTKp0/6vjvI3HvrADNh0a2PVOQ8qL6FhcW4dasapcO
        pNnfCUc+lC8s5hrokvcaxyj/egU1t+o=
X-Google-Smtp-Source: AJdET5eHQP1yoLfPXMjIpc2UH84iPSDuf/46SpD5jC/R7VfF3ym+HVB5TF3aj52U8fu+IXAFZbi5wA==
X-Received: by 2002:a17:906:1353:: with SMTP id x19-v6mr2788062ejb.23.1541031904817;
        Wed, 31 Oct 2018 17:25:04 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s12-v6sm10188175edd.39.2018.10.31.17.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:25:03 -0700 (PDT)
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
Subject: [PATCHv6 6/7] tty/ldsem: Add lockdep asserts for ldisc_sem
Date:   Thu,  1 Nov 2018 00:24:51 +0000
Message-Id: <20181101002452.5483-7-dima@arista.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101002452.5483-1-dima@arista.com>
References: <20181101002452.5483-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 9434d20cf3ca..45eda69b150c 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -478,6 +478,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
 	clear_bit(TTY_LDISC_OPEN, &tty->flags);
 	if (ld->ops->close)
@@ -499,6 +500,7 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
 	int r;
 
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	if (IS_ERR(disc))
 		return PTR_ERR(disc);
 	tty->ldisc = disc;
@@ -622,6 +624,7 @@ EXPORT_SYMBOL_GPL(tty_set_ldisc);
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	if (!tty->ldisc)
 		return;
 	/*
@@ -669,6 +672,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 	struct tty_ldisc *ld;
 	int retval;
 
+	lockdep_assert_held_exclusive(&tty->ldisc_sem);
 	ld = tty_ldisc_get(tty, disc);
 	if (IS_ERR(ld)) {
 		BUG_ON(disc == N_TTY);
@@ -767,6 +771,10 @@ int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 		return retval;
 
 	if (o_tty) {
+		/*
+		 * Called without o_tty->ldisc_sem held, as o_tty has been
+		 * just allocated and no one has a reference to it.
+		 */
 		retval = tty_ldisc_open(o_tty, o_tty->ldisc);
 		if (retval) {
 			tty_ldisc_close(tty, tty->ldisc);
@@ -832,6 +840,7 @@ int tty_ldisc_init(struct tty_struct *tty)
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
+	/* no ldisc_sem, tty is being destroyed */
 	if (tty->ldisc)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
-- 
2.19.1

