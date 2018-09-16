Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43017ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF702087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNkss5kD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF702087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeIPFl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:41:59 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36308 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeIPFl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:41:58 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so12215129qtn.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lzf+RDqvRUUry6Emsm+ZLwTLcMKAVWjZxjmoWJmID6c=;
        b=vNkss5kDzicg6u7vwTzhCcgKXC5oarE6lKfOlEVOb9N0iUArgNnOLI+JL326istm9W
         2nT1tc4Bduf7aL4rV+d+dZSORj4fsop4IAHjOgFyw4jkp0YPWrN1ilPbu17Mjp62d7GH
         XNG8dXlr5yl/RJT6/2bTaLA7xbTsto9WA/nKv/AjIYPWSyw89r4z0dKhvQ3z8SAnvTvB
         c5C6OIMbePKjOEw3xEnj4OXeeMLMseEllr6zMUTRb+FLJlo3n4+CotkHLUQ+bimlUYxi
         6vBVZuyuXI8itSj2/t8auagBSxcuCKSjHpgYGAnFvJtp1ITvdNIjSssaJMKH1mEE1UWo
         iX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lzf+RDqvRUUry6Emsm+ZLwTLcMKAVWjZxjmoWJmID6c=;
        b=ibvJqmcV9BUow91OEPkT/iZToagNakSYYf/q045flN6x6CBzmVZMi1YTgki6jFc84T
         4eXgSeLdgyC1s6/+JP60xQ5yOHRt1fExV7mCZm4Lr5ycPgd819NNTxrdbYijj53b9z/M
         vlfOBTdWr7u0v60bEKiP8zZn1GHg/gUZQ5jwj0wwgQWEWHgt6s8vclDn906KGeLxYb+k
         VbUiIGSKEm4SRhkvXlPrUGCThxTN6VzgnGQDawJsO59SbDbEXfVkWqJmrgt6LAVLhaxC
         PejcSYDDW9phgB4iNLrLbb+hSZQ1GO9oRBm2aNP+qm1PLxgguyaJRHMfOy/AE/hSxUY5
         VBAg==
X-Gm-Message-State: APzg51BhDAQaUufLUxv6xdtwFx/Gnd0CKfV+QzgI0JtKDCgPYhYr0LEv
        HXaB3bYK+HR45Nm3M79WuPo=
X-Google-Smtp-Source: ANB0VdbIxh+bAA/2VWT9fqMUDz+wdNnGdtchZpZk+4C/qr/Zeyyct47xVIqcDUViVzdyjiRrGolyXw==
X-Received: by 2002:ac8:1c4e:: with SMTP id j14-v6mr13881936qtk.159.1537057264230;
        Sat, 15 Sep 2018 17:21:04 -0700 (PDT)
Received: from localhost.localdomain ([186.19.75.93])
        by smtp.gmail.com with ESMTPSA id u7-v6sm7779245qtc.76.2018.09.15.17.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 17:21:03 -0700 (PDT)
From:   Pablo Pellecchia <pablo9891@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Pablo Pellecchia <pablo9891@gmail.com>
Subject: [PATCH] lib: rbtree: Fixed assign coding style issue
Date:   Sat, 15 Sep 2018 21:20:20 -0300
Message-Id: <20180916002020.10926-1-pablo9891@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issue.

Signed-off-by: Pablo Pellecchia <pablo9891@gmail.com>
---
 lib/rbtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rbtree.c b/lib/rbtree.c
index d3ff682fd4b8..c47745c39671 100644
--- a/lib/rbtree.c
+++ b/lib/rbtree.c
@@ -539,7 +539,7 @@ struct rb_node *rb_next(const struct rb_node *node)
 	if (node->rb_right) {
 		node = node->rb_right;
 		while (node->rb_left)
-			node=node->rb_left;
+			node = node->rb_left;
 		return (struct rb_node *)node;
 	}
 
-- 
2.14.1

