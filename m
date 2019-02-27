Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497E21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k64TF+Kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfB0GJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:09:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0GJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:09:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id n125so7479408pfn.5;
        Tue, 26 Feb 2019 22:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIx9DViwNy1t8RFVYwK5Zxk5ryawOq3ot5m5H2OgpcE=;
        b=k64TF+KvLoHtBjQ7kMUuIoxGeRDdAw8bVYtC/jm4rxwoEIHaNZlNpkcz8c5DA+QSpD
         J5TPphLekaosLTciPpGMSevEtYJQzQmI1Q8RiNjoidjfNOJdIK0S7vd8C15mZLMJwu38
         RCueZb44167t8w+bCQlEwMyD/d9yAIzRn+14us5NPFdfxAt0ajiQSGHjTdhtV7x6K12J
         QZnPtQoFob4TAdC6GNhdJ5FgPkiBS+7/5+shuetvC+6hCF3wRlCwVn1CyXRaIw5+EgxA
         XI+ln2dBEJm+geMxNFplzauurzGKeoJ7AYy87fAJlBuh5rM8jSDcwwu7BqAzO3ElqQcx
         g6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIx9DViwNy1t8RFVYwK5Zxk5ryawOq3ot5m5H2OgpcE=;
        b=FYF9h/V50PijTsszmUuW6SA/TsR3VXnNGZM5H3UtQf2y0UZPcr0gppfIbKqn1ATofh
         Wx+E23xKjNn8U1EX67mFu9oFCC5O/T7kA2Ff4FQ1rskI3Hd5rOh/TIf+dvUR8EPdEmgp
         bW4juXW8+IK46JmWOjvXNtutlK4xo8nsAKOy3y8DKQiyet7JnaxUNAlIf+6m8RR0P9LM
         YFtL/41EdqMy5xW3sM29SFmd7uftzqTNkl3/TrY3Kagg93MW62Xikf52n8S1KnQMLkoX
         0Y/zFqx/LoKTB3ZPQVTdOmp4+hKnDDip73JlFIlk1CGEJwANwPR2wFCxWxhKVfUXpJOR
         Wb2g==
X-Gm-Message-State: AHQUAuYZpPRFwHv9iePbH0IRHipdKNdbfRbgME3CLhdexyg47uv8FfJG
        7SQTMbdlDbBqE/xjZGQfPgiQaitwEw4=
X-Google-Smtp-Source: AHgI3Ib6o3x3zjPG6hsuXZ1VEZ7JnWlwaQRfhmquGJKhkr/ekOCiBYaKYGrYpvTvZfqx0kym/HKaag==
X-Received: by 2002:a62:f51d:: with SMTP id n29mr3084pfh.21.1551247784125;
        Tue, 26 Feb 2019 22:09:44 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:09:43 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Samuel Chessman <chessman@tux.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] tlan: use pci_zalloc instead of pci_alloc
Date:   Tue, 26 Feb 2019 22:09:50 -0800
Message-Id: <51125a3daac49f7b5bb360a422663aee26e6776b.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces a pci_alloc_consistent and memset(,0) call
with a single call to pci_zalloc_consistent.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/ti/tlan.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
index b4ab1a5f6cd0..e1f7e71c3b21 100644
--- a/drivers/net/ethernet/ti/tlan.c
+++ b/drivers/net/ethernet/ti/tlan.c
@@ -845,17 +845,16 @@ static int tlan_init(struct net_device *dev)
 
 	dma_size = (TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS)
 		* (sizeof(struct tlan_list));
-	priv->dma_storage = pci_alloc_consistent(priv->pci_dev,
-						 dma_size,
-						 &priv->dma_storage_dma);
+	priv->dma_storage = pci_zalloc_consistent(priv->pci_dev,
+						  dma_size,
+						  &priv->dma_storage_dma);
 	priv->dma_size = dma_size;
 
-	if (priv->dma_storage == NULL) {
+	if (!priv->dma_storage) {
 		pr_err("Could not allocate lists and buffers for %s\n",
 		       dev->name);
 		return -ENOMEM;
 	}
-	memset(priv->dma_storage, 0, dma_size);
 	priv->rx_list = (struct tlan_list *)
 		ALIGN((unsigned long)priv->dma_storage, 8);
 	priv->rx_list_dma = ALIGN(priv->dma_storage_dma, 8);
-- 
2.20.1

