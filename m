Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2996C20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNPT1hEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfANTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:42:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35478 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfANTmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:42:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so284636wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0aWl/+Ew4yEPq0SRrpXsq42WiPfKAaWt6eu386ameI=;
        b=HNPT1hEovqq2Td1bPztlfUbGGxDA6QLt65VD3codbHWzxobt8ilpRHuNi5JaYm+8wp
         l84EcsFSXk9zEY1XRmOzDrq0YfG6T92wIbztF/YgfTZ9wV5/i3QjdBUp+rZ2djs7wd+I
         Nu8L9Pgit2pRglG9Jwilc+WBeeuuXmyct2QXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0aWl/+Ew4yEPq0SRrpXsq42WiPfKAaWt6eu386ameI=;
        b=C31YSmKe0UoVFz8nzL7Czz1dIn55+7klnniwV8mCaYsW+oLpMVvdfJg9UN0kycu/pF
         /xZURyxzwGt6psXAv6xqVGrXp5BOkYRMpxdmD6fp7JbDY+ybEHW5edMpUQEkkK5GCEs8
         pS/ls1RID+JMMorUydrKU2PG8oqstdQE7HHEmjmnnrHGJMWs5ctGx5szF4kKe33wDtm/
         cbmC63SpCtBWgrbsAEU80ItuuOvLp0JYpC6x3D/gWQ4f8XAu3SerEJOIYpvdN4tMjzQY
         Q60ACmUToQJssJ2Ey7EVkZctuoYZlvNTyn1QovhuE19cWz2bg+6MqE0CJdQl342DsiH5
         IYMw==
X-Gm-Message-State: AJcUukfhylai5/MQSjYKGU4702fHtGm2MP8bzik7JXSEaL6hc1j9t4Pb
        gG3+hU/rtsnGS58PjqIKPL9soQ==
X-Google-Smtp-Source: ALg8bN7RdUX2tEB+Kbr6qSY4h7nQJhOW2Kd9CKB26JajLXUjFsCtnExF6XtvVt/usQY7PA9y+boLIQ==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr52723wrw.135.1547494935726;
        Mon, 14 Jan 2019 11:42:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm66779996wrs.47.2019.01.14.11.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 11:42:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        thierry.escande@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/5] misc: fastrpc: Add Qualcomm fastrpc basic driver model
Date:   Mon, 14 Jan 2019 19:41:09 +0000
Message-Id: <20190114194112.32567-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
References: <20190114194112.32567-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic driver model for qualcomm fastrpc.
Each DSP rpmsg channel is represented as fastrpc channel context and
is exposed as a character driver for userspace interface.
Each compute context bank is represented as fastrpc-session-context,
which are dynamically managed by the channel context char device.

Co-developed-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/Kconfig   |  10 ++
 drivers/misc/Makefile  |   1 +
 drivers/misc/fastrpc.c | 327 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 338 insertions(+)
 create mode 100644 drivers/misc/fastrpc.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f417b06e11c5..7e0726253755 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -295,6 +295,16 @@ config QCOM_COINCELL
 	  to maintain PMIC register and RTC state in the absence of
 	  external power.
 
+config QCOM_FASTRPC
+	tristate "Qualcomm FastRPC"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on RPMSG
+	help
+	  Provides a communication mechanism that allows for clients to
+	  make remote method invocations across processor boundary to
+	  applications DSP processor. Say M if you want to enable this
+	  module.
+
 config SGI_GRU
 	tristate "SGI GRU driver"
 	depends on X86_UV && SMP
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e39ccbbc1b3a..623d002c59ce 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
 obj-$(CONFIG_QCOM_COINCELL)	+= qcom-coincell.o
+obj-$(CONFIG_QCOM_FASTRPC)	+= fastrpc.o
 obj-$(CONFIG_SENSORS_BH1770)	+= bh1770glc.o
 obj-$(CONFIG_SENSORS_APDS990X)	+= apds990x.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
