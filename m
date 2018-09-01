Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B3FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B697920845
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bokOuGDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B697920845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeIAQdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:33:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbeIAQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:33:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so6717856pfo.3;
        Sat, 01 Sep 2018 05:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNtbETmUhFnTOzHv72I2Ebs2X16NzbVqsBREibxEVF4=;
        b=bokOuGDMqO7nEMjGEzaScLCLDvlzpD1Fkiv0f7QosUly05uwzyV9FGf2ht+AkgF5GZ
         4oBzp0wS5s7/aA6kRSDw8GGobJOIHoGkdZVz6Q1tnO3MlNBcFqA4X0v9YhcGnFb9lCkp
         UEdXTR654mR250sjP8xiKvcvz+xJ197ATk777KONVa+VjnbjfiUbdkHzs49nmo2EXmBp
         XGejDR3/tkjeSiCveBiv2DAxshf6DaYTkL1E9IqtInw6CQQ/ColpZ1Ly8+uslPMy1Yg8
         LjJHQZuIVGsy/SIvO6XyMcGPiVojy8sDKVmaO3t3lTAjaygo7WF5spDADG4SgsqUIqDL
         kZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GNtbETmUhFnTOzHv72I2Ebs2X16NzbVqsBREibxEVF4=;
        b=B3aI9dY2tBvPC+azXchF17ECPGl/iK4ulX4WCHVRkk6Z0b7DRSj5HJRzc4xZpe/8/P
         XIHEr4XijSMkhuin5l/fXlqMEtY3BiOyOwTXHNL+zEycvVjcJrxo6UAaQRzamDSHQkEe
         xQlIKq/y9xH3Bk7oXIXHIKL9VYSOVb6njXT0rY8uYpqIAl1Omwuc8b7SBT5z9a2q9rEv
         Asugi+UFJJbC+9EEkQASajlbN1uA9h8LG8KtEGAfFwrIpn3kCbpp9fmHugX1gxWQhff6
         8AYzGkX1lGV1Wh8m5AVznfhqwIicxt1Dc4HjLFZtESJSeDTsMUw1J8KtML/aYwVslWnf
         S9zQ==
X-Gm-Message-State: APzg51BYEZ5T2SJMICKNcNTi3mKHtSII2hexS8DDzvk///y2mb53HkFu
        hHIiVkXSLVbSJz8TSHwD4sI=
X-Google-Smtp-Source: ANB0VdY8YvMuN9ZASsWhb+bJnqbdvdlBykUoczssHagRyQMSOhDCYyxFPrhB9Ndu0kPn0uDjf87IXA==
X-Received: by 2002:a62:be03:: with SMTP id l3-v6mr20502131pff.138.1535804492003;
        Sat, 01 Sep 2018 05:21:32 -0700 (PDT)
Received: from bogon.didichuxing.com ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id z19-v6sm22454043pgi.33.2018.09.01.05.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:21:31 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     edumazet@google.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH net-next] tcp: remove useless add operation when init sysctl_max_tw_buckets
Date:   Sat,  1 Sep 2018 20:21:05 +0800
Message-Id: <1535804465-11795-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535804465-11795-1-git-send-email-laoar.shao@gmail.com>
References: <1535804465-11795-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cp_hashinfo.ehash_mask is always an odd number, which is set in function
alloc_large_system_hash(). See bellow,
        if (_hash_mask)
                *_hash_mask = (1 << log2qty) - 1; <<< always odd number

Hence the local variable 'cnt' is a even number, as a result of that it is
no difference to do the incrementation here.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 44c09ed..09547ef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2549,7 +2549,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_tw_reuse = 2;
 
 	cnt = tcp_hashinfo.ehash_mask + 1;
-	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = (cnt + 1) / 2;
+	net->ipv4.tcp_death_row.sysctl_max_tw_buckets = cnt / 2;
 	net->ipv4.tcp_death_row.hashinfo = &tcp_hashinfo;
 
 	net->ipv4.sysctl_max_syn_backlog = max(128, cnt / 256);
-- 
1.8.3.1

