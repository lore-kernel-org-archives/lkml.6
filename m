Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqw48HMQtvqHSsSdRAL8RBCfSJIwCrlQdDeoz7VG6FM/3qZkw2gByxcfDd2vDIaW4jZkozt
ARC-Seal: i=1; a=rsa-sha256; t=1526575130; cv=none;
        d=google.com; s=arc-20160816;
        b=A8DD+BmmuQvb6HtFZmMiBxY7wHsdsfSrrx1qn2J+QvvnXjX7jg2H2Y1HWRsFwLB7h1
         UKtzHAfe5hPI720a3UOPMj8dNhbLrvnB1POzbA5QsEVTds9IuN3eJ84zQP/KyQrxAgZ2
         3O5oEhL5Dau+QZYkVmBFtzmzqwM2NCLDZRhoXeRt46Zgo9irnSlqdXA0cNTHJachYrtB
         d5IMYbf2GYk+X7mCl5wJNPEan69Ig80JEQXrXrWfVrLtghP5wY4Y0ViZ3d11gLH9fa6Z
         kGLsb3jQSNcPJb3+wW6Wl16Q6HrbfHrlg3WrIi53457T8rA65GWUcxT5+NCjUy7/xmyx
         qFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=OTgTGrmuS7LmDVVfvhuub86c1rhPtz+Yz8ajzUQK2Rs=;
        b=LYIB7Xe4TLaw9mViM4S2hEbwSm3OJNzfFTGfuRMBR8bOOmw1BUy6pSxFPFuTHxRBHe
         tr8rc2YTfRFBvai5RlKluBE33OGfNwsErATd5wkyvciqIZPEWXCNjmyOO42tpdz5x6Bc
         9zlv7E9x+pj/IEztl9sYYSyfnTEI/qQlw8+/XUcY/O/nHGvLas9QPQkNIhL+CdhPCRW9
         WPP2DzMlVVgXHDP5nM2LVgCVXbZSyDQsrU/nQmh/xM0lElxu0nJcEhWpKgcbW5Y4/I2D
         S6setGcY/iA+CnVNgUpFjhiH8DKE2oQA7RnCV1PF1GV4hwqq4vpGN8eHphcTVNCsksvu
         1kPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=ifxroyPG;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=ifxroyPG;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>, andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6core: Add q6core driver" to the asoc tree
In-Reply-To: <20180509125635.5653-9-srinivas.kandagatla@linaro.org>
Message-Id: <20180517163841.133C944007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:38:41 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600730043970759525?=
X-GMAIL-MSGID: =?utf-8?q?1600730043970759525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: q6core: Add q6core driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b73e93e183089176beed8a3f80e5f618a52e02fc Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:19 +0100
Subject: [PATCH] ASoC: qdsp6: q6core: Add q6core driver

This patch adds support to core apr service, which is used to query
status of other static and dynamic services on the dsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6core.c | 380 ++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6core.h |  15 ++
 4 files changed, 400 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b44a9fcd7ed3..37ee0d958145 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -44,10 +44,14 @@ config SND_SOC_APQ8016_SBC
 config SND_SOC_QDSP6_COMMON
 	tristate
 
+config SND_SOC_QDSP6_CORE
+	tristate
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
 	select SND_SOC_QDSP6_COMMON
