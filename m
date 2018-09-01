Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFE2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8F72083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 11:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ere6ehCl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8F72083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeIAPbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 11:31:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39233 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 11:31:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so6599846plp.6;
        Sat, 01 Sep 2018 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zpXmcdUsbwj5gElJZ0iWkZ7QP4qhOecXqtvjxnmtywM=;
        b=ere6ehClkDycpxO31dp3Q8cibj10r8TZhkL0+PrMRV1mGwCGLCVDFMjVWUDdlvDTby
         yLpIBCxg+Chcsrhf9KfyVREFy4Qx7oNbSqN0C2mv88IsPPtsyOpNdfN1Wj42+hxXJ5zB
         raA2TyyojjG0M9fCGdnYxOxUdX3tA78PsIVzwU9atNQOU5FFcrS5hVOhRfGQXLiW/c7x
         v2JE67Ha73eEJ3tqpaRU6IupAB0WrP0W6i7ri/OKziO3MiGlWQnfP62DJknAaOW8F3cl
         afRDNdalhiELY3X6jD4qZDBVTLpi4ZezUar8o9ni1tx3wZnv/TcMlf09qHu2MKKVvxEY
         CPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zpXmcdUsbwj5gElJZ0iWkZ7QP4qhOecXqtvjxnmtywM=;
        b=EN3q3SjK4WBIxXyVxGuhZBf6N/FqPOpiq0iaBKQdDsN7h9ZJiIG7YsjMZVvegtB/Os
         c2gLQYOhdHuv3jR0GfTpchDTX3PQ1ZDckqfm67YgGkaEUiDR2BI78pJnI+bMpW+c/31c
         qSvWCCZySiAdt9PVOycKbdJbc6o1XNKgzShr49Tqo0YqjlgnlRkTID+rq2YQduSbnLg+
         WmZSpNoR3woAS7UZdemKhLDCAAxRaUIeIoDut4CLG34soFpVucj0GnrFZBb2p2zbD8yW
         uM1B4PKIHdYhbTPvWj72jji7+//bw9O+dG5RsiIcLDaaXDQazF6Gyg/acB9UtGL4i66I
         sXiQ==
X-Gm-Message-State: APzg51DlEfit4KHQrj2p9F80aKntsdr37WnXtcTHvVEllg22fiooWKAF
        A7jErfKTelbKzmZqv/4AEyY=
X-Google-Smtp-Source: ANB0VdZlroPkWsMeYctXrzFKEpQUNKjKWpNuf74KaNOHzWWYOvhcyO9g749TP8KYNWCxSpropH4f1g==
X-Received: by 2002:a17:902:1ab:: with SMTP id b40-v6mr20057247plb.55.1535800810115;
        Sat, 01 Sep 2018 04:20:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id p26-v6sm6599983pgn.64.2018.09.01.04.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 04:20:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: ipv6: route: Fix a sleep-in-atomic-context bug in ip6_convert_metrics()
Date:   Sat,  1 Sep 2018 19:19:58 +0800
Message-Id: <20180901111958.26529-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kzalloc(GFP_KERNEL)
net/ipv6/route.c, 2430: 
	kzalloc in ip6_convert_metrics
net/ipv6/route.c, 2890: 
	ip6_convert_metrics in ip6_route_add
net/ipv6/addrconf.c, 2322: 
	ip6_route_add in addrconf_prefix_route
net/ipv6/addrconf.c, 3331: 
	addrconf_prefix_route in fixup_permanent_addr
net/ipv6/addrconf.c, 3354: 
	fixup_permanent_addr in addrconf_permanent_addr
net/ipv6/addrconf.c, 3358: 
	_raw_write_lock_bh in addrconf_permanent_addr

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ec18b3ce8b6d..d15e72def7c1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2742,7 +2742,7 @@ static int ip6_convert_metrics(struct net *net, struct fib6_info *rt,
 	if (!cfg->fc_mx)
 		return 0;
 
-	p = kzalloc(sizeof(*rt->fib6_metrics), GFP_KERNEL);
+	p = kzalloc(sizeof(*rt->fib6_metrics), GFP_ATOMIC);
 	if (unlikely(!p))
 		return -ENOMEM;
 
-- 
2.17.0

