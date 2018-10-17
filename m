Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C62ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1C21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fvuypgjV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cajy4p2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA1C21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJQXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:14:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45398 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:14:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 240B7604BE; Wed, 17 Oct 2018 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539789519;
        bh=v17F++X7tl6o7X+0pHmtxDV+56BwYd2QWCd1f5+6sDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvuypgjVKQuBJwtQvmyuuHhxkdZCZ69fqcNm4oGMDx+SkccH+wuy+7X71HSSyK2VL
         815rdhXB+vaCLX4Z1EIJn7n3UHrhFW3oewq8njCYm/rKH4Dyt289QRzBm3vFcmep2r
         CQkEf2fj5lLhGiJ0fga3AtF1OJHHAPjX2gqoqcMk=
Received: from hydsecbld01.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FBAB61385;
        Wed, 17 Oct 2018 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539789515;
        bh=v17F++X7tl6o7X+0pHmtxDV+56BwYd2QWCd1f5+6sDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cajy4p2LpdRMnR140kQ4y3D08ZOwqLgVlCDMP4GuhWF9lQB/B/g1MLuVCjZmA4+oX
         FW1acEgJ/1BXtDAqU8O4/8un9dUIyKVCyZIOZNgtauXqBTAkXBWHwxCOudogAnGs/A
         ZUzueb+9UGioxCquUZjMUz1iZDe5dDkunsElK5vs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FBAB61385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        AnilKumar Chimata <anilc@codeaurora.org>
Subject: [PATCH 1/3] firmware: qcom: scm: Update qcom_scm_call signature
Date:   Wed, 17 Oct 2018 20:47:54 +0530
Message-Id: <1539789476-6098-2-git-send-email-anilc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new syscall for ICE key config restore during
device reset, which needs to update the existing
qcom_scm_call() signature.

Signed-off-by: AnilKumar Chimata <anilc@codeaurora.org>
---
 drivers/firmware/qcom_scm-32.c | 30 +++++++++-------
 drivers/firmware/qcom_scm-64.c | 77 ++++++++++++++++++++++++++----------------
 drivers/firmware/qcom_scm.c    |  8 ++++-
 drivers/firmware/qcom_scm.h    |  5 ++-
 include/linux/qcom_scm.h       |  5 +++
 5 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 4e24e59..9e7963d 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010,2015,2018 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -172,7 +172,7 @@ static u32 smc(u32 cmd_addr)
  * and response buffers is taken care of by qcom_scm_call; however, callers are
  * responsible for any other cached buffers passed over to the secure world.
  */
-static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
+static int qcom_scm_call(struct device *dev, u32 own_id, u32 svc_id, u32 cmd_id,
 			 const void *cmd_buf, size_t cmd_len, void *resp_buf,
 			 size_t resp_len)
 {
@@ -406,7 +406,7 @@ int __qcom_scm_set_warm_boot_addr(struct device *dev, void *entry,
 
 	cmd.addr = cpu_to_le32(virt_to_phys(entry));
 	cmd.flags = cpu_to_le32(flags);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_BOOT, QCOM_SCM_BOOT_ADDR,
 			    &cmd, sizeof(cmd), NULL, 0);
 	if (!ret) {
 		for_each_cpu(cpu, cpus)
@@ -436,7 +436,7 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	__le32 svc_cmd = cpu_to_le32((svc_id << 10) | cmd_id);
 	__le32 ret_val = 0;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
 			    &svc_cmd, sizeof(svc_cmd), &ret_val,
 			    sizeof(ret_val));
 	if (ret)
@@ -451,7 +451,7 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
 		return -ERANGE;
 
-	return qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
+	return qcom_scm_call(dev, 0, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP,
 		req, req_cnt * sizeof(*req), resp, sizeof(*resp));
 }
 
@@ -466,7 +466,7 @@ bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
 	int ret;
 
 	in = cpu_to_le32(peripheral);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_PIL,
 			    QCOM_SCM_PAS_IS_SUPPORTED_CMD,
 			    &in, sizeof(in),
 			    &out, sizeof(out));
@@ -487,7 +487,7 @@ int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 	request.proc = cpu_to_le32(peripheral);
 	request.image_addr = cpu_to_le32(metadata_phys);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_PIL,
 			    QCOM_SCM_PAS_INIT_IMAGE_CMD,
 			    &request, sizeof(request),
 			    &scm_ret, sizeof(scm_ret));
@@ -510,7 +510,7 @@ int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
 	request.addr = cpu_to_le32(addr);
 	request.len = cpu_to_le32(size);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_PIL,
 			    QCOM_SCM_PAS_MEM_SETUP_CMD,
 			    &request, sizeof(request),
 			    &scm_ret, sizeof(scm_ret));
@@ -525,7 +525,7 @@ int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
 	int ret;
 
 	in = cpu_to_le32(peripheral);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_PIL,
 			    QCOM_SCM_PAS_AUTH_AND_RESET_CMD,
 			    &in, sizeof(in),
 			    &out, sizeof(out));
