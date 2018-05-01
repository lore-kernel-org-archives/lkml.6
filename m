Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176644; cv=none;
        d=google.com; s=arc-20160816;
        b=LGXiteXszbS70M/fFjurIzjxPdjyA/GJNnz96rsAPZkNA23yfjoW/yzhLI6a8iEN8K
         QErNZSzjBqXWxpC4T8E1Q+iSGQ0EVwhcUGlbrDLUfC/GNtsBR4ktzhcopVOzO598cjXc
         T2nmGIJqNxLl/AE5EOKq0JAP2u7l9Na2acX1mtJthF4OqgfjaSuexFno3mFnj5pbbLBs
         k7lQ+D7G0oj6NRI4t865bRfo4EkUyomXkTlzCOzz4rdr56zzUQ0GtSzoXnEuM0Mjb5TK
         BucoKZoBZUyW49kyM3kKCsqJ6IiYxLQnH3EI89FhCuCPkcTrECRRCpHAITEqsY4b+WbH
         qS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=9IFZLuZWjux0X4rVtxe1J/YXK4g+tpAxGV07+7CqM6Q=;
        b=iXEm+OBZkVCaASzDf6y5rHTKHr0FhMmzy6jxv2AOB7eQrtZrRBV32JINy+qOkLSvyb
         MBj25adMVYlfhG2XmgAcje9WhfvcaJZS5G1m0GDdBG6laHiaHlJkQNNuB31fsRaGxs0K
         IX/GQ2WAkrWbqhFX30Er2eXzcz4mN3ZXLyIsAMXcZCzDKaJa6LRTAqMc0G869QexFnaB
         p4y3CZTBp/+6+sPkyuP3WeYxrfOQWbWAVClD+oIOzYc315xyU6e98OBvqvjt6LfoNjXJ
         j/Oz25qYuAw5du+ctD5Cz3+/hFMZP0RHxK0/7adEnb5T7u8M+GYa3Y89wHwPLASpHnji
         Zjmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C8FZm/L+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=C8FZm/L+;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp3BA+7jIRM8lahkqIW7iuI4doqceSKfgDzS27oBFJpm202wWIdrPVZGbeiY9fYsLnYo026Sw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 14/24] ASoC: qdsp6: q6asm: Add q6asm driver
Date: Tue,  1 May 2018 13:08:10 +0100
Message-Id: <20180501120820.11016-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263625649235845?=
X-GMAIL-MSGID: =?utf-8?q?1599263625649235845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
as playback/capture. ASM provides top control functions like
Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
decoder and also provides POPP dynamic services.

This patch adds support to basic features to allow hdmi playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6asm.c  | 215 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h  |  15 +++
 4 files changed, 235 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 971127edbc23..941774abd94f 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -53,6 +53,9 @@ config SND_SOC_QDSP6_AFE
 config SND_SOC_QDSP6_ADM
 	tristate
 
