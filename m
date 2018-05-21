Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpgfh91YIEBtovFvLVBIL+xITWeezmNBbrn5BzTNQY/mmrVDvmt0VUBBxGIZmcITX53VBrU
ARC-Seal: i=1; a=rsa-sha256; t=1526917774; cv=none;
        d=google.com; s=arc-20160816;
        b=ahAR860X1CqDU2z5Zz7IK17bmqizLBBbbtRoWbJQ/rJWRd9/lciRZn/ZKK42HqmG1W
         hPOyL17pfO64Q2dZQEE8E1S4Ow5dtqTtDNQit1iKQufEJmX432Wd+DCkarSZMPD6R/2C
         RSCjbaT91VQt4od3RlY5hb84CCWnOJjMu4GEgc8ahwWAFYmWMfXrQhw2gcEp4GLyo3P6
         okuzxzidMHdf6Mp8luGwDU6moWTa6M5MnIVhub6stqGBr2EZXNJNeHLuE7RcihHtprj4
         EnDq3MEtLVkpwylbt7WHhXjsJFg7mhbkGlJZzMpcb5ES+RGwy9+qyHwhokF9eBbSctMH
         1afA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=BYYCLxzfoq81621auBOzfYRAAQL9F1sGUrT299tmfRg=;
        b=mgOyqpXMb5e+1EsmB+EEWt4UK6QC2qj4HkGs7TUO988iZxq4hsQ3rq6JzFw0YHLvvR
         TqwIZBVr/oo1N3Ha0Jv8L38vYg7O6vHCFHusmjJ64Ifyqgb6m6PMx0vAkmFO3nz0cF0/
         k6kNwyDYl10FZgaxscNbfvqdL6R1f2qUZMkw9P7FpmY5yNsMDYLPObRY9qZKpxKEqVsK
         fLO7EHfAVnG5fD7iOxCy2D1ed3mO5E25153vx3IJipl1g91aqLdeJGAPvHmp9h8WpwwK
         chj6hiY0q6f38DaCJ62OrHzN576w3qBQWChgkwNWYbWyWFxglyeTok63XdZ8PM1XcZhk
         mDlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=FxeRRn4/;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=FxeRRn4/;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: qdafe: Add SLIMBus port Support" to the asoc tree
In-Reply-To: <20180518125610.26200-3-srinivas.kandagatla@linaro.org>
Message-Id: <E1fKn41-0007Qf-VB@debutante>
Date: Mon, 21 May 2018 16:49:33 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089332853751266?=
X-GMAIL-MSGID: =?utf-8?q?1601089332853751266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: qdafe: Add SLIMBus port Support

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

>From 4d430d5a0e9d4d065e0447366caf48d5f580d7fb Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 18 May 2018 13:55:57 +0100
Subject: [PATCH] ASoC: qdsp6: qdafe: Add SLIMBus port Support

This patch adds support to 6 SLIMBus AFE ports, which are used as
backend dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 129 +++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |  14 ++++
 2 files changed, 143 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 5e0032c13aab..735c0b5eb55a 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -28,9 +28,45 @@
 #define AFE_PARAM_ID_HDMI_CONFIG	0x00010210
 #define AFE_MODULE_AUDIO_DEV_INTERFACE	0x0001020C
 
+#define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
+
+#define AFE_PARAM_ID_SLIMBUS_CONFIG    0x00010212
+
 /* Port IDs */
 #define AFE_API_VERSION_HDMI_CONFIG	0x1
 #define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+
+#define AFE_API_VERSION_SLIMBUS_CONFIG 0x1
+
+/* SLIMbus Rx port on channel 0. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX      0x4000
+/* SLIMbus Tx port on channel 0. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_TX      0x4001
+/* SLIMbus Rx port on channel 1. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX      0x4002
+/* SLIMbus Tx port on channel 1. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_TX      0x4003
+/* SLIMbus Rx port on channel 2. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX      0x4004
+/* SLIMbus Tx port on channel 2. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_TX      0x4005
+/* SLIMbus Rx port on channel 3. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_RX      0x4006
+/* SLIMbus Tx port on channel 3. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_TX      0x4007
+/* SLIMbus Rx port on channel 4. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_RX      0x4008
+/* SLIMbus Tx port on channel 4. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_TX      0x4009
+/* SLIMbus Rx port on channel 5. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX      0x400a
+/* SLIMbus Tx port on channel 5. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_TX      0x400b
+/* SLIMbus Rx port on channel 6. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX      0x400c
+/* SLIMbus Tx port on channel 6. */
+#define AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_TX      0x400d
+
 #define TIMEOUT_MS 1000
 #define AFE_CMD_RESP_AVAIL	0
 #define AFE_CMD_RESP_NONE	1
@@ -80,8 +116,53 @@ struct afe_param_id_hdmi_multi_chan_audio_cfg {
 	u16 reserved;
 } __packed;
 
