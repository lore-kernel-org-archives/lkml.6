Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1BC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhHW/38w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfAWLsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:48:16 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34848 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWLsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:48:15 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so1667061ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 03:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fB25Mi8HKeuwdrx1ZeEDd3u/unirlpp2EU8uchWpDE=;
        b=LhHW/38w8iE5FnzbPO2Nzy5p1roWV0h35xT95QmAE1MTqcTeu0UC0c9O1TmnmeJAEs
         FZJIRj8etXXhjq4CMuJh+Gh47h39pX7PnQAfYkjsICcw2ixT7S34EtV1LlYWbIVAhkJq
         +w0JYisVOEEaInQkdizhEllCi5z2wznhSmGzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fB25Mi8HKeuwdrx1ZeEDd3u/unirlpp2EU8uchWpDE=;
        b=JTV2sOy2Waf3rKNaa2sWrS9hii39UvNIKd6mvOi69Jbgj167nWKhdBNa3JMsX1XCsD
         soTybxHXYOsfuTyBDkwIlXslYJHL4w+M6e4zCxybsC36I/elSTGCVqAkqGoZJ7g/XUbv
         UXaTjlTxxwkpCYFoykMoqSPgMaThDSdGF3h5mo7rkPpKGrVQesak1+TljydqkJ0qfMZe
         Jph23uSy4kEskPaW+v8Fl9W4HqEA0oYJchXAXZvHbwdlJq4EkTtLNOOpePYy3OHbIqu0
         WCGpTMdc4nwn/c3Dd5v37YQelknRKRiBrqM+ao7F+/1Ovoo6fONJknelzJGZrEfF/3cQ
         NYaA==
X-Gm-Message-State: AJcUukdvSE60zxWtPpjRua8TmVSbVLdHplmm8nguUy+/2JvEgntMgCal
        x9+dpudFMUS6m5WWA4s2wmpojqSyuAaS5w==
X-Google-Smtp-Source: ALg8bN4irT09WOAE96Q+hAx5xybUSl3gnnlc3HXyimQ28mCLA6ontJhN6GnrEqNNwcqYfqPUIrPukA==
X-Received: by 2002:a2e:9595:: with SMTP id w21-v6mr1630868ljh.194.1548244094029;
        Wed, 23 Jan 2019 03:48:14 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id q8-v6sm459760lji.69.2019.01.23.03.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 03:48:13 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] netfilter: ipt_CLUSTERIP: fix warning unused variable cn
Date:   Wed, 23 Jan 2019 12:48:11 +0100
Message-Id: <20190123114811.25388-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PROC_FS isn't set the variable cn isn't used.

net/ipv4/netfilter/ipt_CLUSTERIP.c: In function ‘clusterip_net_exit’:
net/ipv4/netfilter/ipt_CLUSTERIP.c:849:24: warning: unused variable ‘cn’ [-Wunused-variable]
  struct clusterip_net *cn = clusterip_pernet(net);
                        ^~

Rework so the variable 'cn' is declared inside "#ifdef CONFIG_PROC_FS".

Fixes: b12f7bad5ad3 ("netfilter: ipt_CLUSTERIP: remove wrong WARN_ON_ONCE in netns exit routine")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 net/ipv4/netfilter/ipt_CLUSTERIP.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CLUSTERIP.c
index b61977db9b7f..2a909e5f9ba0 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -846,9 +846,9 @@ static int clusterip_net_init(struct net *net)
 
 static void clusterip_net_exit(struct net *net)
 {
+#ifdef CONFIG_PROC_FS
 	struct clusterip_net *cn = clusterip_pernet(net);
 
-#ifdef CONFIG_PROC_FS
 	mutex_lock(&cn->mutex);
 	proc_remove(cn->procdir);
 	cn->procdir = NULL;
-- 
2.19.2

