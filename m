Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eU7sDuN5HlsFOwAAmS7hNA
	; Mon, 11 Jun 2018 13:32:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1B3CA6089E; Mon, 11 Jun 2018 13:32:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdv0XIeb"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6EAE960541;
	Mon, 11 Jun 2018 13:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EAE960541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeFKNc3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:32:29 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43966 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbeFKNbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:31:02 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so30542587lfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30HpfX3MSgIitu/iEBIIx9v0BD6QgrKlorDvbuJTrxs=;
        b=fdv0XIebAEYNjegTF9IOxzBvv2QsAONAPC1wUXtFvOGxXdjAwBGGqMNZZYswgaRG3R
         wU3NKN5x60rw8zDgtFP0asa20mz8VQYZAuQwt1kdfg4wka1rKTyDw4ElgH+JANvblluN
         g24f832NpCTe4bTSi0t78p/Q5IDVEUDvMXuFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30HpfX3MSgIitu/iEBIIx9v0BD6QgrKlorDvbuJTrxs=;
        b=hqTMpAXjW0QklAYLnV6FpGU0um5EB/6RIKyZaXqWRjfX3PtuGUagJQyL+ZqxUMHnhh
         CCzYcsLFyC6OuLYmepk/+FjtMy9T3cj4iQHkG366xHJY0qgz8GgPgCLelY8RSel1t4B0
         wQyHkEpKXig+o3BSrIpck71H6GfMB6tx++K5egxKrKR67p45G4yku9sHYl92lAKL6Pvl
         Q5sdN41Mlugoqr2gC1IoU+wCpNhw/3nqDuPezziXYaUVDsi030Emkh0h5/w13vBOzKQm
         rv+4vCVxkl+S724oh4DUVOuUxb/jIrdViS6nIy4Tib9vXvBmekMzveLi+YUuMNo2/9Rx
         NPqQ==
X-Gm-Message-State: APt69E28yezzF9D8k2xJspgXQEJQoGBkIIsn6RvRZfhWMEFSGSxNS0cD
        3hIthTv4SqxTZ+fu+LoqQQ1kQQ==
X-Google-Smtp-Source: ADUXVKLuIieRtE8ZBknu9jRVcIxo1A6rNKKe57XfpxKf4hSURqEIrmB3qU6YWMkEPzlh+P6XWmyKYg==
X-Received: by 2002:a2e:889a:: with SMTP id k26-v6mr11489579lji.54.1528723861042;
        Mon, 11 Jun 2018 06:31:01 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u24-v6sm2617712ljj.96.2018.06.11.06.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:31:00 -0700 (PDT)
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 3/6] net: ethernet: ti: cpsw: add MQPRIO Qdisc offload
Date: Mon, 11 Jun 2018 16:30:44 +0300
Message-Id: <20180611133047.4818-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's possible to offload vlan to tc priority mapping with
assumption sk_prio == L2 prio.

Example:
$ ethtool -L eth0 rx 1 tx 4

$ qdisc replace dev eth0 handle 100: parent root mqprio num_tc 3 \
map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 queues 1@0 1@1 2@2 hw 1

$ tc -g class show dev eth0
+---(100:ffe2) mqprio
|    +---(100:3) mqprio
|    +---(100:4) mqprio
|    
+---(100:ffe1) mqprio
|    +---(100:2) mqprio
|    
+---(100:ffe0) mqprio
     +---(100:1) mqprio

Here, 100:1 is txq0, 100:2 is txq1, 100:3 is txq2, 100:4 is txq3
txq0 belongs to tc0, txq1 to tc1, txq2 and txq3 to tc2
The offload part only maps L2 prio to classes of traffic, but not
to transmit queues, so to direct traffic to traffic class vlan has
to be created with appropriate egress map.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 406537d74ec1..fd967d2bce5d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -39,6 +39,7 @@
 #include <linux/sys_soc.h>
 
 #include <linux/pinctrl/consumer.h>
