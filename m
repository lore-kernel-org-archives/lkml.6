Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CKDhDwN6HlsEPAAAmS7hNA
	; Mon, 11 Jun 2018 13:32:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 278F860850; Mon, 11 Jun 2018 13:32:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzHgkSmV"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 98E6660541;
	Mon, 11 Jun 2018 13:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98E6660541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933415AbeFKNct (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:32:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38777 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbeFKNa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:30:59 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so30558539lfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3jIepUwDw2xc+pgExVeFYswjqlQIgEI3e1Xbicq7EM=;
        b=SzHgkSmVMJtI82iO9LMiqiAuLA6XITGgA8fh0lVhSWMYL8V886MllHH8ZcjJoiB2iK
         eAd4isGTHWYMpM8MICe6nt4KaUegmO53HsOAYXo5AAkcdGZMKBuOwnU8dW1+7tCT3O3e
         KctIVuoJ8+GekxHKsDz9To7kezqZ41xDoKDxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3jIepUwDw2xc+pgExVeFYswjqlQIgEI3e1Xbicq7EM=;
        b=gnv077dsvuexJYqjLT+hNnt5mPID/Z7wHXQseQx4Iuu1eum+OrtCi6/mE6WSqtyU/S
         sCfVVBe40erRiYqddY6rIrFxOqYoKo7lXb3Y9A+fHtxSdf4Dl2WL1KviZx8XAXnPAN07
         4/I51VsR3bJLa1hgH/klv5K+RWV8ytpnLxRs3sW/vJ4gbSy6EyDhip9ouVPO81Us3UU+
         +HQS21rVFZp19CIxlh0eXuTfh91508MTJS9dIpbwt+vSSIXKn8OtJLUGV5RUGlvMc4pA
         uRwW4gxEM2e1Sjyfj+dQgEE4QiWfshy5UmwpR2jHCsxKBfMqlXUnScGVRBjEo0xautb9
         Q38g==
X-Gm-Message-State: APt69E064ZWueu4LeOUPhoUcxpyhUKCdKQRK7BEezVJl6IBeDtLB1RQd
        zcjB7tatBMmwjzyuhK8nRNCaTe2J56U=
X-Google-Smtp-Source: ADUXVKIrrTFqS29ZZ+IAjFoW7ldj+cRtH7fvspJEIhywlzL+Cik8jXxjHMpVatuwSGCrw93w3cSDHg==
X-Received: by 2002:a2e:163:: with SMTP id 96-v6mr12307996ljb.8.1528723857965;
        Mon, 11 Jun 2018 06:30:57 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id u24-v6sm2617712ljj.96.2018.06.11.06.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:30:57 -0700 (PDT)
From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com,
        ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com,
        francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 1/6] net: ethernet: ti: cpsw: use cpdma channels in backward order for txq
Date: Mon, 11 Jun 2018 16:30:42 +0300
Message-Id: <20180611133047.4818-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpdma channel highest priority is from hi to lo number.
The driver has limited number of descriptors that are shared between
number of cpdma channels. Number of queues can be tuned with ethtool,
that allows to not spend descriptors on not needed cpdma channels.
In AVB usually only 2 tx queues can be enough with rate limitation.
The rate limitation can be used only for hi priority queues. Thus, to
use only 2 queues the 8 has to be created. It's wasteful.

So, in order to allow using only needed number of rate limited
tx queues, save resources, and be able to set rate limitation for
them, let assign tx cpdma channels in backward order to queues.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 534596ce00d3..406537d74ec1 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -967,8 +967,8 @@ static int cpsw_tx_mq_poll(struct napi_struct *napi_tx, int budget)
 
 	/* process every unprocessed channel */
 	ch_map = cpdma_ctrl_txchs_state(cpsw->dma);
-	for (ch = 0, num_tx = 0; ch_map; ch_map >>= 1, ch++) {
-		if (!(ch_map & 0x01))
+	for (ch = 0, num_tx = 0; ch_map & 0xff; ch_map <<= 1, ch++) {
+		if (!(ch_map & 0x80))
 			continue;
 
 		txv = &cpsw->txv[ch];
@@ -2431,7 +2431,7 @@ static int cpsw_update_channels_res(struct cpsw_priv *priv, int ch_num, int rx)
 	void (*handler)(void *, int, int);
 	struct netdev_queue *queue;
 	struct cpsw_vector *vec;
-	int ret, *ch;
+	int ret, *ch, vch;
 
 	if (rx) {
 		ch = &cpsw->rx_ch_num;
@@ -2444,7 +2444,8 @@ static int cpsw_update_channels_res(struct cpsw_priv *priv, int ch_num, int rx)
 	}
 
 	while (*ch < ch_num) {
-		vec[*ch].ch = cpdma_chan_create(cpsw->dma, *ch, handler, rx);
+		vch = rx ? *ch : 7 - *ch;
+		vec[*ch].ch = cpdma_chan_create(cpsw->dma, vch, handler, rx);
 		queue = netdev_get_tx_queue(priv->ndev, *ch);
 		queue->tx_maxrate = 0;
 
@@ -2980,7 +2981,7 @@ static int cpsw_probe(struct platform_device *pdev)
 	u32 slave_offset, sliver_offset, slave_size;
 	const struct soc_device_attribute *soc;
 	struct cpsw_common		*cpsw;
-	int ret = 0, i;
+	int ret = 0, i, ch;
 	int irq;
 
 	cpsw = devm_kzalloc(&pdev->dev, sizeof(struct cpsw_common), GFP_KERNEL);
@@ -3155,7 +3156,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (soc)
 		cpsw->quirk_irq = 1;
 
-	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, 0, cpsw_tx_handler, 0);
+	ch = cpsw->quirk_irq ? 0 : 7;
+	cpsw->txv[0].ch = cpdma_chan_create(cpsw->dma, ch, cpsw_tx_handler, 0);
 	if (IS_ERR(cpsw->txv[0].ch)) {
 		dev_err(priv->dev, "error initializing tx dma channel\n");
 		ret = PTR_ERR(cpsw->txv[0].ch);
-- 
2.17.1
