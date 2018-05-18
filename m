Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526648324; cv=none;
        d=google.com; s=arc-20160816;
        b=QBlz6PD9e58sXLxNklvu1rBAKV5klj348zSHAryxEFmAueID5cCKKfgaWW9/z2D2E2
         tS8M1DIaqE4alaaPn4jH5KYFHlEKj2RQJCdabEk2C32jzPpfrtvLNCyHSqIasz+x8iUV
         98+x5mE6/RQ1uCWFfoiMIsyJ5/HwU0EYMnpGgC1QMRU75yD3hKeeFC+n/LLbEx3ts7Ew
         lD7ql8ckceQsh7DWVQeqlzieLNnhY9s/UTkBiZyTdEVT1ukaj0VXWoxN2enq+kvGVCsr
         lfquQcJZy+EwoQDaudspi3OALlH51OSJPjEJoRYhoFzFKjvYZKKMZYvj8qAxF2WYgKZ2
         LDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6HlBPomlAuVRvk3x5z8W5AzIqXxlYnmsFohInySHtWw=;
        b=ltByGSVqnmM4gepcvgUXAbjyRtTrjyhi/vA93Ccua5SR1Ds2MC4wIHS+qobLRlMmGz
         AK2sRFwni0BoBx+/LHvQNhxiLWrIXOJiwkmvwn3NMI2r3eAHh62MnwdyJmG+J0v/JCmN
         8FpESFHZapEt867ZUh/osrmG0pXDcSbx3dyk075E+wvjU5fLVg8eCaojRYQ65K71INVs
         kElnUDxpnUitet/7YjI6WomGqNo0hjpF7yZ9IYt/ojzevGREzrLXjhYVyYsWeYgM3DFK
         45YbE10YKE3Aw70MCf4gTFwCz6tE6UYr/xLYTzt7RMAlqVAU3t5hGEVl2p6yijR8BAD/
         xfWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DppVBeL4;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DppVBeL4;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpdX5mDuMe4E1/IMWU6jRQETt7p7eAptccev+OKMMvqL7exoJRau+DLBfNJGaqY996+ydrx4Q==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	bgoswami@codeaurora.org
Cc: robh+dt@kernel.org,
	gregkh@linuxfoundation.org,
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
Subject: [PATCH v9 06/15] ASoC: qdsp6: q6asm: Add q6asm driver
Date: Fri, 18 May 2018 13:56:01 +0100
Message-Id: <20180518125610.26200-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
References: <20180518125610.26200-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600806793284164723?=
X-GMAIL-MSGID: =?utf-8?q?1600806793284164723?=
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
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6asm.c  | 252 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h  |  15 +++
 4 files changed, 272 insertions(+)
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
index 000000000000..585fcfbada6a
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -0,0 +1,252 @@
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
+#include <linux/kref.h>
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
+struct q6asm {
+	struct apr_device *adev;
+	struct device *dev;
+	struct q6core_svc_api_info ainfo;
+	wait_queue_head_t mem_wait;
+	struct platform_device *pcmdev;
+	spinlock_t slock;
+	struct audio_client *session[MAX_SESSIONS + 1];
+	struct platform_device *pdev_dais;
+};
+
+struct audio_client {
+	int session;
+	q6asm_cb cb;
+	void *priv;
+	uint32_t io_mode;
+	struct apr_device *adev;
+	struct mutex cmd_lock;
+	spinlock_t lock;
+	struct kref refcount;
+	wait_queue_head_t cmd_wait;
+	struct aprv2_ibasic_rsp_result_t result;
+	int perf_mode;
+	int stream_id;
+	struct q6asm *q6asm;
+	struct device *dev;
+};
+
+static void q6asm_audio_client_release(struct kref *ref)
+{
+	struct audio_client *ac;
+	struct q6asm *a;
+	unsigned long flags;
+
+	ac = container_of(ref, struct audio_client, refcount);
+	a = ac->q6asm;
+
+	spin_lock_irqsave(&a->slock, flags);
+	a->session[ac->session] = NULL;
+	spin_unlock_irqrestore(&a->slock, flags);
+
+	kfree(ac);
+}
+
+/**
+ * q6asm_audio_client_free() - Freee allocated audio client
+ *
+ * @ac: audio client to free
+ */
+void q6asm_audio_client_free(struct audio_client *ac)
+{
+	kref_put(&ac->refcount, q6asm_audio_client_release);
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
+
+static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
+						   int session_id)
+{
+	struct audio_client *ac = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&a->slock, flags);
+	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
+		dev_err(a->dev, "invalid session: %d\n", session_id);
+		goto err;
+	}
+
+	/* check for valid session */
+	if (!a->session[session_id])
+		goto err;
+	else if (a->session[session_id]->session != session_id)
+		goto err;
+
+	ac = a->session[session_id];
+	kref_get(&ac->refcount);
+err:
+	spin_unlock_irqrestore(&a->slock, flags);
+	return ac;
+}
+
+static int q6asm_srvc_callback(struct apr_device *adev,
+			       struct apr_resp_pkt *data)
+{
+	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct audio_client *ac = NULL;
+	struct apr_hdr *hdr = &data->hdr;
+	uint32_t sid = 0;
+
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
+	kref_put(&ac->refcount, q6asm_audio_client_release);
+
+	return 0;
+}
+
+/**
+ * q6asm_get_session_id() - get session id for audio client
+ *
+ * @c: audio client pointer
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
+ * @stream_id: stream id
+ * @perf_mode: performace mode for this client
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
+	unsigned long flags;
+
+	ac = q6asm_get_audio_client(a, stream_id + 1);
+	if (ac) {
+		dev_err(dev, "Audio Client already active\n");
+		return ac;
+	}
+
+	ac = kzalloc(sizeof(*ac), GFP_KERNEL);
+	if (!ac)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_irqsave(&a->slock, flags);
+	a->session[stream_id + 1] = ac;
+	spin_unlock_irqrestore(&a->slock, flags);
+	ac->session = stream_id + 1;
+	ac->cb = cb;
+	ac->dev = dev;
+	ac->q6asm = a;
+	ac->priv = priv;
+	ac->io_mode = ASM_SYNC_IO_MODE;
+	ac->perf_mode = perf_mode;
+	/* DSP expects stream id from 1 */
+	ac->stream_id = 1;
+	ac->adev = a->adev;
+	kref_init(&ac->refcount);
+
+	init_waitqueue_head(&ac->cmd_wait);
+	mutex_init(&ac->cmd_lock);
+	spin_lock_init(&ac->lock);
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
+	spin_lock_init(&q6asm->slock);
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
index 000000000000..b7816e6384e7
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __Q6_ASM_H__
+#define __Q6_ASM_H__
+
+#define MAX_SESSIONS	8
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