+config SND_SOC_QDSP6_ASM
+	tristate
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
@@ -60,6 +63,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_CORE
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_ADM
+	select SND_SOC_QDSP6_ASM
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 95cdb3a12694..01d9dcf3375c 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
new file mode 100644
index 000000000000..c9526d2e59d2
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/device.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include "q6asm.h"
+#include "q6core.h"
+#include "q6dsp-errno.h"
+#include "q6dsp-common.h"
+
+#define ASM_SYNC_IO_MODE		0x0001
+#define ASM_ASYNC_IO_MODE		0x0002
+#define ASM_TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
+#define ASM_TUN_WRITE_IO_MODE		0x0008	/* tunnel read write mode */
+
+struct audio_client {
+	int session;
+	q6asm_cb cb;
+	void *priv;
+	uint32_t io_mode;
+	struct apr_device *adev;
+	struct mutex lock;
+	spinlock_t buf_lock;
+	wait_queue_head_t cmd_wait;
+	struct aprv2_ibasic_rsp_result_t result;
+	int perf_mode;
+	int stream_id;
+	struct device *dev;
+};
+
+struct q6asm {
+	struct apr_device *adev;
+	struct device *dev;
+	struct q6core_svc_api_info ainfo;
+	wait_queue_head_t mem_wait;
+	struct platform_device *pcmdev;
+	struct audio_client *session[MAX_SESSIONS + 1];
+	struct platform_device *pdev_dais;
+};
+
+/**
+ * q6asm_audio_client_free() - Freee allocated audio client
+ *
+ * @ac: audio client to free
+ */
+void q6asm_audio_client_free(struct audio_client *ac)
+{
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+
+	a->session[ac->session] = NULL;
+	kfree(ac);
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
+
+static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
+						   int session_id)
+{
+	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
+		dev_err(a->dev, "invalid session: %d\n", session_id);
+		return NULL;
+	}
+
+	if (!a->session[session_id]) {
+		dev_err(a->dev, "session not active: %d\n", session_id);
+		return NULL;
+	}
+
+	return a->session[session_id];
+}
+
+static int q6asm_srvc_callback(struct apr_device *adev,
+			       struct apr_resp_pkt *data)
+{
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct audio_client *ac = NULL;
+	struct apr_hdr *hdr = &data->hdr;
+	uint32_t sid = 0;
+
+	result = data->payload;
+	sid = (hdr->token >> 8) & 0x0F;
+	ac = q6asm_get_audio_client(q6asm, sid);
+	if (!ac) {
+		dev_err(&adev->dev, "Audio Client not active\n");
+		return 0;
+	}
+
+	if (ac->cb)
+		ac->cb(hdr->opcode, hdr->token, data->payload, ac->priv);
+
+	return 0;
+}
+
+/**
+ * q6asm_get_session_id() - get session id for audio client
+ *
+ * @ac: audio client pointer
+ *
+ * Return: Will be an session id of the audio client.
+ */
+int q6asm_get_session_id(struct audio_client *c)
+{
+	return c->session;
+}
+EXPORT_SYMBOL_GPL(q6asm_get_session_id);
+
+/**
+ * q6asm_audio_client_alloc() - Allocate a new audio client
+ *
+ * @dev: Pointer to asm child device.
+ * @cb: event callback.
+ * @priv: private data associated with this client.
+ *
+ * Return: Will be an error pointer on error or a valid audio client
+ * on success.
+ */
+struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
+					      void *priv, int stream_id,
+					      int perf_mode)
+{
+	struct q6asm *a = dev_get_drvdata(dev->parent);
+	struct audio_client *ac;
+
+	if (stream_id + 1 > MAX_SESSIONS)
+		return ERR_PTR(-EINVAL);
+
+	ac = kzalloc(sizeof(*ac), GFP_KERNEL);
+	if (!ac)
+		return ERR_PTR(-ENOMEM);
+
+	a->session[stream_id + 1] = ac;
+	ac->session = stream_id + 1;
+	ac->cb = cb;
+	ac->dev = dev;
+	ac->priv = priv;
+	ac->io_mode = ASM_SYNC_IO_MODE;
+	ac->perf_mode = perf_mode;
+	/* DSP expects stream id from 1 */
+	ac->stream_id = 1;
+	ac->adev = a->adev;
+
+	init_waitqueue_head(&ac->cmd_wait);
+	mutex_init(&ac->lock);
+	spin_lock_init(&ac->buf_lock);
+
+	return ac;
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
+
+
+static int q6asm_probe(struct apr_device *adev)
+{
+	struct device *dev = &adev->dev;
+	struct device_node *dais_np;
+	struct q6asm *q6asm;
+
+	q6asm = devm_kzalloc(dev, sizeof(*q6asm), GFP_KERNEL);
+	if (!q6asm)
+		return -ENOMEM;
+
+	q6core_get_svc_api_info(adev->svc_id, &q6asm->ainfo);
+
+	q6asm->dev = dev;
+	q6asm->adev = adev;
+	init_waitqueue_head(&q6asm->mem_wait);
+	dev_set_drvdata(dev, q6asm);
+
+	dais_np = of_get_child_by_name(dev->of_node, "dais");
+	if (dais_np) {
+		q6asm->pdev_dais = of_platform_device_create(dais_np,
+							   "q6asm-dai", dev);
+		of_node_put(dais_np);
+	}
+
+	return 0;
+}
+
+static int q6asm_remove(struct apr_device *adev)
+{
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+
+	if (q6asm->pdev_dais)
+		of_platform_device_destroy(&q6asm->pdev_dais->dev, NULL);
+
+	return 0;
+}
+static const struct of_device_id q6asm_device_id[]  = {
+	{ .compatible = "qcom,q6asm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6asm_device_id);
+
+static struct apr_driver qcom_q6asm_driver = {
+	.probe = q6asm_probe,
+	.remove = q6asm_remove,
+	.callback = q6asm_srvc_callback,
+	.driver = {
+		.name = "qcom-q6asm",
+		.of_match_table = of_match_ptr(q6asm_device_id),
+	},
+};
+
+module_apr_driver(qcom_q6asm_driver);
+MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
new file mode 100644
index 000000000000..92cc0efaa2c8
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __Q6_ASM_H__
+#define __Q6_ASM_H__
+
+#define MAX_SESSIONS	16
+
+typedef void (*q6asm_cb) (uint32_t opcode, uint32_t token,
+			  void *payload, void *priv);
+struct audio_client;
+struct audio_client *q6asm_audio_client_alloc(struct device *dev,
+					      q6asm_cb cb, void *priv,
+					      int session_id, int perf_mode);
+void q6asm_audio_client_free(struct audio_client *ac);
+int q6asm_get_session_id(struct audio_client *ac);
+#endif /* __Q6_ASM_H__ */
-- 
2.16.2
