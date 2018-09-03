Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DC8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92D20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+XVCXoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeICWZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:25:01 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41612 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:25:00 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so2241489oiw.8;
        Mon, 03 Sep 2018 11:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zriiPzad5Qk4dHUu080egLe114u9/QRfPO9Vvq1gkMQ=;
        b=n+XVCXoHalOwH/vVji/0SgOKJtge/iQxScQxhJnsTmur5W8at4kkgD0VAtkDcHH/1V
         EvwgCJlSz9QMmr9NQ9YczVQQYXYwN3AjWYUVoVqsNL2ykeDW9WdR9S9oL4+GLEu9P9G5
         BafmRluYoVG+7BI2iyRU5FqWO9ne3c79+DRtfrikg/zbY4pirnoo8l8FJ8KfbHIryIkB
         wfADYm5TbzQCbpdQFXObHWPPqkA/W/p6Jhcpxmd6WA0vsTetNF5D0InG2pzcmiY9Cmtb
         tt654w484Ff3njhjifzDABbCX66fkn29Tid/ZAM1edebHwfe9hKIk4txnOXsuNrdFJXL
         Mqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zriiPzad5Qk4dHUu080egLe114u9/QRfPO9Vvq1gkMQ=;
        b=ffQuHX7z799CLCGJCoJHBkeqYmkZpjiQpH6yHL0PfUkKRHNCx0A3bIZvGCaLLC+izs
         FjzM1hPvX6Qg3vNLtvCdZf0iBxj588l8oBumKP8On6j95hgzfjwWRIwKZ/2nMjT/xX8a
         x44ST53cDG6mOm/Tf6bgyrK4zgtQFp4kD5+HHlFFxtt7sjc1vwULpVrtEX5gRqytUJEw
         QLo0hgLjDnCgUQpBn3hXzQ83rCbJj2jTqH51wozvE3qZD3zxHBX28uYI09LvzwBwynM9
         yLkyYAMdGqEg4y1ISh/adMe3AC1Bo0XXNNuZL6T7IuJ4GlJkEV8yQTxXx2Kkp+AlNDIf
         RurA==
X-Gm-Message-State: APzg51BOkdVep24uGtbR2EP4c8DWw1icQcKgvVQl+QNN1RJI85df9TxV
        sVWja5PxBXptCdhYJ7c6aSDPt2IG/3g=
X-Google-Smtp-Source: ANB0VdbNTBHi0BY1qVvokutvR5J+H6H0CjgkYNP4EVrpJrnWwKMPPBhYJ3lKBqhsDySQHzWz2k1hLg==
X-Received: by 2002:aca:3254:: with SMTP id y81-v6mr19459950oiy.317.1535997822925;
        Mon, 03 Sep 2018 11:03:42 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:42 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH 8/9] net/mlx5: Do not call pcie_print_link_status()
Date:   Mon,  3 Sep 2018 13:02:35 -0500
Message-Id: <20180903180242.14504-9-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903180242.14504-1-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now done by the PCI core to warn of sub-optimal bandwidth.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index cf3e4a659052..888af98694f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1056,10 +1056,6 @@ static int mlx5_load_one(struct mlx5_core_dev *dev, struct mlx5_priv *priv,
 	dev_info(&pdev->dev, "firmware version: %d.%d.%d\n", fw_rev_maj(dev),
 		 fw_rev_min(dev), fw_rev_sub(dev));
 
-	/* Only PFs hold the relevant PCIe information for this query */
-	if (mlx5_core_is_pf(dev))
-		pcie_print_link_status(dev->pdev);
-
 	/* on load removing any previous indication of internal error, device is
 	 * up
 	 */
-- 
2.17.1

