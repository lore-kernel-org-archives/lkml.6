Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95C5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84E98222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcQsZiJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfBPT1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:27:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37760 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfBPT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:27:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so6488833pfh.4;
        Sat, 16 Feb 2019 11:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvGd4wtTpa+CQYMionZSq5bb7Gtx6XZLGmQFvd6i7o0=;
        b=tcQsZiJD79S3XYKwoX5DsGaoRUWQIB4rpn7Qm/enXZniGCizPGoE7ItRPfsduQOD1J
         oqGI28exZD2xtCna6hTXu2SpiVgZuK+wtPbzPejPQLo1/tO1HNGzhfPA43xTOL2RHlmR
         IyPdApP1RkcBfWHRzS4TQHfItBGddeOLwdEgZrDklEPddXpgZ+zn8CwNh7T0AvjNoSAa
         X75mxhE/bnuZx8hKYrPS/5hZSrE9kW4Z4Xty4J6TOdxaricUQCTwRzF0mEIMtPgQTHhj
         LzEYPKwawz14lHyDlycw9yYH76ZVJ/QSbdK/AGEVN/UN+lviQRnyQa5uvO0WwFft5M+g
         LeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvGd4wtTpa+CQYMionZSq5bb7Gtx6XZLGmQFvd6i7o0=;
        b=PGjmx3KFFVOAP2N5d1R+6Hgnmgsve3lHMDYG5vQRxdzWI77YcQU4rWafD41n7TkPIG
         KZXNiTu8IcHw2TkGfoBy4tuvPJe+cYUF1U9Rf2ZvOMzWSA+R7MGFGeBduVgGr2qqsq5u
         6AyTfI9gnuaPGn3g6SlmkXMymuVqPdeiz+yUsPcF6GQakuUC1NQQa3ZciVWl/JHDS+C6
         y59CJAi/FxCtM+RdaFZalVJvkwJYcwA3eCsJw0HLH4OHBI87qyYslI91o5VQoKnWIH0o
         Ebe/W6uSH0IH5C4xD7FzOa7K3ynuozwvOFxpJRxwn2VagiRDcWMf4Di7oWoH/JpmbFyc
         7etQ==
X-Gm-Message-State: AHQUAub/8m+00xH1TTV1TullkUczeKqx6Z85uNE8r14+1JqqUs6RvV50
        jPuUy2bpv7Akqe1UW9u5UXc=
X-Google-Smtp-Source: AHgI3Iay1rbm1GJD5PrYcpdkL+5Mqb9q60MOThvReqGqHvH127FJ/kEbLV1kaYX3jLb1/HwDqT4sBw==
X-Received: by 2002:a62:444b:: with SMTP id r72mr16296174pfa.184.1550345233565;
        Sat, 16 Feb 2019 11:27:13 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id n75sm13472398pfb.39.2019.02.16.11.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Feb 2019 11:27:13 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        alexander.shishkin@linux.intel.com,
        Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guiding Li <liguiding@pinecone.net>
Subject: [PATCH V3] rpmsg: add syslog redirection driver
Date:   Sun, 17 Feb 2019 03:26:43 +0800
Message-Id: <1550345203-25460-2-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550345203-25460-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1550345203-25460-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guiding Li <liguiding@pinecone.net>

This driver allows the remote processor to redirect the output of
syslog or printf into the kernel log, which is very useful to see
what happen in the remote side.

Signed-off-by: Guiding Li <liguiding@pinecone.net>
---
 drivers/rpmsg/Kconfig        |  12 ++++
 drivers/rpmsg/Makefile       |   1 +
 drivers/rpmsg/rpmsg_syslog.c | 161 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_syslog.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b4..13ead55 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,18 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_SYSLOG
+	tristate "RPMSG syslog redirection"
+	depends on RPMSG
+	help
+	  Say Y here to redirect the syslog/printf from remote processor into
+	  the kernel log which is very useful to see what happened in the remote
+	  side.
+
+	  If the remote processor hangs during bootup or panics during runtime,
+	  we can even cat /sys/kernel/debug/remoteproc/remoteprocX/trace0 to
+	  get the last log which hasn't been output yet.
+
 config RPMSG_QCOM_GLINK_NATIVE
 	tristate
 	select RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 9aa8595..bfd22df 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_SYSLOG)	+= rpmsg_syslog.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
