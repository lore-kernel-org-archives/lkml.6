Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CFBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F93120873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiNCNhL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F93120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeG0JSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:18:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35410 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeG0JSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:18:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so1982991plq.2;
        Fri, 27 Jul 2018 00:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j7f3ERZyPaSHj9gk4RlUSMm2ft1Z22gVA5iESHvdbuc=;
        b=TiNCNhL1wjzYSjp1Cv9oiO9Lh+Wo+BJ6JDrMoDX2C534KT/wK2bv11okEPXYvC3OBO
         Lw4yuq+2qDCHMv+jrMDzzZ0Ly+fgRbPS/azVqHS5ubC8gMZr/ClU+qwptPJLRMcUVGXk
         XZkiuJnCh11vLDLCNmcUWchjRLzDlU2JQhctd7tMMkBBOoluSiac1Z1U8yCAcgydAabt
         6i4YnvelYv3L4le3+4c15Bl4nLQnQbJrlTT6+wuR4koqNvcoZuzOmIGhKDLM10cGYkh6
         1U1tyGGy7En3BFqdXBaZ9aYuaPGT3TcXHX9BTPVfOE/jpOIyaCxScd2WTanRBnlgz8Jq
         64/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j7f3ERZyPaSHj9gk4RlUSMm2ft1Z22gVA5iESHvdbuc=;
        b=iKRwe+oT4tY7P7FnEI8gQAbgUegGSD9990Ddm6oI0EkF5tmNlabue6KAMMaAtnVFZb
         1TXMXQR+cE98V4eZ0t0WixhAGLDD0CbRFXuUzMQsgoCGrsy48pKFHjq/X2rMZiUgtMYk
         kJvEInLA3lnyjPgSrTdqs8vylDIQfcQuQZ817QNbFAuQ57NRRXhW7aV5AQOKtYPNa+Yd
         ua4tUhoI4glbd47o1uqq9CjQYlVKmlkWexVpZqKR9eyKnEBD3dTC7HdNw6kHzGeqjjgw
         uvu45vhgXJhuxfqcYrsnMYpkc+P7cujEaZ7ZL3/qWIeCTeTwLEkcN2O9D7PagIQyG5O8
         YuAA==
X-Gm-Message-State: AOUpUlEMO2v8+8S+oL2KR75nFWAIP+mfU8+NCun7Jw3Ppa02SQm6Gk+T
        zc+5pB9ltsZTZ16XHKVmSp4=
X-Google-Smtp-Source: AAOMgpcc/4P3ogZ3R93VuR3MMyYVNg9oKfUF4RIJ6aR9IIlbuf7zFUaGNTyS1XzlLuRr7BocA07sAg==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr5164643pll.186.1532678285135;
        Fri, 27 Jul 2018 00:58:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id p17-v6sm3722165pgv.26.2018.07.27.00.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 00:58:04 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     pcnet32@frontier.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: amd: pcnet32: Replace GFP_ATOMIC with GFP_KERNEL in pcnet32_alloc_ring()
Date:   Fri, 27 Jul 2018 15:57:58 +0800
Message-Id: <20180727075758.2516-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcnet32_alloc_ring() is never called in atomic context.
It calls kcalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/amd/pcnet32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index a561705f232c..e69e810d211d 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -2032,22 +2032,22 @@ static int pcnet32_alloc_ring(struct net_device *dev, const char *name)
 	}
 
 	lp->tx_dma_addr = kcalloc(lp->tx_ring_size, sizeof(dma_addr_t),
-				  GFP_ATOMIC);
+				  GFP_KERNEL);
 	if (!lp->tx_dma_addr)
 		return -ENOMEM;
 
 	lp->rx_dma_addr = kcalloc(lp->rx_ring_size, sizeof(dma_addr_t),
-				  GFP_ATOMIC);
+				  GFP_KERNEL);
 	if (!lp->rx_dma_addr)
 		return -ENOMEM;
 
 	lp->tx_skbuff = kcalloc(lp->tx_ring_size, sizeof(struct sk_buff *),
-				GFP_ATOMIC);
+				GFP_KERNEL);
 	if (!lp->tx_skbuff)
 		return -ENOMEM;
 
 	lp->rx_skbuff = kcalloc(lp->rx_ring_size, sizeof(struct sk_buff *),
-				GFP_ATOMIC);
+				GFP_KERNEL);
 	if (!lp->rx_skbuff)
 		return -ENOMEM;
 
-- 
2.17.0

