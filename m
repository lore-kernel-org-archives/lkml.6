Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E300DC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F021A74
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/FORV79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7F021A74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHHXWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 19:22:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44944 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHHXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 19:22:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id f23-v6so1878394edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0mo9ePQtTLHbjGJoNEjCgXigFQ/SIBELo98X9bp7FWg=;
        b=O/FORV79paIIDCw38wMtDgUov5m0rzOe4/WVFMsWLf1IBXvNVD9mUaqRzkh1mOBqEB
         0YHH4V/GAWCm95Xx1zyfBvbxnF/U2V8GImR3xWPuC9uJznkt1s1GBPXrc9y5xi8cHotu
         Gg5umEUcSqk5od2TSowyR+aoEU0EWeRaIT4yhhYbRnnEAu7beEdSPp91Ic9G6FIGP9r1
         glNSDHQin4NC7zo07tWFlqE/fmv7I9EiU7yjZIzVQJZnGyU8nDdmIHepVHxGTc2BBLjs
         hzClNSzQdT/Og1/D1GvvXdpOO1hSsAqTTBi9bVjDod0dqdSwbj4ZiWxyj8utXpH9n6mN
         lLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0mo9ePQtTLHbjGJoNEjCgXigFQ/SIBELo98X9bp7FWg=;
        b=sHyYeGhe9x3bfdX6ycrigk+kpw/voMuowIVSJYR5toRh9eZsztpx5JUyJ2oibxY3zo
         +RYX4dAb3H/Skyfnp37BfuPSIKR1CmTkVVST7r0+uWIhhik/64fjmRS1gs6xSsHIxXNL
         llRjUCHNBBI8lix6xDpa7gJhuqgNoStrfAY+RtVEcEAbvo2XeMBGBkV9+v3koRve/O3T
         ZagZB5za/nmp/COPiYnPRoRcewlXZ6WMDIKvHQm9qpCS9xFXHbXQ4uzcs2/ahSeW4Hl8
         VNkYYW4MCUSL0wLLSVrWWSbi8mBjZt7/VAj45qTMhqdBd+GVie1xh0DtBe5Yxo5mZCx/
         mXIQ==
X-Gm-Message-State: AOUpUlFqZHVT65BnJfAPIdYAqQgvS2TlUl0174XEzSSV41eNvhtFrKvF
        rqjPKDPYpae1NP8VzAtsCdQ0lMB8uxY=
X-Google-Smtp-Source: AA+uWPw4zRnGDsOPig9jFcGXzOIerxXf4a69n+SYy51qVwYb1VvPqalot1VQJmYfAhA54iyoJE4/UA==
X-Received: by 2002:a50:ae98:: with SMTP id e24-v6mr4946778edd.16.1533762072464;
        Wed, 08 Aug 2018 14:01:12 -0700 (PDT)
Received: from localhost.localdomain ([109.76.213.36])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1883847edn.28.2018.08.08.14.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 14:01:11 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 12/15] staging:rtl8192u: Rename Channel - Style
Date:   Wed,  8 Aug 2018 22:00:33 +0100
Message-Id: <20180808210036.22580-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808210036.22580-1-johnfwhitmore@gmail.com>
References: <20180808210036.22580-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dot11d_get_max_tx_pwr_in_dbm() uses a parameter name,
Channel, which causes a checkpatch issue with CamelCase naming. The
parameter has been renamed to channel.

The change is a coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index cbf93cd27f45..d4333ea106fd 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -49,7 +49,7 @@ void dot11d_update_country_ie(struct ieee80211_device *dev,
 			      u8 *addr,
 			      u16 coutry_ie_len,
 			      u8 *coutry_ie);
-u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 Channel);
+u8 dot11d_get_max_tx_pwr_in_dbm(struct ieee80211_device *dev, u8 channel);
 void DOT11D_ScanComplete(struct ieee80211_device *dev);
 int IsLegalChannel(struct ieee80211_device *dev, u8 channel);
 int ToLegalChannel(struct ieee80211_device *dev, u8 channel);
-- 
2.18.0

