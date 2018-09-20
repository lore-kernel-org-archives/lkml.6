Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE68CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6C021522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 21:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="FyxBmi/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6C021522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbeIUDlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:41:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41891 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeIUDlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 23:41:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so74242pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 14:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxXQmboTvItP65JMXSBooPRpO/opTD3Ny8Kc7AX8+VU=;
        b=FyxBmi/oXUB3LX8JP70XnP4d2x4Y5rxNgrbCCFPcpoN1bb2+3a7xgCdnjJErw5ZFqq
         +rb56v1JI6F6X8xs7qIzOejrZo7cgLbxnTNxKg4mVSwxLBogOcQ0Zu5qbcfzGVhgNutr
         XHSyIQ4Ka+EAZt5fY3iT7Ia5yEa/jBA5ncdFmiAV5b/ICgapnJnRtweGlY4dmpJ0nm60
         gaKVkl4LnOLATYq8bfQNX3qfXGrzfMFbYGreFlLRjh8wSj07ul9/zgBuG+63klkCZLhn
         ALU8gNG7nljM0ytEVCMY6K//ljpQ8qCPI39r0nQO9MUhwl4Fsh24hAjx3v5cxnV1jmZ9
         fL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JxXQmboTvItP65JMXSBooPRpO/opTD3Ny8Kc7AX8+VU=;
        b=NzylnO09mKGraXCJQXavMJvAo6vRB6VQ/3XTT0Z/4tjmpYaSolP3UAOgurukrckisq
         07u1wl5Z5Q6tfTae86txgtlXsm0oOfBIuTj1JoiqQEU8zKKFtyPgAY6GiqVXtwTnVZvi
         Db3KLVWtfFJ3YLKd655v+NkYxhHb5aVBUIG1MI5Br1e6TIlvv+O6iM8npTfZ4QXPHAkJ
         3Q4mB38/9itZo52uOuFuh2nEh4knZrjOBdiWgXKVJBSoc6DvWIRGXVyU/NPytpWUYMaV
         9XUkHDxrOSccJQbw5WKgDKafCZac9X4nYaqwfJlQZL8qe36iR41LObnzMhZC50prrP6M
         4M0w==
X-Gm-Message-State: APzg51AIq3nPmbpLUCMp/22kBo4+nWlmalgXP1PmTGIIo+3L846LSrTp
        fQZdzk+VqEja9WTeJrTiFBgQYa96/eg=
X-Google-Smtp-Source: ANB0VdbEYRNuWyg1COivPw6ETGk7LuARB34MbO2fk4Fep9F1kswCkvCiNCoh4fOJtt4JQP3hiTsWZQ==
X-Received: by 2002:a62:848e:: with SMTP id k136-v6mr43145879pfd.231.1537480546960;
        Thu, 20 Sep 2018 14:55:46 -0700 (PDT)
Received: from localhost ([130.164.62.207])
        by smtp.gmail.com with ESMTPSA id l10-v6sm57761651pfj.179.2018.09.20.14.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 14:55:46 -0700 (PDT)
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, keescook@chromium.org, davem@davemloft.net,
        moritz.fischer@ettus.com, f.fainelli@gmail.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [RFC PATCH] net: nixge: Address compiler warnings when building for i386
Date:   Thu, 20 Sep 2018 14:55:27 -0700
Message-Id: <20180920215527.8812-1-moritz.fischer@ettus.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

Address compiler warnings reported by kbuild autobuilders
when building for i386 as a result of dma_addr_t size on
different architectures.

warning: cast to pointer from integer of different size
	[-Wint-to-pointer-cast]

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi all,

got an angry email from the kbuild bot.
This is an attempt at fixing its complaints. I'm travelling this week
so I don't have access to test this on hardware but maybe someone
can shoot a hole into this already.

I have *only build-tested* this for arm/arm64/x86/x86_64 and it seemed
to be happy.

Comments?

Thanks for your feedback

- Moritz

---
 drivers/net/ethernet/ni/nixge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 74cf52e3fb09..0611f2335b4a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -127,8 +127,8 @@ struct nixge_hw_dma_bd {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
 	do { \
-		(bd)->field##_lo = lower_32_bits(((u64)addr)); \
-		(bd)->field##_hi = upper_32_bits(((u64)addr)); \
+		(bd)->field##_lo = lower_32_bits((addr)); \
+		(bd)->field##_hi = upper_32_bits((addr)); \
 	} while (0)
 #else
 #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
@@ -251,7 +251,7 @@ static void nixge_hw_dma_bd_release(struct net_device *ndev)
 				 NIXGE_MAX_JUMBO_FRAME_SIZE,
 				 DMA_FROM_DEVICE);
 
-		skb = (struct sk_buff *)
+		skb = (struct sk_buff *)(uintptr_t)
 			nixge_hw_dma_bd_get_addr(&priv->rx_bd_v[i],
 						 sw_id_offset);
 		dev_kfree_skb(skb);
@@ -323,7 +323,7 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
 		if (!skb)
 			goto out;
 
-		nixge_hw_dma_bd_set_offset(&priv->rx_bd_v[i], skb);
+		nixge_hw_dma_bd_set_offset(&priv->rx_bd_v[i], (uintptr_t)skb);
 		phys = dma_map_single(ndev->dev.parent, skb->data,
 				      NIXGE_MAX_JUMBO_FRAME_SIZE,
 				      DMA_FROM_DEVICE);
@@ -601,8 +601,8 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
 			 priv->rx_bd_ci;
 
-		skb = (struct sk_buff *)nixge_hw_dma_bd_get_addr(cur_p,
-								 sw_id_offset);
+		skb = (struct sk_buff *)(uintptr_t)
+			nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);
 
 		length = cur_p->status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 		if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
@@ -643,7 +643,7 @@ static int nixge_recv(struct net_device *ndev, int budget)
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
 		cur_p->status = 0;
-		nixge_hw_dma_bd_set_offset(cur_p, new_skb);
+		nixge_hw_dma_bd_set_offset(cur_p, (uintptr_t)new_skb);
 
 		++priv->rx_bd_ci;
 		priv->rx_bd_ci %= RX_BD_NUM;
-- 
2.18.0

