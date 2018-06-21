Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ACDC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF96208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMtlJXR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF96208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeFUNmj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:42:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42215 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeFUNmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:42:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id w10-v6so3255088wrk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FVj1PFDSUplHQprKfdh9zQbbX64Q7GUqY2bfrwLcNSU=;
        b=KMtlJXR5PVmYnMALflr2zilXb2VLSgKSqKpZZh/eqpNlPld3BECB9iThTSxG0IjBC8
         qGr3omtR5gZKA6tOWWQdG3PE1z614FnlvxleegTQfXwSCo6LFTTrAmNTEKCU5AlyxeCd
         mA6Oyka9f4SQC84ymdulvixK0RZoE4ijDe4lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FVj1PFDSUplHQprKfdh9zQbbX64Q7GUqY2bfrwLcNSU=;
        b=jX7Y//OgzsQVd//mzMSyvqiil4juGrTa4swKCk5LiCAL2UlQoI2p9yZRRZkrOOlsL4
         zhG11RhRDNd7mbk8uMidgKWE55bPalYE5tMPAvkEAa806Ipnw1l1zS0ZFwESVcy8Z3ZM
         LJtoyPyau6+OK4/apwoSLjNzP/mqz7gy0N9Elhhxcqsl0/eQ78pzlKHnEdEZ1naAUwg/
         A5iQwYEk2lFM/Xe96O/DBNtEZtrTbzHRLPiJQopGKI20pXvIn9ywIfsRBYEPT2SZI75n
         eDrYhfyCdDXO/rfyGKw/OnWP7ryCpxxtlthEKLDS6iF0WFFUcvfr9HocMv5qy8gm49hm
         kzdg==
X-Gm-Message-State: APt69E29LNnnWlPkkf2HGXYjDhI+8+h8BC4aUUJJ789FULuYGlxze4pi
        pdxrnNIwHu9CPSrmtONUwDuM/kjKk5Q=
X-Google-Smtp-Source: ADUXVKJqXV34vKVyRyoUhZe0JHBm0fKirVFzWlBoTfUM1VG/iwcXCmDdhNF4sq2Jl1mL8tIHuBut9A==
X-Received: by 2002:adf:a35b:: with SMTP id d27-v6mr5455884wrb.189.1529588542759;
        Thu, 21 Jun 2018 06:42:22 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r2-v6sm4797513wrq.55.2018.06.21.06.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jun 2018 06:42:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, broonie@kernel.org
Cc:     sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: stream: add stream support
Date:   Thu, 21 Jun 2018 14:40:08 +0100
Message-Id: <20180621134009.27116-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to SLIMbus stream apis for slimbus device.
SLIMbus streaming involves adding support to Data Channel Management and
channel Reconfiguration Messages to slim core plus few stream apis.
From slim device side the apis are very simple mostly inline with other
stream apis.

Currently it only supports Isochronous and Push/Pull transport protocols,
which are sufficient for audio use cases.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/driver-api/slimbus.rst |   5 +
 drivers/slimbus/Makefile             |   2 +-
 drivers/slimbus/core.c               |   2 +
 drivers/slimbus/slimbus.h            | 206 +++++++++++++++
 drivers/slimbus/stream.c             | 493 +++++++++++++++++++++++++++++++++++
 include/linux/slimbus.h              |  56 ++++
 6 files changed, 763 insertions(+), 1 deletion(-)
 create mode 100644 drivers/slimbus/stream.c

diff --git a/Documentation/driver-api/slimbus.rst b/Documentation/driver-api/slimbus.rst
index a97449cf603a..410eec79b2a1 100644
--- a/Documentation/driver-api/slimbus.rst
+++ b/Documentation/driver-api/slimbus.rst
@@ -125,3 +125,8 @@ Messaging APIs:
 ~~~~~~~~~~~~~~~
 .. kernel-doc:: drivers/slimbus/messaging.c
    :export:
+
+Streaming APIs:
+~~~~~~~~~~~~~~~
+.. kernel-doc:: drivers/slimbus/stream.c
+   :export:
diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
index c78c6e16c2df..d9aa011b6804 100644
--- a/drivers/slimbus/Makefile
+++ b/drivers/slimbus/Makefile
@@ -3,7 +3,7 @@
 # Makefile for kernel SLIMbus framework.
 #
 obj-$(CONFIG_SLIMBUS)			+= slimbus.o
-slimbus-y				:= core.o messaging.o sched.o
+slimbus-y				:= core.o messaging.o sched.o stream.o
 
 #Controllers
 obj-$(CONFIG_SLIM_QCOM_CTRL)		+= slim-qcom-ctrl.o
diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 88248a4ecad9..95b00d28ad6e 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -114,6 +114,8 @@ static int slim_add_device(struct slim_controller *ctrl,
 	sbdev->dev.release = slim_dev_release;
 	sbdev->dev.driver = NULL;
 	sbdev->ctrl = ctrl;
+	INIT_LIST_HEAD(&sbdev->stream_list);
+	spin_lock_init(&sbdev->stream_list_lock);
 
 	if (node)
 		sbdev->dev.of_node = of_node_get(node);
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 63229e8cd050..d0b3469b7de7 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -45,9 +45,20 @@
 #define SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS       0x2
 #define SLIM_MSG_MC_REPORT_ABSENT                0xF
 
+/* Data channel management messages */
+#define SLIM_MSG_MC_CONNECT_SOURCE		0x10
+#define SLIM_MSG_MC_CONNECT_SINK		0x11
+#define SLIM_MSG_MC_DISCONNECT_PORT		0x14
+#define SLIM_MSG_MC_CHANGE_CONTENT		0x18
+
 /* Clock pause Reconfiguration messages */
 #define SLIM_MSG_MC_BEGIN_RECONFIGURATION        0x40
 #define SLIM_MSG_MC_NEXT_PAUSE_CLOCK             0x4A
+#define SLIM_MSG_MC_NEXT_DEFINE_CHANNEL          0x50
+#define SLIM_MSG_MC_NEXT_DEFINE_CONTENT          0x51
+#define SLIM_MSG_MC_NEXT_ACTIVATE_CHANNEL        0x54
+#define SLIM_MSG_MC_NEXT_DEACTIVATE_CHANNEL      0x55
+#define SLIM_MSG_MC_NEXT_REMOVE_CHANNEL          0x58
 #define SLIM_MSG_MC_RECONFIGURE_NOW              0x5F
 
 /*
@@ -69,7 +80,15 @@
 /* Standard values per SLIMbus spec needed by controllers and devices */
 #define SLIM_MAX_CLK_GEAR		10
 #define SLIM_MIN_CLK_GEAR		1
+#define SLIM_SLOT_LEN_BITS		4
+
+/* Indicate that the frequency of the flow and the bus frequency are locked */
+#define SLIM_CHANNEL_CONTENT_FL		BIT(7)
 
+/* Standard values per SLIMbus spec needed by controllers and devices */
+#define SLIM_CL_PER_SUPERFRAME		6144
+#define SLIM_SLOTS_PER_SUPERFRAME	(SLIM_CL_PER_SUPERFRAME >> 2)
+#define SLIM_SL_PER_SUPERFRAME		(SLIM_CL_PER_SUPERFRAME >> 2)
 /* Manager's logical address is set to 0xFF per spec */
 #define SLIM_LA_MANAGER 0xFF
 
@@ -167,6 +186,191 @@ struct slim_sched {
 	struct mutex		m_reconf;
 };
 
+/**
+ * enum slim_port_direction: SLIMbus port direction
+ * @SLIM_PORT_SINK: SLIMbus port is a sink
+ * @SLIM_PORT_SOURCE: SLIMbus port is a source
+ */
+enum slim_port_direction {
+	SLIM_PORT_SINK = 0,
+	SLIM_PORT_SOURCE,
+};
+/**
+ * enum slim_port_state: SLIMbus Port/Endpoint state machine
+ *	according to SLIMbus Spec 2.0
+ * @SLIM_PORT_DISCONNECTED: SLIMbus port is disconnected
+ *	entered from Unconfigure/configured state after
+ *	DISCONNECT_PORT or REMOVE_CHANNEL core command
+ * @SLIM_PORT_UNCONFIGURED: SLIMbus port is in unconfigured state.
+ *	entered from disconnect state after CONNECT_SOURCE/SINK core command
+ * @SLIM_PORT_CONFIGURED: SLIMbus port is in configured state.
+ *	entered from unconfigured state after DEFINE_CHANNEL, DEFINE_CONTENT
+ *	and ACTIVATE_CHANNEL core commands. Ready for data transmission.
+ */
+enum slim_port_state {
+	SLIM_PORT_DISCONNECTED = 0,
+	SLIM_PORT_UNCONFIGURED,
+	SLIM_PORT_CONFIGURED,
+};
+
+/**
+ * enum slim_channel_state: SLIMbus channel state machine used by core.
+ * @SLIM_CH_STATE_DISCONNECTED: SLIMbus channel is disconnected
+ * @SLIM_CH_STATE_ALLOCATED: SLIMbus channel is allocated
+ * @SLIM_CH_STATE_ASSOCIATED: SLIMbus channel is associated with port
+ * @SLIM_CH_STATE_DEFINED: SLIMbus channel parameters are defined
+ * @SLIM_CH_STATE_CONTENT_DEFINED: SLIMbus channel content is defined
+ * @SLIM_CH_STATE_ACTIVE: SLIMbus channel is active and ready for data
+ * @SLIM_CH_STATE_REMOVED: SLIMbus channel is inactive and removed
+ */
+enum slim_channel_state {
+	SLIM_CH_STATE_DISCONNECTED = 0,
+	SLIM_CH_STATE_ALLOCATED,
+	SLIM_CH_STATE_ASSOCIATED,
+	SLIM_CH_STATE_DEFINED,
+	SLIM_CH_STATE_CONTENT_DEFINED,
+	SLIM_CH_STATE_ACTIVE,
+	SLIM_CH_STATE_REMOVED,
+};
+
+/**
+ * enum slim_ch_data_fmt: SLIMbus channel data Type identifiers according to
+ *	Table 60 of SLIMbus Spec 1.01.01
+ * @SLIM_CH_DATA_FMT_NOT_DEFINED: Undefined
+ * @SLIM_CH_DATA_FMT_LPCM_AUDIO: LPCM audio
+ * @SLIM_CH_DATA_FMT_IEC61937_COMP_AUDIO: IEC61937 Compressed audio
+ * @SLIM_CH_DATA_FMT_PACKED_PDM_AUDIO: Packed PDM audio
+ */
+enum slim_ch_data_fmt {
+	SLIM_CH_DATA_FMT_NOT_DEFINED = 0,
+	SLIM_CH_DATA_FMT_LPCM_AUDIO = 1,
+	SLIM_CH_DATA_FMT_IEC61937_COMP_AUDIO = 2,
+	SLIM_CH_DATA_FMT_PACKED_PDM_AUDIO = 3,
+};
+
+/**
+ * enum slim_ch_aux_fmt: SLIMbus channel Aux Field format IDs according to
+ *	Table 63 of SLIMbus Spec 2.0
+ * @SLIM_CH_AUX_FMT_NOT_APPLICABLE: Undefined
+ * @SLIM_CH_AUX_FMT_ZCUV_TUNNEL_IEC60958: ZCUV for tunneling IEC60958
+ * @SLIM_CH_AUX_FMT_USER_DEFINED: User defined
+ */
+enum slim_ch_aux_bit_fmt {
+	SLIM_CH_AUX_FMT_NOT_APPLICABLE = 0,
+	SLIM_CH_AUX_FMT_ZCUV_TUNNEL_IEC60958 = 1,
+	SLIM_CH_AUX_FMT_USER_DEFINED = 0xF,
+};
+
+/**
+ * struct slim_channel  - SLIMbus channel, used for state machine
+ *
+ * @id: ID of channel
+ * @prrate: Presense rate of channel from Table 66 of SLIMbus 2.0 Specs
+ * @seg_dist: segment distribution code from Table 20 of SLIMbus 2.0 Specs
+ * @data_fmt: Data format of channel.
+ * @aux_fmt: Aux format for this channel.
+ * @state: channel state machine
+ */
+struct slim_channel {
+	int id;
+	int prrate;
+	int seg_dist;
+	enum slim_ch_data_fmt data_fmt;
+	enum slim_ch_aux_bit_fmt aux_fmt;
+	enum slim_channel_state state;
+};
+
+/**
+ * struct slim_port  - SLIMbus port
+ *
+ * @id: Port id
+ * @direction: Port direction, Source or Sink.
+ * @state: state machine of port.
+ * @ch: channel associated with this port.
+ */
+struct slim_port {
+	int id;
+	enum slim_port_direction direction;
+	enum slim_port_state state;
+	struct slim_channel ch;
+};
+
+/**
+ * enum slim_transport_protocol: SLIMbus Transport protocol list from
+ *	Table 47 of SLIMbus 2.0 specs.
+ * @SLIM_PROTO_ISO: Isochronous Protocol, no flow control as data rate match
+ *		channel rate flow control embedded in the data.
+ * @SLIM_PROTO_PUSH: Pushed Protocol, includes flow control, Used to carry
+ *		data whose rate	is equal to, or lower than the channel rate.
+ * @SLIM_PROTO_PULL: Pulled Protocol, similar usage as pushed protocol
+ *		but pull is a unicast.
+ * @SLIM_PROTO_LOCKED: Locked Protocol
+ * @SLIM_PROTO_ASYNC_SMPLX: Asynchronous Protocol-Simplex
+ * @SLIM_PROTO_ASYNC_HALF_DUP: Asynchronous Protocol-Half-duplex
+ * @SLIM_PROTO_EXT_SMPLX: Extended Asynchronous Protocol-Simplex
+ * @SLIM_PROTO_EXT_HALF_DUP: Extended Asynchronous Protocol-Half-duplex
+ */
+enum slim_transport_protocol {
+	SLIM_PROTO_ISO = 0,
+	SLIM_PROTO_PUSH,
+	SLIM_PROTO_PULL,
+	SLIM_PROTO_LOCKED,
+	SLIM_PROTO_ASYNC_SMPLX,
+	SLIM_PROTO_ASYNC_HALF_DUP,
+	SLIM_PROTO_EXT_SMPLX,
+	SLIM_PROTO_EXT_HALF_DUP,
+};
+
+/**
+ * slim_stream_state: SLIMbus stream states
+ *
+ * @SLIM_STREAM_STATE_INVALID: Invalid state.
+ * @SLIM_STREAM_STATE_ALLOCATED: New stream allocated.
+ * @SLIM_STREAM_STATE_PREPARED: Stream prepared
+ * @SLIM_STREAM_STATE_ENABLED: Stream enabled
+ * @SLIM_STREAM_STATE_DISABLED: Stream disabled
+ * @SLIM_STREAM_STATE_UNPREPARED: Stream un-prepared
+ * @SLIM_STREAM_STATE_RELEASED: Stream released
+ */
+enum slim_stream_state {
+	SLIM_STREAM_STATE_INVALID = 0,
+	SLIM_STREAM_STATE_ALLOCATED,
+	SLIM_STREAM_STATE_PREPARED,
+	SLIM_STREAM_STATE_ENABLED,
+	SLIM_STREAM_STATE_DISABLED,
+	SLIM_STREAM_STATE_UNPREPARED,
+	SLIM_STREAM_STATE_RELEASED,
+};
+
+/**
+ * struct slim_stream_runtime  - SLIMbus stream runtime instance
+ *
+ * @dev: Name of the stream
+ * @dev: SLIM Device instance associated with this stream
+ * @state: state of stream
+ * @direction: direction of stream
+ * @prot: Transport protocol used in this stream
+ * @rate: Data rate of samples *
+ * @bps: bits per sample
+ * @ratem: rate multipler which is super frame rate/data rate
+ * @num_ports: number of ports
+ * @ports: pointer to instance of ports
+ * @node: list head for stream associated with slim device.
+ */
+struct slim_stream_runtime {
+	const char *name;
+	struct slim_device *dev;
+	enum slim_stream_state state;
+	enum slim_stream_direction direction;
+	enum slim_transport_protocol prot;
+	unsigned int rate;
+	unsigned int bps;
+	unsigned int ratem;
+	int num_ports;
+	struct slim_port *ports;
+	struct list_head node;
+};
+
 /**
  * struct slim_controller  - Controls every instance of SLIMbus
  *				(similar to 'master' on SPI)
@@ -237,6 +441,8 @@ struct slim_controller {
 					     struct slim_eaddr *ea, u8 laddr);
 	int			(*get_laddr)(struct slim_controller *ctrl,
 					     struct slim_eaddr *ea, u8 *laddr);
+	int		(*enable_stream)(struct slim_stream_runtime *rt);
+	int		(*disable_stream)(struct slim_stream_runtime *rt);
 	int			(*wakeup)(struct slim_controller *ctrl);
 };
 
diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
new file mode 100644
index 000000000000..f8af9474d286
--- /dev/null
+++ b/drivers/slimbus/stream.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/slimbus.h>
+#include "slimbus.h"
+
+/**
+ * struct segdist_code - Segment Distributions code from
+ *	Table 20 of SLIMbus Specs Version 2.0
+ *
+ * @ratem: Channel Rate Multipler(Segments per Superframe)
+ * @seg_interval: Number of slots between the first Slot of Segment
+ *		and the first slot of the next  consecutive Segment.
+ * @segdist_code: Segment Distribution Code SD[11:0]
+ * @seg_offset_mask: Segment offset mask in SD[11:0]
+ * @segdist_codes: List of all possible Segmet Distribution codes.
+ */
+static struct segdist_code {
+	int ratem;
+	int seg_interval;
+	int segdist_code;
+	u32 seg_offset_mask;
+
+} segdist_codes[] = {
+	{1,	1536,	0x200,	 0xdff},
+	{2,	768,	0x100,	 0xcff},
+	{4,	384,	0x080,	 0xc7f},
+	{8,	192,	0x040,	 0xc3f},
+	{16,	96,	0x020,	 0xc1f},
+	{32,	48,	0x010,	 0xc0f},
+	{64,	24,	0x008,	 0xc07},
+	{128,	12,	0x004,	 0xc03},
+	{256,	6,	0x002,	 0xc01},
+	{512,	3,	0x001,	 0xc00},
+	{3,	512,	0xe00,	 0x1ff},
+	{6,	256,	0xd00,	 0x0ff},
+	{12,	128,	0xc80,	 0x07f},
+	{24,	64,	0xc40,	 0x03f},
+	{48,	32,	0xc20,	 0x01f},
+	{96,	16,	0xc10,	 0x00f},
+	{192,	8,	0xc08,	 0x007},
+	{364,	4,	0xc04,	 0x003},
+	{768,	2,	0xc02,	 0x001},
+};
+
+/**
+ * struct slim_presence_rate - Presense Rate table for all Natural Frequencies
+ *	The Presense rate of a constant bitrate stram is mean flow rate of the
+ *	stream expressed in occupied Segments of that Data Channel per second.
+ *	Table 66 from SLIMbus 2.0 Specs
+ *
+ * @rate: data rate
+ * @pr_code: presence rate code PR[6:0]
+ * @prate_table: All possible presence rate code for Natural Frequencies
+ */
+static struct slim_presence_rate {
+	int rate;
+	int pr_code;
+} prate_table[] = {
+	{12000,		0x01},
+	{24000,		0x02},
+	{48000,		0x03},
+	{96000,		0x04},
+	{192000,	0x05},
+	{384000,	0x06},
+	{768000,	0x07},
+	{110250,	0x09},
+	{220500,	0x0a},
+	{441000,	0x0b},
+	{882000,	0x0c},
+	{176400,	0x0d},
+	{352800,	0x0e},
+	{705600,	0x0f},
+	{4000,		0x10},
+	{8000,		0x11},
+	{16000,		0x12},
+	{32000,		0x13},
+	{64000,		0x14},
+	{128000,	0x15},
+	{256000,	0x16},
+	{512000,	0x17},
+};
+
+/*
+ * slim_stream_allocate() - Allocate a new SLIMbus Stream
+ * @dev:Slim device to be associated with
+ * @name: name of the stream
+ *
+ * This is very first call for SLIMbus streaming, this API will allocate
+ * a new SLIMbus stream and return a valid stream runtime pointer for client
+ * to use it in subsequent stream apis. state of stream is set to ALLOCATED
+ *
+ * Return: vaild pointer on success and error code on failure. From ASoC DPCM framework,
+ * this state is linked to startup() operation.
+ */
+struct slim_stream_runtime *slim_stream_allocate(struct slim_device *dev,
+						 const char *name)
+{
+	struct slim_stream_runtime *rt;
+	unsigned long flags;
+
+	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
+	if (!rt)
+		return ERR_PTR(-ENOMEM);
+
+	rt->name = kasprintf(GFP_KERNEL, "slim-%s", name);
+	if (!rt->name) {
+		kfree(rt);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rt->dev = dev;
+	rt->state = SLIM_STREAM_STATE_ALLOCATED;
+	spin_lock_irqsave(&dev->stream_list_lock, flags);
+	list_add_tail(&rt->node, &dev->stream_list);
+	spin_unlock_irqrestore(&dev->stream_list_lock, flags);
+
+	return rt;
+}
+EXPORT_SYMBOL_GPL(slim_stream_allocate);
+
+static int slim_connect_port_channel(struct slim_stream_runtime *stream,
+				     struct slim_port *port)
+{
+	struct slim_device *sdev = stream->dev;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
+	u8 mc = SLIM_MSG_MC_CONNECT_SOURCE;
+	DEFINE_SLIM_LDEST_TXN(txn, mc, 6, stream->dev->laddr, &msg);
+	u8 wbuf[2];
+
+	if (port->direction == SLIM_PORT_SINK)
+		txn.mc = SLIM_MSG_MC_CONNECT_SINK;
+
+	wbuf[0] = port->id;
+	wbuf[1] = port->ch.id;
+	txn.msg->num_bytes = 2;
+	txn.msg->wbuf = wbuf;
+	port->ch.state = SLIM_CH_STATE_ASSOCIATED;
+	port->state = SLIM_PORT_UNCONFIGURED;
+
+	return slim_do_transfer(sdev->ctrl, &txn);
+}
+
+static int slim_disconnect_port(struct slim_stream_runtime *stream,
+				struct slim_port *port)
+{
+	struct slim_device *sdev = stream->dev;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
+	u8 mc = SLIM_MSG_MC_DISCONNECT_PORT;
+	DEFINE_SLIM_LDEST_TXN(txn, mc, 5, stream->dev->laddr, &msg);
+	u8 wbuf[1];
+
+	wbuf[0] = port->id;
+	txn.msg->wbuf = wbuf;
+	txn.msg->num_bytes = 1;
+	port->ch.state = SLIM_CH_STATE_DISCONNECTED;
+	port->state = SLIM_PORT_DISCONNECTED;
+
+	return slim_do_transfer(sdev->ctrl, &txn);
+}
+
+static int slim_deactivate_remove_channel(struct slim_stream_runtime *stream,
+				struct slim_port *port)
+{
+	struct slim_device *sdev = stream->dev;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
+	u8 mc = SLIM_MSG_MC_NEXT_DEACTIVATE_CHANNEL;
+	DEFINE_SLIM_LDEST_TXN(txn, mc, 5, stream->dev->laddr, &msg);
+	u8 wbuf[1];
+	int ret;
+
+	txn.msg->num_bytes = 1;
+	txn.msg->wbuf = wbuf;
+	wbuf[0] = port->ch.id;
+
+	ret = slim_do_transfer(sdev->ctrl, &txn);
+	if (ret)
+		return ret;
+
+	txn.mc = SLIM_MSG_MC_NEXT_REMOVE_CHANNEL;
+	port->ch.state = SLIM_CH_STATE_REMOVED;
+
+	return slim_do_transfer(sdev->ctrl, &txn);
+}
+
+/*
+ * slim_stream_prepare() - Prepare a SLIMbus Stream
+ *
+ * @rt: instance of slim stream runtime to configure
+ * @cfg: new configuration for the stream
+ *
+ * This API will configure SLIMbus stream with config parameters from cfg.
+ * return zero on success and error code on failure. From ASoC DPCM framework,
+ * this state is linked to hw_params()/prepare() operation.
+ */
+int slim_stream_prepare(struct slim_stream_runtime *rt,
+			struct slim_stream_config *cfg)
+{
+	struct slim_controller *ctrl = rt->dev->ctrl;
+	struct slim_port *port;
+	int num_ports, i, port_id;
+
+	num_ports = hweight32(cfg->port_mask);
+	rt->ports = kcalloc(num_ports, sizeof(*port), GFP_ATOMIC);
+	if (!rt->ports)
+		return -ENOMEM;
+
+	rt->num_ports = num_ports;
+	rt->rate = cfg->rate;
+	rt->bps = cfg->bps;
+	rt->direction = cfg->direction;
+
+	if (cfg->rate % ctrl->a_framer->superfreq) {
+		/*
+		 * data rate not exactly multiple of super frame,
+		 * use PUSH/PULL protocol
+		 */
+		if (cfg->direction == SLIM_STREAM_DIR_PLAYBACK)
+			rt->prot = SLIM_PROTO_PUSH;
+		else
+			rt->prot = SLIM_PROTO_PULL;
+	} else {
+		rt->prot = SLIM_PROTO_ISO;
+	}
+
+	rt->ratem = cfg->rate/ctrl->a_framer->superfreq;
+
+	i = 0;
+	for_each_set_bit(port_id, &cfg->port_mask, SLIM_DEVICE_MAX_PORTS) {
+		port = &rt->ports[i];
+		port->state = SLIM_PORT_DISCONNECTED;
+		port->id = port_id;
+		port->ch.id = cfg->chs[i];
+		port->ch.data_fmt = SLIM_CH_DATA_FMT_NOT_DEFINED;
+		port->ch.aux_fmt = SLIM_CH_AUX_FMT_NOT_APPLICABLE;
+		port->ch.state = SLIM_CH_STATE_ALLOCATED;
+
+		if (cfg->direction == SLIM_STREAM_DIR_PLAYBACK)
+			port->direction = SLIM_PORT_SINK;
+		else
+			port->direction = SLIM_PORT_SOURCE;
+
+		slim_connect_port_channel(rt, port);
+		i++;
+	}
+
+	rt->state = SLIM_STREAM_STATE_PREPARED;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_stream_prepare);
+
+static int slim_get_prate_code(int rate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(prate_table);) {
+		if (rate == prate_table[i].rate)
+			return prate_table[i].pr_code;
+	}
+
+	return -EINVAL;
+}
+
+
+static int slim_define_channel_content(struct slim_stream_runtime *stream,
+				       struct slim_port *port)
+{
+	struct slim_device *sdev = stream->dev;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
+	u8 mc = SLIM_MSG_MC_NEXT_DEFINE_CONTENT;
+	DEFINE_SLIM_LDEST_TXN(txn, mc, 8, stream->dev->laddr, &msg);
+	u8 wbuf[4];
+
+	port->ch.prrate = slim_get_prate_code(stream->rate);
+	txn.msg->num_bytes = 4;
+	txn.msg->wbuf = wbuf;
+	wbuf[0] = port->ch.id;
+	wbuf[1] = port->ch.prrate;
+
+	/* Frequency Locked for ISO Protocol */
+	if (stream->prot != SLIM_PROTO_ISO)
+		wbuf[1] |= SLIM_CHANNEL_CONTENT_FL;
+
+	wbuf[2] = port->ch.data_fmt | (port->ch.aux_fmt << 4);
+	wbuf[3] = stream->bps/SLIM_SLOT_LEN_BITS;
+	port->ch.state = SLIM_CH_STATE_CONTENT_DEFINED;
+
+	return slim_do_transfer(sdev->ctrl, &txn);
+}
+
+static int slim_get_segdist_code(int ratem)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(segdist_codes); i++) {
+		if (segdist_codes[i].ratem == ratem)
+			return segdist_codes[i].segdist_code;
+	}
+
+	return -EINVAL;
+}
+
+static int slim_define_channel(struct slim_stream_runtime *stream,
+				       struct slim_port *port)
+{
+	struct slim_device *sdev = stream->dev;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
+	u8 mc = SLIM_MSG_MC_NEXT_DEFINE_CHANNEL;
+	DEFINE_SLIM_LDEST_TXN(txn, mc, 8, stream->dev->laddr, &msg);
+	u8 wbuf[4];
+
+	txn.msg->num_bytes = 4;
+	txn.msg->wbuf = wbuf;
+	port->ch.seg_dist = slim_get_segdist_code(stream->ratem);
+
+	wbuf[0] = port->ch.id;
+	wbuf[1] = port->ch.seg_dist & 0xFF;
+	wbuf[2] = (stream->prot << 4) | ((port->ch.seg_dist & 0xF00) >> 8);
+	if (stream->prot == SLIM_PROTO_ISO)
+		wbuf[3] = stream->bps/SLIM_SLOT_LEN_BITS;
+	else
+		wbuf[3] = stream->bps/SLIM_SLOT_LEN_BITS + 1;
+
+	port->ch.state = SLIM_CH_STATE_DEFINED;
+
+	return slim_do_transfer(sdev->ctrl, &txn);
+}
+
+static int slim_activate_channel(struct slim_stream_runtime *stream,
+				 struct slim_port *port)
+{
+	struct slim_device *sdev = stream->dev;
+	struct slim_val_inf msg = {0, 0, NULL, NULL};
+	u8 mc = SLIM_MSG_MC_NEXT_ACTIVATE_CHANNEL;
+	DEFINE_SLIM_LDEST_TXN(txn, mc, 5, stream->dev->laddr, &msg);
+	u8 wbuf[1];
+
+	txn.msg->num_bytes = 1;
+	txn.msg->wbuf = wbuf;
+	wbuf[0] = port->ch.id;
+	port->ch.state = SLIM_CH_STATE_ACTIVE;
+
+	return slim_do_transfer(sdev->ctrl, &txn);
+}
+
+/*
+ * slim_stream_enable() - Enable a prepared SLIMbus Stream
+ *
+ * @stream: instance of slim stream runtime to enable
+ *
+ * This API will enable all the ports and channels associated with
+ * SLIMbus stream
+ *
+ * Return: zero on success and error code on failure. From ASoC DPCM framework,
+ * this state is linked to trigger() start operation.
+ */
+int slim_stream_enable(struct slim_stream_runtime *stream)
+{
+	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
+				3, SLIM_LA_MANAGER, NULL);
+	struct slim_controller *ctrl = stream->dev->ctrl;
+	int ret, i;
+
+	if (ctrl->enable_stream) {
+		ret = ctrl->enable_stream(stream);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < stream->num_ports; i++)
+			stream->ports[i].ch.state = SLIM_CH_STATE_ACTIVE;
+
+		return ret;
+	}
+
+	ret = slim_do_transfer(ctrl, &txn);
+	if (ret)
+		return ret;
+
+	/* define channels first before activating them */
+	for (i = 0; i < stream->num_ports; i++) {
+		struct slim_port *port = &stream->ports[i];
+
+		slim_define_channel(stream, port);
+		slim_define_channel_content(stream, port);
+	}
+
+	for (i = 0; i < stream->num_ports; i++) {
+		struct slim_port *port = &stream->ports[i];
+
+		slim_activate_channel(stream, port);
+		port->state = SLIM_PORT_CONFIGURED;
+	}
+	txn.mc = SLIM_MSG_MC_RECONFIGURE_NOW;
+	stream->state = SLIM_STREAM_STATE_ENABLED;
+
+	return slim_do_transfer(ctrl, &txn);
+}
+EXPORT_SYMBOL_GPL(slim_stream_enable);
+
+/*
+ * slim_stream_disable() - Disable a SLIMbus Stream
+ *
+ * @stream: instance of slim stream runtime to disable
+ *
+ * This API will disable all the ports and channels associated with
+ * SLIMbus stream
+ *
+ * Return: zero on success and error code on failure. From ASoC DPCM framework,
+ * this state is linked to trigger() pause operation.
+ */
+int slim_stream_disable(struct slim_stream_runtime *stream)
+{
+	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
+				3, SLIM_LA_MANAGER, NULL);
+	struct slim_controller *ctrl = stream->dev->ctrl;
+	int ret, i;
+
+	if (ctrl->disable_stream)
+		ctrl->disable_stream(stream);
+
+	ret = slim_do_transfer(ctrl, &txn);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < stream->num_ports; i++)
+		slim_deactivate_remove_channel(stream, &stream->ports[i]);
+
+	txn.mc = SLIM_MSG_MC_RECONFIGURE_NOW;
+	stream->state = SLIM_STREAM_STATE_DISABLED;
+
+	return slim_do_transfer(ctrl, &txn);
+}
+EXPORT_SYMBOL_GPL(slim_stream_disable);
+
+/*
+ * slim_stream_unprepare() - Un-prepare a SLIMbus Stream
+ *
+ * @stream: instance of slim stream runtime to unprepare
+ *
+ * This API will un allocate all the ports and channels associated with
+ * SLIMbus stream
+ *
+ * Return: zero on success and error code on failure. From ASoC DPCM framework,
+ * this state is linked to trigger() stop operation.
+ */
+int slim_stream_unprepare(struct slim_stream_runtime *stream)
+{
+	int i;
+
+	for (i = 0; i < stream->num_ports; i++)
+		slim_disconnect_port(stream, &stream->ports[i]);
+
+	kfree(stream->ports);
+	stream->ports = NULL;
+	stream->num_ports = 0;
+	stream->state = SLIM_STREAM_STATE_UNPREPARED;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_stream_unprepare);
+
+/*
+ * slim_stream_free() - Free a SLIMbus Stream
+ *
+ * @stream: instance of slim stream runtime to free
+ *
+ * This API will un allocate all the memory associated with
+ * slim stream runtime, user is not allowed to make an dereference
+ * to stream after this call.
+ *
+ * Return: zero on success and error code on failure. From ASoC DPCM framework,
+ * this state is linked to shutdown() operation.
+ */
+int slim_stream_free(struct slim_stream_runtime *stream)
+{
+	struct slim_device *sdev = stream->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdev->stream_list_lock, flags);
+	list_del(&stream->node);
+	spin_unlock_irqrestore(&sdev->stream_list_lock, flags);
+
+	kfree(stream->name);
+	kfree(stream);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(slim_stream_free);
diff --git a/include/linux/slimbus.h b/include/linux/slimbus.h
index 63801bcc5e60..46c947d567ee 100644
--- a/include/linux/slimbus.h
+++ b/include/linux/slimbus.h
@@ -48,6 +48,8 @@ struct slim_controller;
  * @ctrl: slim controller instance.
  * @laddr: 1-byte Logical address of this device.
  * @is_laddr_valid: indicates if the laddr is valid or not
