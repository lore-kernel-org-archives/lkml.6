Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEB8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA0221A9A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK7VDg/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA0221A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbeHHXWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43244 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeHHXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id j21-v6so1880161edp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tbR8eUZTuIBm7CpmO+F1OX70+iRRNGNJCVqnmghiLy0=;
        b=KK7VDg/fLL5/xXzTK0Ki6hMHdDX4u29NXhhpAMZNl0w/KlHg/w16GV6FRJNgXeDIds
         eIuXRUwe+ms9HDNUDatirrfCShKEFh5vnEGUwrQ7r+gBk/nf6Jwk43BNAMcNCna32HRu
         FQ2TyXUPFLSpvQIASz2v5cvEMMl2wjjmC56/VDejTJaLjA/3CkTkEq6MRv61q1E7SvDG
         E8NQ80qCra4vPQAeC6OdHSg5BNdcujmSMQ/q5mlzIpbpZNh16y7V5NdXw8kXvTYHG7OA
         IoVSuy7G1kDJDimNjjjME0s1LRgt1+4N3DfiGQ1Ykt7NJry8VgTgRmMWa8Yy1a5bYfYD
         1ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tbR8eUZTuIBm7CpmO+F1OX70+iRRNGNJCVqnmghiLy0=;
        b=LEjxc8Kfk2eyFVghV/zfGaIcuP54ctOnp5yLBCzkVwDdP1tkDcOWq0Qmneos7B3Lbg
         oJZe8DAtZV0bir9A73eMXKjiqeZsxx93WxIN/Sx5lvqtUv4wKC8JY8pcm4wrrj9rCRGR
         R2LEZMqMVg/EM+aSo8Cbp6b4aJatvTPhxMVknr0CLWoakpUFb3YacEqWxLJDOsboLqZL
         /pkejhHLq0xFr+T+pqENwuucED6fmFIrGprDXEwVnE1ba0xohvKuQQg3TnKa/bC1jAe4
         m4Fl0o7TkgpyKssvrtQTPbFRbrWvYjAuNbk7N0b7hI6LDsu7bDWNUr8SSNEdY3ffKydj
         NU4w==
X-Gm-Message-State: AOUpUlFUOyZOFizLEYrso8qYtqN5LvN1NFTzApa//KJLIV54QDyrQFLW
        LCIBOkgbuA1/pqiCN9ox0SH9z++e+Bk=
X-Google-Smtp-Source: AA+uWPw1BzKZ9QiYkM7k2FDura9sEzJHrGUen5YePyLYj9L4sWvB/F9aCgXxBPjrQ2GZYo0tFW06sQ==
X-Received: by 2002:a50:fd93:: with SMTP id o19-v6mr4886273edt.73.1533762076754;
        Wed, 08 Aug 2018 14:01:16 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 15/15] staging:rtl8192u: Rename ToLegalChannel - Style
Date:   Wed,  8 Aug 2018 22:00:36 +0100
Message-Id: <20180808210036.22580-16-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
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
index 37c493789608..be59f720ae20 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -52,6 +52,6 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void dot11d_scan_complete(struct ieee80211_device *dev);
 int is_legal_channel(struct ieee80211_device *dev, u8 channel);
-int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
+int to_legal_channel(struct ieee80211_device *dev, u8 channel);
 
 #endif /* #ifndef __INC_DOT11D_H */
-- 
2.18.0