@@ -540,7 +540,7 @@ int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
 	int ret;
 
 	in = cpu_to_le32(peripheral);
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_PIL,
 			    QCOM_SCM_PAS_SHUTDOWN_CMD,
 			    &in, sizeof(in),
 			    &out, sizeof(out));
@@ -554,7 +554,7 @@ int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	__le32 in = cpu_to_le32(reset);
 	int ret;
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET,
 			&in, sizeof(in),
 			&out, sizeof(out));
 
@@ -579,7 +579,8 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 	req.state = cpu_to_le32(state);
 	req.id = cpu_to_le32(id);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_REMOTE_STATE,
+	ret = qcom_scm_call(dev, 0, QCOM_SCM_SVC_BOOT,
+			    QCOM_SCM_SET_REMOTE_STATE,
 			    &req, sizeof(req), &scm_ret, sizeof(scm_ret));
 
 	return ret ? : le32_to_cpu(scm_ret);
@@ -592,6 +593,11 @@ int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 	return -ENODEV;
 }
 
+int __qcom_scm_restore_cfg(struct device *dev, u32 arginfo, u32 type)
+{
+	return -ENODEV;
+}
+
 int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 			       u32 spare)
 {
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 688525d..5c2d321 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2015, 2018 The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -80,7 +80,7 @@ struct qcom_scm_desc {
  * Sends a command to the SCM and waits for the command to finish processing.
  * This should *only* be called in pre-emptible context.
 */
-static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
+static int qcom_scm_call(struct device *dev, u32 own_id, u32 svc_id, u32 cmd_id,
 			 const struct qcom_scm_desc *desc,
 			 struct arm_smccc_res *res)
 {
@@ -130,7 +130,7 @@ static int qcom_scm_call(struct device *dev, u32 svc_id, u32 cmd_id,
 
 		cmd = ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL,
 					 qcom_smccc_convention,
-					 ARM_SMCCC_OWNER_SIP, fn_id);
+					 own_id, fn_id);
 
 		quirk.state.a6 = 0;
 
@@ -214,8 +214,8 @@ int __qcom_scm_is_call_available(struct device *dev, u32 svc_id, u32 cmd_id)
 	desc.args[0] = QCOM_SCM_FNID(svc_id, cmd_id) |
 			(ARM_SMCCC_OWNER_SIP << ARM_SMCCC_OWNER_SHIFT);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_INFO, QCOM_IS_CALL_AVAIL_CMD,
-			    &desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_INFO,
+			    QCOM_IS_CALL_AVAIL_CMD, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -242,8 +242,8 @@ int __qcom_scm_hdcp_req(struct device *dev, struct qcom_scm_hdcp_req *req,
 	desc.args[9] = req[4].val;
 	desc.arginfo = QCOM_SCM_ARGS(10);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_HDCP, QCOM_SCM_CMD_HDCP, &desc,
-			    &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_HDCP,
+			    QCOM_SCM_CMD_HDCP, &desc, &res);
 	*resp = res.a1;
 
 	return ret;
@@ -277,7 +277,7 @@ bool __qcom_scm_pas_supported(struct device *dev, u32 peripheral)
 	desc.args[0] = peripheral;
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_PIL,
 				QCOM_SCM_PAS_IS_SUPPORTED_CMD,
 				&desc, &res);
 
@@ -295,8 +295,8 @@ int __qcom_scm_pas_init_image(struct device *dev, u32 peripheral,
 	desc.args[1] = metadata_phys;
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_VAL, QCOM_SCM_RW);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_INIT_IMAGE_CMD,
-				&desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_PIL,
+			    QCOM_SCM_PAS_INIT_IMAGE_CMD, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -313,8 +313,8 @@ int __qcom_scm_pas_mem_setup(struct device *dev, u32 peripheral,
 	desc.args[2] = size;
 	desc.arginfo = QCOM_SCM_ARGS(3);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MEM_SETUP_CMD,
-				&desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_PIL,
+			    QCOM_SCM_PAS_MEM_SETUP_CMD, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -328,7 +328,7 @@ int __qcom_scm_pas_auth_and_reset(struct device *dev, u32 peripheral)
 	desc.args[0] = peripheral;
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL,
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_PIL,
 				QCOM_SCM_PAS_AUTH_AND_RESET_CMD,
 				&desc, &res);
 
@@ -344,8 +344,8 @@ int __qcom_scm_pas_shutdown(struct device *dev, u32 peripheral)
 	desc.args[0] = peripheral;
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_SHUTDOWN_CMD,
-			&desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_PIL,
+			    QCOM_SCM_PAS_SHUTDOWN_CMD, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -360,8 +360,8 @@ int __qcom_scm_pas_mss_reset(struct device *dev, bool reset)
 	desc.args[1] = 0;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_PIL, QCOM_SCM_PAS_MSS_RESET, &desc,
-			    &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_PIL,
+			    QCOM_SCM_PAS_MSS_RESET, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -376,8 +376,8 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 	desc.args[1] = id;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_REMOTE_STATE,
-			    &desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_BOOT,
+			    QCOM_SCM_SET_REMOTE_STATE, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -402,13 +402,30 @@ int __qcom_scm_assign_mem(struct device *dev, phys_addr_t mem_region,
 				     QCOM_SCM_RO, QCOM_SCM_VAL, QCOM_SCM_RO,
 				     QCOM_SCM_VAL, QCOM_SCM_VAL);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_MP,
 			    QCOM_MEM_PROT_ASSIGN_ID,
 			    &desc, &res);
 
 	return ret ? : res.a1;
 }
 
