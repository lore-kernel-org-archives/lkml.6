Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2485C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946E42070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 06:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwDYf/9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfADGy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 01:54:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfADGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 01:54:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so17100891pga.1;
        Thu, 03 Jan 2019 22:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HgIRH3ITFXhF8C3OSCxta0zkrzq8EfL6o1r8MfBFziY=;
        b=NwDYf/9f9hLekWoiXIO0KjVgweq1iXQ8p1Yt68UvJw0UyQNNz3430YJ2enlPOsvBoB
         ThTyggmxKqbM7ts4OeFWTzCcqRp5xq9SiFk4IoNG//YyH+ueKKFT/jzwrY0YaGJviKjS
         RVH/JXIMdO9sjxxbeNkAUk7W8Lf/u7/q9xNEs4HQXvfSLDzltKitfC2qJ5IFFq3xJo09
         YwhWH7CZtEOyMjNz1NnrBUWFWcCBemCH+8A+u7iwysIg5pSO9wnnppqDN9Kna7TQsdqc
         Qbul1f7esOjh2gRK/5CW6ScpFldAesSe8Ax7dlaNzvt5sQd2gjpWCGXIiiPAB3+M7QGd
         EQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HgIRH3ITFXhF8C3OSCxta0zkrzq8EfL6o1r8MfBFziY=;
        b=RjFlXfjyRVtVgiIV55X6X+UKhCV/Ll+rd0NGf8/AZS75up0w5GxwpRytN3jE4Ybq9P
         kYjGtf2ohhbsQXLvA2MZ2HMlQa1oyjc+E0F8Dty/xK5emhqq+eBPgMNQ6SwePhmNlMVL
         /pAiq4Oo3ngNta91gBjt0PKDemlyX6U6xUtL0i951DOdMpGNNZ7hHol2goWeMEOVGhnW
         f3WmHEJRxCF19VNTnKtzAJRCAhafSQaqXfNTeq/BRDZNC2+t0SUbyyEBTS8xggbK834x
         NE6vGC764iqMul7FyZ9cOatjuty9CKAPzZrs08bEGjzWwwzfH0S9aA3vSxmaE9glVeKe
         UtvQ==
X-Gm-Message-State: AA+aEWaKrFNiMpHkYi0+k0GX9EcOn41Cd8wtuAbQZk6zTeP6pmQPqLRP
        uBbpRUG9Y7eO5zWo338vMlxgqSH0ru0=
X-Google-Smtp-Source: AFSGD/XUg+Qc8DhPiB4Pa2HomzTASDX5wXVHnl2Pj4SxX9/oH2F2BJb8LooiNToQAnNMk2I/zhS5og==
X-Received: by 2002:aa7:8354:: with SMTP id z20mr50525961pfm.81.1546584897232;
        Thu, 03 Jan 2019 22:54:57 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id w5sm75463057pfn.89.2019.01.03.22.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 22:54:56 -0800 (PST)
Date:   Thu, 3 Jan 2019 22:54:54 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] net/smc: fix TCP fallback socket release
Message-ID: <20190104065452.GA11084@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clcsock can be released while kernel_accept() references it in TCP
listen worker. Also, clcsock needs to wake up before released if TCP
fallback is used and the clcsock is blocked by accept. Add a lock to
safely release clcsock and call kernel_sock_shutdown() to wake up
clcsock from accept in smc_release().

Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 net/smc/af_smc.c | 14 ++++++++++++--
 net/smc/smc.h    |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5fbaf1901571..82cb0e5634bc 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -147,8 +147,14 @@ static int smc_release(struct socket *sock)
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	}
 	if (smc->clcsock) {
+		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
+			/* wake up clcsock accept */
+			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
+		}
+		mutex_lock(&smc->clcsock_release_lock);
 		sock_release(smc->clcsock);
 		smc->clcsock = NULL;
+		mutex_unlock(&smc->clcsock_release_lock);
 	}
 	if (smc->use_fallback) {
 		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
@@ -205,6 +211,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	spin_lock_init(&smc->conn.send_lock);
 	sk->sk_prot->hash(sk);
 	sk_refcnt_debug_inc(sk);
+	mutex_init(&smc->clcsock_release_lock);
 
 	return sk;
 }
@@ -821,7 +828,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	struct socket *new_clcsock = NULL;
 	struct sock *lsk = &lsmc->sk;
 	struct sock *new_sk;
-	int rc;
+	int rc = -EINVAL;
 
 	release_sock(lsk);
 	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
@@ -834,7 +841,10 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	}
 	*new_smc = smc_sk(new_sk);
 
-	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_lock(&lsmc->clcsock_release_lock);
+	if (lsmc->clcsock)
+		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
+	mutex_unlock(&lsmc->clcsock_release_lock);
 	lock_sock(lsk);
 	if  (rc < 0)
 		lsk->sk_err = -rc;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 08786ace6010..5721416d0605 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -219,6 +219,10 @@ struct smc_sock {				/* smc sock container */
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	struct mutex            clcsock_release_lock;
+						/* protects clcsock of a listen
+						 * socket
+						 * */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)
-- 
2.17.1

