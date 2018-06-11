Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vXuQD795HlsWOQAAmS7hNA
	; Mon, 11 Jun 2018 13:31:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 849FA607A4; Mon, 11 Jun 2018 13:31:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rr8ZJvuX"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 00C1E601C3;
	Mon, 11 Jun 2018 13:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00C1E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933364AbeFKNbo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:31:44 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35896 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754251AbeFKNbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:31:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id u4-v6so30586953lff.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/4SX3+u2Y2cLjVWm/+4v5rftrI/D8hB/irhmVjaL3vQ=;
        b=Rr8ZJvuX9dLblZAl1GxZSNyM06LGWgpo6EgwPoIPn4W+//NijV442OnAxjN8IYfaqx
         zyIZ19JbLZVRISyVfHVYWFsdePY3M5wfZjPNFSCnH22AH60PGdJrnzfgi2RgsbjTdIJ4
         uwF26OdZR+bqUAvR99d1jTSJ0qU6Yut+NikUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/4SX3+u2Y2cLjVWm/+4v5rftrI/D8hB/irhmVjaL3vQ=;
        b=kvV9dFWbpq9erbaFwfvvnG+nOwQV95JqsJ6YLpW3k8ZjHV2GWXHYRgdvRpe7uao9qf
         R3zuv+TIkGHIxKVieym4Lzic0pKvoPTdy9zDQsoaEH8qwtZevYpcBwXzHMKvVIu+15iG
         ZygliBi6nRxDmiWif4WR5+zDTdFr8MiHk/vPTTk9fIM6fmyUjlkfdKv3mDTC2cC+7Wxl
         yE75tdTdWVC4vX5gfDb30YfH79cJ7F9cnDiiAqptu6wQx78ZL+J5MDQZs1FiWZMVAEEj
         g8fGqeSDn9JcY1F7pDBEnYUo1Bz64ryTjfaEgT2IXHs6PesRY9kM9X4ZhU9w6arB0M4V
         DVtQ==
X-Gm-Message-State: APt69E13FIwQNEk3h/OlaVwt+YpSO4iMB3tVF+gmFONmBI923QRm9VLQ
        hPcNdjQeuQuIFZDRzLm5muQAHQ==
X-Google-Smtp-Source: ADUXVKKPmNF6f4FWxdp5sidAfYcM5AGq4O5JyuHpISSIgbaSn5PrVqiRGb3eIQDC7cwjGV+k4h9prw==
X-Received: by 2002:a2e:6548:: with SMTP id z69-v6mr9352311ljb.116.1528723864156;
        Mon, 11 Jun 2018 06:31:04 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u24-v6sm2617712ljj.96.2018.06.11.06.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:31:03 -0700 (PDT)
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 5/6] net: ethernet: ti: cpsw: restore shaper configuration while down/up
Date: Mon, 11 Jun 2018 16:30:46 +0300
Message-Id: <20180611133047.4818-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to restore shapers configuration after interface was down/up.
This is needed as appropriate configuration is still replicated in
kernel settings. This only shapers context restore, so vlan
configuration should be restored by user if needed, especially for
devices with one port where vlan frames are sent via ALE.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 87a5586c5ea5..f39d2662c5ab 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1807,6 +1807,51 @@ static int cpsw_set_cbs(struct net_device *ndev,
 	return ret;
 }
 
+static void cpsw_cbs_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	int fifo, bw;
+
+	for (fifo = CPSW_FIFO_SHAPERS_NUM; fifo > 0; fifo--) {
+		bw = priv->fifo_bw[fifo];
+		if (!bw)
+			continue;
+
+		cpsw_set_fifo_rlimit(priv, fifo, bw);
+	}
+}
+
+static void cpsw_mqprio_resume(struct cpsw_slave *slave, struct cpsw_priv *priv)
+{
+	struct cpsw_common *cpsw = priv->cpsw;
+	u32 tx_prio_map = 0;
+	int i, tc, fifo;
+	u32 tx_prio_rg;
+
+	if (!priv->mqprio_hw)
+		return;
+
+	for (i = 0; i < 8; i++) {
+		tc = netdev_get_prio_tc_map(priv->ndev, i);
+		fifo = CPSW_FIFO_SHAPERS_NUM - tc;
+		tx_prio_map |= fifo << (4 * i);
+	}
+
+	tx_prio_rg = cpsw->version == CPSW_VERSION_1 ?
+		     CPSW1_TX_PRI_MAP : CPSW2_TX_PRI_MAP;
+
+	slave_write(slave, tx_prio_map, tx_prio_rg);
+}
+
+/* restore resources after port reset */
+static void cpsw_restore(struct cpsw_priv *priv)
+{
+	/* restore MQPRIO offload */
+	for_each_slave(priv, cpsw_mqprio_resume, priv);
+
+	/* restore CBS offload */
+	for_each_slave(priv, cpsw_cbs_resume, priv);
+}
+
 static int cpsw_ndo_open(struct net_device *ndev)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
@@ -1886,6 +1931,8 @@ static int cpsw_ndo_open(struct net_device *ndev)
 
 	}
 
+	cpsw_restore(priv);
+
 	/* Enable Interrupt pacing if configured */
 	if (cpsw->coal_intvl != 0) {
 		struct ethtool_coalesce coal;
-- 
2.17.1
