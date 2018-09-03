Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B015C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE5220867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 21:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LmGOMTo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE5220867
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIDCC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 22:02:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33563 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeIDCC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 22:02:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id d8-v6so1722491edv.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=oBNaecQNI5LUR61Xu70h7GexgqExlbs13fOtdKldeaU=;
        b=LmGOMTo45NB16Wuqs4wFEUWbj/XV6MvVyN8MtsHj6pJU/k81H6UX5oLhZ7em6d8DUq
         8YYKXB6xVrpc2oDmRWwww/fuQePCQrIYDeT6Xy2kN5uJdoH/UL2gxzcwpHhDIumDJbAZ
         UW021s/AkSYY+6lSFjAWTBpmW7BtjlGiinbHwce9w2hPXtp0jjKS714Z7OzLzgrjmAMt
         Q8h67WpLc5d10ncsMrIjII0KTLjxFx8ZwmfQKTblXi7E9erXVYRPF6unwNy3SiXlKVbS
         cModMqTY4ZOahUJ7BzPytENKtBsZ/M0FlYejU+AmVt6vDFfGwyp4fglBawXD0hnNOUYb
         t3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oBNaecQNI5LUR61Xu70h7GexgqExlbs13fOtdKldeaU=;
        b=pHkW55IyeZ2yJQ3mZFXnG3Qik/y4yqNzXgf4Z1hJROmH+7fFJrUPXVPvz6qfQu6ujO
         10frs22xcftQnVi9TaoMplSlU3FuH2i0uCybmzQ7PtxdsbZ5M33ZjRZJRRGi0W8CdGXT
         QAvLH/60td/MXpheONOiOx5jN1WID/637hGJjAGzq73arSwT1/+m9PFxGgEf0S9fRNu2
         tyKSzS4ZTe5Yf84VJ1zr8+QIm1PEs6NN4BUIBhoJeizbg7S5OUbNANNy/lFArQXjpywy
         p8xbfKol/jatdliF2LpEIwKh8dHfln6h8S6emD8CUt+AHAq3TCBsHgpT/HqF9FjRdaEK
         Neqw==
X-Gm-Message-State: APzg51A13BI19fLd0BpROU4O+dXEkRC4mMFvd1XGr2rPrWk11hKqVPfP
        syfjvliWMuNWjlegXBOGRxGH1x+3Be0=
X-Google-Smtp-Source: ANB0VdbDvQarCt9GGU6amhbV3wLmRNHcKEr1TBz2jj4r3dBWncs3iHnU69aqEJmRt5zek15qiOUU5g==
X-Received: by 2002:a50:898b:: with SMTP id g11-v6mr32460973edg.82.1536010853046;
        Mon, 03 Sep 2018 14:40:53 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x44-v6sm8430679edd.1.2018.09.03.14.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 14:40:52 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org
Subject: [PATCH] netlink: Make groups check less stupid in netlink_bind()
Date:   Mon,  3 Sep 2018 22:40:51 +0100
Message-Id: <20180903214051.4433-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Linus noted, the test for 0 is needless, groups type can follow the
usual kernel style and 8*sizeof(unsigned long) is BITS_PER_LONG:

> The code [..] isn't technically incorrect...
> But it is stupid.
> Why stupid? Because the test for 0 is pointless.
>
> Just doing
>        if (nlk->ngroups < 8*sizeof(groups))
>                groups &= (1UL << nlk->ngroups) - 1;
>
> would have been fine and more understandable, since the "mask by shift
> count" already does the right thing for a ngroups value of 0. Now that
> test for zero makes me go "what's special about zero?". It turns out
> that the answer to that is "nothing".
[..]
> The type of "groups" is kind of silly too.
>
> Yeah, "long unsigned int" isn't _technically_ wrong. But we normally
> call that type "unsigned long".

Cleanup my piece of pointlessness.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Fairly-blamed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/netlink/af_netlink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 930d17fa906c..b4a29bcc33b9 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -993,7 +993,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 	struct netlink_sock *nlk = nlk_sk(sk);
 	struct sockaddr_nl *nladdr = (struct sockaddr_nl *)addr;
 	int err = 0;
-	long unsigned int groups = nladdr->nl_groups;
+	unsigned long groups = nladdr->nl_groups;
 	bool bound;
 
 	if (addr_len < sizeof(struct sockaddr_nl))
@@ -1011,9 +1011,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return err;
 	}
 
-	if (nlk->ngroups == 0)
-		groups = 0;
-	else if (nlk->ngroups < 8*sizeof(groups))
+	if (nlk->ngroups < BITS_PER_LONG)
 		groups &= (1UL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
-- 
2.13.6

