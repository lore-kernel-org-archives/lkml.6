Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37106C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3552406D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQvwtFQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3552406D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeGEN45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:56:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35668 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753290AbeGEN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:56:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id v3-v6so7388655wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=InA9qmVWtON97F3FWZjNEydwLZZpnQa79A8pIy5/rTY=;
        b=YQvwtFQWmJpFWWj9sMNSoLgGPSR1l82nBOQqi1BW+6HLjxyshDteGUZx/ejqevQRpj
         Xv/dFk2Ib8kpqfo7QwXBKLjEB5q6F6arsaZPP0yPlijDYRD8oXhSXHS7t5sgjYs3QPuA
         GtB5Ieqq6U0e9yibMI0Bh23SJYZNvbke0C6oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=InA9qmVWtON97F3FWZjNEydwLZZpnQa79A8pIy5/rTY=;
        b=A3Qv+0d8ich8MglWBy4qxxpCAATJwTCRIf2PrtUEUxB8JmVlvNHt5RbKbsFv00W3Cm
         lFbeW4gjXQpCyqJgaCZQU31K9kgFHJat4XVJFD35wUd2gL9sFx9nG/EYnsbMCiK1RG5g
         kMjlmuJgofj8ElVoWni8luPd1WBghqBUoV2mzoAS2hTY9Z2plqCNeJ6NPPmNtY8e2KXf
         EiyU1L6SAmmYE34TnkhPBGxpNX0Fro2vF4DO/qwbFoSa+8cGk1NZuEkElb/8gCR776vC
         oujYM9BUXHZiuWzGrzTVe2nuWmJusRgCMFCid08YI9a7Twf1E+JS9bSGALKJrS2qQq1M
         9K/A==
X-Gm-Message-State: APt69E3Uun1ONIynlh1pb0A4J9kvGAlcUEHPaeNRX/mzQ5LeJxsMBwTA
        GeRMtyxvWtlZnlAaaJk0DL+Ysg==
X-Google-Smtp-Source: AAOMgpcd8D9oW1wy0mSTKWsrB+SdZ+0X5LmxU1pnOjCfdXbY1IjzUHunCdRGu4gdIN9HtfcwirlEqg==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13-v6mr4430934wmh.73.1530799007487;
        Thu, 05 Jul 2018 06:56:47 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id l17-v6sm11003297wrh.45.2018.07.05.06.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jul 2018 06:56:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, broonie@kernel.org
Cc:     vkoul@kernel.org, ctatlor97@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sdharia@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] slimbus: ngd: add stream support
Date:   Thu,  5 Jul 2018 14:54:26 +0100
Message-Id: <20180705135426.20748-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180705135426.20748-1-srinivas.kandagatla@linaro.org>
References: <20180705135426.20748-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to stream support, this involve implementing
user specific implementation of Data channel management and channel
management SLIMbus messages.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 149 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8554e3f43522..8be4d6786c61 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -603,7 +603,9 @@ static void qcom_slim_ngd_rx(struct qcom_slim_ngd_ctrl *ctrl, u8 *buf)
 
 	if (mc == SLIM_MSG_MC_REPLY_INFORMATION ||
 	    mc == SLIM_MSG_MC_REPLY_VALUE || (mc == SLIM_USR_MC_ADDR_REPLY &&
-	    mt == SLIM_MSG_MT_SRC_REFERRED_USER)) {
+	    mt == SLIM_MSG_MT_SRC_REFERRED_USER) ||
+		(mc == SLIM_USR_MC_GENERIC_ACK &&
+		 mt == SLIM_MSG_MT_SRC_REFERRED_USER)) {
 		slim_msg_response(&ctrl->ctrl, &buf[4], buf[3], len - 4);
 		pm_runtime_mark_last_busy(ctrl->dev);
 	}
@@ -766,10 +768,14 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 {
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
 	DECLARE_COMPLETION_ONSTACK(tx_sent);
-	int ret, timeout;
+	DECLARE_COMPLETION_ONSTACK(done);
+	int ret, timeout, i;
+	u8 wbuf[SLIM_MSGQ_BUF_LEN];
+	u8 rbuf[SLIM_MSGQ_BUF_LEN];
 	u32 *pbuf;
 	u8 *puc;
 	u8 la = txn->la;
+	bool usr_msg = false;
 
 	if (txn->mc & SLIM_MSG_CLK_PAUSE_SEQ_FLG)
 		return -EPROTONOSUPPORT;
@@ -794,6 +800,48 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 		return -ENOMEM;
 	}
 
+	if (txn->mt == SLIM_MSG_MT_CORE &&
+		(txn->mc == SLIM_MSG_MC_CONNECT_SOURCE ||
+		txn->mc == SLIM_MSG_MC_CONNECT_SINK ||
+		txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)) {
+		txn->mt = SLIM_MSG_MT_DEST_REFERRED_USER;
+		switch (txn->mc) {
+		case SLIM_MSG_MC_CONNECT_SOURCE:
+			txn->mc = SLIM_USR_MC_CONNECT_SRC;
+			break;
+		case SLIM_MSG_MC_CONNECT_SINK:
+			txn->mc = SLIM_USR_MC_CONNECT_SINK;
+			break;
+		case SLIM_MSG_MC_DISCONNECT_PORT:
+			txn->mc = SLIM_USR_MC_DISCONNECT_PORT;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		usr_msg = true;
+		i = 0;
+		wbuf[i++] = txn->la;
+		la = SLIM_LA_MGR;
+		wbuf[i++] = txn->msg->wbuf[0];
+		if (txn->mc != SLIM_USR_MC_DISCONNECT_PORT)
+			wbuf[i++] = txn->msg->wbuf[1];
+
+		txn->comp = &done;
+		ret = slim_alloc_txn_tid(sctrl, txn);
+		if (ret) {
+			dev_err(ctrl->dev, "Unable to allocate TID\n");
+			return ret;
+		}
+
+		wbuf[i++] = txn->tid;
+
+		txn->msg->num_bytes = i;
+		txn->msg->wbuf = wbuf;
+		txn->msg->rbuf = rbuf;
+		txn->rl = txn->msg->num_bytes + 4;
+	}
+
 	/* HW expects length field to be excluded */
 	txn->rl--;
 	puc = (u8 *)pbuf;
@@ -830,6 +878,15 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
 		return -ETIMEDOUT;
 	}
 
