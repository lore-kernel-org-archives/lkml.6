Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676B7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2BE2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfvBF6eA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2BE2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeH1Ot1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:49:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43530 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeH1Ot1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:49:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so572050pgb.10;
        Tue, 28 Aug 2018 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kkmSP+S2xa50vt/kMfU0J7pd/UBt4Xna2GL+M0WES7E=;
        b=KfvBF6eARkbnTYc1Cw5k/bqbBXqfnW0mBGGVB0WjRZBpWKGs09NKonAhgkBl81VhbE
         vFZ74rbEkDnQiuaCVGCDOpeXiJ0ol0WqW/CT4Z9I0Klfif4coPcXsOmB6NkKTcXSnRz6
         m2Njs39NYTpH42Fddnuq8efVcgMsiiZCEBnj3FdKifQToF/8hgOVztQWinEWq714Rnm5
         hBBwN2nk8WgJRG6za3Nwt4UYbgNhiL//AJ6IhZi87VOwxgr15SbKSg4yPh1WvaVwVcZi
         sU5Tk4/QVND2QKHNoTV09wNqSG37wGm6zcBbiPVct01DIeXuXcm1+zfbJPqBpeWOBfe6
         EmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kkmSP+S2xa50vt/kMfU0J7pd/UBt4Xna2GL+M0WES7E=;
        b=Sc82SvtiXufyMorXDjh+BH1a5qYQ266rzcnkycEVyg/a7/XEhG94s6w2oo79ZBl1Gi
         Myuf1/c556g30pXFeTn38KvUr6DUV7UGwip+A+GA5+ipyJmgn1a2x7K0EjHznJ5rmYa5
         3GdSDCzQgwfpC1Ovn8zyNOe64IPCfXXs7i448JUanf3+dCUOT6EIP5AceZKCg+U9XgYV
         Z5PZmh4pD3subZ+JaNbEOvPFHi1K+8o4ASwknN+7IZnumljZDrLJUUb6dKT7mHOgzzrs
         Mw+CCNiBD4RYyl0S8dq5gvHIqaZtkoJ89KqYRm6JgUaLYe+bA4ml2rtwqbjTYnQ4IxQG
         9JUg==
X-Gm-Message-State: APzg51BuU15q6b6Akoi2I1CHnqAsLrAcUWbzWCeCLSt3VUpcf7l6XRQE
        dEO5w5XR9f0w9Q0XU8DelCXm+Lmy
X-Google-Smtp-Source: ANB0VdYIKTdO9enqOwsMP10JfxgATq7jrSIqHnIUicnXpfIRFrcdAB2xKQnGgvGp8/vOTcPOZv1GzQ==
X-Received: by 2002:a63:91c2:: with SMTP id l185-v6mr1016500pge.321.1535453901013;
        Tue, 28 Aug 2018 03:58:21 -0700 (PDT)
Received: from machine421.caveonetworks.com ([115.113.156.2])
        by smtp.googlemail.com with ESMTPSA id n22-v6sm2946798pfj.68.2018.08.28.03.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Aug 2018 03:58:20 -0700 (PDT)
From:   sunil.kovvuri@gmail.com
To:     linux-kernel@vger.kernel.org, arnd@arndb.de, olof@lixom.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org,
        Linu Cherian <lcherian@marvell.com>,
        Nithya Mani <nmani@marvell.com>
Subject: [PATCH 13/15] soc: octeontx2: Add support for CGX link management
Date:   Tue, 28 Aug 2018 16:27:16 +0530
Message-Id: <1535453838-12154-14-git-send-email-sunil.kovvuri@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linu Cherian <lcherian@marvell.com>

CGX LMAC initialization, link status polling etc is done
by low level secure firmware. For link management this patch
adds a interface or communication mechanism between firmware
and this kernel CGX driver.

