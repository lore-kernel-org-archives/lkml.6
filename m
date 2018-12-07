Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3416C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942A92083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942A92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbeLGVJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:09:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbeLGVJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:09:43 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C562DA24A21F;
        Sat,  8 Dec 2018 05:09:40 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 05:09:33 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH net-next 08/14] net: hns3: deleted logging 1 bit errors
Date:   Fri, 7 Dec 2018 21:08:05 +0000
Message-ID: <20181207210811.23844-9-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181207210811.23844-1-salil.mehta@huawei.com>
References: <20181207210811.23844-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

This patch deletes logging 1 bit errors for the following reasons.
1. AER does not notify 1 bit errors to the device drivers.
   However AER reports 1 bit errors to the userspace through the
   trace_aer_event for logging in the rasdaemon.
2. Firmware clears the status of 1 bit errors in the hw registers.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 37 ----------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 22e7c5b..7371ae4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -4,42 +4,26 @@
 #include "hclge_err.h"
 
 static const struct hclge_hw_error hclge_imp_tcm_ecc_int[] = {
-	{ .int_msk = BIT(0), .msg = "imp_itcm0_ecc_1bit_err" },
 	{ .int_msk = BIT(1), .msg = "imp_itcm0_ecc_mbit_err" },
-	{ .int_msk = BIT(2), .msg = "imp_itcm1_ecc_1bit_err" },
 	{ .int_msk = BIT(3), .msg = "imp_itcm1_ecc_mbit_err" },
-	{ .int_msk = BIT(4), .msg = "imp_itcm2_ecc_1bit_err" },
 	{ .int_msk = BIT(5), .msg = "imp_itcm2_ecc_mbit_err" },
-	{ .int_msk = BIT(6), .msg = "imp_itcm3_ecc_1bit_err" },
 	{ .int_msk = BIT(7), .msg = "imp_itcm3_ecc_mbit_err" },
-	{ .int_msk = BIT(8), .msg = "imp_dtcm0_mem0_ecc_1bit_err" },
 	{ .int_msk = BIT(9), .msg = "imp_dtcm0_mem0_ecc_mbit_err" },
-	{ .int_msk = BIT(10), .msg = "imp_dtcm0_mem1_ecc_1bit_err" },
 	{ .int_msk = BIT(11), .msg = "imp_dtcm0_mem1_ecc_mbit_err" },
-	{ .int_msk = BIT(12), .msg = "imp_dtcm1_mem0_ecc_1bit_err" },
 	{ .int_msk = BIT(13), .msg = "imp_dtcm1_mem0_ecc_mbit_err" },
-	{ .int_msk = BIT(14), .msg = "imp_dtcm1_mem1_ecc_1bit_err" },
 	{ .int_msk = BIT(15), .msg = "imp_dtcm1_mem1_ecc_mbit_err" },
 	{ .int_msk = BIT(17), .msg = "imp_itcm4_ecc_mbit_err" },
 	{ /* sentinel */ }
 };
 
 static const struct hclge_hw_error hclge_cmdq_nic_mem_ecc_int[] = {
-	{ .int_msk = BIT(0), .msg = "cmdq_nic_rx_depth_ecc_1bit_err" },
 	{ .int_msk = BIT(1), .msg = "cmdq_nic_rx_depth_ecc_mbit_err" },
-	{ .int_msk = BIT(2), .msg = "cmdq_nic_tx_depth_ecc_1bit_err" },
 	{ .int_msk = BIT(3), .msg = "cmdq_nic_tx_depth_ecc_mbit_err" },
-	{ .int_msk = BIT(4), .msg = "cmdq_nic_rx_tail_ecc_1bit_err" },
 	{ .int_msk = BIT(5), .msg = "cmdq_nic_rx_tail_ecc_mbit_err" },
-	{ .int_msk = BIT(6), .msg = "cmdq_nic_tx_tail_ecc_1bit_err" },
 	{ .int_msk = BIT(7), .msg = "cmdq_nic_tx_tail_ecc_mbit_err" },
-	{ .int_msk = BIT(8), .msg = "cmdq_nic_rx_head_ecc_1bit_err" },
 	{ .int_msk = BIT(9), .msg = "cmdq_nic_rx_head_ecc_mbit_err" },
-	{ .int_msk = BIT(10), .msg = "cmdq_nic_tx_head_ecc_1bit_err" },
 	{ .int_msk = BIT(11), .msg = "cmdq_nic_tx_head_ecc_mbit_err" },
-	{ .int_msk = BIT(12), .msg = "cmdq_nic_rx_addr_ecc_1bit_err" },
 	{ .int_msk = BIT(13), .msg = "cmdq_nic_rx_addr_ecc_mbit_err" },
-	{ .int_msk = BIT(14), .msg = "cmdq_nic_tx_addr_ecc_1bit_err" },
 	{ .int_msk = BIT(15), .msg = "cmdq_nic_tx_addr_ecc_mbit_err" },
 	{ .int_msk = BIT(17), .msg = "cmdq_rocee_rx_depth_ecc_mbit_err" },
 	{ .int_msk = BIT(19), .msg = "cmdq_rocee_tx_depth_ecc_mbit_err" },
@@ -53,12 +37,6 @@ static const struct hclge_hw_error hclge_cmdq_nic_mem_ecc_int[] = {
 };
 
 static const struct hclge_hw_error hclge_tqp_int_ecc_int[] = {
-	{ .int_msk = BIT(0), .msg = "tqp_int_cfg_even_ecc_1bit_err" },
-	{ .int_msk = BIT(1), .msg = "tqp_int_cfg_odd_ecc_1bit_err" },
-	{ .int_msk = BIT(2), .msg = "tqp_int_ctrl_even_ecc_1bit_err" },
-	{ .int_msk = BIT(3), .msg = "tqp_int_ctrl_odd_ecc_1bit_err" },
-	{ .int_msk = BIT(4), .msg = "tx_que_scan_int_ecc_1bit_err" },
-	{ .int_msk = BIT(5), .msg = "rx_que_scan_int_ecc_1bit_err" },
 	{ .int_msk = BIT(6), .msg = "tqp_int_cfg_even_ecc_mbit_err" },
 	{ .int_msk = BIT(7), .msg = "tqp_int_cfg_odd_ecc_mbit_err" },
 	{ .int_msk = BIT(8), .msg = "tqp_int_ctrl_even_ecc_mbit_err" },
@@ -76,9 +54,7 @@ static const struct hclge_hw_error hclge_msix_sram_ecc_int[] = {
 
 static const struct hclge_hw_error hclge_igu_int[] = {
 	{ .int_msk = BIT(0), .msg = "igu_rx_buf0_ecc_mbit_err" },
-	{ .int_msk = BIT(1), .msg = "igu_rx_buf0_ecc_1bit_err" },
 	{ .int_msk = BIT(2), .msg = "igu_rx_buf1_ecc_mbit_err" },
-	{ .int_msk = BIT(3), .msg = "igu_rx_buf1_ecc_1bit_err" },
 	{ /* sentinel */ }
 };
 
@@ -93,7 +69,6 @@ static const struct hclge_hw_error hclge_igu_egu_tnl_int[] = {
 };
 
 static const struct hclge_hw_error hclge_ncsi_err_int[] = {
-	{ .int_msk = BIT(0), .msg = "ncsi_tx_ecc_1bit_err" },
 	{ .int_msk = BIT(1), .msg = "ncsi_tx_ecc_mbit_err" },
 	{ /* sentinel */ }
 };
@@ -154,7 +129,6 @@ static const struct hclge_hw_error hclge_ppp_mpf_abnormal_int_st3[] = {
 };
 
 static const struct hclge_hw_error hclge_tm_sch_rint[] = {
-	{ .int_msk = BIT(0), .msg = "tm_sch_ecc_1bit_err" },
 	{ .int_msk = BIT(1), .msg = "tm_sch_ecc_mbit_err" },
 	{ .int_msk = BIT(2), .msg = "tm_sch_port_shap_sub_fifo_wr_err" },
 	{ .int_msk = BIT(3), .msg = "tm_sch_port_shap_sub_fifo_rd_err" },
@@ -222,27 +196,16 @@ static const struct hclge_hw_error hclge_qcn_fifo_rint[] = {
 };
 
 static const struct hclge_hw_error hclge_qcn_ecc_rint[] = {
-	{ .int_msk = BIT(0), .msg = "qcn_byte_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(1), .msg = "qcn_byte_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(2), .msg = "qcn_time_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(3), .msg = "qcn_time_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(4), .msg = "qcn_fb_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(5), .msg = "qcn_fb_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(6), .msg = "qcn_link_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(7), .msg = "qcn_link_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(8), .msg = "qcn_rate_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(9), .msg = "qcn_rate_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(10), .msg = "qcn_tmplt_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(11), .msg = "qcn_tmplt_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(12), .msg = "qcn_shap_cfg_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(13), .msg = "qcn_shap_cfg_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(14), .msg = "qcn_gp0_barrel_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(15), .msg = "qcn_gp0_barrel_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(16), .msg = "qcn_gp1_barrel_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(17), .msg = "qcn_gp1_barrel_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(18), .msg = "qcn_gp2_barrel_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(19), .msg = "qcn_gp2_barrel_mem_ecc_mbit_err" },
-	{ .int_msk = BIT(20), .msg = "qcn_gp3_barral_mem_ecc_1bit_err" },
 	{ .int_msk = BIT(21), .msg = "qcn_gp3_barral_mem_ecc_mbit_err" },
 	{ /* sentinel */ }
 };
-- 
2.7.4