+	if (usr_msg) {
+		timeout = wait_for_completion_timeout(&done, HZ);
+		if (!timeout) {
+			dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x",
+				txn->mc, txn->mt);
+			return -ETIMEDOUT;
+		}
+	}
+
 	return 0;
 }
 
@@ -856,6 +913,93 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
 	return 0;
 }
 
+static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
+{
+	struct slim_device *sdev = rt->dev;
+	struct slim_controller *ctrl = sdev->ctrl;
+	struct slim_val_inf msg =  {0};
+	u8 wbuf[SLIM_MSGQ_BUF_LEN];
+	u8 rbuf[SLIM_MSGQ_BUF_LEN];
+	struct slim_msg_txn txn = {0,};
+	int i, ret;
+
+	txn.mt = SLIM_MSG_MT_DEST_REFERRED_USER;
+	txn.dt = SLIM_MSG_DEST_LOGICALADDR;
+	txn.la = SLIM_LA_MGR;
+	txn.ec = 0;
+	txn.msg = &msg;
+	txn.msg->num_bytes = 0;
+	txn.msg->wbuf = wbuf;
+	txn.msg->rbuf = rbuf;
+
+	for (i = 0; i < rt->num_ports; i++) {
+		struct slim_port *port = &rt->ports[i];
+
+		if (txn.msg->num_bytes == 0) {
+			int seg_interval = SLIM_SLOTS_PER_SUPERFRAME/rt->ratem;
+			int exp;
+
+			wbuf[txn.msg->num_bytes++] = sdev->laddr;
+			wbuf[txn.msg->num_bytes] = rt->bps >> 2 |
+						   (port->ch.aux_fmt << 6);
+
+			/* Data channel segment interval not multiple of 3 */
+			exp = seg_interval % 3;
+			if (exp)
+				wbuf[txn.msg->num_bytes] |= BIT(5);
+
+			txn.msg->num_bytes++;
+			wbuf[txn.msg->num_bytes++] = exp << 4 | rt->prot;
+
+			if (rt->prot == SLIM_PROTO_ISO)
+				wbuf[txn.msg->num_bytes++] =
+						port->ch.prrate |
+						SLIM_CHANNEL_CONTENT_FL;
+			else
+				wbuf[txn.msg->num_bytes++] =  port->ch.prrate;
+
+			ret = slim_alloc_txn_tid(ctrl, &txn);
+			if (ret) {
+				dev_err(&sdev->dev, "Fail to allocate TID\n");
+				return -ENXIO;
+			}
+			wbuf[txn.msg->num_bytes++] = txn.tid;
+		}
+		wbuf[txn.msg->num_bytes++] = port->ch.id;
+	}
+
+	txn.mc = SLIM_USR_MC_DEF_ACT_CHAN;
+	txn.rl = txn.msg->num_bytes + 4;
+	ret = qcom_slim_ngd_xfer_msg_sync(ctrl, &txn);
+	if (ret) {
+		slim_free_txn_tid(ctrl, &txn);
+		dev_err(&sdev->dev, "TX timed out:MC:0x%x,mt:0x%x", txn.mc,
+				txn.mt);
+		return ret;
+	}
+
+	txn.mc = SLIM_USR_MC_RECONFIG_NOW;
+	txn.msg->num_bytes = 2;
+	wbuf[1] = sdev->laddr;
+	txn.rl = txn.msg->num_bytes + 4;
+
+	ret = slim_alloc_txn_tid(ctrl, &txn);
+	if (ret) {
+		dev_err(ctrl->dev, "Fail to allocate TID\n");
+		return ret;
+	}
+
+	wbuf[0] = txn.tid;
+	ret = qcom_slim_ngd_xfer_msg_sync(ctrl, &txn);
+	if (ret) {
+		slim_free_txn_tid(ctrl, &txn);
+		dev_err(&sdev->dev, "TX timed out:MC:0x%x,mt:0x%x", txn.mc,
+				txn.mt);
+	}
+
+	return ret;
+}
+
 static int qcom_slim_ngd_get_laddr(struct slim_controller *ctrl,
 				   struct slim_eaddr *ea, u8 *laddr)
 {
@@ -1288,6 +1432,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	ctrl->ctrl.a_framer = &ctrl->framer;
 	ctrl->ctrl.clkgear = SLIM_MAX_CLK_GEAR;
 	ctrl->ctrl.get_laddr = qcom_slim_ngd_get_laddr;
+	ctrl->ctrl.enable_stream = qcom_slim_ngd_enable_stream;
 	ctrl->ctrl.xfer_msg = qcom_slim_ngd_xfer_msg;
 	ctrl->ctrl.wakeup = NULL;
 	ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
-- 
2.16.2

