Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1E1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70A820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9JM/8Rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70A820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbeFTJDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:03:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:47098 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754012AbeFTIme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id u5-v6so3648851lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sYHap52ZFvU1YoFIXSmQWxFDIVLNqxp0/nUZxn+RUiA=;
        b=U9JM/8RwFdaS17LbpXbCXWptnGIcJfe/tM6C3jZ8qTPndyZ8spk0st/f+uDaJZJSUK
         4mZTRvU1j0Dad0HcGPnujz9k7ehPn3X6h0mpwaLQTIlmiCg17xIMdai+vLRVfwdahnmQ
         QYq6etRoMjhxGn9BWsFx8Mhw9VsSHe5YlTqnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sYHap52ZFvU1YoFIXSmQWxFDIVLNqxp0/nUZxn+RUiA=;
        b=TspxhxgxelEZYWrz6zpwdJ0G+7CrtQlWWvZ1WKh9/fahHR96ZdFGFv4SLB1F0VcM8u
         7qIbEFvml7YzRWThmHxW4YRW2cU5lNGhWdP+E3Yt5h5UY9rm4xYxtdsnpD2yOIetLkqx
         o2NIE9Ulss7CSRFQ3vH1K8xSFBo89nfHm3J4Hs6HUB3XgMncHwSetJVpMWAuAft8lWfd
         LtHtzEzgt+fkw1z/zVA4vopLa4GBBp9T4do3psyA8moOBOR9pYgomBX8QPo59GOWpBEq
         SLT30WGzL682UUMt4beK9/4TbJhtcFf2jcgBagpIAFr4whZeX+/aJZEqY0irMehmEb1c
         jy0g==
X-Gm-Message-State: APt69E2ps3MPwLa+RthkhkIDXB/Q1YuuXTwrDVHCDPXsnsqmkCm4TuRA
        WIR2slezIxfFpP7z1kHew2fo2A==
X-Google-Smtp-Source: ADUXVKJWpHxRqCeghmtVb9Fae9OZh1TCsprzeURFGjtiKnumr9YTr4okShMqAtm7ARrgrTsHcP+s3g==
X-Received: by 2002:a2e:3011:: with SMTP id w17-v6mr14437016ljw.20.1529484153062;
        Wed, 20 Jun 2018 01:42:33 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id l25-v6sm301267ljj.30.2018.06.20.01.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 01:42:32 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     alagusankar@silex-india.com,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ath10k: sdio: allocate correct size for RECV_1MORE_BLOCK rx packets
Date:   Wed, 20 Jun 2018 10:42:21 +0200
Message-Id: <20180620084222.3521-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620084222.3521-1-niklas.cassel@linaro.org>
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, when receiving a packet that has this flag set
from firmware, we will read invalid trailer data from the packet,
which will be shown as various errors, e.g. "sdio mbox lookahead
is zero" or "invalid rx packet" or "payload length x exceeds max
htc length".

Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/wireless/ath/ath10k/htc.h  | 1 +
 drivers/net/wireless/ath/ath10k/sdio.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index 34877597dd6a..cf1068dc3254 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -58,6 +58,7 @@ enum ath10k_htc_tx_flags {
 };
 
 enum ath10k_htc_rx_flags {
+	ATH10K_HTC_FLAGS_RECV_1MORE_BLOCK = 0x01,
 	ATH10K_HTC_FLAG_TRAILER_PRESENT = 0x02,
 	ATH10K_HTC_FLAG_BUNDLE_MASK     = 0xF0
 };
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index d46523b0472c..0c57d6aaa437 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -603,6 +603,9 @@ static int ath10k_sdio_mbox_rx_alloc(struct ath10k *ar,
 		 * ATH10K_HTC_FLAG_BUNDLE_MASK flag set, all bundled
 		 * packet skb's have been allocated in the previous step.
 		 */
+		if (htc_hdr->flags & ATH10K_HTC_FLAGS_RECV_1MORE_BLOCK)
+			full_len += ATH10K_HIF_MBOX_BLOCK_SIZE;
+
 		ret = ath10k_sdio_mbox_alloc_rx_pkt(&ar_sdio->rx_pkts[i],
 						    act_len,
 						    full_len,
-- 
2.17.1