new file mode 100644
index 000000000000..2b2dd7373959
--- /dev/null
+++ b/drivers/misc/fastrpc.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2018, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/idr.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/rpmsg.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+
+#define ADSP_DOMAIN_ID (0)
+#define MDSP_DOMAIN_ID (1)
+#define SDSP_DOMAIN_ID (2)
+#define CDSP_DOMAIN_ID (3)
+#define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
+#define FASTRPC_MAX_SESSIONS	9 /*8 compute, 1 cpz*/
+#define FASTRPC_CTX_MAX (256)
+#define FASTRPC_CTXID_MASK (0xFF0)
+#define FASTRPC_DEVICE_NAME	"fastrpc"
+
+#define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
+
+static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
+						"sdsp", "cdsp"};
+
+struct fastrpc_session_ctx {
+	struct device *dev;
+	int sid;
+	bool used;
+	bool valid;
+	bool secure;
+};
+
+struct fastrpc_channel_ctx {
+	int domain_id;
+	int sesscount;
+	struct rpmsg_device *rpdev;
+	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
+	spinlock_t lock;
+	struct idr ctx_idr;
+	struct list_head users;
+	struct miscdevice miscdev;
+};
+
+struct fastrpc_user {
+	struct list_head user;
+	struct list_head maps;
+	struct list_head pending;
+
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_session_ctx *sctx;
+
+	int tgid;
+	int pd;
+	/* Lock for lists */
+	spinlock_t lock;
+	/* lock for allocations */
+	struct mutex mutex;
+};
+
+static struct fastrpc_session_ctx *fastrpc_session_alloc(
+					struct fastrpc_channel_ctx *cctx,
+					int secure)
+{
+	struct fastrpc_session_ctx *session = NULL;
+	int i;
+
+	spin_lock(&cctx->lock);
+	for (i = 0; i < cctx->sesscount; i++) {
+		if (!cctx->session[i].used && cctx->session[i].valid &&
+		    cctx->session[i].secure == secure) {
+			cctx->session[i].used = true;
+			session = &cctx->session[i];
+			break;
+		}
+	}
+	spin_unlock(&cctx->lock);
+
+	return session;
+}
+
+static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
+				 struct fastrpc_session_ctx *session)
+{
+	spin_lock(&cctx->lock);
+	session->used = false;
+	spin_unlock(&cctx->lock);
+}
+
+static int fastrpc_device_release(struct inode *inode, struct file *file)
+{
+	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+
+	spin_lock(&cctx->lock);
+	list_del(&fl->user);
+	spin_unlock(&cctx->lock);
+
+	fastrpc_session_free(fl->cctx, fl->sctx);
+
+	mutex_destroy(&fl->mutex);
+	kfree(fl);
+	file->private_data = NULL;
+
+	return 0;
+}
+
+static int fastrpc_device_open(struct inode *inode, struct file *filp)
+{
+	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
+	struct fastrpc_user *fl = NULL;
+
+	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
+	if (!fl)
+		return -ENOMEM;
+
+	filp->private_data = fl;
+	spin_lock_init(&fl->lock);
+	mutex_init(&fl->mutex);
+	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->maps);
+	INIT_LIST_HEAD(&fl->user);
+	fl->tgid = current->tgid;
+	fl->cctx = cctx;
+	spin_lock(&cctx->lock);
+	list_add_tail(&fl->user, &cctx->users);
+	spin_unlock(&cctx->lock);
+	fl->sctx = fastrpc_session_alloc(cctx, 0);
+
+	return 0;
+}
+
+static const struct file_operations fastrpc_fops = {
+	.open = fastrpc_device_open,
+	.release = fastrpc_device_release,
+};
+
+static int fastrpc_cb_probe(struct platform_device *pdev)
+{
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_session_ctx *sess;
+	struct device *dev = &pdev->dev;
+	int i, sessions = 0;
+
+	cctx = dev_get_drvdata(dev->parent);
+	if (!cctx)
+		return -EINVAL;
+
+	of_property_read_u32(dev->of_node, "nsessions", &sessions);
+
+	spin_lock(&cctx->lock);
+	sess = &cctx->session[cctx->sesscount];
+	sess->used = false;
+	sess->valid = true;
+	sess->dev = dev;
+	dev_set_drvdata(dev, sess);
+	sess->secure = of_property_read_bool(dev->of_node, "secured");
+
+	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
+		dev_info(dev, "FastRPC Session ID not specified in DT\n");
+
+	if (sessions > 0) {
+		struct fastrpc_session_ctx *dup_sess;
+
+		for (i = 1; i < sessions; i++) {
+			if (cctx->sesscount++ >= FASTRPC_MAX_SESSIONS)
+				break;
+			dup_sess = &cctx->session[cctx->sesscount];
+			memcpy(dup_sess, sess, sizeof(*dup_sess));
+		}
+	}
+	cctx->sesscount++;
+	spin_unlock(&cctx->lock);
+	dma_set_mask(dev, DMA_BIT_MASK(32));
+
+	return 0;
+}
+
+static int fastrpc_cb_remove(struct platform_device *pdev)
+{
+	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
+	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
+	int i;
+
+	spin_lock(&cctx->lock);
+	for (i = 1; i < FASTRPC_MAX_SESSIONS; i++) {
+		if (cctx->session[i].sid == sess->sid) {
+			cctx->session[i].valid = false;
+			cctx->sesscount--;
+		}
+	}
+	spin_unlock(&cctx->lock);
+
+	return 0;
+}
+
+static const struct of_device_id fastrpc_match_table[] = {
+	{ .compatible = "qcom,fastrpc-compute-cb", },
+	{}
+};
+
+static struct platform_driver fastrpc_cb_driver = {
+	.probe = fastrpc_cb_probe,
+	.remove = fastrpc_cb_remove,
+	.driver = {
+		.name = "qcom,fastrpc-cb",
+		.of_match_table = fastrpc_match_table,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct device *rdev = &rpdev->dev;
+	struct fastrpc_channel_ctx *data;
+	int i, err, domain_id = 0;
+	const char *domain;
+
+	data = devm_kzalloc(rdev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	err = of_property_read_string(rdev->of_node, "label", &domain);
+	if (err) {
+		dev_info(rdev, "FastRPC Domain not specified in DT\n");
+		return err;
+	}
+
+	for (i = 0; i < CDSP_DOMAIN_ID; i++) {
+		if (!strcmp(domains[i], domain)) {
+			domain_id = i;
+			break;
+		}
+	}
+
+	if (domain_id > CDSP_DOMAIN_ID) {
+		dev_info(rdev, "FastRPC Invalid Domain ID %d\n", domain_id);
+		return -EINVAL;
+	}
+
+	data->miscdev.minor = MISC_DYNAMIC_MINOR;
+	data->miscdev.name = kasprintf(GFP_KERNEL, "fastrpc-%s",
+				domains[domain_id]);
+	data->miscdev.fops = &fastrpc_fops;
+	err = misc_register(&data->miscdev);
+	if (err)
+		return err;
+
+	dev_set_drvdata(&rpdev->dev, data);
+	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
+	INIT_LIST_HEAD(&data->users);
+	spin_lock_init(&data->lock);
+	idr_init(&data->ctx_idr);
+	data->domain_id = domain_id;
+	data->rpdev = rpdev;
+
+	return of_platform_populate(rdev->of_node, NULL, NULL, rdev);
+}
+
+static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
+
+	misc_deregister(&cctx->miscdev);
+	of_platform_depopulate(&rpdev->dev);
+	kfree(cctx);
+}
+
+static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+				  int len, void *priv, u32 addr)
+{
+	return 0;
+}
+
+static const struct of_device_id fastrpc_rpmsg_of_match[] = {
+	{ .compatible = "qcom,fastrpc" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fastrpc_rpmsg_of_match);
+
+static struct rpmsg_driver fastrpc_driver = {
+	.probe = fastrpc_rpmsg_probe,
+	.remove = fastrpc_rpmsg_remove,
+	.callback = fastrpc_rpmsg_callback,
+	.drv = {
+		.name = "qcom,fastrpc",
+		.of_match_table = fastrpc_rpmsg_of_match,
+	},
+};
+
+static int fastrpc_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&fastrpc_cb_driver);
+	if (ret < 0) {
+		pr_err("fastrpc: failed to register cb driver\n");
+		return ret;
+	}
+
+	ret = register_rpmsg_driver(&fastrpc_driver);
+	if (ret < 0) {
+		pr_err("fastrpc: failed to register rpmsg driver\n");
+		platform_driver_unregister(&fastrpc_cb_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(fastrpc_init);
+
+static void fastrpc_exit(void)
+{
+	platform_driver_unregister(&fastrpc_cb_driver);
+	unregister_rpmsg_driver(&fastrpc_driver);
+}
+module_exit(fastrpc_exit);
+
+MODULE_ALIAS("fastrpc:fastrpc");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

