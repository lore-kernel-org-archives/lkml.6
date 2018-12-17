Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2483C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A897420874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9curkAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbeLQPC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43521 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbeLQPCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so10980037eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wzegbj62oKFY0N23tiI9K4BZ0/ujbWxxaw1GF3q8v/o=;
        b=a9curkAiGadYYithTEranfnV6iucbdeWLEMPIbcQSjNyWsEg1htVElYT+iCWUNKuno
         jMj4RrUT/ajCJiV6vEZj7GeSLhC+tvR7TYqnAMjwqHjKKJCnpesKFahK2MHTXzHlyXNS
         Kdvnm4OwRDPxuPpqmRcv86mQaf42Ycc1RhZJTaeXRjt2ViYKx7NqjKyIVnNp0rPfOPiM
         kKhAV76kyBt1SDYuShxGKYTVGHwRWKx7zF180P9+zTafOu2ObXqqD+3VRBAXtFSV7IVp
         dFCYZyBhMgJ405WSNcH+V8shRXIiXEsKju4D6IzsiTg4QZyvCbTFf0WdhdH6u8BQf2Av
         7Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wzegbj62oKFY0N23tiI9K4BZ0/ujbWxxaw1GF3q8v/o=;
        b=nIDhDPfBM13PNPHqg1ZaJjN5Rk6apK/KKxQ6uaThyyxezy8j1Hjm77tYMAmqYDX9Ax
         kN9VSZygUqF7SBK5jXwdARHDPCz/LBDhMQo+lNSdvo7k2V2NCp9RXkogrDmFnCU2ZzKg
         sSXcZvmxjPvRkbHS6UIQD0ZVrUwOx1S6N2ydZL8Fz+5BrtoUxP1hm1DMwJfE5oQAw5Hy
         9jB3njCyolzpqH0kmfpDRT5Lnr+jfAbt3wA48de8TzGn9k+2Rv8s20LKowcfX/bvQYmQ
         jzR5Aqa7HvlAnyd/or91p4LJVG/uanzSTWN/EP6ShU8Mv9wtBNa1heV6nHK8ocmTr0I9
         G63Q==
X-Gm-Message-State: AA+aEWYwqFndy5FAhkpttVaZXDgeq7VC3eHQDbUnjblEWyAff3rVW4k3
        06t2q0ZiGvjJtYaDxus/PAs=
X-Google-Smtp-Source: AFSGD/VyjOP33ttHF+PybzAKVOnjbuvxWdbHPHNOxmr++Yh7tQFCjDOSxWvLYnTyx9qodS172sQblA==
X-Received: by 2002:a17:906:7c92:: with SMTP id w18-v6mr10612233ejo.236.1545058941580;
        Mon, 17 Dec 2018 07:02:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id t10-v6sm1914483ejg.41.2018.12.17.07.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:20 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gospodarek <gospo@broadcom.com>,
        Anup Patel <anup.patel@broadcom.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Caesar Wang <wxt@rock-chips.com>, CK Hu <ck.hu@mediatek.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, Duc Dang <dhdang@apm.com>,
        Eric Anholt <eric@anholt.net>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Feng Kan <fkan@apm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Jon Mason <jon.mason@broadcom.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Lee Jones <lee.jones@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Ley Foon Tan <lftan@altera.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Ray Jui <ray.jui@broadcom.com>,
        Rob Rice <rob.rice@broadcom.com>,
        Ruyi Wang <wangruyi@huawei.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Steve Lin <steven.lin1@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suman Anna <s-anna@ti.com>, Tony Lindgren <tony@atomide.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 01/19] mailbox: Add device-managed registration functions
Date:   Mon, 17 Dec 2018 16:01:59 +0100
Message-Id: <20181217150217.32435-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217150217.32435-1-thierry.reding@gmail.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add device-managed equivalents of the mbox_controller_register() and
mbox_controller_unregister() functions that can be used to have the
devres infrastructure automatically unregister mailbox controllers on
driver probe failure or driver removal. This can help remove a lot of
boiler plate code from drivers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox.c          | 70 ++++++++++++++++++++++++++++++
 include/linux/mailbox_controller.h |  5 +++
 2 files changed, 75 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..eb781e2b19cb 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -515,3 +515,73 @@ void mbox_controller_unregister(struct mbox_controller *mbox)
 	mutex_unlock(&con_mutex);
 }
 EXPORT_SYMBOL_GPL(mbox_controller_unregister);
+
+static void __devm_mbox_controller_unregister(struct device *dev, void *res)
+{
+	struct mbox_controller *mbox = res;
+
+	mbox_controller_unregister(mbox);
+}
+
+static int devm_mbox_controller_match(struct device *dev, void *res, void *data)
+{
+	struct mbox_controller **mbox = res;
+
+	if (WARN_ON(!mbox || !*mbox))
+		return 0;
+
+	return *mbox == data;
+}
+
+/**
+ * devm_mbox_controller_register() - managed mbox_controller_register()
+ * @dev: device owning the mailbox controller being registered
+ * @mbox: mailbox controller being registered
+ *
+ * This function adds a device-managed resource that will make sure that the
+ * mailbox controller, which is registered using mbox_controller_register()
+ * as part of this function, will be unregistered along with the rest of
+ * device-managed resources upon driver probe failure or driver removal.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int devm_mbox_controller_register(struct device *dev,
+				  struct mbox_controller *mbox)
+{
+	struct mbox_controller **ptr;
+	int err;
+
+	ptr = devres_alloc(__devm_mbox_controller_unregister, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	err = mbox_controller_register(mbox);
+	if (err < 0) {
+		devres_free(ptr);
+		return err;
+	}
+
+	devres_add(dev, ptr);
+	*ptr = mbox;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_mbox_controller_register);
+
+/**
+ * devm_mbox_controller_unregister() - managed mbox_controller_unregister()
+ * @dev: device owning the mailbox controller being unregistered
+ * @mbox: mailbox controller being unregistered
+ *
+ * This function unregisters the mailbox controller and removes the device-
+ * managed resource that was set up to automatically unregister the mailbox
+ * controller on driver probe failure or driver removal. It's typically not
+ * necessary to call this function.
+ */
+void devm_mbox_controller_unregister(struct device *dev, struct mbox_controller *mbox)
+{
+	WARN_ON(devres_release(dev, __devm_mbox_controller_unregister,
+			       devm_mbox_controller_match, mbox));
+}
+EXPORT_SYMBOL_GPL(devm_mbox_controller_unregister);
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 74deadb42d76..9b0b21207345 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -131,4 +131,9 @@ void mbox_controller_unregister(struct mbox_controller *mbox); /* can sleep */
 void mbox_chan_received_data(struct mbox_chan *chan, void *data); /* atomic */
 void mbox_chan_txdone(struct mbox_chan *chan, int r); /* atomic */
 
+int devm_mbox_controller_register(struct device *dev,
+				  struct mbox_controller *mbox);
+void devm_mbox_controller_unregister(struct device *dev,
+				     struct mbox_controller *mbox);
+
 #endif /* __MAILBOX_CONTROLLER_H */
-- 
2.19.1

