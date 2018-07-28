Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB7EC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2274C20671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVV5DDAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2274C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeG1E1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:27:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42835 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeG1E1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:27:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so4232931pgp.9;
        Fri, 27 Jul 2018 20:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VORt7Vwp8kPRlVcENJKRTCkFAYCMncXQwnhWNINm5uI=;
        b=GVV5DDAFXeA09yi01EiKb2xUMVIjbPeGhkL4BrsIU8qMgVMHpvLyIKqhMzLQFdruRD
         Eqs0LBMiIQzouAhXOVkHnahzrQdUDjF5h1N0LswMUgp/U6dh0BogCrW1tjcD1YjbEuxq
         p9m2/HIFtugmVED0vmaAktYa52Y9Q3IvTCaI21KSemGTMJWb2e1txMv8Efm/+Oe/WzJT
         F6U/w4TROuz/s9jO0960rbByswA4lbZeiFPgEyr6M09F8VnC2i0j3057n24nP8xphe8C
         JeCo5W1aCdqr3hxyOWmjD11YoG4DJxTlqgYN3mVgTJeH/gJyjnZD9c4Y2oooiQn5yCHK
         CO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VORt7Vwp8kPRlVcENJKRTCkFAYCMncXQwnhWNINm5uI=;
        b=OcalikQbyGHOsPKbbqj3hN7pEamQwieOtonttvEus//SC2V/V90CeHV8knyoO0hDtH
         ju2QBPKrORjnhCZCLi8VI65DessZyZc2SRpcuaLiZFEBYG5+oSbFEAM4Yr59gYl48O1p
         fjLwZA9wg13x7D2xTOYEA0DnZ49FUK3qNs54oIvTpZCecABu3R4RZ6IixCplcL9YAlXm
         u2U5xB2Gi4jK04vZUl6BA6Xb0psEw6g6OvC0GM26srBgjqhrxMrPYHIYZXTnLCeCA753
         J5HpArqp9MbgyNat9AWoj/R8Tpdz/wew5j2fwWCZuDM7nQJ4DLGZ/Gg5FDaKFqV2wiGE
         Bb5A==
X-Gm-Message-State: AOUpUlGeIKfNYVrEB5Zfu2pznRv9xYhMyA/1kH+aFtVQh+xtQ3+gbU6m
        mobYnTcOWXxqSyToiGJFirc=
X-Google-Smtp-Source: AAOMgpf081xLUvgupQ6M4/abaSJypk9fuZSo2oo+oNSEY3PuRKaZxU64DoofInqOIuQa0EYUVRnwWw==
X-Received: by 2002:a62:c1:: with SMTP id 184-v6mr9159922pfa.100.1532746937729;
        Fri, 27 Jul 2018 20:02:17 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id z10-v6sm7329196pfh.83.2018.07.27.20.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 20:02:16 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
Date:   Sat, 28 Jul 2018 11:01:39 +0800
Message-Id: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this SKB is dropped, we should add the counter sk_drops.
That could help us better tracking this behavior.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d51fa35..90f83eb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4802,7 +4802,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
 	else
 		rb_erase(&skb->rbnode, root);
 
-	__kfree_skb(skb);
+	tcp_drop(sk, skb);
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVCOLLAPSED);
 
 	return next;
-- 
1.8.3.1

