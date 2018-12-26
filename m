Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01882148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dZvW669f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbeLZDuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:50:32 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:58938 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeLZDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:50:31 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 00067A98
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SM4uluW8iqHx for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:50:29 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id C5FE09AA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:50:29 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id g7so18697054itg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o5RiJVoGILRyfHHQUYAiGnY19zw49HHQPflwBs5Gz04=;
        b=dZvW669fQrUjsDLwIocYyF/7lk84IwuBVA/PJtyO7QGpplGI3dstKMqqxUCXGnX9E/
         hLhJF51r4h6Nxd7Dr1ihETVhY+M8FpeCMn43n9fieg42oLxPZ9N3UZdWPlpKp036wtOA
         cnAJfuWITG7a9w3k++Xlh6PEQClET8Ki0O4eOm+0HO50/4lBZfBJEnEPR2HO0CbpoyMa
         VYxUGstIQW3ZbceCB5MoxK6DcwuZjmZw8dRR5cQvQO9q2+XQFAfDoNX6B6q/n2HMWSDp
         XonLoAHFcZMMsoQMgP8T5Oz5+lh6JPBe0C8HunnXr8AteCDFvgNZXViXf5x1uk6fRC5O
         JH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o5RiJVoGILRyfHHQUYAiGnY19zw49HHQPflwBs5Gz04=;
        b=OBL83TolcRA3hmnx+GEruNi9ufEgJ9eCE3Ev+sBZ/XiYwJz9JR+gqbqNeStUiR4Ns2
         ex7CgXWEWLE5gCgpQaec9Xaz0YOntN45CZRj81PM8znUFtpxrH1XUs1ZCkHuzW2eFPXj
         zisP93m860o3zlcot5tcvU5zTCoCKXCn6FnOeTSwlE0Z46Fg6lQBCv4dbnLsK301xfLU
         dVPV16kdaFNDA90XVtoO3PmZjXsdsq7OZiQGnI2KHJcGonvqc7yEnr/k/z+SrVcHvuGl
         wwIMOhZP8dBylqgP5XsZk3aWnbes/Kvc4VsQwrD9NbuSTJ8/82a8+lL3o0LBkvB9Hc3h
         TLsw==
X-Gm-Message-State: AA+aEWZUjcYv+kNjhIROWnSJmBAlPVBGwpZJ9kgmk6OCBJe23xGI27jF
        J82/Xu1rgkSch3V4heX4WTlZ73Xxt7FA7GvV3wxcWxSOnFUFOBovlt+zpnmOlF4UCjc+pOkEEUm
        qbgYgXRDL3E5M86oXeQNV2TTfWJR2
X-Received: by 2002:a02:7a58:: with SMTP id z24mr12316602jad.22.1545796229350;
        Tue, 25 Dec 2018 19:50:29 -0800 (PST)
X-Google-Smtp-Source: AFSGD/X5v+gPVfmxZqMxmcR87k3cGGk8QCMEKxG+AeFy/5WfLEWyTE8YFr8tyOML6o58p12sEg2Lxw==
X-Received: by 2002:a02:7a58:: with SMTP id z24mr12316590jad.22.1545796229117;
        Tue, 25 Dec 2018 19:50:29 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id h14sm16062538ior.41.2018.12.25.19.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:50:28 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipset: fix a missing check of nla_parse
Date:   Tue, 25 Dec 2018 21:50:01 -0600
Message-Id: <20181226035002.73614-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nla_parse fails, we should not use the results (the first
argument). The fix checks if it fails, and if so, returns its error code
upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 net/netfilter/ipset/ip_set_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 1577f2f76060..4dc8057cff02 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1531,8 +1531,10 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
 		cmdattr = (void *)&errmsg->msg + min_len;
 
-		nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
+		ret = nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
 			  nlh->nlmsg_len - min_len, ip_set_adt_policy, NULL);
+		if (ret)
+			return ret;
 
 		errline = nla_data(cda[IPSET_ATTR_LINENO]);
 
-- 
2.17.2 (Apple Git-113)