+ * @stream_list: List of streams on this device
+ * @stream_list_lock: lock to protect the stream list
  *
  * This is the client/device handle returned when a SLIMbus
  * device is registered with a controller.
@@ -60,6 +62,8 @@ struct slim_device {
 	enum slim_device_status	status;
 	u8			laddr;
 	bool			is_laddr_valid;
+	struct list_head	stream_list;
+	spinlock_t stream_list_lock;
 };
 
 #define to_slim_device(d) container_of(d, struct slim_device, dev)
@@ -108,6 +112,46 @@ struct slim_val_inf {
 	struct	completion	*comp;
 };
 
+/**
+ * slim_stream_direction: SLIMbus stream direction
+ *
+ * @SLIM_STREAM_DIR_PLAYBACK: Playback
+ * @SLIM_STREAM_DIR_CAPTURE: Capture
+ */
+enum slim_stream_direction {
+	SLIM_STREAM_DIR_PLAYBACK = 0,
+	SLIM_STREAM_DIR_CAPTURE,
+};
+
+#define SLIM_DEVICE_MAX_CHANNELS	256
+/* A SLIMBus Device may have frmo 0 to 31 Ports (inclusive) */
+#define SLIM_DEVICE_MAX_PORTS		32
+
+/**
+ * struct slim_stream_config - SLIMbus stream configuration
+ *	Configuring a stream is done at hw_params or prepare call
+ *	from audio drivers where they have all the required information
+ *	regarding rate, number of channels and so on.
+ *	There is a 1:1 mapping of channel and ports.
+ *
+ * @rate: data rate
+ * @bps: bits per data sample
+ * @ch_count: number of channels
+ * @chs: pointer to list of channel numbers
+ * @port_mask: port mask of ports to use for this stream
+ * @direction: direction of the stream, Playback or Capture.
+ */
+struct slim_stream_config {
+	unsigned int rate;
+	unsigned int bps;
+	/* MAX 256 channels */
+	unsigned int ch_count;
+	unsigned int *chs;
+	/* Max 32 ports per device */
+	unsigned long port_mask;
+	enum slim_stream_direction direction;
+};
+
 /*
  * use a macro to avoid include chaining to get THIS_MODULE
  */
@@ -163,4 +207,16 @@ int slim_readb(struct slim_device *sdev, u32 addr);
 int slim_writeb(struct slim_device *sdev, u32 addr, u8 value);
 int slim_read(struct slim_device *sdev, u32 addr, size_t count, u8 *val);
 int slim_write(struct slim_device *sdev, u32 addr, size_t count, u8 *val);
+
+/* SLIMbus Stream apis */
+struct slim_stream_runtime;
+struct slim_stream_runtime *slim_stream_allocate(struct slim_device *dev,
+						 const char *sname);
+int slim_stream_prepare(struct slim_stream_runtime *stream,
+			struct slim_stream_config *c);
+int slim_stream_enable(struct slim_stream_runtime *stream);
+int slim_stream_disable(struct slim_stream_runtime *stream);
+int slim_stream_unprepare(struct slim_stream_runtime *stream);
+int slim_stream_free(struct slim_stream_runtime *stream);
+
 #endif /* _LINUX_SLIMBUS_H */
-- 
2.16.2

