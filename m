Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921A4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D2E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GFasW/3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D2E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeGZDql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44823 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbeGZDqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so324154edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wmvEwHXGrv0tUfQuAGw1QAVTFm4+aPV+0zO5SRaH9Dc=;
        b=GFasW/3rpCfEDxx869JZ2gMOa0aGVdQ+Xp0AqFkV79sxenfv/FofBLpJY3EEsyq0LK
         F8Bn1JqlHZl/ouwO81Xe503uYa0xMxvYkYogN+K5IAja14NM6XZmVUxf0MQVRSkJT7t1
         z4HgQpG2dgafxwArde4dGK/5qkL5BBUtFrHE9otFocSvl3xG1PTpQro1+vBB6d4DAa4E
         hZvxmrnXnYeJBRV4vzUVNof4nKYA4ecopviyT+CA78y/BcupZawgo1/308JKRwu+RCLz
         alUSjDEar4cnlaPdCJrt76XRNGnx5Coe3Yd2HCugGvXsTNkvF5JOKvzVb+iJx7KTXn6X
         ARYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wmvEwHXGrv0tUfQuAGw1QAVTFm4+aPV+0zO5SRaH9Dc=;
        b=tGhH3O0wKI2cOdpZqx9XQBS1FAkgvbfQ8VzfXcZ2hIDwkb61g/1+EAYAWGBQ4xJ1cH
         lLz03l2kunP189e/Azex7uBIKWERjosZNsYpXIN4mkMYNZqJJSzPZoz4yEV+B61inPLx
         /Bf6b6h9jk9nKKOYTruZSpIT78EQjUnDeIFJxfO04VyymNzpwnbAIwICSyK/QbZ6oQsV
         vxj5swHK3rOPg618/+eCBEJADk3mdRQWwpAy/CHfhIUVG2iwZqs7SLRta62gNqce3ICI
         L6lhSeNR0Go1yn7T0XyQBXBWtt1AVBLjNTpRaB1C2zLm/rJtQ0+CuQWTLvyht7To0nih
         Mscw==
X-Gm-Message-State: AOUpUlEgQU+i6g1biFOJtg0zvSRhdeZkyrkyoP3SIs77zITmOQDftarL
        jY4hjLg8hW/TQgPgbdqpDfvGZkicSnQ=
X-Google-Smtp-Source: AAOMgpfkBuqpE8+D8EBdkD0A7vQZAIZnwXxzZjXqBv6iDNeecHhwaeurNGBc5vP8YHSUooX2yiRT/Q==
X-Received: by 2002:a50:9a02:: with SMTP id o2-v6mr517551edb.236.1532572325870;
        Wed, 25 Jul 2018 19:32:05 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:32:05 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 17/18] xfrm: Notify compat listeners about state flush
Date:   Thu, 26 Jul 2018 03:31:43 +0100
Message-Id: <20180726023144.31066-18-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify two groups of listeners:
XFRMNLGRP_SA - applications that uses native UABI for messages;
XFRMNLGRP_COMPAT_SA - applications that uses compat UABI for messages;

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/xfrm/xfrm_user.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 7bba0638c014..7e3a132b76fb 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2879,7 +2879,7 @@ static int xfrm_aevent_state_notify(struct xfrm_state *x, const struct km_event
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_AEVENTS);
 }
 
-static int xfrm_notify_sa_flush(const struct km_event *c)
+static int __xfrm_notify_sa_flush(const struct km_event *c, unsigned int group)
 {
 	struct net *net = c->net;
 	struct xfrm_usersa_flush *p;
@@ -2902,7 +2902,16 @@ static int xfrm_notify_sa_flush(const struct km_event *c)
 
 	nlmsg_end(skb, nlh);
 
-	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_SA);
+	return xfrm_nlmsg_multicast(net, skb, 0, group);
+}
+
+static int xfrm_notify_sa_flush(const struct km_event *c)
+{
+	int ret = __xfrm_notify_sa_flush(c, XFRMNLGRP_SA);
+
+	if ((ret && ret != -ESRCH) || !IS_ENABLED(CONFIG_COMPAT))
+		return ret;
+	return __xfrm_notify_sa_flush(c, XFRMNLGRP_COMPAT_SA);
 }
 
 static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
-- 
2.13.6

