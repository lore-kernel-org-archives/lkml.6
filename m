Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB45C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36569204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRHx9SqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36569204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeKDW3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 17:29:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34005 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbeKDW3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 17:29:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id k1-v6so2990279pgq.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 05:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1MrB5yf3k6Vh4n7BS2cHNATRztz8yFqbsqSu4L931yY=;
        b=fRHx9SqUObvZrhqmZAIfuMDJMj8oHkpl+uxQ8rT/bixo5hNLib0yk89UAc3FtGWa2M
         5c2hiB4Lt4GJ7J5XI7dmzQtcbDpSyr+CXprg5ISE7kIWcVBRhuQsReoiH/Y6XTEamOQj
         jNb63mcZTcz5OsI3x5GX2o6E/yrK4Yo2NusSMfW2gTAgfwpctaDwes0cfca9lamrDGf+
         imNBmH65LMg4UKAOwuIZ0YkWsdPui13we4SNhVjVagkweIIMkDhe+AeW9+LFPKx0qQnN
         3CmeJQlfVKVbq1G/RVCCThKN/EATF4QsFiIGG673eBRvuv1tySvY57GJxFcExPQbUbJF
         jDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1MrB5yf3k6Vh4n7BS2cHNATRztz8yFqbsqSu4L931yY=;
        b=KWD+WzR7TDTkTIPyVr7oe0LT7Pa+9aCUiqy4jv5Bry/XvBYarQNIqdUlEKUffRHMHE
         U8b5dY/cYu7Puou2aM6w4ozqSv3F8lLCEkw0hEMKD9Hvrgsb3OH6vmUUvsoD0WD2mgy6
         QgXMHYT2Tt6/Hnm1VUHjiuq8ejXU3gMvnXDUbfB4rO1iMzaqiO1paGpVN0Wt0xJXOHhu
         YIXN1K0kjwZ/yH4k+TT68SzJzGZkupxKxDsXpbXDZOMm+tRMSYO1HfgefVKWKLjSC2tM
         G+nBrMdU9A44T29HfkrOMCp3EiVowniWuKlQOF1iI3Rquw0DhzZf/vlCk0HHJknhsb6l
         e6gA==
X-Gm-Message-State: AGRZ1gJE5FKqLT60ihqYO57pMlHVAs9dn1f1Rfu/AMVjUFWdAWUvlxKd
        y9OPtR8v08RjSoMSWBW3ta8=
X-Google-Smtp-Source: AJdET5cSsdQcL8zoiYX3CbYQYeREOVAOxe0awLVln9/pmYGsYznIYeOXf/TJuxO/i7AGZ4E2sBiSLQ==
X-Received: by 2002:a62:e0dd:: with SMTP id d90-v6mr18244963pfm.214.1541337288052;
        Sun, 04 Nov 2018 05:14:48 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z7-v6sm32609550pgi.42.2018.11.04.05.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 05:14:47 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, willemb@google.com,
        dja@axtens.net, ast@kernel.org, sbrivio@redhat.com,
        pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: skbuff.h: remove unnecessary unlikely()
Date:   Sun,  4 Nov 2018 08:14:44 -0500
Message-Id: <20181104131444.4049-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 include/linux/skbuff.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..7dcfb5591dc3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2508,10 +2508,8 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len);
 
 static inline void __skb_set_length(struct sk_buff *skb, unsigned int len)
 {
-	if (unlikely(skb_is_nonlinear(skb))) {
-		WARN_ON(1);
+	if (WARN_ON(skb_is_nonlinear(skb)))
 		return;
-	}
 	skb->len = len;
 	skb_set_tail_pointer(skb, len);
 }
-- 
2.17.0

