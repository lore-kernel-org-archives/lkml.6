Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD9C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CB42081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J863Us3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfBFFN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:13:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43603 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfBFFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so2414405pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+JsCVSwcWKdm/aTk0uK6Req0/gJIwLF/l4LfLmjrExk=;
        b=J863Us3kF0HpU7PnNjGaCzU64PX7BiLHvNHdMQtehUriGHYT/qswbqBNAntEfOizsm
         ZbJry+FKWA2BLs1Vwmt9NU1p6tINUqiVmxq20hW3H987+JwEdoIy/IA0to5LWzMeKgY9
         8H35zCW3+Eim9aoW1BmwzV6NIpJ3MAwZZeR9tSiJiwuPPkvRCZ67v3pc6XRLuf0BxB9W
         Mq0FE+OIWin6EGUJ9LYJOP0upSaUkOSb/GlXOTPubdTzE8JY2/zk/FUNHZuGaLhE9Q3D
         rFk05IDNd2TrjSzUAqcTJPm6v9Pl7Zea/79Rl9O5ezkWawr1ekE9ueU8VkizO5StozsP
         lpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+JsCVSwcWKdm/aTk0uK6Req0/gJIwLF/l4LfLmjrExk=;
        b=IlDzSDBq0Gqynak9FqEX2fBm/4WCvA2o27KmZZenVzfkQQGnV8RvIkLBsEaUh5V4f1
         j9/fH9pF+KiwyES8GD0epbSUvKRLWPpfPUCTbyyL+zVifHNBBdyg33IFVKv6l1Fa4wly
         wDmgWKsDZ+7e9EtvniVRkz1tvLiIBG/aTnh5O1DL5nCIaAoxzvPh8e5+LKsyhHUYb+Y9
         UX5+1l4UIUBBMhQEh/0y4rJMLB/s/XNvaEG6P3wMbNwGMMGhtQjX9fl7H3PBFebSAplY
         F/8VCgpN0PCM23GVyVF5ITXK6ISKE2wgJ/W9X2LW4MvvMrq19gQ+aMYMt6C+AwkxZwCF
         pZFA==
X-Gm-Message-State: AHQUAuYV4QhdMHeAEKoU3HwGVaQHpY45JWoM1GSHNRuCFKJ44OdfNm0m
        fFPGD2TLmEGQ/5Fk/kWwxYw5pw==
X-Google-Smtp-Source: AHgI3IZJIrg3zEwzjH0MG4WEGKy0wUhdOzE9C0nUdVQWdsYgj9GoOF6IbHyR5U6qnJqv5dcH5n3CkA==
X-Received: by 2002:a62:3811:: with SMTP id f17mr8864551pfa.206.1549430029882;
        Tue, 05 Feb 2019 21:13:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:49 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] soc: qcom: Add AOSS QMP genpd provider
Date:   Tue,  5 Feb 2019 21:13:33 -0800
Message-Id: <20190206051335.23799-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP genpd provider implements control over power-related
resources related to low-power state associated with the remoteprocs in
the system as well as control over a set of clocks related to debug
hardware in the SoC.

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- Clear outgoing buffer, to avoid sending unitialized stack content to AOP
- Fix domain initialization
- Clean up domains on failure and remove

 drivers/soc/qcom/Kconfig       |   9 ++
 drivers/soc/qcom/Makefile      |   1 +
 drivers/soc/qcom/aoss-qmp-pd.c | 158 +++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 28ab19bf8c98..893b56b70957 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -12,6 +12,15 @@ config QCOM_AOSS_QMP
 	  micro-controller in the AOSS, using QMP, to control certain resource
 	  that are not exposed through RPMh.
 