+int __qcom_scm_restore_cfg(struct device *dev, u32 arginfo, u32 type)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+	int ret;
+
+	if (type)
+		desc.args[0] = type;
+	desc.arginfo = arginfo;
+
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_TRUSTED_OS,
+			    QCOM_SCM_SVC_KEYSTORE,
+			    QCOM_SCM_RESTORE_CFG, &desc, &res);
+
+	return ret ? : res.a1;
+}
+
 int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
 {
 	struct qcom_scm_desc desc = {0};
@@ -419,8 +436,8 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
 	desc.args[1] = spare;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_RESTORE_SEC_CFG,
-			    &desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_MP,
+			    QCOM_SCM_RESTORE_SEC_CFG, &desc, &res);
 
 	return ret ? : res.a1;
 }
@@ -435,7 +452,7 @@ int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 	desc.args[0] = spare;
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_MP,
 			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE, &desc, &res);
 
 	if (size)
@@ -457,7 +474,7 @@ int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
 	desc.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
 				     QCOM_SCM_VAL);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_MP,
 			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT, &desc, &res);
 
 	/* the pg table has been initialized already, ignore the error */
@@ -476,8 +493,8 @@ int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	desc.args[1] = enable ? QCOM_SCM_SET_DLOAD_MODE : 0;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	return qcom_scm_call(dev, QCOM_SCM_SVC_BOOT, QCOM_SCM_SET_DLOAD_MODE,
-			     &desc, &res);
+	return qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_BOOT,
+			     QCOM_SCM_SET_DLOAD_MODE, &desc, &res);
 }
 
 int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
@@ -490,8 +507,8 @@ int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr,
 	desc.args[0] = addr;
 	desc.arginfo = QCOM_SCM_ARGS(1);
 
-	ret = qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_READ,
-			    &desc, &res);
+	ret = qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_IO,
+			    QCOM_SCM_IO_READ, &desc, &res);
 	if (ret >= 0)
 		*val = res.a1;
 
@@ -507,6 +524,6 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
 	desc.args[1] = val;
 	desc.arginfo = QCOM_SCM_ARGS(2);
 
-	return qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
-			     &desc, &res);
+	return qcom_scm_call(dev, ARM_SMCCC_OWNER_SIP, QCOM_SCM_SVC_IO,
+			     QCOM_SCM_IO_WRITE, &desc, &res);
 }
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e778af7..3519299 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1,7 +1,7 @@
 /*
  * Qualcomm SCM driver
  *
- * Copyright (c) 2010,2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2010,2015,2018 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -335,6 +335,12 @@ static int qcom_scm_pas_reset_deassert(struct reset_controller_dev *rcdev,
 	.deassert = qcom_scm_pas_reset_deassert,
 };
 
+int qcom_scm_ice_restore_cfg(u32 arginfo, u32 storage_type)
+{
+	return __qcom_scm_restore_cfg(__scm->dev, arginfo, storage_type);
+}
+EXPORT_SYMBOL(qcom_scm_ice_restore_cfg);
+
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 {
 	return __qcom_scm_restore_sec_cfg(__scm->dev, device_id, spare);
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index dcd7f79..bd2ee0a 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -1,4 +1,4 @@
-/* Copyright (c) 2010-2015, The Linux Foundation. All rights reserved.
+/* Copyright (c) 2010-2015,2018 The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -93,6 +93,9 @@ static inline int qcom_scm_remap_error(int err)
 	return -EINVAL;
 }
 
+#define QCOM_SCM_SVC_KEYSTORE		0x5
+#define QCOM_SCM_RESTORE_CFG		6
+extern int __qcom_scm_restore_cfg(struct device *dev, u32 arginfo, u32 type);
 #define QCOM_SCM_SVC_MP			0xc
 #define QCOM_SCM_RESTORE_SEC_CFG	2
 extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 5d65521..59e764e 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -60,6 +60,7 @@ extern int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
 extern u32 qcom_scm_get_version(void);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
+extern int qcom_scm_ice_restore_cfg(u32 arginfo, u32 storage_type);
 extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
@@ -96,6 +97,10 @@ static inline void qcom_scm_cpu_power_down(u32 flags) {}
 static inline u32
 qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
 static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
+static inline int qcom_scm_ice_restore_cfg(u32 arginfo, u32 storage_type)
+{
+	return -ENODEV;
+}
 static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
 static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

