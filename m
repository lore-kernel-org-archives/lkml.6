Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C757C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E0A2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZ8Vqna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeLPXHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:07:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40290 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeLPXHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:07:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so5393864pfo.7;
        Sun, 16 Dec 2018 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GccI8EQoljWfK+3QZgpO69tRslzn7VGxvncrGhyuE60=;
        b=brZ8VqnaAVcTAYp66sFvCG8xSBwUPEaUcknhLcKaNJcvmaJkSfaKJTosqMLEYK42Xt
         2QCS1wFrHkxfSKKtsTH+ccTot/T+rzpIxjKjPENEd9zMCZBJE2GG7Aypxj4FCYSRSckc
         mFR1W5zJ+KbsOhVrphXOs5jDTfzixo1pJU5zMVSYfHH4quVs9lxUGdW1Ns7yd5UE3nOS
         FMAzvuhC0/Zr+o0YMs3AkfFlB558tASMp92nl9ys8StNiY3SvoPhIVPIwA4Gf5yOoorw
         X02mNR7qo7x8dQB5SOo7JGexatENBqs2G47lrPU2UnL88nsZJ2/SiX/dM+jRJQ2ID1OB
         LymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GccI8EQoljWfK+3QZgpO69tRslzn7VGxvncrGhyuE60=;
        b=JqhfBzbMwleI7Zt8uSEZ61qov2QBLDDg73kuVNZiwWJjg2E7GCjNnXblJLot0+RfbT
         mUXqQ35miVII0lme+O4V0MRQp9ZjKq/U133Ox7Yu5SgZNlwLanReeMg4adRowYnDj4Km
         aO6rte2MtKpKZ508S9DqeK4uK7OqQWzFkPrmugtTABrtz8Pe16WsxzEhKSIVXHEco8Eq
         7/MpPVcEbSJ/6wHz2IKxyToTg1MZjmvwTv8SUiJXfqx2KjJtXUBycmjnL/guvGKnToGP
         CMCMmXDqLVtPdngZNO5DuJj0MqS5Z45lHbsmmUPPQNY1cNyzootcJ71pscm/bHMNF0+M
         NDBA==
X-Gm-Message-State: AA+aEWZPwwcBYGxHmVqjxHCY6LZSn0C+3MYuZjLH1FM9ScrxIRW06rKd
        XM0+lYxR7FEntjT/e0dOA6z15pNW
X-Google-Smtp-Source: AFSGD/XVmyDuECN7HRJMelDMzsuM7cEHAVfgNTshiI5P0SDT14T80ttFbG8/XrayHDC2m1ZcR6QJwA==
X-Received: by 2002:a63:f047:: with SMTP id s7mr10131876pgj.441.1545001623488;
        Sun, 16 Dec 2018 15:07:03 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id i193sm16222788pgc.22.2018.12.16.15.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:07:03 -0800 (PST)
Date:   Sun, 16 Dec 2018 15:07:00 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/smc: fix TCP fallback socket release
Message-ID: <20181216230657.GA16104@myunghoj-Precision-5530>
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
 net/smc/af_smc.c | 12 +++++++++++-
 net/smc/smc.h    |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 5fbaf1901571..a127a13689c3 100644
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