+#include <net/pkt_cls.h>
 
 #include "cpsw.h"
 #include "cpsw_ale.h"
@@ -153,6 +154,8 @@ do {								\
 #define IRQ_NUM			2
 #define CPSW_MAX_QUEUES		8
 #define CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT 256
+#define CPSW_TC_NUM			4
+#define CPSW_FIFO_SHAPERS_NUM		(CPSW_TC_NUM - 1)
 
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_SHIFT	29
 #define CPSW_RX_VLAN_ENCAP_HDR_PRIO_MSK		GENMASK(2, 0)
@@ -453,6 +456,7 @@ struct cpsw_priv {
 	u8				mac_addr[ETH_ALEN];
 	bool				rx_pause;
 	bool				tx_pause;
+	bool				mqprio_hw;
 	u32 emac_port;
 	struct cpsw_common *cpsw;
 };
@@ -1577,6 +1581,14 @@ static void cpsw_slave_stop(struct cpsw_slave *slave, struct cpsw_common *cpsw)
 	soft_reset_slave(slave);
 }
 
+static int cpsw_tc_to_fifo(int tc, int num_tc)
+{
+	if (tc == num_tc - 1)
+		return 0;
+
+	return CPSW_FIFO_SHAPERS_NUM - tc;
+}
+
 static int cpsw_ndo_open(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
@@ -2190,6 +2202,75 @@ static int cpsw_ndo_set_tx_maxrate(struct net_device *ndev, int queue, u32 rate)
 	return ret;
 }
 
+static int cpsw_set_tc(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int fifo, num_tc, count, offset;
+	struct cpsw_slave *slave;
+	u32 tx_prio_map = 0;
+	int i, tc, ret;
+
+	num_tc = mqprio->qopt.num_tc;
+	if (num_tc > CPSW_TC_NUM)
+		return -EINVAL;
+
+	if (mqprio->mode != TC_MQPRIO_MODE_DCB)
+		return -EINVAL;
+
+	ret = pm_runtime_get_sync(cpsw->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(cpsw->dev);
+		return ret;
+	}
+
+	if (num_tc) {
+		for (i = 0; i < 8; i++) {
+			tc = mqprio->qopt.prio_tc_map[i];
+			fifo = cpsw_tc_to_fifo(tc, num_tc);
+			tx_prio_map |= fifo << (4 * i);
+		}
+
+		netdev_set_num_tc(ndev, num_tc);
+		for (i = 0; i < num_tc; i++) {
+			count = mqprio->qopt.count[i];
+			offset = mqprio->qopt.offset[i];
+			netdev_set_tc_queue(ndev, i, count, offset);
+		}
+	}
+
+	if (!mqprio->qopt.hw) {
+		/* restore default configuration */
+		netdev_reset_tc(ndev);
+		tx_prio_map = TX_PRIORITY_MAPPING;
+	}
+
+	priv->mqprio_hw = mqprio->qopt.hw;
+
+	offset = cpsw->version == CPSW_VERSION_1 ?
+		 CPSW1_TX_PRI_MAP : CPSW2_TX_PRI_MAP;
+
+	slave = &cpsw->slaves[cpsw_slave_index(cpsw, priv)];
+	slave_write(slave, tx_prio_map, offset);
+
+	pm_runtime_put_sync(cpsw->dev);
+
+	return 0;
+}
+
+static int cpsw_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			     void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_MQPRIO:
+		return cpsw_set_tc(ndev, type_data);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops cpsw_netdev_ops = {
 	.ndo_open		= cpsw_ndo_open,
 	.ndo_stop		= cpsw_ndo_stop,
@@ -2205,6 +2286,7 @@ static const struct net_device_ops cpsw_netdev_ops = {
 #endif
 	.ndo_vlan_rx_add_vid	= cpsw_ndo_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= cpsw_ndo_vlan_rx_kill_vid,
+	.ndo_setup_tc           = cpsw_ndo_setup_tc,
 };
 
 static int cpsw_get_regs_len(struct net_device *ndev)
-- 
2.17.1
