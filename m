Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA94C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF5020684
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="c4HMnIOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF5020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeH2GSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:18:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33690 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeH2GSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:18:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id h9-v6so2791494edr.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2RMWkQyH28Vn7WolgdhN8/YoFRS2WigG+t4/w6rRBUw=;
        b=c4HMnIOSrq9ofbaAOdc1PAb/QMggbiiMgCBPXjcN69RgVdXaaklCQ7pWgPcpeSWpaG
         tZ7CMWKe032+HetD2HkXzP33nZFjQAuZVDIb8K5y6KK4vcLN0cxvFckFMoYMZ0zlpYVa
         VKKUubGEdhrW1Ch8zdWBvlNsZjb1BDogaiUI8vGuAnT/q1/QTpkd/DwiYtdDbMbf618M
         pT5z6Grkmjoi2W2bAQWzLZPiFmhthmHqjd1pdkbuTcN6/eEtHPXWKMu4QhEYXM0L/Xf9
         wNNLBg0tTGoHmaIDnWzRHQYklwdwyZ9WvKO7n7Qs4spSH+NC3j2JIyLQphziDtMD1mhT
         cyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2RMWkQyH28Vn7WolgdhN8/YoFRS2WigG+t4/w6rRBUw=;
        b=n9NsmqWjLO2ZKttkR4iNfeztStXerU3kJqty/s2yrcixZ4C1GnCLcJMkimbX8C3YLU
         hxhphpSPpITnEmjHbse9K70ZAoFSjagU9jk5bsyTw7yez7ZuzdLmEkUnIu/nvHDU+J/2
         8N/urSLXrS34zXWX0S1l42er2Gn3czY/zY7QvwLTvXV8OVkYpVA6/20XHcGzXRoKbbBi
         Tm70XgMGn+z488TlKEYo/ulKx17J1Zc89LLUVeb9iOYbP09LtkS8BpfefwhTNlDvlIWm
         zsso1T4g6jitCWzbOlkrZunJdTSLxLT3qFsCPtmnmwWmnVZlEo09CXFQWtRYdp+NpcMO
         RjvQ==
X-Gm-Message-State: APzg51BnesbboyXgpgyVglvlROX3JFcPgvHBToM8YiVRLrYJY/9Uedsk
        PxRuZQZAz3ccbZvBG0e2oNWz9D80mv4=
X-Google-Smtp-Source: ANB0VdY223iR7YzHJbGiMW43+1+GFnniCNuYgLAtqhqlTEef598bj4XlgfxCeCW/HNrN30Fbn2lv0w==
X-Received: by 2002:a50:a542:: with SMTP id z2-v6mr4975255edb.77.1535509439934;
        Tue, 28 Aug 2018 19:23:59 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f26-v6sm1236367edb.28.2018.08.28.19.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 19:23:59 -0700 (PDT)
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
Subject: [PATCH 4/4] tty/lockdep: Add ldisc_sem asserts
Date:   Wed, 29 Aug 2018 03:23:53 +0100
Message-Id: <20180829022353.23568-5-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180829022353.23568-1-dima@arista.com>
References: <20180829022353.23568-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should nicely document that each change to line discipline should
held write semaphor. Otherwise potential reader will have a good time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/tty_ldisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index b72266461c00..9ef0b33a4132 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -444,6 +444,7 @@ static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
 
 static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 {
+	lockdep_assert_held(&tty->ldisc_sem);
 	WARN_ON(test_and_set_bit(TTY_LDISC_OPEN, &tty->flags));
 	if (ld->ops->open) {
 		int ret;
@@ -469,6 +470,7 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
+	lockdep_assert_held(&tty->ldisc_sem);
 	WARN_ON(!test_bit(TTY_LDISC_OPEN, &tty->flags));
 	clear_bit(TTY_LDISC_OPEN, &tty->flags);
 	if (ld->ops->close)
@@ -490,6 +492,7 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
 	int r;
 
+	lockdep_assert_held(&tty->ldisc_sem);
 	if (IS_ERR(disc))
 		return PTR_ERR(disc);
 	tty->ldisc = disc;
@@ -613,6 +616,7 @@ EXPORT_SYMBOL_GPL(tty_set_ldisc);
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
+	lockdep_assert_held(&tty->ldisc_sem);
 	if (!tty->ldisc)
 		return;
 	/*
@@ -660,6 +664,7 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 	struct tty_ldisc *ld;
 	int retval;
 
+	lockdep_assert_held(&tty->ldisc_sem);
 	ld = tty_ldisc_get(tty, disc);
 	if (IS_ERR(ld)) {
 		BUG_ON(disc == N_TTY);
@@ -823,6 +828,7 @@ int tty_ldisc_init(struct tty_struct *tty)
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
+	/* no ldisc_sem, tty is being destroyed */
 	if (tty->ldisc)
 		tty_ldisc_put(tty->ldisc);
 	tty->ldisc = NULL;
-- 
2.13.6

