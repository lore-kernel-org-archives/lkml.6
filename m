Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD2C21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jX2AmSUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbeLUGqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:46:50 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:50922 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731902AbeLUGqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:46:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id DF1BACF6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:46:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c1jW77_3QxZD for <linux-kernel@vger.kernel.org>;
        Fri, 21 Dec 2018 00:46:47 -0600 (CST)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B147DCF8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 00:46:47 -0600 (CST)
Received: by mail-it1-f197.google.com with SMTP id g7so4131630itg.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 22:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZXOsz8D6OYuAq24OnPFb5LGonzTDqcsAOi7dzlwP3e8=;
        b=jX2AmSUK/nfN0daZAP8GNROPCpg0wKT+3R/QHKlliiuskahjLL/4+QpsCQawOKNbqA
         bM5KZoAs6IZ3SyQ9nVFPKt3Ou2azSU6mqacvYEhpZ8rUbesVP7Z5C6xZaI+5lPOg4J2l
         1+qeR8bFBXzjKMgpvHP7QHzjX3EVDdMHCYtRf7/kBYFXXRBW6bsADLHcwkeS7bKS6jnS
         g2mVntT2+gaqNFJwns3EULm6DUfGl8Cdh7TeBXXNea3xUNFYTuQcZPPSarkBNAf7sLUx
         KgPPKMIHvfA1IGeOOgT8oak/cW8kIVypCRw1J23ttWgLtRyBunWqrAHdZaW9lhNhYLA7
         WD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZXOsz8D6OYuAq24OnPFb5LGonzTDqcsAOi7dzlwP3e8=;
        b=k4WTyeSMxpZNICA+DElI6ASmoCaicxgsCR5KyzOsyk9J/5AJYy6twDFXVYH7RCvmPu
         O0xTg2KHhaopNR5ZQ4k7HJCibdEieZsJmeCED8FhDWV+a6J0vO5ZOs3Ap5YvDmnh7MyC
         rGRu77J85iXH2e83TELeDT8ITatSQ/Ij0BKNeqsG1wAIlH6aWdyKcFTWM+0ZiVo2T/Hi
         t49AGH5mLbKMgD7SLYBUZVfmwJwYsali27cPKZ64MQz/7JU0zU0OxUod4/CU48MzZ3MN
         cC+iIq8U4AgG4dZpwy/Hh6RUQN4L9/gvElzuVsyEaD/eOpdRYo5jaYZLeoN3brFo8EB9
         rJfQ==
X-Gm-Message-State: AJcUukfTt8/p3n5q9kAjYoYNf06R1c9gJ+TkzuS+A92LzIPpuownwx7p
        hFwebl+7iO8pKYTF/N6s350MkYDsjqius6f3R6rm6+XVBH7cG3zLcFNPJqQz5L4EXPvw2nS84+X
        zU674Cjjvr4/U8AaH9v+tIJXTM1Gn
X-Received: by 2002:a24:74d1:: with SMTP id o200mr1185651itc.95.1545374807302;
        Thu, 20 Dec 2018 22:46:47 -0800 (PST)
X-Google-Smtp-Source: AFSGD/U2A4iVGF6lJGA8lRJaDSeR9wqxtQj2X7E+NXtuPQKg3iEzzumAUDf473cSVohGR45jGSSWcQ==
X-Received: by 2002:a24:74d1:: with SMTP id o200mr1185636itc.95.1545374807070;
        Thu, 20 Dec 2018 22:46:47 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-23.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.23])
        by smtp.gmail.com with ESMTPSA id p10sm345346iol.57.2018.12.20.22.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 22:46:46 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: fix a missing check of nla put failure
Date:   Fri, 21 Dec 2018 00:46:23 -0600
Message-Id: <20181221064623.59988-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nla_nest_start() may fail. The fix checks its return value and goes
to nla_put_failure if it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/netfilter/nf_tables_api.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2e61aab6ed73..bc1b9814f2ee 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5689,6 +5689,8 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 		goto nla_put_failure;
 
 	nest = nla_nest_start(skb, NFTA_FLOWTABLE_HOOK);
+	if (!nest)
+		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_FLOWTABLE_HOOK_NUM, htonl(flowtable->hooknum)) ||
 	    nla_put_be32(skb, NFTA_FLOWTABLE_HOOK_PRIORITY, htonl(flowtable->priority)))
 		goto nla_put_failure;
-- 
2.17.2 (Apple Git-113)

