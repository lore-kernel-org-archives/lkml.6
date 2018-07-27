Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC47208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUbKMExv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC47208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeG0Kwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:52:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37579 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0Kwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:52:45 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so2088563plc.4;
        Fri, 27 Jul 2018 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U2bUIY3jlZNqRQT7LBCuDAObxV24OjoUZQ6VoM6FH/M=;
        b=TUbKMExvB3PzUOI4/JEYUW9LtrXSDaxJ34XGmxBEsL3L+NSDwChs4m4gRh8yT4qG9s
         EwNvpJLXpdtlQGHzaGc3dd8+lnekXBPUSHApFcqWa0VM9TpQIJPKdfkDmL+p+i+qYE9B
         e6oA0ga7SOB8qZ8MRdfrGJvJAhUD7t1+N7MlYjJDvHFRqObKOhQPgvyV9hmBXzjYGuDw
         /C08E5/HOL8zvafDh35yU5bcpN7wyiBJ0xP/WFUsnDyFH5X9DZYyJtFkEZBAR1zRw82G
         oPCtUUINh0rArZBK1wGrH7YYuXBW54aIoYHbvVPPO7dxePlIh/o/jZq6A1EydjBKjjwU
         f9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U2bUIY3jlZNqRQT7LBCuDAObxV24OjoUZQ6VoM6FH/M=;
        b=BdIDBC/dLbatnNpJ2l3IMJ2RyYN2wHwxbgc7+mkjhHH+VrkwA9mZ9AvxhuqZiZRs7h
         +ZAA8QIodxBBo3ipTHwtZE0JiEe8E+fqv+X9hugaxSiUYDYm+EwufWzUxc3Jk946l/3P
         CAZUeC/0RMXqpgwkS68W/WOdyXQABDqi3669scK1s6pM2l7TkAV06RoOd0ikYVjS+B1x
         kC/urwrghSkWGXKjZilvMGVZd3zkXGpVzAd5pyHNyGcWcqITbPS6PR+r1r2E5V+FkLWV
         +GPf0e3Ix/wP4IQeumMKcOfguLqkCTyXhSTkDBZtjC7xafZFUGIeB8hJQVRQLjQ9h85I
         qzlw==
X-Gm-Message-State: AOUpUlEu/vS9AWNU2tUcp/sTD7vGoOg8PBoPjFfuz4kqa+b3XeEFvBz2
        F09KSatJY1t669Y3pZq/vUE=
X-Google-Smtp-Source: AAOMgpfpnAX+HAj90pZ3c+AGL6lCUtOfL1ya8iw4MuITTP/GHRHWB3JuZuj9nkzSa0bYQJTjQ8S1RQ==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3-v6mr5321171plk.246.1532683903086;
        Fri, 27 Jul 2018 02:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id n18-v6sm9331893pfa.50.2018.07.27.02.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:31:42 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jon.maloy@ericsson.com, ying.xue@windriver.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: tipc: bcast: Replace GFP_ATOMIC with GFP_KERNEL in tipc_bcast_init()
Date:   Fri, 27 Jul 2018 17:31:35 +0800
Message-Id: <20180727093135.7469-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tipc_bcast_init() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/tipc/bcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index f3711176be45..9ee6cfea56dd 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -512,7 +512,7 @@ int tipc_bcast_init(struct net *net)
 	struct tipc_bc_base *bb = NULL;
 	struct tipc_link *l = NULL;
 
-	bb = kzalloc(sizeof(*bb), GFP_ATOMIC);
+	bb = kzalloc(sizeof(*bb), GFP_KERNEL);
 	if (!bb)
 		goto enomem;
 	tn->bcbase = bb;
-- 
2.17.0

