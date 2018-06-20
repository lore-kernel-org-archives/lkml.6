Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D20C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1604D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAinP0cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1604D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeFTImg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:42:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33665 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeFTImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:42:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id y20-v6so3718378lfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JKpvz3vtYdohxjtXmtyo5SjzMcz9c7S9E23fQ5xXab4=;
        b=QAinP0cUkQ5zt0rvGHnPqm8C19pbEnTgsOdE7o40ZdxvOw2oQcLgAOSxwX6DLHAuuY
         QykZ2tKUcx1FH0YkKELwREaH3E4p62NCXRQCX84610BJLQSwnfqxHsrpK1pioz3YvOm7
         oV89YuUoBTNtuVg0sY8Ow276CNIH9u0+NeMZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JKpvz3vtYdohxjtXmtyo5SjzMcz9c7S9E23fQ5xXab4=;
        b=ABe9KPX+73Plgw5pCgmJgHor9VMoM+IHNhLSq/uKjHPaqD43w6sNKXZQG/nvkqAUc9
         e0wTmHr3YYWt6V2pUmTk1RT2pQr/6W2dTbP8oj4Oj7BkJBC3lFD7y3VzGTGeJguAx38R
         6U+2wtmJevZhklCs0iphoG8nlkJ/5QiGQSeorUjKTxZM2Ied6geHvT/27Wwjb8kOW0wG
         /9uhmRIxJNwKlIlqQ7r0OtT1lkCr9TKWM6nK0AshZmhKHGKbnqNcfU7+RRcCrT5Bc+gs
         b7OPWlVwyvlufkXpE3XZcOVODF4rwMqdBXbMRS8Fitmur/xOI0rGUuY4ZxtzIuISsz8/
         QB9w==
X-Gm-Message-State: APt69E1Pzo7a1xGHrMtIodaewP+FpUWuBl53x0XVaGUO6oFdEuDby5Xm
        Pbo7ToCFyYhNwf5J2dUTujnU2A==
X-Google-Smtp-Source: ADUXVKIErsU8106cF3yhAARbMNfvZR03AIjYYlG+OfmTWkM5BZCvGZkfQnP3XZecKt9E8j+VfkwfOg==
X-Received: by 2002:a2e:7a0f:: with SMTP id v15-v6mr14038227ljc.68.1529484151743;
        Wed, 20 Jun 2018 01:42:31 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id l25-v6sm301267ljj.30.2018.06.20.01.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 01:42:31 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     alagusankar@silex-india.com,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ath10k: sdio: use same endpoint id for all packets in a bundle
Date:   Wed, 20 Jun 2018 10:42:20 +0200
Message-Id: <20180620084222.3521-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620084222.3521-1-niklas.cassel@linaro.org>
References: <20180620084222.3521-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All packets in a bundle should use the same endpoint id as the
first lookahead.

This matches how things are done is ath6kl, however,
this patch can theoretically handle several bundles
in ath10k_sdio_mbox_rx_process_packets().

Without this patch we get lots of errors about invalid endpoint id:

ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12

Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index d612ce8c9cff..d46523b0472c 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -434,12 +434,14 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 	enum ath10k_htc_ep_id id;
 	int ret, i, *n_lookahead_local;
 	u32 *lookaheads_local;
+	int lookahead_idx = 0;
 
 	for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
 		lookaheads_local = lookaheads;
 		n_lookahead_local = n_lookahead;
 
-		id = ((struct ath10k_htc_hdr *)&lookaheads[i])->eid;
+		id = ((struct ath10k_htc_hdr *)
+		      &lookaheads[lookahead_idx++])->eid;
 
 		if (id >= ATH10K_HTC_EP_COUNT) {
 			ath10k_warn(ar, "invalid endpoint in look-ahead: %d\n",
@@ -462,6 +464,7 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 			/* Only read lookahead's from RX trailers
 			 * for the last packet in a bundle.
 			 */
+			lookahead_idx--;
 			lookaheads_local = NULL;
 			n_lookahead_local = NULL;
 		}
-- 
2.17.1