+	select SND_SOC_QDSP6_CORE
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index accebdb49306..03b8e89c9731 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
+obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
new file mode 100644
index 000000000000..06f03a5fe9bd
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/jiffies.h>
+#include <linux/wait.h>
+#include <linux/soc/qcom/apr.h>
+#include "q6core.h"
+#include "q6dsp-errno.h"
+
+#define ADSP_STATE_READY_TIMEOUT_MS    3000
+#define Q6_READY_TIMEOUT_MS 100
+#define AVCS_CMD_ADSP_EVENT_GET_STATE		0x0001290C
+#define AVCS_CMDRSP_ADSP_EVENT_GET_STATE	0x0001290D
+#define AVCS_GET_VERSIONS       0x00012905
+#define AVCS_GET_VERSIONS_RSP   0x00012906
+#define AVCS_CMD_GET_FWK_VERSION	0x001292c
+#define AVCS_CMDRSP_GET_FWK_VERSION	0x001292d
+
+struct avcs_svc_info {
+	uint32_t service_id;
+	uint32_t version;
+} __packed;
+
+struct avcs_cmdrsp_get_version {
+	uint32_t build_id;
+	uint32_t num_services;
+	struct avcs_svc_info svc_api_info[];
+} __packed;
+
+/* for ADSP2.8 and above */
+struct avcs_svc_api_info {
+	uint32_t service_id;
+	uint32_t api_version;
+	uint32_t api_branch_version;
+} __packed;
+
+struct avcs_cmdrsp_get_fwk_version {
+	uint32_t build_major_version;
+	uint32_t build_minor_version;
+	uint32_t build_branch_version;
+	uint32_t build_subbranch_version;
+	uint32_t num_services;
+	struct avcs_svc_api_info svc_api_info[];
+} __packed;
+
+struct q6core {
+	struct apr_device *adev;
+	wait_queue_head_t wait;
+	uint32_t avcs_state;
+	struct mutex lock;
+	bool resp_received;
+	uint32_t num_services;
+	struct avcs_cmdrsp_get_fwk_version *fwk_version;
+	struct avcs_cmdrsp_get_version *svc_version;
+	bool fwk_version_supported;
+	bool get_state_supported;
+	bool get_version_supported;
+	bool is_version_requested;
+};
+
+static struct q6core *g_core;
+
+static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
+{
+	struct q6core *core = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct apr_hdr *hdr = &data->hdr;
+
+	result = data->payload;
+	switch (hdr->opcode) {
+	case APR_BASIC_RSP_RESULT:{
+		result = data->payload;
+		switch (result->opcode) {
+		case AVCS_GET_VERSIONS:
+			if (result->status == ADSP_EUNSUPPORTED)
+				core->get_version_supported = false;
+			core->resp_received = true;
+			break;
+		case AVCS_CMD_GET_FWK_VERSION:
+			if (result->status == ADSP_EUNSUPPORTED)
+				core->fwk_version_supported = false;
+			core->resp_received = true;
+			break;
+		case AVCS_CMD_ADSP_EVENT_GET_STATE:
+			if (result->status == ADSP_EUNSUPPORTED)
+				core->get_state_supported = false;
+			core->resp_received = true;
+			break;
+		}
+		break;
+	}
+	case AVCS_CMDRSP_GET_FWK_VERSION: {
+		struct avcs_cmdrsp_get_fwk_version *fwk;
+		int bytes;
+
+		fwk = data->payload;
+		bytes = sizeof(*fwk) + fwk->num_services *
+				sizeof(fwk->svc_api_info[0]);
+
+		core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
+		if (!core->fwk_version)
+			return -ENOMEM;
+
+		memcpy(core->fwk_version, data->payload, bytes);
+
+		core->fwk_version_supported = true;
+		core->resp_received = true;
+
+		break;
+	}
+	case AVCS_GET_VERSIONS_RSP: {
+		struct avcs_cmdrsp_get_version *v;
+		int len;
+
+		v = data->payload;
+
+		len = sizeof(*v) + v->num_services * sizeof(v->svc_api_info[0]);
+
+		core->svc_version = kzalloc(len, GFP_ATOMIC);
+		if (!core->svc_version)
+			return -ENOMEM;
+
+		memcpy(core->svc_version, data->payload, len);
+
+		core->get_version_supported = true;
+		core->resp_received = true;
+
+		break;
+	}
+	case AVCS_CMDRSP_ADSP_EVENT_GET_STATE:
+		core->get_state_supported = true;
+		core->avcs_state = result->opcode;
+
+		core->resp_received = true;
+		break;
+	default:
+		dev_err(&adev->dev, "Message id from adsp core svc: 0x%x\n",
+			hdr->opcode);
+		break;
+	}
+
+	if (core->resp_received)
+		wake_up(&core->wait);
+
+	return 0;
+}
+
+static int q6core_get_fwk_versions(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_pkt pkt;
+	int rc;
+
+	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	pkt.hdr.pkt_size = APR_HDR_SIZE;
+	pkt.hdr.opcode = AVCS_CMD_GET_FWK_VERSION;
+
+	rc = apr_send_pkt(adev, &pkt);
+	if (rc < 0)
+		return rc;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+
+		if (!core->fwk_version_supported)
+			return -ENOTSUPP;
+		else
+			return 0;
+	}
+
+
+	return rc;
+}
+
+static int q6core_get_svc_versions(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_pkt pkt;
+	int rc;
+
+	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	pkt.hdr.pkt_size = APR_HDR_SIZE;
+	pkt.hdr.opcode = AVCS_GET_VERSIONS;
+
+	rc = apr_send_pkt(adev, &pkt);
+	if (rc < 0)
+		return rc;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+		return 0;
+	}
+
+	return rc;
+}
+
+static bool __q6core_is_adsp_ready(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_pkt pkt;
+	int rc;
+
+	core->get_state_supported = false;
+
+	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	pkt.hdr.pkt_size = APR_HDR_SIZE;
+	pkt.hdr.opcode = AVCS_CMD_ADSP_EVENT_GET_STATE;
+
+	rc = apr_send_pkt(adev, &pkt);
+	if (rc < 0)
+		return false;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+
+		if (core->avcs_state)
+			return true;
+	}
+
+	/* assume that the adsp is up if we not support this command */
+	if (!core->get_state_supported)
+		return true;
+
+	return false;
+}
+
+/**
+ * q6core_get_svc_api_info() - Get version number of a service.
+ *
+ * @svc_id: service id of the service.
+ * @ainfo: Valid struct pointer to fill svc api information.
+ *
+ * Return: zero on success and error code on failure or unsupported
+ */
+int q6core_get_svc_api_info(int svc_id, struct q6core_svc_api_info *ainfo)
+{
+	int i;
+	int ret = -ENOTSUPP;
+
+	if (!g_core || !ainfo)
+		return 0;
+
+	mutex_lock(&g_core->lock);
+	if (!g_core->is_version_requested) {
+		if (q6core_get_fwk_versions(g_core) == -ENOTSUPP)
+			q6core_get_svc_versions(g_core);
+		g_core->is_version_requested = true;
+	}
+
+	if (g_core->fwk_version_supported) {
+		for (i = 0; i < g_core->fwk_version->num_services; i++) {
+			struct avcs_svc_api_info *info;
+
+			info = &g_core->fwk_version->svc_api_info[i];
+			if (svc_id != info->service_id)
+				continue;
+
+			ainfo->api_version = info->api_version;
+			ainfo->api_branch_version = info->api_branch_version;
+			ret = 0;
+			break;
+		}
+	} else if (g_core->get_version_supported) {
+		for (i = 0; i < g_core->svc_version->num_services; i++) {
+			struct avcs_svc_info *info;
+
+			info = &g_core->svc_version->svc_api_info[i];
+			if (svc_id != info->service_id)
+				continue;
+
+			ainfo->api_version = info->version;
+			ainfo->api_branch_version = 0;
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&g_core->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6core_get_svc_api_info);
+
+/**
+ * q6core_is_adsp_ready() - Get status of adsp
+ *
+ * Return: Will be an true if adsp is ready and false if not.
+ */
+bool q6core_is_adsp_ready(void)
+{
+	unsigned long  timeout;
+	bool ret = false;
+
+	if (!g_core)
+		return false;
+
+	mutex_lock(&g_core->lock);
+	timeout = jiffies + msecs_to_jiffies(ADSP_STATE_READY_TIMEOUT_MS);
+	for (;;) {
+		if (__q6core_is_adsp_ready(g_core)) {
+			ret = true;
+			break;
+		}
+
+		if (!time_after(timeout, jiffies)) {
+			ret = false;
+			break;
+		}
+	}
+
+	mutex_unlock(&g_core->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6core_is_adsp_ready);
+
+static int q6core_probe(struct apr_device *adev)
+{
+	g_core = kzalloc(sizeof(*g_core), GFP_KERNEL);
+	if (!g_core)
+		return -ENOMEM;
+
+	dev_set_drvdata(&adev->dev, g_core);
+
+	mutex_init(&g_core->lock);
+	g_core->adev = adev;
+	init_waitqueue_head(&g_core->wait);
+	return 0;
+}
+
+static int q6core_exit(struct apr_device *adev)
+{
+	struct q6core *core = dev_get_drvdata(&adev->dev);
+
+	if (core->fwk_version_supported)
+		kfree(core->fwk_version);
+	if (core->get_version_supported)
+		kfree(core->svc_version);
+
+	g_core = NULL;
+	kfree(core);
+
+	return 0;
+}
+
+static const struct of_device_id q6core_device_id[]  = {
+	{ .compatible = "qcom,q6core" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6core_device_id);
+
+static struct apr_driver qcom_q6core_driver = {
+	.probe = q6core_probe,
+	.remove = q6core_exit,
+	.callback = q6core_callback,
+	.driver = {
+		.name = "qcom-q6core",
+		.of_match_table = of_match_ptr(q6core_device_id),
+	},
+};
+
+module_apr_driver(qcom_q6core_driver);
+MODULE_DESCRIPTION("q6 core");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6core.h b/sound/soc/qcom/qdsp6/q6core.h
new file mode 100644
index 000000000000..4105b1d730be
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6core.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __Q6CORE_H__
+#define __Q6CORE_H__
+
+struct q6core_svc_api_info {
+	uint32_t service_id;
+	uint32_t api_version;
+	uint32_t api_branch_version;
+};
+
+bool q6core_is_adsp_ready(void);
+int q6core_get_svc_api_info(int svc_id, struct q6core_svc_api_info *ainfo);
+
+#endif /* __Q6CORE_H__ */
-- 
2.17.0
