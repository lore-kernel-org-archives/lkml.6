Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6B820882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE65DjaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfA2Vuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:50:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42185 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfA2Vue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:50:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so17305403edw.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 13:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTM3oUocaEUpdR4dp3v/pgr3uNhYbKTQi55NFUqe5zU=;
        b=cE65DjaL6EPvl4DbkvbH5GmRrfD1/QYSG640FFBK0AoFnr9YWcggrHr6tVC/L+SeRk
         JwbT6JnJQFu1mnoCvLrMVsr1zTQlAgPSZEgEj2CzaClUorqsxL4yvbeSvFk46RB85zO9
         qSUYCsoc1S4ea6mRehf3Og0A0b8APAm4CNM+PNrNaPe64PQW/T6AjcpEmijAfaoaLKrg
         GB64LbwP6Ryi+WJLkTuhuZYBqh0tICN7ewGilfb3h+7VWFeSytB+RyMiwiDreo0y9eaU
         sdGGjoAmCftTtl538tAyJyNVUDmxewswSi0Gi7l80gD9EXHPQk+/lU55bGU4ou5uYCHy
         4gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oTM3oUocaEUpdR4dp3v/pgr3uNhYbKTQi55NFUqe5zU=;
        b=tVhGZntyUk/bf00KFsq9MlPQqsva0Fvta9EiclzriRipw+RIJ2blliymooxWQUhJwQ
         AEJm8YRX77pnh8fl0FZXo+2OSLDXkm+FfMeqirs9uOk+GG1bHkbPcLZIScdcYchPER8h
         r+LzHtLk+Oad8Mv9jLGUdmW0JIYJTiZYN9xrrwvhOfb9xSVQ2n+YbZZoAK5dqfhVG+6G
         7jCuij0UjxEtCSfykshbQVGKK939Q0lOtZ7hfSR9pQVa7disXcyNZZ/qmTXDSz2xMF1k
         lmYqf6jTcvivWgEPWrfJb4er7kZHQZ82Xq3jw6iZzUcMDAURh6Bz/1zZ7V4IXtfAgTOd
         22xg==
X-Gm-Message-State: AJcUukfYkpUb5zKj9J6aIGgpxq2Xv7fnFviU9Ee5D3i1HN0LS28SHdtf
        VzcwaJe6ooFDMJ10w3tpL6o=
X-Google-Smtp-Source: ALg8bN4nSvD3wGtHh2B8Uyzv6VdaECDjw2K6jfOSXmV2+47brbkl4NsfAKOp0r9tX1l3Esq5iqQVvw==
X-Received: by 2002:a50:d643:: with SMTP id c3mr26147122edj.178.1548798632272;
        Tue, 29 Jan 2019 13:50:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id p21sm6660edr.67.2019.01.29.13.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 13:50:31 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] wcd9335: Remove unnecessary null checks in wcd9335_set_channel_map
Date:   Tue, 29 Jan 2019 14:48:47 -0700
Message-Id: <20190129214847.6341-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/soc/codecs/wcd9335.c:2004:11: warning: address of array
'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (wcd->rx_chs) {
        ~~  ~~~~~^~~~~~
sound/soc/codecs/wcd9335.c:2012:11: warning: address of array
'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (wcd->tx_chs) {
        ~~  ~~~~~^~~~~~
2 warnings generated.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 3878187bb512..981f88a5f615 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2001,20 +2001,16 @@ static int wcd9335_set_channel_map(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	if (wcd->rx_chs) {
-		wcd->num_rx_port = rx_num;
-		for (i = 0; i < rx_num; i++) {
-			wcd->rx_chs[i].ch_num = rx_slot[i];
-			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
-		}
+	wcd->num_rx_port = rx_num;
+	for (i = 0; i < rx_num; i++) {
+		wcd->rx_chs[i].ch_num = rx_slot[i];
+		INIT_LIST_HEAD(&wcd->rx_chs[i].list);
 	}
 
-	if (wcd->tx_chs) {
-		wcd->num_tx_port = tx_num;
-		for (i = 0; i < tx_num; i++) {
-			wcd->tx_chs[i].ch_num = tx_slot[i];
-			INIT_LIST_HEAD(&wcd->tx_chs[i].list);
-		}
+	wcd->num_tx_port = tx_num;
+	for (i = 0; i < tx_num; i++) {
+		wcd->tx_chs[i].ch_num = tx_slot[i];
+		INIT_LIST_HEAD(&wcd->tx_chs[i].list);
 	}
 
 	return 0;
-- 
2.20.1