+config QCOM_AOSS_QMP_PD
+	tristate "Qualcomm AOSS Messaging Power Domain driver"
+	depends on QCOM_AOSS_QMP
+	select PM_GENERIC_DOMAINS
+	help
+	  This driver provides the means of controlling the AOSS's handling of
+	  low-power state for resources related to the remoteproc subsystems as
+	  well as controlling the debug clocks.
+
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 2c04d27fbf9e..16913e73fddf 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	aoss-qmp.o
+obj-$(CONFIG_QCOM_AOSS_QMP_PD) += aoss-qmp-pd.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
diff --git a/drivers/soc/qcom/aoss-qmp-pd.c b/drivers/soc/qcom/aoss-qmp-pd.c
new file mode 100644
index 000000000000..a375abcbe9c7
--- /dev/null
+++ b/drivers/soc/qcom/aoss-qmp-pd.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Ltd
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/soc/qcom/aoss-qmp.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
+
+/* Requests are expected to be 96 bytes long */
+#define AOSS_QMP_PD_MSG_LEN	96
+
+struct qmp_pd {
+	struct qmp *qmp;
+	struct generic_pm_domain pd;
+};
+
+#define to_qmp_pd_resource(res) container_of(res, struct qmp_pd, pd)
+
+struct qmp_pd_resource {
+	const char *name;
+	int (*on)(struct generic_pm_domain *domain);
+	int (*off)(struct generic_pm_domain *domain);
+};
+
+static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
+{
+	char buf[AOSS_QMP_PD_MSG_LEN];
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), "{class: clock, res: %s, val: %d}",
+		 res->pd.name, enable);
+	return qmp_send(res->qmp, buf, sizeof(buf));
+}
+
+static int qmp_pd_clock_on(struct generic_pm_domain *domain)
+{
+	return qmp_pd_clock_toggle(to_qmp_pd_resource(domain), true);
+}
+
+static int qmp_pd_clock_off(struct generic_pm_domain *domain)
+{
+	return qmp_pd_clock_toggle(to_qmp_pd_resource(domain), false);
+}
+
+static int qmp_pd_image_toggle(struct qmp_pd *res, bool enable)
+{
+	char buf[AOSS_QMP_PD_MSG_LEN];
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf),
+		 "{class: image, res: load_state, name: %s, val: %s}",
+		 res->pd.name, enable ? "on" : "off");
+	return qmp_send(res->qmp, buf, sizeof(buf));
+}
+
+static int qmp_pd_image_on(struct generic_pm_domain *domain)
+{
+	return qmp_pd_image_toggle(to_qmp_pd_resource(domain), true);
+}
+
+static int qmp_pd_image_off(struct generic_pm_domain *domain)
+{
+	return qmp_pd_image_toggle(to_qmp_pd_resource(domain), false);
+}
+
+static const struct qmp_pd_resource sdm845_resources[] = {
+	[AOSS_QMP_QDSS_CLK] = { "qdss", qmp_pd_clock_on, qmp_pd_clock_off },
+	[AOSS_QMP_LS_CDSP] = { "cdsp", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_LPASS] = { "adsp", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_MODEM] = { "modem", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_SLPI] = { "slpi", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_SPSS] = { "spss", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_VENUS] = { "venus", qmp_pd_image_on, qmp_pd_image_off },
+};
+
+static int qmp_pd_probe(struct platform_device *pdev)
+{
+	struct genpd_onecell_data *data;
+	struct device *parent = pdev->dev.parent;
+	struct qmp_pd *res;
+	struct qmp *qmp;
+	size_t num = ARRAY_SIZE(sdm845_resources);
+	int ret;
+	int i;
+
+	qmp = dev_get_drvdata(pdev->dev.parent);
+	if (!qmp)
+		return -EINVAL;
+
+	res = devm_kcalloc(&pdev->dev, num, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		res[i].qmp = qmp;
+		res[i].pd.name = sdm845_resources[i].name;
+		res[i].pd.power_on = sdm845_resources[i].on;
+		res[i].pd.power_off = sdm845_resources[i].off;
+
+		ret = pm_genpd_init(&res[i].pd, NULL, true);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to init genpd\n");
+			goto unroll_genpds;
+		}
+
+		data->domains[i] = &res[i].pd;
+	}
+
+	data->num_domains = i;
+
+	platform_set_drvdata(pdev, data);
+
+	return of_genpd_add_provider_onecell(parent->of_node, data);
+
+unroll_genpds:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(data->domains[i]);
+
+	return ret;
+}
+
+static int qmp_pd_remove(struct platform_device *pdev)
+{
+	struct device *parent = pdev->dev.parent;
+	struct genpd_onecell_data *data = platform_get_drvdata(pdev);
+	int i;
+
+	of_genpd_del_provider(parent->of_node);
+
+	for (i = 0; i < data->num_domains; i++)
+		pm_genpd_remove(data->domains[i]);
+
+	return 0;
+}
+
+static struct platform_driver qmp_pd_driver = {
+	.driver = {
+		.name		= "aoss_qmp_pd",
+	},
+	.probe = qmp_pd_probe,
+	.remove = qmp_pd_remove,
+};
+module_platform_driver(qmp_pd_driver);
+
+MODULE_ALIAS("platform:aoss_qmp_pd");
+MODULE_DESCRIPTION("Qualcomm AOSS QMP load-state driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

