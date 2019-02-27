Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2283FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC075218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbJfWa4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfB0GKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:10:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44962 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfB0GKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:10:02 -0500
Received: by mail-pl1-f194.google.com with SMTP id c4so7446439pls.11;
        Tue, 26 Feb 2019 22:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRonf4JgDjTB+99qJ+9yUUD96xiqhWyi/Sw/8hK24fo=;
        b=AbJfWa4aqEVhKIqlA63PkzT9/Ejjcjo/0PtIot3fQ+acGCAZvs6kyeMEjN9BFePvSc
         YIpSo7+YbB5LCjPfYC11w44F+uIXe/r/MI7fO/jlAn5VQDNRT/mECLCJ2KdUQwaYvY2E
         U+m2WsnqR7ngq09gV3qsI+DDs7C2xEt/r5e4qjEIQv5v91rq3R0VdhtK1Wqv4ZNJllp8
         SZh3lfhoxixlmoJ9VJO1LHaX3fKPi9whgJ5IrxVZtJQI4tKikrKlloNMBcHZrQa8yQId
         4zdlogRjnC0w7yZp2C1yplH9ovA45fiPTvyY96xMJLjS1+sHswyh3H0B6iLhWcGNYcKq
         YQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRonf4JgDjTB+99qJ+9yUUD96xiqhWyi/Sw/8hK24fo=;
        b=L7DyTdGAWtLnE7h0uTLJMEpW15AnM1+gJbfZEsN9ZCqtE9+iILbp/iDWrDQGVjH1v2
         M6FJxY9b+6Eph1rII1n/wa441rHGZR+u1zaGFjLvjew+6MxoSoWq8Ec3AEGSAtDF/Wg5
         uW8jFn5zHPUQ7bM7xavTyxBlnprUrnOfZqWc2JbHOai9TB2G3JNOXffwC8DbiGNtURGO
         CHD52o6Sz7VTi+xCdTnNEfNaoJOBjC9GZfJU0Sknd4nHApsPnpBfe+4XsHLKZUOkyLgE
         usQ8Bt9q2Wp+zBXNDftTFSbjQzl4vx+JwTJqCtHlLsYLFcvvFXUvcgY1Ailgxjo/EO8L
         AnzQ==
X-Gm-Message-State: AHQUAuZD9tC+MrVGLbXR3y8oGZo0kPMj3G841hNG1iT029zxHKj3+TjV
        ZTZDBFHrMbnArWhdueNlhOE=
X-Google-Smtp-Source: AHgI3IbnfBFFnmvAcy2IQHU7fH40aHlhNLrV6Qx/12M98EAa6Ym/QomcaoaAQ9q9c3QAe5aBzGGhWA==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr486327plb.10.1551247801274;
        Tue, 26 Feb 2019 22:10:01 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::87c4])
        by smtp.googlemail.com with ESMTPSA id d5sm20733473pfo.83.2019.02.26.22.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 22:10:00 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Manish Chopra <manishc@marvell.com>,
        Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] netxen: remove unnecessary memset(,0) calls
Date:   Tue, 26 Feb 2019 22:09:53 -0800
Message-Id: <8448a151b01dc228987c820ac84845a832fd50c9.1551246708.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces calls to memset(,0) by replacing memset(,0)
calls that only zero-out newly declared structs with simply
assigning those structs to zero structs.

