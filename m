Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B4C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CA3217BD
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 14:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf2ECf5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CA3217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeHLRbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 13:31:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39600 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbeHLRbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 13:31:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id a134-v6so9569836lfe.6;
        Sun, 12 Aug 2018 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g/mn5+dYy3phpyIHh3N1We6mfdSB17flN2Cpgf2iUCg=;
        b=Bf2ECf5wLhjTUL7OWh8LGjXcJXWhto5AMYOrSWYjP+fVYQHPDX/jys9QXZyvqNgPUV
         Gq7CUmTSk8n7YNIgjk+wsvH6y/RUSN6TX27o4h852sM4kMRpbsf9E2dlmYRPl4dAXym8
         /qoS+3aYvseGca0QwevhywgcoavLulLnKCEX4/1GrLubfbTLCreqCblwnoBbzNwNW+m4
         9zoPP4QbSvoJ/JnP9bSagby8NR0HYNCjma8fhGfSaRvQiyuypP6FsZ2l9esu7qRsMd9B
         jTJ9lyTIX0qujOTqGwblBtPSmh+ucSdIAISNfZi1wvA2eQcsT7RGLfEAuCiPZn498519
         Ce5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g/mn5+dYy3phpyIHh3N1We6mfdSB17flN2Cpgf2iUCg=;
        b=DkfwIseouPN8CXfYuNWi+yjcj5Y+KR/N/Oh8zK/odIoGSt/NoahJ4AM4bse0EEVPVa
         yvRJyz2m1QxsQlk3iLhHW+Lfa/27AgIce37u4zHPI4gEBMyMb3tmiG3dX0mpIp70bZyH
         wjPbGnXLe54bOaihEsjke18eEEs9bCsB0raay2o7JqwQH9Dpvp+IV69ACrMgPT5Su+aH
         ddfMXoAGg8qx5VFPYC4aUBGFHOmUCKkADawoXrCtOimN+gjbCwFtz3Dz8EAYrnHgJnL9
         wiQNlxXQcKUcac2CJwGDVkSaMjI+LkD1psnnXAiR+urVVwDpQBGBaOXQOVd63dcQMgaj
         81mA==
X-Gm-Message-State: AOUpUlEVyFhb9f39wHu0biOFbqNtZACGOForSr2mqMO1L9RAMS3fV1xn
        Y3/ZJfqcEHixaJ2qM3jv464dYSNH
X-Google-Smtp-Source: AA+uWPxZ+6Fp5+niRbELS2VqbK5U3YvWC8DipBfXui9Ekni6CsbixKIZ7Gm/Osk+mY5e8kUqxZqJWg==
X-Received: by 2002:a19:9345:: with SMTP id v66-v6mr8880676lfd.89.1534085584775;
        Sun, 12 Aug 2018 07:53:04 -0700 (PDT)
Received: from localhost.localdomain (155.51-175-192.customer.lyse.net. [51.175.192.155])
        by smtp.gmail.com with ESMTPSA id p134-v6sm2906631lfe.11.2018.08.12.07.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 07:53:04 -0700 (PDT)
From:   Kristian Evensen <kristian.evensen@gmail.com>
To:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kristian Evensen <kristian.evensen@gmail.com>
Subject: [PATCH] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
Date:   Sun, 12 Aug 2018 16:52:07 +0200
Message-Id: <20180812145207.11395-1-kristian.evensen@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the use of CQM with mt76-devices.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 029d54bc..3eb328ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -305,6 +305,8 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 
 	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
 
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+
 	wiphy->available_antennas_tx = dev->antenna_mask;
 	wiphy->available_antennas_rx = dev->antenna_mask;
 
-- 
2.14.1

