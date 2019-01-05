Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B31C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 15:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E16208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 15:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="XPkMKZj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfAEPcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 10:32:36 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:52196 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfAEPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 10:32:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id AF315D16
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 15:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yd0ScdrFo1XK for <linux-kernel@vger.kernel.org>;
        Sat,  5 Jan 2019 09:32:34 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 82067C3A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jan 2019 09:32:34 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id s3so38421104iob.15
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sEZHiYH52u/jD2RMeuXA32RsiWKpbCNXS9d2zhsVsD0=;
        b=XPkMKZj2uwwXdHOFV27FbndBvMQgORUcLU6Hg4RT9Nljdebop/eksMKfJesbQmKR6+
         CaBZU4wYj1cCxfK0o2UKv6HfycFqIGcOQl6NTnopSOzSZ5VHCLi2qiej3nlp8wa8N4yL
         4oXy7ZZ4irGhP7GN4e/w8SLhPwFq/LGyl0ggTLGLfpYR5LjKKk5CCGXAD8AlJx32cqk+
         7RvcrjSr1zMrggHYiuUk56PKBJv40kXa+fXMas8VIi9dYlNUAXEoE/myssyeOfkv/Rdd
         Afhvtw0hbw+FTA0Od7dXLcudjl4BL0FRE5LngAXILiY1rxpxXh9C6iGCz1A+gI1BaIak
         OWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sEZHiYH52u/jD2RMeuXA32RsiWKpbCNXS9d2zhsVsD0=;
        b=QRT0VxfxqBB6+1wkQp/KFCig24UtZUAzUGtHyjQyMv3gfaMkwjovAM/V7+JFMGvuO+
         f1r/8ELR5E47hPXdBo24GWx6WLAsjpkF843fep8Ck16JisGp9Z9ZekqhKtC0aQqgfoV+
         e76BtVb6Eimj3orHX6Cpepj42uIcg9uHvl7jj429kZHddyKyFTlUPjw8T3GHoB9nJ/AS
         REgvsJj85Cd83tbwqsa6qEDQ4RpQktWgTQXoBx4VGu++n7Pcl6sYAIiQgfNFCaZw869J
         YJqvqVwvKqHK6J5dbMp6bezkTHbDN9uZ2kHDhSuA6FupwA3g7HhAAkTdeQRX4e3qat5V
         wQ9A==
X-Gm-Message-State: AJcUukcP3NoenD5nV1Uz9XQlt219O0grl6+jqYbJYMkd19NGieYUCifT
        n7staob91LNy+AxU60a6BzNBYcSefGDwBiOntpyuMe6ZVP4qXt8rnAJldQTrrpbqalZJczcAH+H
        XlOQHj9QuSZqnWQXsfUJHHdWdHeU5
X-Received: by 2002:a24:81d4:: with SMTP id q203mr3770103itd.23.1546702354125;
        Sat, 05 Jan 2019 07:32:34 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6oDonFdwQKXlaQeYDugC5CYJAC4Kx4zmTnTnpbrBJW6oxwd5BZgTfxzPEfGk7M3nLDq63hNg==
X-Received: by 2002:a24:81d4:: with SMTP id q203mr3770086itd.23.1546702353915;
        Sat, 05 Jan 2019 07:32:33 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id y12sm16765651ion.62.2019.01.05.07.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 07:32:33 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] netfilter: ipset: fix a missing check of nla_parse
Date:   Sat,  5 Jan 2019 09:31:49 -0600
Message-Id: <20190105153150.2600-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When nla_parse fails, we should not use the results (the first
argument). The fix checks if it fails, and if so, returns its error code
upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/netfilter/ipset/ip_set_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 45a257695bef..3ee0fda05a3b 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1546,8 +1546,13 @@ call_ad(struct sock *ctnl, struct sk_buff *skb, struct ip_set *set,
 		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
 		cmdattr = (void *)&errmsg->msg + min_len;
 
-		nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
-			  nlh->nlmsg_len - min_len, ip_set_adt_policy, NULL);
+		ret = nla_parse(cda, IPSET_ATTR_CMD_MAX, cmdattr,
+				nlh->nlmsg_len - min_len, ip_set_adt_policy,
+				NULL);
+		if (ret) {
+			nlmsg_free(skb2);
+			return ret;
+		}
 
 		errline = nla_data(cda[IPSET_ATTR_LINENO]);
 
-- 
2.17.1

