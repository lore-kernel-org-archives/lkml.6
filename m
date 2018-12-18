Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C359AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86980217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhCMmV/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeLRHDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:03:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRHDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:03:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so7668810pfk.10;
        Mon, 17 Dec 2018 23:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1eR8kJuUlnry0eT2pQhsogofHopHzJJoOHfQjXxch4U=;
        b=bhCMmV/sNFrSyoekJjv3bzTHQrwM14ERWxvgDEu3DzctmdD5Yz1eU8fh77aMbEUcWZ
         2AaodLP/S9X/Nz+F3Hs8HwmE7LEUi/L37JynAJtCjrA0T+WSG//acbm/DGF13gGVjliq
         HKGj/OyGoqs3V2hHjg8OVoH+juvGP75FyrMO4LWTn2YVkfj7CgXWfdKiTS3sT+xOSnly
         Lg2QhScbW9rCNu480Vlsrl3+mMI8UTFPLMgr8XwB3ar6xygx+cxWyfv9dN7nLBVmspMA
         BvOvZBqJjU/USJnf/Scy8aUL06i9iKYfUMRp7vqOJTPqD+KIF1SsPcggZnn48dvVeFMB
         SzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1eR8kJuUlnry0eT2pQhsogofHopHzJJoOHfQjXxch4U=;
        b=cag/n/EeBS/ZagNsIsx1pS5viFUxTZNbfnQYVXMqA/tKwhagGIipGfUXup7EorIDBA
         aJHpPCijiQ1r7uM13Jj3XKo+dsCPNMQZQ/8mU/JRIStiKPJ4i+xNgdULosmjQlnwqsWa
         RtOS2Xk9J5SBfZ6uxxy2okmikokP+QYuPy4Fcprdfy4HssiFCjmwiAS4f0uRCv7KJyQ4
         i/HerKt9sOaqqbzS4NK2FWWluupXZ7xwgOUkx2t9A/dlGIjrtw3tZ36O609P+2nTlDnj
         uFeqsjTp+WkWY2qlsrknPddPguCE3i7wewSU3oUmsccYAIRbyJVNd0qkdXMmQIswbaTP
         JTHg==
X-Gm-Message-State: AA+aEWa+7efAIaGfoZbahsFCWFksj8rgLPf+GST3L7I5irIe4++RjSYs
        9roEB7z+enaHxJyNIa3DUng=
X-Google-Smtp-Source: AFSGD/WJaPyMcbMGCc1bB5PvOHNbTqWdQTd0QqGCqxHiUMz8Fk0MegrGaNCaiVDop2WtXy2bNrEzUQ==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr14427860pgk.213.1545116624689;
        Mon, 17 Dec 2018 23:03:44 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id g26sm17614643pfh.61.2018.12.17.23.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 23:03:43 -0800 (PST)
Date:   Mon, 17 Dec 2018 23:03:40 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Ursula Braun <ubraun@linux.ibm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/smc: fix TCP fallback socket release
Message-ID: <20181218070339.GA20290@myunghoj-Precision-5530>
References: <20181217052122.GA26299@myunghoj-Precision-5530>
 <a9ad19c4-1ef7-4dc9-639e-03b3459457e2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ad19c4-1ef7-4dc9-639e-03b3459457e2@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:58:58PM +0100, Ursula Braun wrote:
> 

Hi Ursula,

Thank you for your suggestion. I have a question on your comment.

> 
> On 12/17/2018 06:21 AM, Myungho Jung wrote:
> > clcsock can be released while kernel_accept() references it in TCP
> > listen worker. Also, clcsock needs to wake up before released if TCP
> > fallback is used and the clcsock is blocked by accept. Add a lock to
> > safely release clcsock and call kernel_sock_shutdown() to wake up
> > clcsock from accept in smc_release().
> 
> Thanks for your effort to solve this problem. I have some minor
> improvement proposals:
> 
> > 
> > Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
> > Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> > ---
> >  net/smc/af_smc.c | 14 ++++++++++++--
> >  net/smc/smc.h    |  2 ++
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index 5fbaf1901571..5d06fb1bbccf 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -147,8 +147,14 @@ static int smc_release(struct socket *sock)
> >  		sk->sk_shutdown |= SHUTDOWN_MASK;
> >  	}
> >  	if (smc->clcsock) {
> > +		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
> > +			/* wake up clcsock accept */
> > +			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
> > +		}
> 
> This part is not needed, since an SMC socket in state SMC_LISTEN is never
> a use_fallback socket.

In smc_sendmsg(), set use_fallback to true if SMC socket is SMC_INIT
state and the message has MSG_FASTOPEN flag. After this, smc_listen()
would trigger smc_tcp_listen_work(). Is this not an expected scenario?
Then, what is the reason for not skipping smc_sendmsg() in SMC_INIT
state?

> 
> > +		mutex_lock(&smc->clcsock_release_lock);
> >  		sock_release(smc->clcsock);
> >  		smc->clcsock = NULL;
> > +		mutex_unlock(&smc->clcsock_release_lock);
> >  	}
> >  	if (smc->use_fallback) {
> >  		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
> > @@ -205,6 +211,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> >  	spin_lock_init(&smc->conn.send_lock);
> >  	sk->sk_prot->hash(sk);
> >  	sk_refcnt_debug_inc(sk);
> > +	mutex_init(&smc->clcsock_release_lock);
> >  
> >  	return sk;
> >  }
> > @@ -821,7 +828,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
> >  	struct socket *new_clcsock = NULL;
> >  	struct sock *lsk = &lsmc->sk;
> >  	struct sock *new_sk;
> > -	int rc;
> > +	int rc = 0;
> 
> Without clcsock the good path should not be executed. Thus I suggest
> to initialize with something negative like -EINVAL.
> 
> >  
> >  	release_sock(lsk);
> >  	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
> > @@ -834,7 +841,10 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
> >  	}
> >  	*new_smc = smc_sk(new_sk);
> >  
> > -	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
> > +	mutex_lock(&lsmc->clcsock_release_lock);
> > +	if (lsmc->clcsock)
> > +		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
> > +	mutex_unlock(&lsmc->clcsock_release_lock);
> >  	lock_sock(lsk);
> >  	if  (rc < 0)
> >  		lsk->sk_err = -rc;
> > diff --git a/net/smc/smc.h b/net/smc/smc.h
> > index 08786ace6010..9a2795cf5d30 100644
> > --- a/net/smc/smc.h
> > +++ b/net/smc/smc.h
> > @@ -219,6 +219,8 @@ struct smc_sock {				/* smc sock container */
> >  						 * started, waiting for unsent
> >  						 * data to be sent
> >  						 */
> > +	struct mutex            clcsock_release_lock;
> > +						/* protects clcsock */
> 
> I suggest to be more precise: "protects clcsock of a listen socket" 
> 
> >  };
> >  
> >  static inline struct smc_sock *smc_sk(const struct sock *sk)
> > 
> 
