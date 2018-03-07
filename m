Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520453113-2-8920435317976664067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520453113; b=iZ0JzVkfXBNCFTsiTai0W4NtH0/p8Hg2389x3WFhMEYBTNV
    04y++zkd9DmQvtOsV7BNIHvVCR4Uzx6vZY0UGXeYGz2ACqezduMqSG8+2GQl7au0
    JIGPWr7utvFtPv8PtNcl0CwCtpHF56+Nz6zSS/Uh1sVpdzywZIwhbVXQjGU5aUaV
    JxnnNkGF5yn9YY/1QAomUGfura7NgtDVnkgjqZombpd5HuJFF8lJ0yLK7Gli5Zvh
    5A6kxPzUVJ+Y4aTW4UeXolVVMaiWE9S0rzoOiQFizFuQLUDOUs4GU4j35ZS3/eNY
    uS8yGJ0LQNcLIgluFXl4YTTscUFm3jq1FfgVjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520453113; bh=uP4eP94G4VB0UOYVwLQsbQtLjO
    PzXouOBhRpWx8/wRk=; b=G8a5kMQ4Bzjl5T243eMG8OydOq7RDpXGb9wE2Vl92j
    62U7jnp/tT18KaMR+3NghYxiHg35WXKTQ16ElCY4UF1YKWNM4s/JeSPp+e57scMe
    YE4K2fbe+dACMxf4gnTz4c0mq5I36zA6Ci/+fKemlqy8zHhDR854nVsZNNResoyX
    w+8p0Ynftn9JLhfYKbgcCr6Cw+oPSYz0mCAeZhM72Ar0T3iAIXkvBpvaQ8yIhINV
    jzkL2AV5qGp1IvA8LIrLfzrfaqqIZRUWpLFrEtLRlR7NHb/uP1iipeQk0eBxc1ah
    BDN7MCm7yiGCFTsCS1R5I7TesNExPDfAuXd56pb6YS/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934803AbeCGUE4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:04:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965509AbeCGTqT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:19 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gal Pressman <galp@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 050/110] net/mlx5e: Specify numa node when allocating drop rq
Date: Wed,  7 Mar 2018 11:38:33 -0800
Message-Id: <20180307191046.119870190@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <galp@mellanox.com>


[ Upstream commit 2f0db87901698cd73d828cc6fb1957b8916fc911 ]

When allocating a drop rq, no numa node is explicitly set which means
allocations are done on node zero. This is not necessarily the nearest
numa node to the HCA, and even worse, might even be a memoryless numa
node.

Choose the numa_node given to us by the pci device in order to properly
allocate the coherent dma memory instead of assuming zero is valid.

Fixes: 556dd1b9c313 ("net/mlx5e: Set drop RQ's necessary parameters only")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1918,13 +1918,16 @@ static void mlx5e_build_rq_param(struct
 	param->wq.linear = 1;
 }
 
-static void mlx5e_build_drop_rq_param(struct mlx5e_rq_param *param)
+static void mlx5e_build_drop_rq_param(struct mlx5_core_dev *mdev,
+				      struct mlx5e_rq_param *param)
 {
 	void *rqc = param->rqc;
 	void *wq = MLX5_ADDR_OF(rqc, rqc, wq);
 
 	MLX5_SET(wq, wq, wq_type, MLX5_WQ_TYPE_LINKED_LIST);
 	MLX5_SET(wq, wq, log_wq_stride,    ilog2(sizeof(struct mlx5e_rx_wqe)));
+
+	param->wq.buf_numa_node = dev_to_node(&mdev->pdev->dev);
 }
 
 static void mlx5e_build_sq_param_common(struct mlx5e_priv *priv,
@@ -2778,6 +2781,9 @@ static int mlx5e_alloc_drop_cq(struct ml
 			       struct mlx5e_cq *cq,
 			       struct mlx5e_cq_param *param)
 {
+	param->wq.buf_numa_node = dev_to_node(&mdev->pdev->dev);
+	param->wq.db_numa_node  = dev_to_node(&mdev->pdev->dev);
+
 	return mlx5e_alloc_cq_common(mdev, param, cq);
 }
 
@@ -2789,7 +2795,7 @@ static int mlx5e_open_drop_rq(struct mlx
 	struct mlx5e_cq *cq = &drop_rq->cq;
 	int err;
 
-	mlx5e_build_drop_rq_param(&rq_param);
+	mlx5e_build_drop_rq_param(mdev, &rq_param);
 
 	err = mlx5e_alloc_drop_cq(mdev, cq, &cq_param);
 	if (err)
