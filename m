Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874AEC46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B12B20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ogL2jtZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeIKGpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34089 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeIKGpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id u1-v6so17996911eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pr975JCzWCkcuM69evolnKQNNRXCXUiPHrsc4GObTkU=;
        b=ogL2jtZY5fj1Zggr2N/4zNGOqM0z+JWsyFzDADitnz9ei8XQm5sQ/jF9RUbxf0y/lG
         PB35uO23nc7WG7ytYd+E467l3mWpaJXK0OtsXsOk5LKxEJFduTTUb5MUEvPNa/En39Fq
         ujUuw/zkh2X3rsUnGJaKKhaSRCHQBUAaWpoufnkfn88p48QwdGdkhXAAiPP1S86rOT45
         LzgB8GydICrqnUcIWjf4ECJ5etYhqO47yfS8/NkJYtR3ohJzBnhh2j4AMqsPeIiZFfpK
         H07Ysh4jn+3AQoay7Ydf2SMIZFNeJCqX/a1SezZsIBf836MKG+G+1eRwbHAw1kqu9M7V
         u9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pr975JCzWCkcuM69evolnKQNNRXCXUiPHrsc4GObTkU=;
        b=uJqeHzBEcnEJq/RScfgxI5m0w9NWHp0+PFCNpx3SPf3tHOz3RdG+3KIrhXwGEOGOzc
         3NJ6dhHYpSheg3u6QS2YWvg1NddSbsihbZ4u5oStaf/vYwMzgCp9SJM2vETFrzmBFCwb
         q8smelv0H0AULr9bOzJP1bl4jGM9Rs7HbRlviLgWBN7kRtPHuay9enwZtkQuogAgaJIe
         lntUFrrJ1kOkNzNihwQW12TKBUXxv7xjMu3N/pX2OXfzWs43AUS8q9AfV2kUR0+r8rPg
         NDAhuBRTYqBhSRoM5EG0gskKBvr6d5pCEANEj7WMYKfidIVtXDqBdXWWZtU765cKE65/
         WUzQ==
X-Gm-Message-State: APzg51AMB8PMWyqEq3emkFl0goPhUa8/pMf9XbhBg0s2hidBQAidLYTf
        oYDWhoRjdd0lGmJZ35WnlvcOk7hER9Q=
X-Google-Smtp-Source: ANB0VdbUINPhHHCXk2+wyR61+kDmYILqf+Gvam9fl65YnED6Ak5YO/9Dgdm8UZx4y9esIkEGnXR3Yw==
X-Received: by 2002:a50:a2e5:: with SMTP id 92-v6mr24532781edm.106.1536630509095;
        Mon, 10 Sep 2018 18:48:29 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:28 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv3 4/6] tty/lockdep: Add ldisc_sem asserts
Date:   Tue, 11 Sep 2018 02:48:19 +0100
Message-Id: <20180911014821.26286-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180911014821.26286-1-dima@arista.com>
References: <20180911014821.26286-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure under CONFIG_LOCKDEP that each change to line discipline
is done with held write semaphor.
Otherwise potential reader will have a good time dereferencing
incomplete/uninitialized ldisc.

Exception here is tty_ldisc_open(), as it's called without ldisc_sem
locked by tty_init_dev() for the tty->link.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldisc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index fc4c97cae01e..202cb645582f 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -471,6 +471,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
+	lockdep_assert_held(&tty->ldisc_sem);
 	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
 	clear_bit(TTY_LDISC_OPEN, &tty->flags);
 	if (ld->ops->close)
@@ -492,6 +493,7 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
 	int r;
 
+	lockdep_assert_held(&tty->ldisc_sem);
 	if (IS_ERR(disc))
 		return PTR_ERR(disc);
 	tty->ldisc = disc;
@@ -615,6 +617,7 @@ EXPORT_SYMBOL_GPL(tty_set_ldisc);
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
+	lockdep_assert_held(&tty->ldisc_sem);
 	if (!tty->ldisc)
 		return;
 	/*
@@ -662,6 +665,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 	struct tty_ldisc *ld;
 	int retval;
 
+	lockdep_assert_held(&tty->ldisc_sem);
 	ld = tty_ldisc_get(tty, disc);
 	if (IS_ERR(ld)) {
 		BUG_ON(disc == N_TTY);
@@ -825,6 +829,7 @@ int tty_ldisc_init(struct tty_struct *tty)
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
+	/* no ldisc_sem, tty is being destroyed */
 	if (tty->ldisc)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
-- 
2.13.6

