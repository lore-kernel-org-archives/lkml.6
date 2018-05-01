Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525176637; cv=none;
        d=google.com; s=arc-20160816;
        b=xNCmZevnnvLiDmgv2/wh+u4U1E7aKaF70g6JFIa/ZZHPzzVJ6TXOtBi6vDKnSa+Put
         SWSGEVDH+YtGEOaw0ClOXB4z3SAM2CN6263kzLnBSKlvJOLbbsefpdPIjeYgrtHgiZCW
         KWN2HNbkRf1KaLNFuaynDmqCJdTodmmgPds4bPMZIC6T2NfD7TYc0oaNChrcGwKGTn0j
         nbn0o9NSkd8JbiAMHaF772p8b+8ruBmgWT/2hoBV2//bizf5rRf6D4mriI2wvY32eRit
         jBZmOiafFU1uCqy9In54KtP25awFyaErGOy8Qjy69KXaduFGKgvbd5t9W3zLd+FXdjk1
         yKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Ht7ya69XtsZKeHlHhnGBWeXy3UEzY1lhmQ7sgfqD5zY=;
        b=eGBDyTjNjA10D++R9lEMCnHrNS4M5eNsK200WAiwaLtS6WY7ysrdUa/c2zyH5v/hge
         Sk8QR2zAErVOy0LL6yA7UZUpbdAw2S52tSo9vM6keI1mixVRZ+dvks+w1+tcqkf9+iiY
         pP5uvEGz2gqCIv0WdGVDlvsSKTCs7asK5RHf8vDBga1vM9VGa694sjZuwEZPj/C3Slu1
         4txGnZWNbtV0XPPxG7Lm4J7EEnrq3qs40A1loeoZCoxv1bd75uqMWN2hBL5HRqPJYkJi
         whVk1KJMnuKCwXJlxlEd8rOZYzUHwx1zDeh7pZiA0dqQ64+lRpA8Si7Sm8mfdePTJuwQ
         t20A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ns2xCCcO;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Ns2xCCcO;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq86ES9kCeBNN+h/8VQl77H8cj8/MlFvqCd4VsqLiR7ULaGwNc1FFYBGh3WdVACav9xMyvu3A==
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
Subject: [PATCH v7 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
Date: Tue,  1 May 2018 13:08:05 +0100
Message-Id: <20180501120820.11016-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263617301455375?=
X-GMAIL-MSGID: =?utf-8?q?1599263617301455375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.

AFE module sits right at the other end of cpu where the codec/audio
devices are connected.

AFE provides abstraced interfaces to both hardware and virtual devices.
Each AFE tx/rx port can be configured to connect to one of the hardware
devices like codec, hdmi, slimbus, i2s and so on. AFE services include
starting, stopping, and if needed, any configurations of the ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6afe.c  | 536 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h  |  35 +++
 4 files changed, 576 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 37ee0d958145..bb0a2afb0563 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -47,11 +47,15 @@ config SND_SOC_QDSP6_COMMON
 config SND_SOC_QDSP6_CORE
 	tristate
 
+config SND_SOC_QDSP6_AFE
+	tristate
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_CORE
+	select SND_SOC_QDSP6_AFE
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 03b8e89c9731..7ff666bd10ca 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
+obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
new file mode 100644
index 000000000000..635c51126dc3
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/soc/qcom/apr.h>
+#include "q6dsp-errno.h"
+#include "q6core.h"
+#include "q6afe.h"
+
+/* AFE CMDs */
+#define AFE_PORT_CMD_DEVICE_START	0x000100E5
+#define AFE_PORT_CMD_DEVICE_STOP	0x000100E6
+#define AFE_PORT_CMD_SET_PARAM_V2	0x000100EF
+#define AFE_SVC_CMD_SET_PARAM		0x000100f3
+#define AFE_PORT_CMDRSP_GET_PARAM_V2	0x00010106
+#define AFE_PARAM_ID_HDMI_CONFIG	0x00010210
+#define AFE_MODULE_AUDIO_DEV_INTERFACE	0x0001020C
+
+/* Port IDs */
+#define AFE_API_VERSION_HDMI_CONFIG	0x1
+#define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+#define TIMEOUT_MS 1000
+#define AFE_CMD_RESP_AVAIL	0
+#define AFE_CMD_RESP_NONE	1
+
+struct q6afe {
+	struct apr_device *apr;
+	struct device *dev;
+	struct q6core_svc_api_info ainfo;
+	struct mutex lock;
+	struct list_head port_list;
+	spinlock_t port_list_lock;
+	struct list_head node;
+	struct platform_device *pdev_dais;
+};
+
+struct afe_port_cmd_device_start {
+	u16 port_id;
+	u16 reserved;
+} __packed;
+
+struct afe_port_cmd_device_stop {
+	u16 port_id;
+	u16 reserved;
+/* Reserved for 32-bit alignment. This field must be set to 0.*/
+} __packed;
+
+struct afe_port_param_data_v2 {
+	u32 module_id;
+	u32 param_id;
+	u16 param_size;
+	u16 reserved;
+} __packed;
+
+struct afe_port_cmd_set_param_v2 {
+	u16 port_id;
+	u16 payload_size;
+	u32 payload_address_lsw;
+	u32 payload_address_msw;
+	u32 mem_map_handle;
+} __packed;
+
+struct afe_param_id_hdmi_multi_chan_audio_cfg {
+	u32 hdmi_cfg_minor_version;
+	u16 datatype;
+	u16 channel_allocation;
+	u32 sample_rate;
+	u16 bit_width;
+	u16 reserved;
+} __packed;
+
+union afe_port_config {
+	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
+} __packed;
+
+struct q6afe_port {
+	wait_queue_head_t wait;
+	union afe_port_config port_cfg;
+	struct aprv2_ibasic_rsp_result_t result;
+	int token;
+	int id;
+	int cfg_type;
+	struct q6afe *afe;
+	struct list_head	node;
+};
+
+struct afe_audioif_config_command {
+	struct apr_hdr hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2 pdata;
+	union afe_port_config pcfg;
+} __packed;
+
+struct afe_port_map {
+	int port_id;
+	int token;
+	int is_rx;
+	int is_dig_pcm;
+};
+
+/**
+ * Mapping between Virtual Port IDs to DSP AFE Port ID
+ * On B Family SoCs DSP Port IDs are consistent across multiple SoCs
+ * on A Family SoCs DSP port IDs are same as virtual Port IDs.
+ **/
+
+static struct afe_port_map port_maps[AFE_PORT_MAX] = {
+	[HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
+};
+
+static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
+{
+	struct q6afe_port *p = NULL;
+	struct q6afe_port *ret = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&afe->port_list_lock, flags);
+	list_for_each_entry(p, &afe->port_list, node)
+		if (p->token == token) {
+			ret = p;
+			break;
+		}
+
+	spin_unlock_irqrestore(&afe->port_list_lock, flags);
+	return ret;
+}
+
+static int q6afe_callback(struct apr_device *adev, struct apr_resp_pkt *data)
+{
+	struct q6afe *afe = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *res;
+	struct apr_hdr *hdr = &data->hdr;
+	struct q6afe_port *port;
+
+	if (!data->payload_size)
+		return 0;
+
+	res = data->payload;
+	switch (hdr->opcode) {
+	case APR_BASIC_RSP_RESULT: {
+		if (res->status) {
+			dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
+				res->opcode, res->status);
+		}
+		switch (res->opcode) {
+		case AFE_PORT_CMD_SET_PARAM_V2:
+		case AFE_PORT_CMD_DEVICE_STOP:
+		case AFE_PORT_CMD_DEVICE_START:
+		case AFE_SVC_CMD_SET_PARAM:
+			port = afe_find_port(afe, hdr->token);
+			if (port) {
+				port->result = *res;
+				wake_up(&port->wait);
+			}
+			break;
+		default:
+			dev_err(afe->dev, "Unknown cmd 0x%x\n",	res->opcode);
+			break;
+		}
+	}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * q6afe_get_port_id() - Get port id from a given port index
+ *
+ * @index: port index
+ *
+ * Return: Will be an negative on error or valid port_id on success
+ */
+int q6afe_get_port_id(int index)
+{
+	if (index < 0 || index > AFE_PORT_MAX)
+		return -EINVAL;
+
+	return port_maps[index].port_id;
+}
+EXPORT_SYMBOL_GPL(q6afe_get_port_id);
+
+static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
+			    struct q6afe_port *port)
+{
+	wait_queue_head_t *wait = &port->wait;
+	struct apr_hdr *hdr = &pkt->hdr;
+	int ret;
+
+	mutex_lock(&afe->lock);
+	port->result.opcode = 0;
+	port->result.status = 0;
+
+	ret = apr_send_pkt(afe->apr, pkt);
+	if (ret < 0) {
+		dev_err(afe->dev, "packet not transmitted (%d)\n", ret);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = wait_event_timeout(*wait, (port->result.opcode == hdr->opcode),
+				 msecs_to_jiffies(TIMEOUT_MS));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+	} else if (port->result.status > 0) {
+		dev_err(afe->dev, "DSP returned error[%x]\n",
+			port->result.status);
+		ret = -EINVAL;
+	} else {
+		ret = 0;
+	}
+
+err:
+	mutex_unlock(&afe->lock);
+
+	return ret;
+}
+
+static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
+				   int param_id, int psize)
+{
+	struct afe_port_cmd_set_param_v2 *param;
+	struct afe_port_param_data_v2 *pdata;
+	struct q6afe *afe = port->afe;
+	struct apr_pkt *pkt;
+	u16 port_id = port->id;
+	int ret, pkt_size;
+	void *p, *pl;
+
+	pkt_size = APR_HDR_SIZE + sizeof(*param) + sizeof(*pdata) + psize;
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	param = p + APR_HDR_SIZE;
+	pdata = p + APR_HDR_SIZE + sizeof(*param);
+	pl = p + APR_HDR_SIZE + sizeof(*param) + sizeof(*pdata);
+	memcpy(pl, data, psize);
+
+	pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					   APR_HDR_LEN(APR_HDR_SIZE),
+					   APR_PKT_VER);
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.token = port->token;
+	pkt->hdr.opcode = AFE_PORT_CMD_SET_PARAM_V2;
+
+	param->port_id = port_id;
+	param->payload_size = sizeof(*pdata) + psize;
+	param->payload_address_lsw = 0x00;
+	param->payload_address_msw = 0x00;
+	param->mem_map_handle = 0x00;
+	pdata->module_id = AFE_MODULE_AUDIO_DEV_INTERFACE;
+	pdata->param_id = param_id;
+	pdata->param_size = psize;
+
+	ret = afe_apr_send_pkt(afe, pkt, port);
+	if (ret)
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+		       port_id, ret);
+
+	kfree(pkt);
+	return ret;
+}
+
+/**
+ * q6afe_port_stop() - Stop a afe port
+ *
+ * @port: Instance of port to stop
+ *
+ * Return: Will be an negative on packet size on success.
+ */
+int q6afe_port_stop(struct q6afe_port *port)
+{
+	struct afe_port_cmd_device_stop *stop;
+	struct q6afe *afe = port->afe;
+	struct apr_pkt *pkt;
+	int port_id = port->id;
+	int ret = 0;
+	int index, pkt_size;
+	void *p;
+
+	port_id = port->id;
+	index = port->token;
+	if (index < 0 || index > AFE_PORT_MAX) {
+		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
+		return -EINVAL;
+	}
+
+	pkt_size = APR_HDR_SIZE + sizeof(*stop);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	stop = p + APR_HDR_SIZE;
+
+	pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					   APR_HDR_LEN(APR_HDR_SIZE),
+					   APR_PKT_VER);
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.token = index;
+	pkt->hdr.opcode = AFE_PORT_CMD_DEVICE_STOP;
+	stop->port_id = port_id;
+	stop->reserved = 0;
+
+	ret = afe_apr_send_pkt(afe, pkt, port);
+	if (ret)
+		dev_err(afe->dev, "AFE close failed %d\n", ret);
+
+	kfree(pkt);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_stop);
+
+/**
+ * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: HDMI configuration for the afe port
+ *
+ */
+void q6afe_hdmi_port_prepare(struct q6afe_port *port,
+			     struct q6afe_hdmi_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->hdmi_multi_ch.hdmi_cfg_minor_version =
+					AFE_API_VERSION_HDMI_CONFIG;
+	pcfg->hdmi_multi_ch.datatype = cfg->datatype;
+	pcfg->hdmi_multi_ch.channel_allocation = cfg->channel_allocation;
+	pcfg->hdmi_multi_ch.sample_rate = cfg->sample_rate;
+	pcfg->hdmi_multi_ch.bit_width = cfg->bit_width;
+}
+EXPORT_SYMBOL_GPL(q6afe_hdmi_port_prepare);
+
+/**
+ * q6afe_port_start() - Start a afe port
+ *
+ * @port: Instance of port to start
+ *
+ * Return: Will be an negative on packet size on success.
+ */
+int q6afe_port_start(struct q6afe_port *port)
+{
+	struct afe_port_cmd_device_start *start;
+	struct q6afe *afe = port->afe;
+	int port_id = port->id;
+	int ret, param_id = port->cfg_type;
+	struct apr_pkt *pkt;
+	int pkt_size;
+	void *p;
+
+	ret  = q6afe_port_set_param_v2(port, &port->port_cfg, param_id,
+				       sizeof(port->port_cfg));
+	if (ret) {
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+			port_id, ret);
+		return ret;
+	}
+
+	pkt_size = APR_HDR_SIZE + sizeof(*start);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	start = p + APR_HDR_SIZE;
+
+	pkt->hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					    APR_HDR_LEN(APR_HDR_SIZE),
+					    APR_PKT_VER);
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.token = port->token;
+	pkt->hdr.opcode = AFE_PORT_CMD_DEVICE_START;
+
+	start->port_id = port_id;
+
+	ret = afe_apr_send_pkt(afe, pkt, port);
+	if (ret)
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+			port_id, ret);
+
+	kfree(pkt);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_start);
+
+/**
+ * q6afe_port_get_from_id() - Get port instance from a port id
+ *
+ * @dev: Pointer to afe child device.
+ * @id: port id
+ *
+ * Return: Will be an error pointer on error or a valid afe port
+ * on success.
+ */
+struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
+{
+	int port_id;
+	struct q6afe *afe = dev_get_drvdata(dev->parent);
+	struct q6afe_port *port;
+	unsigned long flags;
+	int cfg_type;
+
+	if (id < 0 || id > AFE_PORT_MAX) {
+		dev_err(dev, "AFE port token[%d] invalid!\n", id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	port_id = port_maps[id].port_id;
+
+	switch (port_id) {
+	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
+		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
+		break;
+	default:
+		dev_err(dev, "Invalid port id 0x%x\n", port_id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	init_waitqueue_head(&port->wait);
+
+	port->token = id;
+	port->id = port_id;
+	port->afe = afe;
+	port->cfg_type = cfg_type;
+
+	spin_lock_irqsave(&afe->port_list_lock, flags);
+	list_add_tail(&port->node, &afe->port_list);
+	spin_unlock_irqrestore(&afe->port_list_lock, flags);
+
+	return port;
+
+}
+EXPORT_SYMBOL_GPL(q6afe_port_get_from_id);
+
+/**
+ * q6afe_port_put() - Release port reference
+ *
+ * @port: Instance of port to put
+ */
+void q6afe_port_put(struct q6afe_port *port)
+{
+	struct q6afe *afe = port->afe;
+	unsigned long flags;
+
+	spin_lock_irqsave(&afe->port_list_lock, flags);
+	list_del(&port->node);
+	spin_unlock_irqrestore(&afe->port_list_lock, flags);
+	kfree(port);
+}
+EXPORT_SYMBOL_GPL(q6afe_port_put);
+
+static int q6afe_probe(struct apr_device *adev)
+{
+	struct q6afe *afe;
+	struct device *dev = &adev->dev;
+	struct device_node *dais_np;
+
+	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+
+	q6core_get_svc_api_info(adev->svc_id, &afe->ainfo);
+	afe->apr = adev;
+	mutex_init(&afe->lock);
+	afe->dev = dev;
+	INIT_LIST_HEAD(&afe->port_list);
+	spin_lock_init(&afe->port_list_lock);
+
+	dev_set_drvdata(dev, afe);
+
+	dais_np = of_get_child_by_name(dev->of_node, "dais");
+	if (dais_np) {
+		afe->pdev_dais = of_platform_device_create(dais_np,
+							   "q6afe-dai", dev);
+		of_node_put(dais_np);
+	}
+
+	return 0;
+}
+
+static int q6afe_remove(struct apr_device *adev)
+{
+	struct q6afe *afe = dev_get_drvdata(&adev->dev);
+
+	if (afe->pdev_dais)
+		of_platform_device_destroy(&afe->pdev_dais->dev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id q6afe_device_id[]  = {
+	{ .compatible = "qcom,q6afe" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6afe_device_id);
+
+static struct apr_driver qcom_q6afe_driver = {
+	.probe = q6afe_probe,
+	.remove = q6afe_remove,
+	.callback = q6afe_callback,
+	.driver = {
+		.name = "qcom-q6afe",
+		.of_match_table = of_match_ptr(q6afe_device_id),
+
+	},
+};
+
+module_apr_driver(qcom_q6afe_driver);
+MODULE_DESCRIPTION("Q6 Audio Front End");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
new file mode 100644
index 000000000000..3bd991a7c42d
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __Q6AFE_H__
+#define __Q6AFE_H__
+
+#include <dt-bindings/sound/qcom,q6afe.h>
+
+#define AFE_PORT_MAX		48
+
+#define MSM_AFE_PORT_TYPE_RX 0
+#define MSM_AFE_PORT_TYPE_TX 1
+#define AFE_MAX_PORTS AFE_PORT_MAX
+
+struct q6afe_hdmi_cfg {
+	u16                  datatype;
+	u16                  channel_allocation;
+	u32                  sample_rate;
+	u16                  bit_width;
+};
+
+struct q6afe_port_config {
+	struct q6afe_hdmi_cfg hdmi;
+};
+
+struct q6afe_port;
+
+struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id);
+int q6afe_port_start(struct q6afe_port *port);
+int q6afe_port_stop(struct q6afe_port *port);
+void q6afe_port_put(struct q6afe_port *port);
+int q6afe_get_port_id(int index);
+void q6afe_hdmi_port_prepare(struct q6afe_port *port,
+			    struct q6afe_hdmi_cfg *cfg);
+
+#endif /* __Q6AFE_H__ */
-- 
2.16.2
