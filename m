Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B4820897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uw0YtFNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B4820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeG0Kte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:49:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37605 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0Ktd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:49:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id a26-v6so1550107pfo.4;
        Fri, 27 Jul 2018 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JQYFqhmvm9oimqODcCnHpXglZUI39aOOaIg2pJoT+p4=;
        b=uw0YtFNBothlTevafQgLVK2GgNyTq/JlG3SGAlwDuoMZCEbZVuEvQxQmiXuBsSrJce
         dYxTYN3nhUJLjmlsSkjClsCOnM3xdSSSOYDbO+lWgKZhRv39PSwVJQlVb6y9PHHXBN+a
         TIuPg3gAlDWpDUSctGwdzaJBHaokykr6ZXD+bo1NXSd6bJF9k7xBd7qyzg1Ci13M+C6R
         tUF1mkmuxj0reyE58pg/ff3ZnElANKJ1wqSEQYPMJNr6/a7TYCL8vKHEsCHmqHp8IsqP
         KWKNMkl9TkYca8M0gF8V0RfO9s5UsNF76V6E22+/ZhEN/R0VBcBuFjdMKBjuDzF/WU29
         cymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JQYFqhmvm9oimqODcCnHpXglZUI39aOOaIg2pJoT+p4=;
        b=uUdtxaG5La/RbpXuAV1m7iScZo5RxBcpP4z469SgjIR/tS4MxEEQvusqfuEznZfuF2
         wUTK1wL+UrUXv8zpeRD6lQyO5DEv9HrcQAsLp4zJu/za5vN1zZYhZMBOq3iNWWf5g2UB
         ImzYQdJPMn6HI5AQm/90qk+twOA5TDkPO71njg0dGjoaZRfpZ72mnl8g89JgTumGne4q
         VgR2k3/AwikKgbo+i9gnIkLzjaW2AYQruk+gatfpDgy/vOuovYsYhPyzvxpZypt8ozyh
         VuSERWcUScTt2aWz33qVNaKMB1iRMt3dilpMIEX4y8ECA/UELgUr1cazmJvxx4mqfpui
         80eA==
X-Gm-Message-State: AOUpUlGtb/eoizmP5QJgH7Gd2oZ5c4c6EPVDB4W9CBR+XzPYiFoSqrbl
        WefOVpZmAxXeuHap6yVQga4=
X-Google-Smtp-Source: AAOMgpesWzeK9Rr+XGuyYMBggE2qWNOTWbNtdAHKTi/N6PFLUIO3GX2Big0hfswPnJViZfh/EDjk+Q==
X-Received: by 2002:a62:998:: with SMTP id 24-v6mr5739379pfj.99.1532683712510;
        Fri, 27 Jul 2018 02:28:32 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id q140-v6sm6378886pgq.11.2018.07.27.02.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:28:32 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jon.maloy@ericsson.com, ying.xue@windriver.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: tipc: name_table: Replace GFP_ATOMIC with GFP_KERNEL in tipc_nametbl_init()
Date:   Fri, 27 Jul 2018 17:28:25 +0800
Message-Id: <20180727092825.7370-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tipc_nametbl_init() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/tipc/name_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index dd1c4fa2eb78..960aa21444cf 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -731,7 +731,7 @@ int tipc_nametbl_init(struct net *net)
 	struct name_table *nt;
 	int i;
 
-	nt = kzalloc(sizeof(*nt), GFP_ATOMIC);
+	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
 	if (!nt)
 		return -ENOMEM;
 
-- 
2.17.0

