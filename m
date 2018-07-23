Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AD7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED79A20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Exd/jRYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED79A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbeGWRAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:00:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55145 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388624AbeGWRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:00:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so1627855wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CzBFjPKScoyq8BRqzbqfUtYN9SRCEjh94Gk9yR48PY4=;
        b=Exd/jRYCdnfSbligYmk3crjO2fB9cN2/GDgfJ4B1iopHDyR02iJBZn4XjbvO+G1ARe
         6Y/x4boHJ7ODa2Ilws/+HexkfYAMmNj61kr1vlEE4I2Ih9Nc0qRqiWcaw5kKHPHp3rj5
         WLCKWFhVYOrADM+CkOID6mX6r/I9zpbsKoN2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CzBFjPKScoyq8BRqzbqfUtYN9SRCEjh94Gk9yR48PY4=;
        b=rhN9sBViQo51qTiC/KEwRphr7AEW97UepKjClRVaqHV7kJPZLAuqxn4JylOGqQf4X1
         skpWJ/KFseEtjoJfUz7A/A+CHkYjNWjewM4JRq7yjO72e8IoTJU9AKzymGJpc7bgCfeE
         jzWllJKq26ccV+4chhpfOqmYoQWuZS2QBsAbyjTtC2LXIaV1QcBkSHy+nAwG+NuCUICy
         JnOgnt+AU76hzcqZZ2WwxSfIrRZumOwQC63APfjIhompg6zXxOLoguOBBN4Xd+oDOVR0
         oTfP88TqhytLqiR75LgVW82hEm9+8uR+8zJGrogyLL/QARKU/EFid6Mq245nRvsLC7vX
         d/dA==
X-Gm-Message-State: AOUpUlEwKtP2uLxjMRrmJ6nlMqo+8t9x+PiD0c6w3hxtX2LcuJNLKUbI
        bMWXTZoTsOLGDFRZ2nAN/BPgNQ==
X-Google-Smtp-Source: AAOMgpdAoFdtunQpKzD4ENl3qlOWLmmLeTFznKqG8/wb/3yfFst00xxEsULR6wuGRmT+cYPBPK/WIA==
X-Received: by 2002:a1c:93d3:: with SMTP id v202-v6mr8084643wmd.57.1532361501376;
        Mon, 23 Jul 2018 08:58:21 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 14-v6sm206385wmt.1.2018.07.23.08.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 08:58:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc:     mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/12] ASoC: core: add support to snd_soc_dai_get_channel_map()
Date:   Mon, 23 Jul 2018 16:54:03 +0100
Message-Id: <20180723155410.9494-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm platforms, specifically with SLIMbus interfaced codecs,
the codec slim channel numbers are passed to DSP while configuring
the slim audio path. Having get_channel_map() would allow dais to
share such information across multiple dais.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-dai.h |  8 ++++++++
 sound/soc/soc-core.c    | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index a14bc0608ae9..f5d70041108f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -138,6 +138,11 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 			     int direction);
 
+
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+		unsigned int *tx_num, unsigned int *tx_slot,
+		unsigned int *rx_num, unsigned int *rx_slot);
+
 int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
 
 struct snd_soc_dai_ops {
@@ -165,6 +170,9 @@ struct snd_soc_dai_ops {
 	int (*set_channel_map)(struct snd_soc_dai *dai,
 		unsigned int tx_num, unsigned int *tx_slot,
 		unsigned int rx_num, unsigned int *rx_slot);
+	int (*get_channel_map)(struct snd_soc_dai *dai,
+			unsigned int *tx_num, unsigned int *tx_slot,
+			unsigned int *rx_num, unsigned int *rx_slot);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad5b0ef16d82..81b27923303d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2679,6 +2679,28 @@ int snd_soc_dai_set_channel_map(struct snd_soc_dai *dai,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_channel_map);
 
+/**
+ * snd_soc_dai_get_channel_map - Get DAI audio channel map
+ * @dai: DAI
+ * @tx_num: how many TX channels
+ * @tx_slot: pointer to an array which imply the TX slot number channel
+ *           0~num-1 uses
+ * @rx_num: how many RX channels
+ * @rx_slot: pointer to an array which imply the RX slot number channel
+ *           0~num-1 uses
+ */
+int snd_soc_dai_get_channel_map(struct snd_soc_dai *dai,
+	unsigned int *tx_num, unsigned int *tx_slot,
+	unsigned int *rx_num, unsigned int *rx_slot)
+{
+	if (dai->driver->ops->get_channel_map)
+		return dai->driver->ops->get_channel_map(dai, tx_num, tx_slot,
+			rx_num, rx_slot);
+	else
+		return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dai_get_channel_map);
+
 /**
  * snd_soc_dai_set_tristate - configure DAI system or master clock.
  * @dai: DAI
-- 
2.16.2

