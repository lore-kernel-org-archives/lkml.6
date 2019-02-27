Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9082C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E94B218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj0AzSAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfB0GJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:09:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45484 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0GJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:09:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id v21so7458131pfm.12;
        Tue, 26 Feb 2019 22:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQPkIngMrcE2+FBP5eq2WMfuREnfwAvMoO7PEvScLck=;
        b=aj0AzSAemII5Fgp7RJw0NR/FdavmYEIcKjSzD40kVAN9Cza4pOUgy/DcIn1nu4qsRu
         aaaGBUyBiKwxZJk7JFeSEp+9eCocU+ejBLmEW0C7wQW3ZvS3/Ln1aYAYeOo7s7kCMztS
         tNyuW0Nh6iSKQWvWAnfBV5dZxLnTXxgIHhpFiRYU85v42jNeukutSaRgoDp5AzVXPt5M
         VavTnfLaJMtJZJ76I0wcP0HmPs+DKluy1uQXXGHBMsriM+/B5RyNS0tnOopKfYri702Q
         jnXM7352hEr6jzOFEwjwHBC8gr+ycGGa4eLf9Mt00q4MjSMjQKzivWWhc9oyC6sEVDj/
         2D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQPkIngMrcE2+FBP5eq2WMfuREnfwAvMoO7PEvScLck=;
        b=pmKRv5PbIccC7Lg21r0c4kmts2SC39ww5uyWzUc18qz7toL+cElrji0+LB6K5gN1Cp
         Q3mCDMfRfY2x9IjHF6X2c9kgaorxSa+J2LK5w2LFtIQN2qMbBsi77L4GryWWR5wVfMGt
         T5r9LGKRhaTXRNpRihWlBdoC190+51G07+4YYf0tvN0GE2dhao2L1oLKC8I0l3v0WSpa
         w39IA19K/HKOck2NfHrQXWZ/IVqDGI7Ol+g+eh9GCz0MlPWa8WZrtxTMkKnDcxK/ei/g
         DWuCxCEKEnhhiC3QXTi7283EhMl5GuFREHxQ8mfC6HF6JpBPPnw3HWigPuJEOn9SAwKH
         nB9A==
X-Gm-Message-State: AHQUAuYIOh4KwnCz9ww81lwkNPzTg1SLRGN6A7yzvFuM7q/BSTdmkXzS
        JU1qPYRm7PZWCowX2+Li++I=
X-Google-Smtp-Source: AHgI3IaM/bVhNfmKnv6Zmy34QMvk/SqcHwwwhCwRIeOS3hpt11u6lcqhnJD3v6pB1WIr/S4+OYHKqA==
X-Received: by 2002:a62:e704:: with SMTP id s4mr29742pfh.94.1551247780977;
        Tue, 26 Feb 2019 22:09:40 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:09:40 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] net/mlxsw: use pci_zalloc_consistent instead of pci_alloc_consistent
Date:   Tue, 26 Feb 2019 22:09:49 -0800
Message-Id: <9ddcd9104b83c58f74cdd350f462017ad0612d4b.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces a call to pci_alloc_consistent and then
memset(0,) with a single call to pci_zalloc_consistent.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index a2321fe8d6a0..388f349573f3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -830,12 +830,11 @@ static int mlxsw_pci_queue_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		tasklet_init(&q->tasklet, q_ops->tasklet, (unsigned long) q);
 
 	mem_item->size = MLXSW_PCI_AQ_SIZE;
-	mem_item->buf = pci_alloc_consistent(mlxsw_pci->pdev,
-					     mem_item->size,
-					     &mem_item->mapaddr);
+	mem_item->buf = pci_zalloc_consistent(mlxsw_pci->pdev,
+					      mem_item->size,
+					      &mem_item->mapaddr);
 	if (!mem_item->buf)
 		return -ENOMEM;
-	memset(mem_item->buf, 0, mem_item->size);
 
 	q->elem_info = kcalloc(q->count, sizeof(*q->elem_info), GFP_KERNEL);
 	if (!q->elem_info) {
-- 
2.20.1

