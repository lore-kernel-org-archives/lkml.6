Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFADC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EA02075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKiVLWuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EA02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeIGICQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:02:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35484 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIGICQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:02:16 -0400
Received: by mail-qt0-f193.google.com with SMTP id j7-v6so14875178qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 20:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lzf+RDqvRUUry6Emsm+ZLwTLcMKAVWjZxjmoWJmID6c=;
        b=LKiVLWuu7ayaxwF5s5+FFA49Br/i6X3+eFmSAi6TDkeB0leKI+Fq7KLC4XLW4dBB/U
         tlQ0GNLoLGU9ycM9TJ8bYlUZefpwEN6NTpHW9M7P+OrZ3lIkCQU2AQQCVKCKN4mMAfrB
         eGD2Vtdjjo6cqfBMXO9KQdFk3ZKzF19HpdnWW0Y+Vpu+60533MfA+xVrgRWh2TfaN3IM
         JSKrwAwl48AmlSNi3xsCycoowwWgUxC/LXS+MCAgElwSnpmrrRmB1slvT0Jf+E7rT1pf
         dlL38tyDF4koUBizQmqYTtozPDCt4Fz5npOH2bm/pgURAJ543dlbtKF4w13MJMas1EQ9
         xUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lzf+RDqvRUUry6Emsm+ZLwTLcMKAVWjZxjmoWJmID6c=;
        b=KhZTMmdMAWPgQ3GYx5eyUwZEL1/h+zs8cpXEl/eu4I4t42ukLQpntwpgVSHiSjpfUx
         GVvpkMDUjr3pgCuo3jawNDa6qYee7ZJDy3FnQ6GKrTwr4Sj6U5SaRG9aewYCBysvWhoT
         14tYBw0TVDGKxMNtgnuwpEbLZfVemSEIvLoK++oPCawab+c78iJ9QYBAXmrIbpWVUT2D
         7qNcbUUhQIAIcbh7L2ByxueJF5v9p4EvIX/mFBRhL4V+1+MEbBDuvnb74GdjyrQ+71zI
         TMc3WVQrnIvM/bxGNMHBOnnMMkg8ugw/YHP8WrZsJUtt5MtXFsEj9CVz2TxCIyq3zz2P
         h6gQ==
X-Gm-Message-State: APzg51BVATpusjfcUXuADWjvcI4jbBQGzmrtXQwGW6+O0BPQS1Y2w8+D
        /6Jcj4ZQILK4Jf762jOJEsc=
X-Google-Smtp-Source: ANB0VdYcextLHuWQZ/kYjiD9q8oMUR6Y/DxAAKoQmk+z02vi8c6wvRHRwl4yE+PfhbtQsfqeSBcSBg==
X-Received: by 2002:ac8:5514:: with SMTP id j20-v6mr4494716qtq.139.1536290613026;
        Thu, 06 Sep 2018 20:23:33 -0700 (PDT)
Received: from localhost.localdomain ([186.19.75.93])
        by smtp.gmail.com with ESMTPSA id u38-v6sm4891506qth.67.2018.09.06.20.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 20:23:32 -0700 (PDT)
From:   Pablo Pellecchia <pablo9891@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Pablo Pellecchia <pablo9891@gmail.com>
Subject: [PATCH] lib: rbtree: Fixed assign coding style issue
Date:   Fri,  7 Sep 2018 00:23:00 -0300
Message-Id: <20180907032300.30322-1-pablo9891@gmail.com>
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