+struct afe_param_id_slimbus_cfg {
+	u32                  sb_cfg_minor_version;
+/* Minor version used for tracking the version of the SLIMBUS
+ * configuration interface.
+ * Supported values: #AFE_API_VERSION_SLIMBUS_CONFIG
+ */
+
+	u16                  slimbus_dev_id;
+/* SLIMbus hardware device ID, which is required to handle
+ * multiple SLIMbus hardware blocks.
+ * Supported values: - #AFE_SLIMBUS_DEVICE_1 - #AFE_SLIMBUS_DEVICE_2
+ */
+	u16                  bit_width;
+/* Bit width of the sample.
+ * Supported values: 16, 24
+ */
+	u16                  data_format;
+/* Data format supported by the SLIMbus hardware. The default is
+ * 0 (#AFE_SB_DATA_FORMAT_NOT_INDICATED), which indicates the
+ * hardware does not perform any format conversions before the data
+ * transfer.
+ */
+	u16                  num_channels;
+/* Number of channels.
+ * Supported values: 1 to #AFE_PORT_MAX_AUDIO_CHAN_CNT
+ */
+	u8  shared_ch_mapping[AFE_PORT_MAX_AUDIO_CHAN_CNT];
+/* Mapping of shared channel IDs (128 to 255) to which the
+ * master port is to be connected.
+ * Shared_channel_mapping[i] represents the shared channel assigned
+ * for audio channel i in multichannel audio data.
+ */
+	u32              sample_rate;
+/* Sampling rate of the port.
+ * Supported values:
+ * - #AFE_PORT_SAMPLE_RATE_8K
+ * - #AFE_PORT_SAMPLE_RATE_16K
+ * - #AFE_PORT_SAMPLE_RATE_48K
+ * - #AFE_PORT_SAMPLE_RATE_96K
+ * - #AFE_PORT_SAMPLE_RATE_192K
+ */
+} __packed;
+
+
 union afe_port_config {
 	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
+	struct afe_param_id_slimbus_cfg           slim_cfg;
 } __packed;
 
 struct q6afe_port {
@@ -111,6 +192,20 @@ struct afe_port_map {
 
 static struct afe_port_map port_maps[AFE_PORT_MAX] = {
 	[HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
+	[SLIMBUS_0_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX,
+				SLIMBUS_0_RX, 1, 1},
+	[SLIMBUS_1_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX,
+				SLIMBUS_1_RX, 1, 1},
+	[SLIMBUS_2_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX,
+				SLIMBUS_2_RX, 1, 1},
+	[SLIMBUS_3_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_RX,
+				SLIMBUS_3_RX, 1, 1},
+	[SLIMBUS_4_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_RX,
+				SLIMBUS_4_RX, 1, 1},
+	[SLIMBUS_5_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX,
+				SLIMBUS_5_RX, 1, 1},
+	[SLIMBUS_6_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX,
+				SLIMBUS_6_RX, 1, 1},
 };
 
 static void q6afe_port_free(struct kref *ref)
@@ -340,6 +435,31 @@ int q6afe_port_stop(struct q6afe_port *port)
 }
 EXPORT_SYMBOL_GPL(q6afe_port_stop);
 
+/**
+ * q6afe_slim_port_prepare() - Prepare slim afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: SLIM configuration for the afe port
+ *
+ */
+void q6afe_slim_port_prepare(struct q6afe_port *port,
+			     struct q6afe_slim_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->slim_cfg.sb_cfg_minor_version = AFE_API_VERSION_SLIMBUS_CONFIG;
+	pcfg->slim_cfg.sample_rate = cfg->sample_rate;
+	pcfg->slim_cfg.bit_width = cfg->bit_width;
+	pcfg->slim_cfg.num_channels = cfg->num_channels;
+	pcfg->slim_cfg.data_format = cfg->data_format;
+	pcfg->slim_cfg.shared_ch_mapping[0] = cfg->ch_mapping[0];
+	pcfg->slim_cfg.shared_ch_mapping[1] = cfg->ch_mapping[1];
+	pcfg->slim_cfg.shared_ch_mapping[2] = cfg->ch_mapping[2];
+	pcfg->slim_cfg.shared_ch_mapping[3] = cfg->ch_mapping[3];
+
+}
+EXPORT_SYMBOL_GPL(q6afe_slim_port_prepare);
+
 /**
  * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
  *
@@ -451,6 +571,15 @@ struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
 	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
 		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
 		break;
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_1_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_2_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_3_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_4_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_5_RX:
+	case AFE_PORT_ID_SLIMBUS_MULTI_CHAN_6_RX:
+		cfg_type = AFE_PARAM_ID_SLIMBUS_CONFIG;
+		break;
 	default:
 		dev_err(dev, "Invalid port id 0x%x\n", port_id);
 		return ERR_PTR(-EINVAL);
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 3bd991a7c42d..5659966c6b1e 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -11,6 +11,9 @@
 #define MSM_AFE_PORT_TYPE_TX 1
 #define AFE_MAX_PORTS AFE_PORT_MAX
 
+#define AFE_MAX_CHAN_COUNT	8
+#define AFE_PORT_MAX_AUDIO_CHAN_CNT	0x8
+
 struct q6afe_hdmi_cfg {
 	u16                  datatype;
 	u16                  channel_allocation;
@@ -18,8 +21,17 @@ struct q6afe_hdmi_cfg {
 	u16                  bit_width;
 };
 
+struct q6afe_slim_cfg {
+	u32	sample_rate;
+	u16	bit_width;
+	u16	data_format;
+	u16	num_channels;
+	u8	ch_mapping[AFE_MAX_CHAN_COUNT];
+};
+
 struct q6afe_port_config {
 	struct q6afe_hdmi_cfg hdmi;
+	struct q6afe_slim_cfg slim;
 };
 
 struct q6afe_port;
@@ -31,5 +43,7 @@ void q6afe_port_put(struct q6afe_port *port);
 int q6afe_get_port_id(int index);
 void q6afe_hdmi_port_prepare(struct q6afe_port *port,
 			    struct q6afe_hdmi_cfg *cfg);
+void q6afe_slim_port_prepare(struct q6afe_port *port,
+			  struct q6afe_slim_cfg *cfg);
 
 #endif /* __Q6AFE_H__ */
-- 
2.17.0