diff --git a/drivers/rpmsg/rpmsg_syslog.c b/drivers/rpmsg/rpmsg_syslog.c
new file mode 100644
index 0000000..06e3f86
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_syslog.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Pinecone Inc.
+ *
+ * redirect syslog/printf from remote to the kernel.
+ */
+
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+
+#define RPMSG_SYSLOG_TRANSFER		0
+#define RPMSG_SYSLOG_TRANSFER_DONE	1
+#define RPMSG_SYSLOG_SUSPEND		2
+#define RPMSG_SYSLOG_RESUME		3
+
+struct rpmsg_syslog_header {
+	u32				command;
+	s32				result;
+} __packed;
+
+struct rpmsg_syslog_transfer {
+	struct rpmsg_syslog_header	header;
+	u32				count;
+	char				data[0];
+} __packed;
+
+#define rpmsg_syslog_suspend		rpmsg_syslog_header
+#define rpmsg_syslog_resume		rpmsg_syslog_header
+#define rpmsg_syslog_transfer_done	rpmsg_syslog_header
+
+struct rpmsg_syslog {
+	char				*buf;
+	unsigned int			next;
+	unsigned int			size;
+};
+
+static int rpmsg_syslog_callback(struct rpmsg_device *rpdev,
+				 void *data, int len, void *priv_, u32 src)
+{
+	struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
+	struct rpmsg_syslog_transfer *msg = data;
+	struct rpmsg_syslog_transfer_done done;
+	char *s, *e, *nl;
+
+	if (msg->header.command != RPMSG_SYSLOG_TRANSFER)
+		return -EINVAL;
+
+	s = msg->data;
+	e = s + msg->count;
+
+	/* redirect the message to kernel log line by line */
+	while ((nl = strnchr(s, e - s, '\n')) != NULL) {
+		*nl = '\0';
+		if (priv->next) {
+			pr_info("%.*s%s\n", priv->next, priv->buf, s);
+			priv->next = 0;
+		} else {
+			pr_info("%s\n", s);
+		}
+		s = nl + 1;
+	}
+
+	/* append the remain to the buffer */
+	if (s != e) {
+		unsigned int size = e - s;
+		unsigned int newsize = priv->next + size;
+
+		if (newsize > priv->size) {
+			char *newbuf;
+
+			newbuf = krealloc(priv->buf, newsize, GFP_KERNEL);
+			if (newbuf) {
+				priv->buf  = newbuf;
+				priv->size = newsize;
+			} else {
+				size = priv->size - priv->next;
+			}
+		}
+
+		strncpy(priv->buf + priv->next, s, size);
+		priv->next += size;
+		s += size;
+	}
+
+	done.command = RPMSG_SYSLOG_TRANSFER_DONE;
+	done.result  = s - msg->data;
+	return rpmsg_send(rpdev->ept, &done, sizeof(done));
+}
+
+static int rpmsg_syslog_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_syslog *priv;
+
+	priv = devm_kzalloc(&rpdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&rpdev->dev, priv);
+	return 0;
+}
+
+static void rpmsg_syslog_remove(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
+
+	/* flush the buffered log if need */
+	if (priv->next)
+		pr_info("%.*s\n", priv->next, priv->buf);
+	kfree(priv->buf);
+}
+
+static int __maybe_unused rpmsg_syslog_dev_suspend(struct device *dev)
+{
+	struct rpmsg_device *rpdev = dev_get_drvdata(dev);
+	struct rpmsg_syslog_suspend msg = {
+		.command = RPMSG_SYSLOG_SUSPEND,
+	};
+
+	return rpmsg_send(rpdev->ept, &msg, sizeof(msg));
+}
+
+static int __maybe_unused rpmsg_syslog_dev_resume(struct device *dev)
+{
+	struct rpmsg_device *rpdev = dev_get_drvdata(dev);
+	struct rpmsg_syslog_resume msg = {
+		.command = RPMSG_SYSLOG_RESUME,
+	};
+
+	return rpmsg_send(rpdev->ept, &msg, sizeof(msg));
+}
+
+static SIMPLE_DEV_PM_OPS(rpmsg_syslog_pm,
+			rpmsg_syslog_dev_suspend,
+			rpmsg_syslog_dev_resume);
+
+static const struct rpmsg_device_id rpmsg_syslog_id_table[] = {
+	{ .name = "rpmsg-syslog" },
+	{ }
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_syslog_id_table);
+
+static struct rpmsg_driver rpmsg_syslog_driver = {
+	.drv = {
+		.name  = "rpmsg_syslog",
+		.owner = THIS_MODULE,
+		.pm    = &rpmsg_syslog_pm,
+	},
+
+	.id_table = rpmsg_syslog_id_table,
+	.probe    = rpmsg_syslog_probe,
+	.callback = rpmsg_syslog_callback,
+	.remove   = rpmsg_syslog_remove,
+};
+
+module_rpmsg_driver(rpmsg_syslog_driver);
+
+MODULE_ALIAS("rpmsg:rpmsg_syslog");
+MODULE_AUTHOR("Guiding Li <liguiding@pinecone.net>");
+MODULE_DESCRIPTION("rpmsg syslog redirection driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

