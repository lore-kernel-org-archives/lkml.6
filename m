Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2619D214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyZZcev/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2619D214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbeKVB3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:29:20 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbeKVB3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:29:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so5122792edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 06:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wzegbj62oKFY0N23tiI9K4BZ0/ujbWxxaw1GF3q8v/o=;
        b=YyZZcev/ahDtpwnFFXYQap4pTREzl9gUVDZj4+3vxF57+Wy6UMajvQQpn/RiOK+ZO/
         GtMOsS1d1JRJiIN+9Pxv3FYCvj2iZJghPUqPzCdIWMSR2m8pCjAtmYlCoVYJyBQtUD2d
         RZBIjATaqfj7oghdGpIalcgt8CyVosXycGUCeraf2b2ZVqR6twq/NyrCY8Bm8bxGxVJs
         TATYgLO+IIkPS+karyOw008GNh6GIjV8TlhfEwLjW320kn3Y5NUTqFM4TyhA6hMYQ53o
         e47DcdNq+sFSAEV8ne2oFd8V3VKEtBEdUfZ5K41QbrH8scmKpr3xS1Yex+v0FeKAjhT0
         c/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wzegbj62oKFY0N23tiI9K4BZ0/ujbWxxaw1GF3q8v/o=;
        b=sS1n/+PapszDD3ZHAbphoU16eyA84KJrprMTNT1yVfUnomA7jJ/UuCN6899Xw6Slsk
         ALZSNUO7QKUd/dnY6ED0CrbMnECMyl4xPx3ZFg2dgWy+uUzbN/P42PJjfbli8op8cIVH
         M0K46k1s/Xs7u09SfNDiG/ztaaEtiSp+vdB9lZtIbn/2fR/LkdTREm3c0/I0hCLWPqJZ
         Z1ALuANP8etitGV6RZeYvZ6hQHBHiycZ+1b7C9qBcmVXcAJslXX6YWgyg2d3J88cdcak
         IiDFiiraN8fHrLVRsVPMHKeA2xIZNSvIv5MRbBxbAaVaCW/wRNlYp3sH2KjXT4HR++kI
         brXA==
X-Gm-Message-State: AGRZ1gKMxWEBCAa5AraAsh7NsgFAlJBHbkOpejIXi5SosuO4WZnKrf4x
        /2cR5GnTXBLNYZggbawYCyg=
X-Google-Smtp-Source: AJdET5evAZ4iLCGU0zS0kqlRh1Py8/aw0fzps4pxHn5YnMDWuYk7W6UM3qgmOlyNf4mkl63eycDWfw==
X-Received: by 2002:a17:906:2acf:: with SMTP id m15-v6mr5237549eje.180.1542812072459;
        Wed, 21 Nov 2018 06:54:32 -0800 (PST)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id g3sm13469973edc.63.2018.11.21.06.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 06:54:31 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] mailbox: Add device-managed registration functions
Date:   Wed, 21 Nov 2018 15:54:11 +0100
Message-Id: <20181121145429.7582-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121145429.7582-1-thierry.reding@gmail.com>
References: <20181121145429.7582-1-thierry.reding@gmail.com>
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

