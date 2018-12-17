Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C74C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh3lL7qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeLQFVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:21:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36965 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbeLQFVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:21:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so5767311pfb.4;
        Sun, 16 Dec 2018 21:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1zllOByLoO22y5xTVjNIv+ds4K+Cd07CKJ0+Yk6+4S8=;
        b=Lh3lL7qi4hSASXX/uam4sgyDc4keqHHMswke3haU1WEt0FzRDWsNvxXdJRzOof/IbP
         ByxKi0dW4oQBIBPdLzrqiPYI/gkjXo068xoV5yCQ4acz+MQAIN3oenE1cMTrQ7wjIN7f
         N18XbSUevJvWIxBY0Tn0gs8yD1+R3BK6sqzrO0wfkh2rH4D57A5jfFHf50Nmgwx6HfFk
         VPmIp3K/IjnpwNi8us7VA7DxNKekdmIs6C/5HXma7igefAP154ALQbyOoWRGjmr1IJKU
         Vr1nob3gBC3XiHDctlogLxOR8iHV5HIhnjgfvuI2iIgeF+KPhV6GqegLMAkOn5NY0svN
         OQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1zllOByLoO22y5xTVjNIv+ds4K+Cd07CKJ0+Yk6+4S8=;
        b=PKQn8A9LnG2R1lgITUzmTsrd4jiyGxE0n7X3xf6J3Pb9Yt/wgY0cE4pgMhILTI+EeO
         PH7dDWDXVbrlReB+7yqRvikrSsqNAxi2W3rn89ow9mzgXnWVPxZvCx7N2xsg5MCqNl73
         F7h8GfvAz5Zy4cWuBDybxnasgoCwGrsottvipFKzFcW6dgUOGhOmeOSkRhmZ8e0/arMU
         cmuxfnkmRmb0eKJrTBLWx1B5+8w/bO4TSgY3ktYwV6jjL8Mn22liKdShJxVDw2E9N1A9
         jtTmJWedMneOUn2DLXVaL1mvngVRAbXrZXB3h+8ubH+BRqZIKeSkmYodzu09aycJHC/6
         wdDQ==
X-Gm-Message-State: AA+aEWYunp1ljgeVBUg0yOxv9BFEDw7C0kUo1y+LgWeJdy05LtEw+nyO
        fQAQ19mT0kI7PrauXxNd7tCGXQNx
X-Google-Smtp-Source: AFSGD/Xsl9ovPuc9YZLsFxCQUFawd+CtiuzzaOw7IUXGPR2n2eiHK421Pof3Ls9DmBrjJQuXJUFYPg==
X-Received: by 2002:a63:f615:: with SMTP id m21mr11281608pgh.428.1545024089056;
        Sun, 16 Dec 2018 21:21:29 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id m67sm15073269pfm.73.2018.12.16.21.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 21:21:28 -0800 (PST)
Date:   Sun, 16 Dec 2018 21:21:25 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net/smc: fix TCP fallback socket release
Message-ID: <20181217052122.GA26299@myunghoj-Precision-5530>
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
 net/smc/smc.h    |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5fbaf1901571..5d06fb1bbccf 100644
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
+	int rc = 0;
 
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
index 08786ace6010..9a2795cf5d30 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -219,6 +219,8 @@ struct smc_sock {				/* smc sock container */
 						 * started, waiting for unsent
 						 * data to be sent
 						 */
+	struct mutex            clcsock_release_lock;
+						/* protects clcsock */
 };
 
 static inline struct smc_sock *smc_sk(const struct sock *sk)
-- 
2.17.1