- Firmware interface specification is defined in cgx_fw_if.h.
- Support to send/receive commands/events to/form firmware.
- events/commands implemented
  * link up
  * link down
  * reading firmware version

Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Nithya Mani <nmani@marvell.com>
---
 drivers/soc/marvell/octeontx2/cgx.c       | 361 +++++++++++++++++++++++++++++-
 drivers/soc/marvell/octeontx2/cgx.h       |  32 +++
 drivers/soc/marvell/octeontx2/cgx_fw_if.h | 225 +++++++++++++++++++
 3 files changed, 614 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/marvell/octeontx2/cgx_fw_if.h

diff --git a/drivers/soc/marvell/octeontx2/cgx.c b/drivers/soc/marvell/octeontx2/cgx.c
index 70ca2e2f1..811422f 100644
--- a/drivers/soc/marvell/octeontx2/cgx.c
+++ b/drivers/soc/marvell/octeontx2/cgx.c
@@ -25,16 +25,43 @@
 #define DRV_STRING      "Marvell OcteonTX2 CGX/MAC Driver"
 #define DRV_VERSION	"1.0"
 
+/**
+ * struct lmac
+ * @wq_cmd_cmplt:	waitq to keep the process blocked until cmd completion
+ * @cmd_lock:		Lock to serialize the command interface
+ * @resp:		command response
+ * @event_cb:		callback for linkchange events
+ * @cmd_pend:		flag set before new command is started
+ *			flag cleared after command response is received
+ * @cgx:		parent cgx port
+ * @lmac_id:		lmac port id
+ * @name:		lmac port name
+ */
+struct lmac {
+	wait_queue_head_t wq_cmd_cmplt;
+	struct mutex cmd_lock;
+	struct cgx_evt_sts resp;
+	struct cgx_event_cb event_cb;
+	bool cmd_pend;
+	struct cgx *cgx;
+	u8 lmac_id;
+	char *name;
+};
+
 struct cgx {
 	void __iomem		*reg_base;
 	struct pci_dev		*pdev;
 	u8			cgx_id;
 	u8			lmac_count;
+	struct lmac		*lmac_idmap[MAX_LMAC_PER_CGX];
 	struct list_head	cgx_list;
 };
 
 static LIST_HEAD(cgx_list);
 
+/* CGX PHY management internal APIs */
+static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool en);
+
 /* Supported devices */
 static const struct pci_device_id cgx_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_OCTEONTX2_CGX) },
@@ -47,11 +74,24 @@ MODULE_LICENSE("GPL v2");
 MODULE_VERSION(DRV_VERSION);
 MODULE_DEVICE_TABLE(pci, cgx_id_table);
 
+static void cgx_write(struct cgx *cgx, u64 lmac, u64 offset, u64 val)
+{
+	writeq(val, cgx->reg_base + (lmac << 18) + offset);
+}
+
 static u64 cgx_read(struct cgx *cgx, u64 lmac, u64 offset)
 {
 	return readq(cgx->reg_base + (lmac << 18) + offset);
 }
 
+static inline struct lmac *lmac_pdata(u8 lmac_id, struct cgx *cgx)
+{
+	if (!cgx || lmac_id >= MAX_LMAC_PER_CGX)
+		return NULL;
+
+	return cgx->lmac_idmap[lmac_id];
+}
+
 int cgx_get_cgx_cnt(void)
 {
 	struct cgx *cgx_dev;
@@ -87,18 +127,315 @@ void *cgx_get_pdata(int cgx_id)
 }
 EXPORT_SYMBOL(cgx_get_pdata);
 