It also removes a pci_alloc_consistent call followed by a memset(,0)
call by simply using pci_zalloc_consistent.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 .../ethernet/qlogic/netxen/netxen_nic_ctx.c   | 36 +++++++------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
index 7503aa222392..f2010c032361 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -99,8 +99,7 @@ netxen_issue_cmd(struct netxen_adapter *adapter, struct netxen_cmd_args *cmd)
 static int
 netxen_get_minidump_template_size(struct netxen_adapter *adapter)
 {
-	struct netxen_cmd_args cmd;
-	memset(&cmd, 0, sizeof(cmd));
+	struct netxen_cmd_args cmd = {0};
 	cmd.req.cmd = NX_CDRP_CMD_TEMP_SIZE;
 	memset(&cmd.rsp, 1, sizeof(struct _cdrp_cmd));
 	netxen_issue_cmd(adapter, &cmd);
@@ -120,7 +119,7 @@ netxen_get_minidump_template(struct netxen_adapter *adapter)
 	dma_addr_t md_template_addr;
 	void *addr;
 	u32 size;
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 	size = adapter->mdump.md_template_size;
 
 	if (size == 0) {
@@ -135,7 +134,6 @@ netxen_get_minidump_template(struct netxen_adapter *adapter)
 		return -ENOMEM;
 	}
 
-	memset(&cmd, 0, sizeof(cmd));
 	memset(&cmd.rsp, 1, sizeof(struct _cdrp_cmd));
 	cmd.req.cmd = NX_CDRP_CMD_GET_TEMP_HDR;
 	cmd.req.arg1 = LSD(md_template_addr);
@@ -233,9 +231,8 @@ nx_fw_cmd_set_mtu(struct netxen_adapter *adapter, int mtu)
 {
 	u32 rcode = NX_RCODE_SUCCESS;
 	struct netxen_recv_context *recv_ctx = &adapter->recv_ctx;
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.cmd = NX_CDRP_CMD_SET_MTU;
 	cmd.req.arg1 = recv_ctx->context_id;
 	cmd.req.arg2 = mtu;
@@ -254,9 +251,8 @@ int
 nx_fw_cmd_set_gbe_port(struct netxen_adapter *adapter,
 			u32 speed, u32 duplex, u32 autoneg)
 {
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.cmd = NX_CDRP_CMD_CONFIG_GBE_PORT;
 	cmd.req.arg1 = speed;
 	cmd.req.arg2 = duplex;
@@ -276,7 +272,7 @@ nx_fw_cmd_create_rx_ctx(struct netxen_adapter *adapter)
 	nx_cardrsp_sds_ring_t *prsp_sds;
 	struct nx_host_rds_ring *rds_ring;
 	struct nx_host_sds_ring *sds_ring;
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
 	dma_addr_t hostrq_phys_addr, cardrsp_phys_addr;
 	u64 phys_addr;
@@ -359,7 +355,6 @@ nx_fw_cmd_create_rx_ctx(struct netxen_adapter *adapter)
 	}
 
 	phys_addr = hostrq_phys_addr;
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.arg1 = (u32)(phys_addr >> 32);
 	cmd.req.arg2 = (u32)(phys_addr & 0xffffffff);
 	cmd.req.arg3 = rq_size;
@@ -413,9 +408,8 @@ static void
 nx_fw_cmd_destroy_rx_ctx(struct netxen_adapter *adapter)
 {
 	struct netxen_recv_context *recv_ctx = &adapter->recv_ctx;
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.arg1 = recv_ctx->context_id;
 	cmd.req.arg2 = NX_DESTROY_CTX_RESET;
 	cmd.req.arg3 = 0;
@@ -520,9 +514,8 @@ nx_fw_cmd_create_tx_ctx(struct netxen_adapter *adapter)
 static void
 nx_fw_cmd_destroy_tx_ctx(struct netxen_adapter *adapter)
 {
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.arg1 = adapter->tx_context_id;
 	cmd.req.arg2 = NX_DESTROY_CTX_RESET;
 	cmd.req.arg3 = 0;
@@ -538,9 +531,8 @@ int
 nx_fw_cmd_query_phy(struct netxen_adapter *adapter, u32 reg, u32 *val)
 {
 	u32 rcode;
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.arg1 = reg;
 	cmd.req.arg2 = 0;
 	cmd.req.arg3 = 0;
@@ -561,9 +553,8 @@ int
 nx_fw_cmd_set_phy(struct netxen_adapter *adapter, u32 reg, u32 val)
 {
 	u32 rcode;
-	struct netxen_cmd_args cmd;
+	struct netxen_cmd_args cmd = {0};
 
-	memset(&cmd, 0, sizeof(cmd));
 	cmd.req.arg1 = reg;
 	cmd.req.arg2 = val;
 	cmd.req.arg3 = 0;
@@ -763,15 +754,14 @@ int netxen_alloc_hw_resources(struct netxen_adapter *adapter)
 	recv_ctx = &adapter->recv_ctx;
 	tx_ring = adapter->tx_ring;
 
-	addr = pci_alloc_consistent(pdev,
-			sizeof(struct netxen_ring_ctx) + sizeof(uint32_t),
-			&recv_ctx->phys_addr);
-	if (addr == NULL) {
+	addr = pci_zalloc_consistent(pdev,
+				     sizeof(struct netxen_ring_ctx) + sizeof(uint32_t),
+				     &recv_ctx->phys_addr);
+	if (!addr) {
 		dev_err(&pdev->dev, "failed to allocate hw context\n");
 		return -ENOMEM;
 	}
 
-	memset(addr, 0, sizeof(struct netxen_ring_ctx));
 	recv_ctx->hwctx = addr;
 	recv_ctx->hwctx->ctx_id = cpu_to_le32(port);
 	recv_ctx->hwctx->cmd_consumer_offset =
-- 
2.20.1

