Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC96C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65306217C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnYvaDog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65306217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbeHDLTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:19:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43056 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbeHDLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:19:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so7568787wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TvKvZapJIAxSnc8+Z+TutHRChSsCe7DibYYYZtHewtA=;
        b=fnYvaDogHyVfkgw59wRfltyFxAE/7BOj9EtvSbvXX1fxu68aJJDtA8zWqo06H0No2K
         gcpmJmusPAKm/8ZbuWdqqB4XmZCkC9GJRxzr+wWIKH/5oCdyId4287fbkmzi0a/K4FUV
         mksMrncDXIjW/q0zKX1xmsaMOVvAAHNgMB6WCWG0K4YZjHR/u9cKw0wGIJdggDgGmNqu
         ZupqKgmGBOFU8MXuxuBrjD6rLmtaNxsB3U8XxhMO7j02jvvJceBMk5Ns+YqBOBWcysE5
         DlO6Ca7Jmw+LCron/EbQVQyizBwUBfvAIoqWxUM0vvhWK9yE6U/AeF3j2WLXOgrEj6fp
         2wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TvKvZapJIAxSnc8+Z+TutHRChSsCe7DibYYYZtHewtA=;
        b=qr66DUwHfmZLxT3090R99O5pE5q3EmwDm1diwhj8V/2e/nHGx56XJUlH9p1lEw3W+H
         07jj2f8JkB9HbRo2Dj8kxNZPdKQpuFfu1ij3KCn6Wvd5a5gvhOHvXckuM8KnnAtIx10F
         XYAmdP3zYX0ldQHvQ7uVyu2up4iqzMYX6lUiIMWsgGoTvxU8CJNCOry/5qf9k62jrxTE
         Nvc6GLuLVDuZJQLuag8CkIYq+YrPxdWqqh5V/NmzPKL2ehhN9iPWXVeC6Rqo+XAG9Wvy
         P9wdcx78eEDsc7E4MRb4IljesX/ujPp8OYOkEUV4NBQVWC0r/nUdwucW0r8nzPezRI5Q
         pQfw==
X-Gm-Message-State: AOUpUlGKEniYw5PR4LNOVndAksLI9C1PKIB2m2OJ6cKwbCPHikbayxg5
        XKBoRc1rWhBCIBUo11cAVt72oujKHqM=
X-Google-Smtp-Source: AAOMgpc9KbNBRx6lv+pF5D+gVnTPKG7ZdJTDeHgVOq9kRR4PILrthSVuGiwqZ7L4r/dhmHi8zfQLTQ==
X-Received: by 2002:adf:93a3:: with SMTP id 32-v6mr4494476wrp.140.1533374354812;
        Sat, 04 Aug 2018 02:19:14 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id q188-v6sm2710040wmd.36.2018.08.04.02.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 02:19:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 7/7] staging:rtl8192u: Replace magic number with defined constant - Style
Date:   Sat,  4 Aug 2018 10:18:59 +0100
Message-Id: <20180804091859.6729-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804091859.6729-1-johnfwhitmore@gmail.com>
References: <20180804091859.6729-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the magic number '8' with defined constant which is normally used
'MAX_DEV_ADDR_SIZE'.

This is a coding style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 51cb5e4658b0..212cc9ccbb96 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -217,7 +217,7 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, struct ieee80211_device *ieee
 	struct rtl_80211_hdr_3addr  *header =
 		(struct rtl_80211_hdr_3addr  *)skb->data;
 
-	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + 8);
+	struct cb_desc *tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 
 	spin_lock_irqsave(&ieee->lock, flags);
 
-- 
2.18.0