-static void cgx_lmac_init(struct cgx *cgx)
+/* CGX Firmware interface low level support */
+static int cgx_fwi_cmd_send(struct cgx_cmd *cmd, struct cgx_evt_sts *rsp,
+			    struct lmac *lmac)
+{
+	struct cgx *cgx = lmac->cgx;
+	union cgx_cmdreg creg;
+	union cgx_evtreg ereg;
+	struct device *dev;
+	int err = 0;
+
+	/* Ensure no other command is in progress */
+	err = mutex_lock_interruptible(&lmac->cmd_lock);
+	if (err)
+		return err;
+
+	/* Ensure command register is free */
+	creg.val = cgx_read(cgx, lmac->lmac_id,  CGX_COMMAND_REG);
+	if (creg.cmd.own != CGX_CMD_OWN_NS) {
+		err = -EBUSY;
+		goto unlock;
+	}
+
+	/* Update ownership in command request */
+	cmd->own = CGX_CMD_OWN_FIRMWARE;
+
+	/* Mark this lmac as pending, before we start */
+	lmac->cmd_pend = true;
+
+	/* Start command in hardware */
+	creg.cmd = *cmd;
+	cgx_write(cgx, lmac->lmac_id, CGX_COMMAND_REG, creg.val);
+	creg.val = cgx_read(cgx, lmac->lmac_id,  CGX_COMMAND_REG);
+
+	/* Ensure command is completed without errors */
+	if (!wait_event_timeout(lmac->wq_cmd_cmplt, !lmac->cmd_pend,
+				msecs_to_jiffies(CGX_CMD_TIMEOUT))) {
+		dev = &cgx->pdev->dev;
+		ereg.val = cgx_read(cgx, lmac->lmac_id,  CGX_EVENT_REG);
+		if (ereg.val) {
+			dev_err(dev, "cgx port %d:%d: No event for response\n",
+				cgx->cgx_id, lmac->lmac_id);
+			/* copy event */
+			lmac->resp = ereg.evt_sts;
+		} else {
+			dev_err(dev, "cgx port %d:%d cmd timeout\n",
+				cgx->cgx_id, lmac->lmac_id);
+			err = -EIO;
+			goto unlock;
+		}
+	}
+
+	/* we have a valid command response */
+	smp_rmb(); /* Ensure the latest updates are visible */
+	*rsp = lmac->resp;
+
+unlock:
+	mutex_unlock(&lmac->cmd_lock);
+
+	return err;
+}
+
+static inline int cgx_fwi_cmd_generic(struct cgx_cmd *req,
+				      struct cgx_evt_sts *rsp,
+				      struct cgx *cgx, int lmac_id)
+{
+	struct lmac *lmac;
+	int err;
+
+	lmac = lmac_pdata(lmac_id, cgx);
+	if (!lmac)
+		return -ENODEV;
+
+	err = cgx_fwi_cmd_send(req, rsp, lmac);
+
+	/* Check for valid response */
+	if (!err) {
+		if (rsp->stat == CGX_STAT_FAIL)
+			return -EIO;
+		else
+			return 0;
+	}
+
+	return err;
+}
+
+/* Hardware event handlers */
+static inline void cgx_link_change_handler(struct cgx_lnk_sts *lstat,
+					   struct lmac *lmac)
+{
+	struct cgx *cgx = lmac->cgx;
+	struct cgx_link_event event;
+	struct device *dev = &cgx->pdev->dev;
+
+	event.lstat = *lstat;
+	event.cgx_id = cgx->cgx_id;
+	event.lmac_id = lmac->lmac_id;
+
+	if (!lmac->event_cb.notify_link_chg) {
+		dev_dbg(dev, "cgx port %d:%d Link change handler null",
+			cgx->cgx_id, lmac->lmac_id);
+		if (lstat->err_type != CGX_ERR_NONE) {
+			dev_err(dev, "cgx port %d:%d Link error %d\n",
+				cgx->cgx_id, lmac->lmac_id, lstat->err_type);
+		}
+		dev_info(dev, "cgx port %d:%d Link status %s, speed %x\n",
+			 cgx->cgx_id, lmac->lmac_id,
+			lstat->link_up ? "UP" : "DOWN", lstat->speed);
+		return;
+	}
+
+	if (lmac->event_cb.notify_link_chg(&event, lmac->event_cb.data))
+		dev_err(dev, "event notification failure\n");
+}
+
+static inline bool cgx_cmdresp_is_linkevent(struct cgx_evt_sts *rsp)
+{
+	if (rsp->id == CGX_CMD_LINK_BRING_UP ||
+	    rsp->id == CGX_CMD_LINK_BRING_DOWN)
+		return true;
+	else
+		return false;
+}
+
+static inline bool cgx_event_is_linkevent(struct cgx_evt_sts *evt)
+{
+	if (evt->id == CGX_EVT_LINK_CHANGE)
+		return true;
+	else
+		return false;
+}
+
+static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
+{
+	struct lmac *lmac = data;
+	struct cgx *cgx = lmac->cgx;
+	struct cgx_evt_sts event;
+	union cgx_evtreg ereg;
+	struct device *dev;
+
+	ereg.val = cgx_read(cgx, lmac->lmac_id, CGX_EVENT_REG);
+	if (!ereg.evt_sts.ack)
+		return IRQ_NONE;
+
+	dev = &cgx->pdev->dev;
+
+	event = ereg.evt_sts;
+
+	switch (event.evt_type) {
+	case CGX_EVT_CMD_RESP:
+		/* Copy the response. Since only one command is active at a
+		 * time, there is no way a response can get overwritten
+		 */
+		lmac->resp = event;
+		/* Ensure response is updated before thread context starts */
+		smp_wmb();
+
+		/* There wont be separate events for link change initiated from
+		 * software; Hence report the command responses as events
+		 */
+		if (cgx_cmdresp_is_linkevent(&event))
+			cgx_link_change_handler(&ereg.link_sts, lmac);
+
+		/* Release thread waiting for completion  */
+		lmac->cmd_pend = false;
+		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		break;
+	case CGX_EVT_ASYNC:
+		if (cgx_event_is_linkevent(&event))
+			cgx_link_change_handler(&ereg.link_sts, lmac);
+		break;
+	default:
+		dev_err(dev, "cgx port %d:%d Unknown event received\n",
+			cgx->cgx_id, lmac->lmac_id);
+	}
+
+	/* Any new event or command response will be posted by firmware
+	 * only after the current status is acked.
+	 * Ack the interrupt register as well.
+	 */
+	cgx_write(lmac->cgx, lmac->lmac_id, CGX_EVENT_REG, 0);
+	cgx_write(lmac->cgx, lmac->lmac_id, CGXX_CMRX_INT, FW_CGX_INT);
+
+	return IRQ_HANDLED;
+}
+
+/* APIs for PHY management using CGX firmware interface */
+
+/* callback registration for hardware events like link change */
+int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id)
+{
+	struct lmac *lmac;
+	struct cgx *cgx = cgxd;
+
+	lmac = lmac_pdata(lmac_id, cgx);
+	if (!lmac)
+		return -ENODEV;
+
+	lmac->event_cb = *cb;
+
+	return 0;
+}
+EXPORT_SYMBOL(cgx_lmac_evh_register);
+
+static int cgx_fwi_link_change(struct cgx *cgx, int lmac_id, bool enable)
 {
+	struct cgx_cmd req = { 0 };
+	struct cgx_evt_sts rsp;
+
+	if (enable)
+		req.id = CGX_CMD_LINK_BRING_UP;
+	else
+		req.id = CGX_CMD_LINK_BRING_DOWN;
+
+	return cgx_fwi_cmd_generic(&req, &rsp, cgx, lmac_id);
+}
+EXPORT_SYMBOL(cgx_fwi_link_change);
+
+static inline int cgx_fwi_read_version(struct cgx_ver_s *ver, struct cgx *cgx)
+{
+	struct cgx_cmd req = { 0 };
+	union cgx_evtreg event;
+	int err;
+
+	req.id = CGX_CMD_GET_FW_VER;
+
+	err = cgx_fwi_cmd_generic(&req, &event.evt_sts, cgx, 0);
+	if (!err)
+		*ver = event.ver;
+
+	return err;
+}
+
+static int cgx_lmac_verify_fwi_version(struct cgx *cgx)
+{
+	struct cgx_ver_s ver;
+	struct device *dev = &cgx->pdev->dev;
+	int err;
+
+	err = cgx_fwi_read_version(&ver, cgx);
+	dev_dbg(dev, "Firmware command interface version = %d.%d\n",
+		ver.major_ver, ver.minor_ver);
+	if (err || ver.major_ver != CGX_FIRMWARE_MAJOR_VER ||
+	    ver.minor_ver != CGX_FIRMWARE_MINOR_VER)
+		return -EIO;
+	else
+		return 0;
+}
+
+static int cgx_lmac_init(struct cgx *cgx)
+{
+	struct lmac *lmac;
+	int i, err;
+
 	cgx->lmac_count = cgx_read(cgx, 0, CGXX_CMRX_RX_LMACS) & 0x7;
 	if (cgx->lmac_count > MAX_LMAC_PER_CGX)
 		cgx->lmac_count = MAX_LMAC_PER_CGX;
+
+	for (i = 0; i < cgx->lmac_count; i++) {
+		lmac = kcalloc(1, sizeof(struct lmac), GFP_KERNEL);
+		if (!lmac)
+			return -ENOMEM;
+		lmac->name = kcalloc(1, sizeof("cgx_fwi_xxx_yyy"), GFP_KERNEL);
+		if (!lmac->name)
+			return -ENOMEM;
+		sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
+		lmac->lmac_id = i;
+		lmac->cgx = cgx;
+		init_waitqueue_head(&lmac->wq_cmd_cmplt);
+		mutex_init(&lmac->cmd_lock);
+		err = request_irq(pci_irq_vector(cgx->pdev,
+						 CGX_LMAC_FWI + i * 9),
+				   cgx_fwi_event_handler, 0, lmac->name, lmac);
+		if (err)
+			return err;
+
+		/* Enable interrupt */
+		cgx_write(cgx, lmac->lmac_id, CGXX_CMRX_INT_ENA_W1S,
+			  FW_CGX_INT);
+
+		/* Add reference */
+		cgx->lmac_idmap[i] = lmac;
+	}
+
+	return cgx_lmac_verify_fwi_version(cgx);
+}
+
+static int cgx_lmac_exit(struct cgx *cgx)
+{
+	struct lmac *lmac;
+	int i;
+
+	/* Free all lmac related resources */
+	for (i = 0; i < cgx->lmac_count; i++) {
+		lmac = cgx->lmac_idmap[i];
+		if (!lmac)
+			continue;
+		free_irq(pci_irq_vector(cgx->pdev, CGX_LMAC_FWI + i * 9), lmac);
+		kfree(lmac->name);
+		kfree(lmac);
+	}
+
+	return 0;
 }
 
 static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int err;
 	struct device *dev = &pdev->dev;
 	struct cgx *cgx;
