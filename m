Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V04qOueqGFscGQAAmS7hNA
	; Thu, 07 Jun 2018 03:49:25 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C00C9607F7; Thu,  7 Jun 2018 03:49:25 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOSvoHd8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F31B760290;
	Thu,  7 Jun 2018 03:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F31B760290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeFGDtW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:49:22 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41547 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeFGDtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:49:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so4031372pgl.8;
        Wed, 06 Jun 2018 20:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rfaI/Xv3SN/BsS1QOT9Yd1Ltcxj27uk5U8iflrKC1RE=;
        b=oOSvoHd8ifdx6mF7YI0fTiaJBZNrayr15AA/c4eQfylzzXh+3kuFBgFXTpZ2UcBNw3
         UGTfD1oZVPvYZK/NloQ4xEkoT9u4dm3tS3Agz/tomplHtyvAoocvNdDEYn80tVPFPumv
         1CZYLkwM4yxPWI+KItgi+grBpVjU0QCUcBGC6yb8uNSZjVP42HLfA+5A1V0BMEL/lYEb
         ytzro8eiBpsQwZX39WnW+yFpez5u21jchqZvmKurBSfgo2OSSp+7pC7gX7qHnJezsDhu
         xnlji7vJX3GToImncxIXvrlVVSo0QFdQWWkc96Ou/9nbY5FO8Tv7dW7IojbqO3O6y1XB
         mxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rfaI/Xv3SN/BsS1QOT9Yd1Ltcxj27uk5U8iflrKC1RE=;
        b=F1D2WW5KbSAYMJw7zlxUbcaZ3qTM5w6Mu4c8nutp5du9w1z4K43axANEaQQz9Iz5I2
         1kTYUn7L3EeKlbb1uyzJR5jYhfiCDmRLfNZQejqDb0gXUP7eQi40gLYy3nAgvA26K+Yk
         7Zy92NKgm9FI2ad2HA2ya3o9QLYJPbFbodH6IMj66hh3BaIUlq5ff9aJNBI1rAQVJ1q1
         2ftqds6nCFui57Dy2FOWdV3IHN1ZC6cztN5ACOeG/z4LSPhhFmiUu8jEPNiJB1nENEqo
         WraprybkgdO5u8cIYob61ax3Cw8dp2J0T+fOIG9zQq58lbUikkHvsOu3rXmw40jk2qy0
         /E8Q==
X-Gm-Message-State: APt69E3dSGuWkAstuzztn7oqfW55duPT6z6tGTYvSJOyGkZ+eVx4GTX9
        H5XucfywoFSAgkRKOQ4oQIAKIA==
X-Google-Smtp-Source: ADUXVKJJ9vmedE/XE+zjCxl6eEb+r+8Kir9jyizKaRwzt4ICwdtMOYJpUY8kQMCZmG5QeuGqES0cJw==
X-Received: by 2002:a62:1747:: with SMTP id 68-v6mr211117pfx.69.1528343360020;
        Wed, 06 Jun 2018 20:49:20 -0700 (PDT)
Received: from localhost.localdomain ([103.62.68.119])
        by smtp.googlemail.com with ESMTPSA id o72-v6sm23860229pfk.76.2018.06.06.20.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 20:49:19 -0700 (PDT)
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH v2 2/2] message: fusion: Replace NULL comparison
Date: Thu,  7 Jun 2018 09:19:02 +0530
Message-Id: <32f62942e8803ea1c9f1389c3784bfcf8962584d.1528342739.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528342739.git.rvarsha016@gmail.com>
References: <cover.1528342739.git.rvarsha016@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace x == NULL with !x, to fix checkpatch issue. This patch also
fixes line over 80 characters warning.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
Following coccinelle script is used to fix the warnings.

@disable is_null@
expression e;
@@
- e == NULL
+!e

