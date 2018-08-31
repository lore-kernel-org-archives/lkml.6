Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2894E2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nmx6r78e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2894E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeHaTL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:11:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43950 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeHaTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:11:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id m84-v6so10321424lje.10;
        Fri, 31 Aug 2018 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E69oyJ5kxilsnkzG5PpQ1Q9o/UeB3+CE8n3MRUqdzy4=;
        b=Nmx6r78e6InxzD5KRQBg5zYn3rgSfLaT5Yjgkex8Xn74SxiIMnGRxOyFUWutUzMRx8
         JrTdDHV3faehLxlE8DPggWbQzKcg8Nt81sldjCg61DMaciC4+pDA0SmYsoO5bSCAiaGx
         1fVsUSbJPYOZJxyFx78uY6Vww8Pmuy84ZSzI/+0wzDvz5sFNtNVB7T80Wt3YH0HVE/8Z
         swr+mJozFcNFq6Nu/61Iiy7haCAyHUuvX3TtsWqMVacup8gq1r599S9dGKEw1cp+doJT
         WhYQqNf8rrbnmWYo+I+U6owCCTbPmb8PEnMHxnBxO898Ulpcz32k+VD6ZvoqJ60t3mjf
         F0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E69oyJ5kxilsnkzG5PpQ1Q9o/UeB3+CE8n3MRUqdzy4=;
        b=KZ2NFwZ8gNRdv7vweA6pSs3Jkbg8rjb2bvwSjxLZdTndgK1D7EkR1mGmLzZPU5Wvda
         xSo9cURrKE2qmw++wVTltT/6gMx8vHTqIjyQA5UAZUTiM7LVvBFLlkhxy98hdzrPJSGp
         gIliCbCLgIvKythKROpawscpMqmN/RURR3X12GS1PoXa8q40tYPc5ueeR5iGEQBN2ezO
         yZZ+uPR1tIeu529a/8RH0XBQSlUUPsRJdwYTS/Nm9nXFLRLoEnpO1Gs3rNoLf7IsOtvM
         sfsPLyhBLZD8vsJP0at+cgZDfVCL4NdBkEB7GSKMS0grz+03TNdnYl3UP+9kqd3862ej
         PSZw==
X-Gm-Message-State: APzg51AoZIyBp+wxmfFJvySJncnqfq6vULZsmzkDJvGi4GcxHN1NL15a
        6iwLLRn63sMjFK+miXRuhqY=
X-Google-Smtp-Source: ANB0Vdb2Mq2PEbAe5uaQBVpWxRRBL1VtdA6K9MIVod4VShr0QgfqSHQp9vef6sbSxij+TN30msfr/g==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr11124183ljf.79.1535727810557;
        Fri, 31 Aug 2018 08:03:30 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id l16-v6sm1898583lfc.32.2018.08.31.08.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 08:03:29 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless Mailing List <linux-wireless@vger.kernel.org>
Subject: [PATCH] wireless: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 18:03:00 +0300
Message-Id: <20180831150300.2702-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both WARN_ON() and WARN_ON_ONCE() already contain unlikely().

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Christian Lamparter <chunkeey@googlemail.com>
Cc: Michal Kazior <michal.kazior@tieto.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Wireless Mailing List <linux-wireless@vger.kernel.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c      | 4 ++--
 drivers/net/wireless/ath/carl9170/tx.c        | 4 ++--
 drivers/net/wireless/broadcom/b43/dma.c       | 2 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 4d1cd90d6d27..1455007f3eb8 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1176,11 +1176,11 @@ static void ath10k_htt_rx_h_undecap_raw(struct ath10k *ar,
 	 */
 
 	/* This probably shouldn't happen but warn just in case */
-	if (unlikely(WARN_ON_ONCE(!is_first)))
+	if (WARN_ON_ONCE(!is_first))
 		return;
 
 	/* This probably shouldn't happen but warn just in case */
-	if (unlikely(WARN_ON_ONCE(!(is_first && is_last))))
+	if (WARN_ON_ONCE(!(is_first && is_last)))
 		return;
 
 	skb_trim(msdu, msdu->len - FCS_LEN);
diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 0cb5b58925dc..8c75651ede6c 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -246,8 +246,8 @@ static void carl9170_release_dev_space(struct ar9170 *ar, struct sk_buff *skb)
 	 *    of available memory blocks, so the number can
 	 *    never execeed the mem_blocks count.
 	 */
-	if (unlikely(WARN_ON_ONCE(cookie == 0) ||
-	    WARN_ON_ONCE(cookie > ar->fw.mem_blocks)))
+	if (WARN_ON_ONCE(cookie == 0) ||
+	    WARN_ON_ONCE(cookie > ar->fw.mem_blocks))
 		return;
 
 	atomic_add(DIV_ROUND_UP(skb->len, ar->fw.mem_block_size),
diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 6b0e1ec346cb..d113bd997f4b 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1432,7 +1432,7 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff *skb)
 		goto out;
 	}
 
-	if (unlikely(WARN_ON(free_slots(ring) < TX_SLOTS_PER_FRAME))) {
+	if (WARN_ON(free_slots(ring) < TX_SLOTS_PER_FRAME)) {
 		/* If we get here, we have a real error with the queue
 		 * full, but queues not stopped. */
 		b43err(dev->wl, "DMA queue overflow\n");
diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index 2f0c64cef65f..1b1da7d83652 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -1149,7 +1149,7 @@ int b43legacy_dma_tx(struct b43legacy_wldev *dev,
 		return -ENOSPC;
 	}
 
-	if (unlikely(WARN_ON(free_slots(ring) < SLOTS_PER_PACKET))) {
+	if (WARN_ON(free_slots(ring) < SLOTS_PER_PACKET)) {
 		/* If we get here, we have a real error with the queue
 		 * full, but queues not stopped. */
 		b43legacyerr(dev->wl, "DMA queue overflow\n");
-- 
2.17.1

