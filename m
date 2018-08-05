Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C773C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479BB217C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YCMAnW9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479BB217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeHECic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:38:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45904 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeHECia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:38:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16-v6so3443448edq.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 17:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=8jr4ubE/89EJDjqVIiMcByHCHqgz22N9cboNFoT1jj0=;
        b=YCMAnW9lrJqDVtC/d3gc/kZVqdFZd8URQFxPfNmsjF6iHo9wdkw0OjsZ9CiLw0C9rQ
         ekQbo0qE4G1mZFfpoCDhvSe6FS/iXX9U78q1Nsb3Zuu7iAGabCWi4Ue+97iA7h+CaQhD
         VIs1CQvvF4PUG36W+iGyv0PFmkM+54T4WALqhKk+1KPGNfTWz0ASo5dJ3wG29mGD8qoO
         sRxI4FoGZTaDQSbcbXZgdUtPhGGUByNBeDKqO6k55+1Iom6nyWshrwP7FONKq2nAYxJ8
         PKJIw5/f93gqcy0hEuHKedFDeUKzq7pWbF9oFKagHhON6qwv9CkTEVHV1YVoJ3wcv8xr
         xS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8jr4ubE/89EJDjqVIiMcByHCHqgz22N9cboNFoT1jj0=;
        b=MhRHJ5ITXA5qXGhmmosu8nIEdTdmnGhV/tlJCCw2KT2lSSb9/alW6qO5tydzwG+vvC
         9ndENG6C69ctzbH60PWEXKiI5vIcPKGsGqfTt7JBlVLplBDyQKXLCp+8/hNJFW2GL4+7
         OJ5vvxfuFExSI5HpMKN/6fsFJf5XzSazGiDSVhjxDdLDBwCHiG/Nr9zC79hBAwfhDoA7
         Gv7aY37BwQofR4j3v/ZHqkDr0I9JLH7IjZmVOS9vFESyGQzLScqaMzqkfuBL7yd+lDUQ
         3L1ZWLcOXhnzdeMziBe+99MUKSY3m1Qjdlea8Wpu9+7XayA1fPJUYW/izTZKbihXkxAX
         UvAw==
X-Gm-Message-State: AOUpUlFvbb3XgU8SjRibHyExA8IoWXPOTl1PlXZQpc5gZQZhqxb4a2zx
        UDIAnSS3kMpzEcZrtOlHFxgNeY6956I=
X-Google-Smtp-Source: AAOMgpdqxyAqRiyZikXH67zd2XPsiuaTL5puOeKkSAqpww25aqpCsfEeouymyMQ5MXK+oV/+WShPPw==
X-Received: by 2002:a50:89d3:: with SMTP id h19-v6mr12498657edh.140.1533429356628;
        Sat, 04 Aug 2018 17:35:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id q26-v6sm4164249eda.35.2018.08.04.17.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 17:35:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCHv2] netlink: Don't shift on 64 for ngroups
Date:   Sun,  5 Aug 2018 01:35:53 +0100
Message-Id: <20180805003553.11104-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's legal to have 64 groups for netlink_sock.

As user-supplied nladdr->nl_groups is __u32, it's possible to subscribe
only to first 32 groups.

The check for correctness of .bind() userspace supplied parameter
is done by applying mask made from ngroups shift. Which broke Android
as they have 64 groups and the shift for mask resulted in an overflow.

Fixes: 61f4b23769f0 ("netlink: Don't shift with UB on nlk->ngroups")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Reported-and-Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
v2:
  sizeof() is in bytes

 net/netlink/af_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 7d860a22e5fb..d6ff4d409437 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1011,8 +1011,8 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 
 	if (nlk->ngroups == 0)
 		groups = 0;
-	else
-		groups &= (1ULL << nlk->ngroups) - 1;
+	else if (nlk->ngroups < 8*sizeof(groups))
+		groups &= (1UL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
 	if (bound) {
-- 
2.13.6