Changes in v2:
- Removed coccinelle script from commit message.
- Fixed line over 80 characters warning.

 drivers/message/fusion/mptbase.c | 46 ++++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 5b98b7fca0f2..8af294619d92 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -488,7 +488,7 @@ mpt_turbo_reply(MPT_ADAPTER *ioc, u32 pa)
 
 	/*  Check for (valid) IO callback!  */
 	if (!cb_idx || cb_idx >= MPT_MAX_PROTOCOL_DRIVERS ||
-		MptCallbacks[cb_idx] == NULL) {
+		!MptCallbacks[cb_idx]) {
 		printk(MYIOC_s_WARN_FMT "%s: Invalid cb_idx (%d)!\n",
 				__func__, ioc->name, cb_idx);
 		goto out;
@@ -552,7 +552,7 @@ mpt_reply(MPT_ADAPTER *ioc, u32 pa)
 
 	/*  Check for (valid) IO callback!  */
 	if (!cb_idx || cb_idx >= MPT_MAX_PROTOCOL_DRIVERS ||
-		MptCallbacks[cb_idx] == NULL) {
+		!MptCallbacks[cb_idx]) {
 		printk(MYIOC_s_WARN_FMT "%s: Invalid cb_idx (%d)!\n",
 				__func__, ioc->name, cb_idx);
 		freeme = 0;
@@ -707,7 +707,7 @@ mpt_register(MPT_CALLBACK cbfunc, MPT_DRIVER_CLASS dclass, char *func_name)
 	 *  (slot/handle 0 is reserved!)
 	 */
 	for (cb_idx = MPT_MAX_PROTOCOL_DRIVERS-1; cb_idx; cb_idx--) {
-		if (MptCallbacks[cb_idx] == NULL) {
+		if (!MptCallbacks[cb_idx]) {
 			MptCallbacks[cb_idx] = cbfunc;
 			MptDriverClass[cb_idx] = dclass;
 			MptEvHandlers[cb_idx] = NULL;
@@ -928,7 +928,7 @@ mpt_get_msg_frame(u8 cb_idx, MPT_ADAPTER *ioc)
 	spin_unlock_irqrestore(&ioc->FreeQlock, flags);
 
 #ifdef MFCNT
-	if (mf == NULL)
+	if (!mf)
 		printk(MYIOC_s_WARN_FMT "IOC Active. No free Msg Frames! "
 		    "Count 0x%x Max 0x%x\n", ioc->name, ioc->mfcnt,
 		    ioc->req_depth);
@@ -1723,7 +1723,7 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 	/* Get logical ptr for PciMem0 space */
 	/*mem = ioremap(mem_phys, msize);*/
 	mem = ioremap(mem_phys, msize);
-	if (mem == NULL) {
+	if (!mem) {
 		printk(MYIOC_s_ERR_FMT ": ERROR - Unable to map adapter"
 			" memory!\n", ioc->name);
 		r = -EINVAL;
@@ -1780,7 +1780,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_device_id *id)
 #endif
 
 	ioc = kzalloc(sizeof(MPT_ADAPTER), GFP_ATOMIC);
-	if (ioc == NULL) {
+	if (!ioc) {
 		printk(KERN_ERR MYNAM ": ERROR - Insufficient memory to add adapter!\n");
 		return -ENOMEM;
 	}
@@ -2821,7 +2821,7 @@ mpt_adapter_dispose(MPT_ADAPTER *ioc)
 {
 	int sz_first, sz_last;
 
-	if (ioc == NULL)
+	if (!ioc)
 		return;
 
 	sz_first = ioc->alloc_total;
@@ -4328,17 +4328,17 @@ initChainBuffers(MPT_ADAPTER *ioc)
 	/* ReqToChain size must equal the req_depth
 	 * index = req_idx
 	 */
-	if (ioc->ReqToChain == NULL) {
+	if (!ioc->ReqToChain) {
 		sz = ioc->req_depth * sizeof(int);
 		mem = kmalloc(sz, GFP_ATOMIC);
-		if (mem == NULL)
+		if (!mem)
 			return -1;
 
 		ioc->ReqToChain = (int *) mem;
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "ReqToChain alloc  @ %p, sz=%d bytes\n",
 			 	ioc->name, mem, sz));
 		mem = kmalloc(sz, GFP_ATOMIC);
-		if (mem == NULL)
+		if (!mem)
 			return -1;
 
 		ioc->RequestNB = (int *) mem;
@@ -4403,9 +4403,9 @@ initChainBuffers(MPT_ADAPTER *ioc)
 	ioc->num_chain = num_chain;
 
 	sz = num_chain * sizeof(int);
-	if (ioc->ChainToChain == NULL) {
+	if (!ioc->ChainToChain) {
 		mem = kmalloc(sz, GFP_ATOMIC);
-		if (mem == NULL)
+		if (!mem)
 			return -1;
 
 		ioc->ChainToChain = (int *) mem;
@@ -4443,7 +4443,7 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 
 	/*  Prime reply FIFO...  */
 
-	if (ioc->reply_frames == NULL) {
+	if (!ioc->reply_frames) {
 		if ( (num_chain = initChainBuffers(ioc)) < 0)
 			return -1;
 		/*
@@ -4495,7 +4495,7 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 
 		total_size += sz;
 		mem = pci_alloc_consistent(ioc->pcidev, total_size, &alloc_dma);
-		if (mem == NULL) {
+		if (!mem) {
 			printk(MYIOC_s_ERR_FMT "Unable to allocate Reply, Request, Chain Buffers!\n",
 				ioc->name);
 			goto out_fail;
@@ -4573,7 +4573,7 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		sz = (ioc->req_depth * MPT_SENSE_BUFFER_ALLOC);
 		ioc->sense_buf_pool =
 			pci_alloc_consistent(ioc->pcidev, sz, &ioc->sense_buf_pool_dma);
-		if (ioc->sense_buf_pool == NULL) {
+		if (!ioc->sense_buf_pool) {
 			printk(MYIOC_s_ERR_FMT "Unable to allocate Sense Buffers!\n",
 				ioc->name);
 			goto out_fail;
@@ -5092,7 +5092,7 @@ mptbase_sas_persist_operation(MPT_ADAPTER *ioc, u8 persist_opcode)
 
 	/* Get a MF for this command.
 	 */
-	if ((mf = mpt_get_msg_frame(mpt_base_index, ioc)) == NULL) {
+	if (!(mf = mpt_get_msg_frame(mpt_base_index, ioc))) {
 		printk(KERN_DEBUG "%s: no msg frames!\n", __func__);
 		ret = -1;
 		goto out;
@@ -5372,7 +5372,7 @@ mpt_GetScsiPortSettings(MPT_ADAPTER *ioc, int portnum)
 		u8	*mem;
 		sz = MPT_MAX_SCSI_DEVICES * sizeof(int);
 		mem = kmalloc(sz, GFP_ATOMIC);
-		if (mem == NULL)
+		if (!mem)
 			return -EFAULT;
 
 		ioc->spi_data.nvram = (int *) mem;
@@ -5692,8 +5692,8 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 channel, u8 id)
 		    buffer->PhysDisk[i].PhysDiskNum, &phys_disk) != 0)
 			continue;
 
-		if ((component_info = kmalloc(sizeof (*component_info),
-		 GFP_KERNEL)) == NULL)
+		component_info = kmalloc(sizeof(*component_info), GFP_KERNEL);
+		if (!component_info)
 			continue;
 
 		component_info->volumeID = id;
@@ -6106,7 +6106,7 @@ mpt_read_ioc_pg_4(MPT_ADAPTER *ioc)
 	if (header.PageLength == 0)
 		return;
 
-	if ( (pIoc4 = ioc->spi_data.pIocPg4) == NULL ) {
+	if (!(pIoc4 = ioc->spi_data.pIocPg4)) {
 		iocpage4sz = (header.PageLength + 4) * 4; /* Allow 4 additional SEP's */
 		pIoc4 = pci_alloc_consistent(ioc->pcidev, iocpage4sz, &ioc4_dma);
 		if (!pIoc4)
@@ -6302,7 +6302,7 @@ SendEventAck(MPT_ADAPTER *ioc, EventNotificationReply_t *evnp)
 {
 	EventAck_t	*pAck;
 
-	if ((pAck = (EventAck_t *) mpt_get_msg_frame(mpt_base_index, ioc)) == NULL) {
+	if (!(pAck = (EventAck_t *)mpt_get_msg_frame(mpt_base_index, ioc))) {
 		dfailprintk(ioc, printk(MYIOC_s_WARN_FMT "%s, no msg frames!!\n",
 		    ioc->name, __func__));
 		return -1;
@@ -6393,7 +6393,7 @@ mpt_config(MPT_ADAPTER *ioc, CONFIGPARMS *pCfg)
 
 	/* Get and Populate a free Frame
 	 */
-	if ((mf = mpt_get_msg_frame(mpt_base_index, ioc)) == NULL) {
+	if (!(mf = mpt_get_msg_frame(mpt_base_index, ioc))) {
 		dcprintk(ioc, printk(MYIOC_s_WARN_FMT
 		"mpt_config: no msg frames!\n", ioc->name));
 		ret = -EAGAIN;
@@ -6605,7 +6605,7 @@ static int
 procmpt_create(void)
 {
 	mpt_proc_root_dir = proc_mkdir(MPT_PROCFS_MPTBASEDIR, NULL);
-	if (mpt_proc_root_dir == NULL)
+	if (!mpt_proc_root_dir)
 		return -ENOTDIR;
 
 	proc_create_single("summary", S_IRUGO, mpt_proc_root_dir,
-- 
2.17.0
