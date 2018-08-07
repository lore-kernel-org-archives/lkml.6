Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AEC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0D4208A2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 21:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEAN2w84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0D4208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeHGX3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:29:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44514 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeHGX3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:29:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so43890wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 14:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sA66F/dX7EqyWaS6aNgAvXje+udMpuwGeiLXeszRTX8=;
        b=qEAN2w84B1ZjoKj7cna4kDqAH1laEB8Bz5KPv1QbuxY8XSyuN6U8nmhPnCtks6qI15
         6H8ZuCcJmZr2FzTO1SCuqEwkVJeF2MQqi/lK6r7bkX44clFYM1mjOhBvzOdVTagkmmUT
         tnbHPkxnsEWf+HGbZ21mY71I8892KDK9KUfPNk5zlmhbw70WZBMR7OgJIvGFiu/oaVvH
         ftHxSKf2HTuKj9erH3E9+ESM+WJVNGR871UJQ9F5wixbpvezIZDO3KuRw2EFfydzKS0M
         qjGwSzSDDODKWUmfcT0abSXpqwvTJcDjMVIn0wGhmNmyN9y1l6q1S56VGqo63hXVvI6H
         Lx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sA66F/dX7EqyWaS6aNgAvXje+udMpuwGeiLXeszRTX8=;
        b=C3t4AOXSoexMtGE8umKhHaVYcSMinNBU7UXRt9711VaJhMC73KV4p/mk9I0MvMdwyr
         tgJ9Jpj9Eh5KltVeTQ0IJYV0nJuNs+zC0hXmyUspsNfniXJpfzdpOpWCpE768Jd/KG0U
         O+Ra0B2IcV0Xo29XWPUqQr6dU8Wuyo0Bmt6ugvSUghwyPbAm2CyPI3BWfq+zslTIKV+E
         SilzfeTXUhsdbFetm+sWIOQ0LiNAC6o7m1nDUwAw6TNPMUVfwOS2udrOl51IO4pKn+Zv
         XbKkcb0zDhcTSjakEKb5sA/IfdW3lFDJrLOuhkvDQrGUfV2Lg9oCs16UBwe9VwLFnNNC
         A/rw==
X-Gm-Message-State: AOUpUlEyw9lh08gzKMukVNi/MIJT5cvVLWV7YTHhicsm082/g+Qc6jY0
        CVl0vYo1N4IZ1C/iB7PcVfyr6k8/
X-Google-Smtp-Source: AA+uWPxNnMVPy6QM4xD6+UzuWK1giuvAmO0IkPDO0Gd416dBQJ9GIO43wkoiBbGWxzcTCPvoW+elyQ==
X-Received: by 2002:a5d:438d:: with SMTP id i13-v6mr62737wrq.156.1533676407145;
        Tue, 07 Aug 2018 14:13:27 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o3-v6sm3375985wrj.31.2018.08.07.14.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 14:13:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/17] staging:rtl8192u: Rename ToLegalChannel - Style
Date:   Tue,  7 Aug 2018 22:12:55 +0100
Message-Id: <20180807211255.29343-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807211255.29343-1-johnfwhitmore@gmail.com>
References: <20180807211255.29343-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the function ToLegalChannel, which causes a checkpatch issue due
to its use of CamelCase naming. The function has been renamed to
to_legal_channel.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c | 4 ++--
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/rtl8192u/ieee80211/dot11d.c
index a116858d151c..d3b13f0cfc09 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -150,7 +150,7 @@ int is_legal_channel(struct ieee80211_device *dev, u8 channel)
 }
 EXPORT_SYMBOL(is_legal_channel);
 
-int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
+int to_legal_channel(struct ieee80211_device *dev, u8 channel)
 {
 	struct rt_dot11d_info *pDot11dInfo = GET_DOT11D_INFO(dev);
 	u8 default_chn = 0;
@@ -173,4 +173,4 @@ int ToLegalChannel(struct ieee80211_device *dev, u8 channel)
 
 	return default_chn;
 }
-EXPORT_SYMBOL(ToLegalChannel);
+EXPORT_SYMBOL(to_legal_channel);
diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index e792aaa9995c..6c30ed66c09c 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -58,6 +58,6 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void dot11d_scan_complete(struct ieee80211_device *dev);
 int is_legal_channel(struct ieee80211_device *dev, u8 channel);
-int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
+int to_legal_channel(struct ieee80211_device *dev, u8 channel);
 
 #endif /* #ifndef __INC_DOT11D_H */
-- 
2.18.0