+	int err, nvec;
 
 	cgx = devm_kzalloc(dev, sizeof(*cgx), GFP_KERNEL);
 	if (!cgx)
@@ -128,14 +465,28 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_release_regions;
 	}
 
+	nvec = CGX_NVEC;
+	err = pci_alloc_irq_vectors(pdev, nvec, nvec, PCI_IRQ_MSIX);
+	if (err < 0 || err != nvec) {
+		dev_err(dev, "Request for %d msix vectors failed, err %d\n",
+			nvec, err);
+		goto err_release_regions;
+	}
+
 	list_add(&cgx->cgx_list, &cgx_list);
 	cgx->cgx_id = cgx_get_cgx_cnt() - 1;
-	cgx_lmac_init(cgx);
+
+	err = cgx_lmac_init(cgx);
+	if (err)
+		goto err_release_lmac;
+
 
 	return 0;
 
-err_release_regions:
+err_release_lmac:
+	cgx_lmac_exit(cgx);
 	list_del(&cgx->cgx_list);
+err_release_regions:
 	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
@@ -147,7 +498,9 @@ static void cgx_remove(struct pci_dev *pdev)
 {
 	struct cgx *cgx = pci_get_drvdata(pdev);
 
+	cgx_lmac_exit(cgx);
 	list_del(&cgx->cgx_list);
+	pci_free_irq_vectors(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
diff --git a/drivers/soc/marvell/octeontx2/cgx.h b/drivers/soc/marvell/octeontx2/cgx.h
index 9ec72b1..3f8879f 100644
--- a/drivers/soc/marvell/octeontx2/cgx.h
+++ b/drivers/soc/marvell/octeontx2/cgx.h
@@ -11,6 +11,8 @@
 #ifndef CGX_H
 #define CGX_H
 
+#include "cgx_fw_if.h"
+
  /* PCI device IDs */
 #define	PCI_DEVID_OCTEONTX2_CGX		0xA059
 
@@ -22,10 +24,40 @@
 #define CGX_OFFSET(x)			((x) * MAX_LMAC_PER_CGX)
 
 /* Registers */
+#define CGXX_CMRX_INT			0x040
+#define  FW_CGX_INT				BIT_ULL(1)
+#define CGXX_CMRX_INT_ENA_W1S		0x058
 #define CGXX_CMRX_RX_ID_MAP		0x060
 #define CGXX_CMRX_RX_LMACS		0x128
+#define CGXX_SCRATCH0_REG		0x1050
+#define CGXX_SCRATCH1_REG		0x1058
+#define CGX_CONST			0x2000
+
+#define CGX_COMMAND_REG			CGXX_SCRATCH1_REG
+#define CGX_EVENT_REG			CGXX_SCRATCH0_REG
+#define CGX_CMD_TIMEOUT			2200 /* msecs */
+
+#define CGX_NVEC			37
+#define CGX_LMAC_FWI			0
+
+struct cgx_link_event {
+	struct cgx_lnk_sts lstat;
+	u8 cgx_id;
+	u8 lmac_id;
+};
+
+/**
+ * struct cgx_event_cb
+ * @notify_link_chg:	callback for link change notification
+ * @data:	data passed to callback function
+ */
+struct cgx_event_cb {
+	int (*notify_link_chg)(struct cgx_link_event *event, void *data);
+	void *data;
+};
 
 int cgx_get_cgx_cnt(void);
 int cgx_get_lmac_cnt(void *cgxd);
 void *cgx_get_pdata(int cgx_id);
+int cgx_lmac_evh_register(struct cgx_event_cb *cb, void *cgxd, int lmac_id);
 #endif /* CGX_H */
diff --git a/drivers/soc/marvell/octeontx2/cgx_fw_if.h b/drivers/soc/marvell/octeontx2/cgx_fw_if.h
new file mode 100644
index 0000000..771dd50
--- /dev/null
+++ b/drivers/soc/marvell/octeontx2/cgx_fw_if.h
@@ -0,0 +1,225 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Marvell OcteonTx2 CGX driver
+ *
+ * Copyright (C) 2018 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __CGX_FW_INTF_H__
+#define __CGX_FW_INTF_H__
+
+#define CGX_FIRMWARE_MAJOR_VER		1
+#define CGX_FIRMWARE_MINOR_VER		0
+
+#define CGX_EVENT_ACK                   1UL
+
+/* CGX error types. set for cmd response status as CGX_STAT_FAIL */
+enum cgx_error_type {
+	CGX_ERR_NONE,
+	CGX_ERR_LMAC_NOT_ENABLED,
+	CGX_ERR_LMAC_MODE_INVALID,
+	CGX_ERR_REQUEST_ID_INVALID,
+	CGX_ERR_PREV_ACK_NOT_CLEAR,
+	CGX_ERR_PHY_LINK_DOWN,
+	CGX_ERR_PCS_RESET_FAIL,
+	CGX_ERR_AN_CPT_FAIL,
+	CGX_ERR_TX_NOT_IDLE,
+	CGX_ERR_RX_NOT_IDLE,
+	CGX_ERR_SPUX_BR_BLKLOCK_FAIL,
+	CGX_ERR_SPUX_RX_ALIGN_FAIL,
+	CGX_ERR_SPUX_TX_FAULT,
+	CGX_ERR_SPUX_RX_FAULT,
+	CGX_ERR_SPUX_RESET_FAIL,
+	CGX_ERR_SPUX_AN_RESET_FAIL,
+	CGX_ERR_SPUX_USX_AN_RESET_FAIL,
+	CGX_ERR_SMUX_RX_LINK_NOT_OK,
+	CGX_ERR_PCS_RECV_LINK_FAIL,
+	CGX_ERR_TRAINING_FAIL,
+	CGX_ERR_RX_EQU_FAIL,
+	CGX_ERR_SPUX_BER_FAIL,
+	CGX_ERR_SPUX_RSFEC_ALGN_FAIL,   /* = 22 */
+};
+
+/* LINK speed types */
+enum cgx_link_speed {
+	CGX_LINK_NONE,
+	CGX_LINK_10M,
+	CGX_LINK_100M,
+	CGX_LINK_1G,
+	CGX_LINK_2HG,
+	CGX_LINK_5G,
+	CGX_LINK_10G,
+	CGX_LINK_20G,
+	CGX_LINK_25G,
+	CGX_LINK_40G,
+	CGX_LINK_50G,
+	CGX_LINK_100G,
+	CGX_LINK_SPEED_MAX,
+};
+
+/* REQUEST ID types. Input to firmware */
+enum cgx_cmd_id {
+	CGX_CMD_NONE,
+	CGX_CMD_GET_FW_VER,
+	CGX_CMD_GET_MAC_ADDR,
+	CGX_CMD_SET_MTU,
+	CGX_CMD_GET_LINK_STS,		/* optional to user */
+	CGX_CMD_LINK_BRING_UP,
+	CGX_CMD_LINK_BRING_DOWN,
+	CGX_CMD_INTERNAL_LBK,
+	CGX_CMD_EXTERNAL_LBK,
+	CGX_CMD_HIGIG,
+	CGX_CMD_LINK_STATE_CHANGE,
+	CGX_CMD_MODE_CHANGE,		/* hot plug support */
+	CGX_CMD_INTF_SHUTDOWN,
+	CGX_CMD_IRQ_ENABLE,
+	CGX_CMD_IRQ_DISABLE,
+};
+
+/* async event ids */
+enum cgx_evt_id {
+	CGX_EVT_NONE,
+	CGX_EVT_LINK_CHANGE,
+};
+
+/* event types - cause of interrupt */
+enum cgx_evt_type {
+	CGX_EVT_ASYNC,
+	CGX_EVT_CMD_RESP
+};
+
+enum cgx_stat {
+	CGX_STAT_SUCCESS,
+	CGX_STAT_FAIL
+};
+
+enum cgx_cmd_own {
+	CGX_CMD_OWN_NS,
+	CGX_CMD_OWN_FIRMWARE,
+};
+
+/* scratchx(0) CSR used for ATF->non-secure SW communication.
+ * This acts as the status register
+ * Provides details on command ack/status, link status, error details
+ */
+struct cgx_evt_sts {
+	uint64_t ack:1;
+	uint64_t evt_type:1;		/* cgx_evt_type */
+	uint64_t stat:1;		/* cgx_stat */
+	uint64_t id:6;			/* cgx_evt_id/cgx_cmd_id */
+	uint64_t reserved:55;
+};
+
+/* Response to command IDs with command status as CGX_STAT_FAIL
+ *
+ * Not applicable for commands :
+ * CGX_CMD_LINK_BRING_UP/DOWN/CGX_EVT_LINK_CHANGE
+ * check struct cgx_lnk_sts comments
+ */
+struct cgx_err_sts_s {
+	uint64_t reserved1:9;
+	uint64_t type:10;		/* cgx_error_type */
+	uint64_t reserved2:35;
+};
+
+/* Response to cmd ID as CGX_CMD_GET_FW_VER with cmd status as
+ * CGX_STAT_SUCCESS
+ */
+struct cgx_ver_s {
+	uint64_t reserved1:9;
+	uint64_t major_ver:4;
+	uint64_t minor_ver:4;
+	uint64_t reserved2:47;
+};
+
+/* Response to cmd ID as CGX_CMD_GET_MAC_ADDR with cmd status as
+ * CGX_STAT_SUCCESS
+ */
+struct cgx_mac_addr_s {
+	uint64_t reserved1:9;
+	uint64_t local_mac_addr:48;
+	uint64_t reserved2:7;
+};
+
+/* Response to cmd ID - CGX_CMD_LINK_BRING_UP/DOWN, event ID CGX_EVT_LINK_CHANGE
+ * status can be either CGX_STAT_FAIL or CGX_STAT_SUCCESS
+ *
+ * In case of CGX_STAT_FAIL, it indicates CGX configuration failed
+ * when processing link up/down/change command.
+ * Both err_type and current link status will be updated
+ *
+ * In case of CGX_STAT_SUCCESS, err_type will be CGX_ERR_NONE and current
+ * link status will be updated
+ */
+struct cgx_lnk_sts {
+	uint64_t reserved1:9;
+	uint64_t link_up:1;
+	uint64_t full_duplex:1;
+	uint64_t speed:4;		/* cgx_link_speed */
+	uint64_t err_type:10;
+	uint64_t reserved2:39;
+};
+
+union cgx_evtreg {
+	u64 val;
+	struct cgx_evt_sts evt_sts; /* common for all commands/events */
+	struct cgx_lnk_sts link_sts; /* response to LINK_BRINGUP/DOWN/CHANGE */
+	struct cgx_ver_s ver;		/* response to CGX_CMD_GET_FW_VER */
+	struct cgx_mac_addr_s mac_addr;	/* response to CGX_CMD_GET_MAC_ADDR */
+	struct cgx_err_sts_s err;	/* response if evt_status = CMD_FAIL */
+};
+
+/* scratchx(1) CSR used for non-secure SW->ATF communication
+ * This CSR acts as a command register
+ */
+struct cgx_cmd {
+	uint64_t own:2;			/* cgx_csr_own */
+	uint64_t id:6;			/* cgx_request_id */
+	uint64_t reserved2:56;
+};
+
+/* Any command using enable/disable as an argument need
+ * to pass the option via this structure.
+ * Ex: Loopback, HiGig...
+ */
+struct cgx_ctl_args {
+	uint64_t reserved1:8;
+	uint64_t enable:1;
+	uint64_t reserved2:55;
+};
+
+/* command argument to be passed for cmd ID - CGX_CMD_SET_MTU */
+struct cgx_mtu_args {
+	uint64_t reserved1:8;
+	uint64_t size:16;
+	uint64_t reserved2:40;
+};
+
+/* command argument to be passed for cmd ID - CGX_CMD_LINK_CHANGE */
+struct cgx_link_change_args {
+	uint64_t reserved1:8;
+	uint64_t link_up:1;
+	uint64_t full_duplex:1;
+	uint64_t speed:4;		/* cgx_link_speed */
+	uint64_t reserved2:50;
+};
+
+struct cgx_irq_cfg {
+	uint64_t reserved1:8;
+	uint64_t irq_phys:32;
+	uint64_t reserved2:24;
+};
+
+union cgx_cmdreg {
+	u64 val;
+	struct cgx_cmd cmd;
+	struct cgx_ctl_args cmd_args;
+	struct cgx_mtu_args mtu_size;
+	struct cgx_irq_cfg irq_cfg; /* Input to CGX_CMD_IRQ_ENABLE */
+	struct cgx_link_change_args lnk_args;/* Input to CGX_CMD_LINK_CHANGE */
+};
+
+#endif /* __CGX_FW_INTF_H__ */
-- 
2.7.4

