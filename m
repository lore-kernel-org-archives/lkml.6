Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFD5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007C520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JybiprDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbeGWTps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:45:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37473 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeGWTps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:45:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so1202977lfb.4;
        Mon, 23 Jul 2018 11:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y9Xfm3vtovJ8g5i3WTgcahs6SUzJIiJRUaY1j06RJ80=;
        b=JybiprDyiwKJyF1VXoa3/XeX9kG5HxekyBk+iWyMkKoLfH1mRvXElSM0a+C3kakl9Q
         dcFB3g94U5eg6jYvEU4oZujOxugqgF5U2n+ck74YqDDblQGQ33/3BEYWFr8rZzoocqtP
         Nzp1XnN2m5h86jN+VN1+ELRKptVLZ8e5OByw1G6t8BhqDyKxhgQQNw+xOqO2htod2aGx
         Q7Zt5+CQluxrFZAR4yBj1JefKh7VQ8r5r8A0Bto182zelrTbdycUVDMonU+Ul5ICxBDy
         nktUt0BQ4M3Cd30BeqD8CMI/sJeL9Lsbth/RaXogV/lFxd4mkEjqlJVw4++h8Mf0LWpW
         8ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y9Xfm3vtovJ8g5i3WTgcahs6SUzJIiJRUaY1j06RJ80=;
        b=Pod+smngyFQo6/n1JWI3zvolSx5EYXhaEfGNTqnN7uqoW490koe7s+OqqVqbzqCy2F
         ropND1U5jJlgIapgy1BqUjjClqJbdAIcVlhJ2YYb9uInT7cIngvwa1E+EkfxscKFgW4X
         sutU2NagJxO9gwpxxALjHZbTXBNNGukiXq/wg8Xz3oxT7ZmcDApaa6K0tDmJno0z9orU
         7kIUbanxr4dvARMw98zkFBpksbFM/WVuC04NI7dh9l/bMWxHCTccL1U9QeNuI8WmUPTC
         fdoElCQjpIviMYnLdLNhprvra6URcnm+Z7DsRWNHufjEVKrkRvqEDvw2ATjN1YSU2j0R
         uk9w==
X-Gm-Message-State: AOUpUlHcQcDclz5pbzccqLPKJedKnrTMK4FmT4zq4t0CZywGL0NruDIQ
        ILseOuL0mNq9XzkNEtQNS3s=
X-Google-Smtp-Source: AAOMgpejDRyI00XWB5Diwv5RRL6T0uAgReC0EY6kZvxML12IxlWFJQA31OYn6fBaBcWV4lrhkB1elA==
X-Received: by 2002:a19:120d:: with SMTP id h13-v6mr7884617lfi.13.1532371394446;
        Mon, 23 Jul 2018 11:43:14 -0700 (PDT)
Received: from debian-tom.lan ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id k65-v6sm1925437lje.3.2018.07.23.11.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 11:43:13 -0700 (PDT)
From:   Tomas Bortoli <tomasbortoli@gmail.com>
To:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc:     asmadeus@codewreck.org, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        Tomas Bortoli <tomasbortoli@gmail.com>
Subject: [PATCH] net/9p/trans_fd.c: fix race by holding the lock
Date:   Mon, 23 Jul 2018 20:42:53 +0200
Message-Id: <20180723184253.6682-1-tomasbortoli@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be possible to run p9_fd_cancel() with a deleted req->req_list
and incur in a double del. To fix hold the client->lock while changing
the status, so the other threads will be synchronized.

Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
---
 net/9p/trans_fd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 588bf88c3305..f9f96d50d96d 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -197,15 +197,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 static void p9_conn_cancel(struct p9_conn *m, int err)
 {
 	struct p9_req_t *req, *rtmp;
-	unsigned long flags;
 	LIST_HEAD(cancel_list);

 	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);

-	spin_lock_irqsave(&m->client->lock, flags);
+	spin_lock(&m->client->lock);

 	if (m->err) {
-		spin_unlock_irqrestore(&m->client->lock, flags);
+		spin_unlock(&m->client->lock);
 		return;
 	}

@@ -217,7 +216,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
 		list_move(&req->req_list, &cancel_list);
 	}
-	spin_unlock_irqrestore(&m->client->lock, flags);

 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
@@ -226,6 +224,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
 			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
 	}
+	spin_unlock(&m->client->lock);
 }

 static __poll_t
@@ -373,8 +372,9 @@ static void p9_read_work(struct work_struct *work)
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
 		list_del(&m->req->req_list);
-		spin_unlock(&m->client->lock);
+		/* update req->status while holding client->lock  */
 		p9_client_cb(m->client, m->req, status);
+		spin_unlock(&m->client->lock);
 		m->rc.sdata = NULL;
 		m->rc.offset = 0;
 		m->rc.capacity = 0;
--
2.11.0
