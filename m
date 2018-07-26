Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0C5C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AC820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Bv++vz/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AC820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeGZDrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:47:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44821 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbeGZDqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id f23-v6so324104edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1lJb2Xgk8XeoJi527HTQMfXBx4RnBCtj+CFeFlu3zoM=;
        b=Bv++vz/GESBtRPNgCCKHpg6Xh3cDuuQs8KocTF+BoOeY3v+Bx6w/KUvMnwupir0eun
         pG5a5ULvNUHqZImP7AFDTbdxma5C7OPjcbd1+lKy8D2UtB2B3wEJXqVvH8tkp8EgIaC1
         XwKqUDWG2XV/Fvh4oryMY6Cj/UcwOCcTOnz5mQ5Ele2BTCJu1a9xQUPVrj+S/eC7Yx7v
         mWzHg7EZooYyBdqS7Tz9ihLKWnqOIltxOg02xLaTmjkDHZdeJaf25wDaj1sq9FpbC5ac
         jemaeo41id8SBDgEF0H1NoMCJa1ssnaEZ9cBdjyKU7d5CIt3+MEplxIhWqjDK/tBMM+3
         xBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1lJb2Xgk8XeoJi527HTQMfXBx4RnBCtj+CFeFlu3zoM=;
        b=JtLLgj32TQOC6Mcs6M6c0J4T4oEtMPGQg7O1MuTmI44YPao/w5iwNnfmqwPDXxjq32
         2j5bVyraIibXNAPKrSANCjIm+OFXI9dmvIADDejrb/Jg1CNL2qrHgl+fzyQVLh2W8CcJ
         1WLyI1RyuFw7Xc2MotZUd/ObMM77P31xUQUrRgFva7dbO8WleqoGPVySH9Sc16kAN6z1
         81ffX3Bpr6CK94OLTSMIEpDxw9djZHBsESFbCanhZfGuDRi7FZSo913GpKiqZ3ioee00
         qTHc9/6X/WFn2Y7tVWVl2o0sXgucltlno4Ph4XYuXTd1JR+nSb4+qkCUDz77erMAeOQU
         n9Yg==
X-Gm-Message-State: AOUpUlFoX1Y7FWfaI1XH0+wysonoraVfcF2OzfGsfeN5bbaiZWVSJzfC
        GoHnaDfOUSr4UIdPjXF3qbcel41KX9M=
X-Google-Smtp-Source: AAOMgpfOz4nbJFpMROISGgUI776G4g+ZHIUkE6QHLmpIFO6dEcJT+YNfdonzBvheejiCWBpphpWQGw==
X-Received: by 2002:a50:a7e2:: with SMTP id i89-v6mr493394edc.176.1532572323756;
        Wed, 25 Jul 2018 19:32:03 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:32:03 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 15/18] xfrm: Check compat acquire listeners in xfrm_is_alive()
Date:   Thu, 26 Jul 2018 03:31:41 +0100
Message-Id: <20180726023144.31066-16-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As now there are two groups of listeners:
XFRMNLGRP_ACQUIRE - applications that uses native UABI for messages;
XFRMNLGRP_COMPAT_ACQUIRE - applications that uses compat UABI for messages;

So, both groups should be checked for listeners of acquire
notifications.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/xfrm.h   | 14 --------------
 net/xfrm/xfrm_user.c | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 557122846e0e..c9b713017ae8 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1784,20 +1784,6 @@ static inline int xfrm_aevent_is_on(struct net *net)
 	rcu_read_unlock();
 	return ret;
 }
-
-static inline int xfrm_acquire_is_on(struct net *net)
-{
-	struct sock *nlsk;
-	int ret = 0;
-
-	rcu_read_lock();
-	nlsk = rcu_dereference(net->xfrm.nlsk);
-	if (nlsk)
-		ret = netlink_has_listeners(nlsk, XFRMNLGRP_ACQUIRE);
-	rcu_read_unlock();
-
-	return ret;
-}
 #endif
 
 static inline unsigned int aead_len(struct xfrm_algo_aead *alg)
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 2fe6174b8a18..752019963b1e 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3517,6 +3517,22 @@ static int xfrm_send_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_MAPPING);
 }
 
+static inline int xfrm_acquire_is_on(struct net *net)
+{
+	struct sock *nlsk;
+	int ret = 0;
+
+	rcu_read_lock();
+	nlsk = rcu_dereference(net->xfrm.nlsk);
+	if (nlsk)
+		ret = netlink_has_listeners(nlsk, XFRMNLGRP_ACQUIRE);
+	if (!ret || IS_ENABLED(CONFIG_COMPAT))
+		ret = netlink_has_listeners(nlsk, XFRMNLGRP_COMPAT_ACQUIRE);
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static bool xfrm_is_alive(const struct km_event *c)
 {
 	return (bool)xfrm_acquire_is_on(c->net);
-- 
2.13.6

