Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF6C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743F220671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fUf6faqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743F220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbeGZDqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44822 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbeGZDqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so324131edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6C2SkELl5J+d+DA1SAR8gQBCVXA7QDjBRXy/0yXYOx8=;
        b=fUf6faqOO/TcoZXkzKhndEw/rFIkTIKr8IBH6d/Rz/UDiO4vFkW6PHvlqeharxgltg
         z09CLMoj/N3v901QNThclraXGww736EtgmnpDCYLm+4QONZLipLe7UakioFUAxF9LSYq
         dcZ7ZDzrOxUDJMpYKLeNPwNXLns489dm///Ijun8osHTwKenYapZjoNHIgGogYk4uuZS
         kP7doBP6+vuDs/knxMuxP/kd4bU+TR1aOfsTCYNVo1aDKyHCnFpBfeeMDHxpGQVDuF4N
         65tTtZpWcpjHawpxtFksn3HU4Axc8o8zO86ESHvtsmfddDL9iojDhbqfq+Nzz8Ju6Tfr
         Chwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6C2SkELl5J+d+DA1SAR8gQBCVXA7QDjBRXy/0yXYOx8=;
        b=grrHm2EUWKyAO+JSFsqsdX3PVwRavqxA4F0XCYAJqVYCAnaRcO1Ww1sympZyFPTim4
         6rKzDEb1Oa36PTVKgTlRSzmEmt4SOnZWHXHh3k97wd44YUGx08b50BvTym+Ehj98JWUb
         GdJTYCn+X7RzZghulbSzHE60NHGC7dyrd0fmcDBsFWWR/KVaNIgNvhjF0e0ececOQFLZ
         lEauB/VSUHpDB22sgvxIYLx8puX5wUb2GBDZ2jaWCiZT7P8uYKnmIGwTVeybShW34dCm
         tVRZqspDxb8b/RIOWjLkVtSA2in/qsWm8h4ydOU3tRnN5VXWn/wlFU1Cr/f4Q7BeLy/D
         xRIw==
X-Gm-Message-State: AOUpUlGH82mmuBtNUTb7dsg/2y6u7NDjogutPCGIDyCqrRaKAUT7/Tro
        EWnR0GfYNaYCja5OJkPbDVlmgWRI+xU=
X-Google-Smtp-Source: AAOMgpd/LjiVOi0r6rdv3t3em7ZRO8x14m+zcpA7VQR4J12XIbD3IIuQhgHlavxtz/eeGBj8yyPq/g==
X-Received: by 2002:a50:ed92:: with SMTP id h18-v6mr492026edr.117.1532572324976;
        Wed, 25 Jul 2018 19:32:04 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:32:04 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 16/18] xfrm: Notify compat listeners about policy flush
Date:   Thu, 26 Jul 2018 03:31:42 +0100
Message-Id: <20180726023144.31066-17-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify two groups of listeners:
XFRMNLGRP_POLICY - applications that uses native UABI for messages;
XFRMNLGRP_COMPAT_POLICY - applications that uses compat UABI for messages;

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 752019963b1e..7bba0638c014 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3368,7 +3368,8 @@ static int xfrm_notify_policy(struct xfrm_policy *xp, int dir,
 	return __xfrm_notify_policy(xp, dir, c, true);
 }
 
-static int xfrm_notify_policy_flush(const struct km_event *c)
+static int __xfrm_notify_policy_flush(const struct km_event *c,
+			unsigned int group)
 {
 	struct net *net = c->net;
 	struct nlmsghdr *nlh;
@@ -3389,13 +3390,22 @@ static int xfrm_notify_policy_flush(const struct km_event *c)
 
 	nlmsg_end(skb, nlh);
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_POLICY);
+	return xfrm_nlmsg_multicast(net, skb, 0, group);
 
 out_free_skb:
 	kfree_skb(skb);
 	return err;
 }
 
+static int xfrm_notify_policy_flush(const struct km_event *c)
+{
+	int ret = __xfrm_notify_policy_flush(c, XFRMNLGRP_POLICY);
+
+	if ((ret && ret != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return ret;
+	return __xfrm_notify_policy_flush(c, XFRMNLGRP_COMPAT_POLICY);
+}
+
 static int xfrm_send_policy_notify(struct xfrm_policy *xp, int dir, const struct km_event *c)
 {
 
-- 
2.13.6

