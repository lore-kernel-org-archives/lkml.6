Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D97C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F93520868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="i/Pnqb5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F93520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeICVOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:14:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44685 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbeICVOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:14:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so1218775edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pr975JCzWCkcuM69evolnKQNNRXCXUiPHrsc4GObTkU=;
        b=i/Pnqb5gM9FdbghZSbLK0yE5jaqNNl33xCKN8uQ5wWMTMwuU/bf4EUjb3PPHrvjWD8
         C/YVfhHjET6LUJugRpRVr4gHAqWrqenjbYgavHmSgilh4W1PqZJHDafO7riLwvJllNOh
         0LCE1pn56LNKiG40nyiQhf/rxjCco4p4Y6pAvLrfdwowicoMU5gnGYzB2C6ZCvIRFKLk
         ttgyuHz86kBtl1amLS1n72JWlKczUbASWkhzv0cdqWLqHWN5gsMInDloLbq1BdyP9fCK
         UqoDP2ioFd3vh9etELO8/USeq44ZmcIBjx9ZrVzJ47pKuBKo7rqdD48ztqzorJ6xa338
         mYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pr975JCzWCkcuM69evolnKQNNRXCXUiPHrsc4GObTkU=;
        b=TNCF/ZZE+UpaJ2NV8Qk1hRAmCN1QW2jsD7Eiux6I9FEU3f+OTfaNwWRdQcmYmYHL5E
         DY22m02FSDO8BfDCJXugkTuq748j+615McOcCrHxJDKYksytv6hXgFRFfVxWySkyTxo5
         6dnp9l4UIWZIS8WIRH79+qYLN4gPAAjv/R7y4CZQG7M/RZmtKT/t3R61lmW9rl5RQzAw
         1o8lREc/zyqyCBqaA+sshf/PpOlx3vwap7XQnJvvLHOGQ4Rwnal/x0ypglTflWx3h4AH
         1eUhAGRTAU4K7f8Teb+hWdDCX/+pR7gH1eRrORvjK2SMYJhvgI2ig8ioWlOL9I+UGsqs
         UVOg==
X-Gm-Message-State: APzg51BCc3t6g5VHOuQ+q/EzVDUaAkBkxDVi7VFhHRT3Q2xbl/zh4ym1
        mYrSUMqKzoL08+RJCAbr2mmSze+yO3Q=
X-Google-Smtp-Source: ANB0VdYV5HGiox4azJHir81eurEC96l8Y7OaDvNa/hRirZxJMlCcy1y9fF5kFd/r+T3lvWEsLjmpzQ==
X-Received: by 2002:a50:9732:: with SMTP id c47-v6mr33345761edb.89.1535993584118;
        Mon, 03 Sep 2018 09:53:04 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8085745ede.14.2018.09.03.09.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 09:53:03 -0700 (PDT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCHv2 3/4] tty/lockdep: Add ldisc_sem asserts
Date:   Mon,  3 Sep 2018 17:52:56 +0100
Message-Id: <20180903165257.29227-4-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180903165257.29227-1-dima@arista.com>
References: <20180903165257.29227-1-dima@arista.com>
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

