Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B960C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8882083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzxaVSwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8882083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeIAMt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:49:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36741 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:49:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id v26-v6so11790297ljj.3;
        Sat, 01 Sep 2018 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O7Tjqcj/rIwztbOo0PVgR+qbyuzZ9PZ2BchzrTsHhb8=;
        b=TzxaVSwxixugQYPNA2TIHNCR9bMD9fMlRiKHJmSzxrSNOeFR+vvB4wH5WcAcRHzWm/
         JRIj6HdqWKkJHY2vaqvDGRLUGGY1rZUk1QTJg1c+NUKUj0oLbsz7Blq7ZlqyH32sMyEb
         VGszl7u/dJUFflancHkXYZ/PY8nH/+edIMkE2/E9xqKSnIgz/GB/oKINndEC2G05ljvR
         l75JZPdoyt5n75r98mjOpFaoxxnupau07c4hAX404Vrut1ZB8TSccwYI1RJxR2dSdtlt
         slMWPigJP6tY8ukELYMuvP92ts3LN4mMS88aEebERpuYFYQ3t2wn+ReS94XXQG2Gk+UC
         h+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O7Tjqcj/rIwztbOo0PVgR+qbyuzZ9PZ2BchzrTsHhb8=;
        b=asj/tIiS/GdC7tyu1+FWi9BH8iArah2J5HJXRf+kvOY7gAaBeHW40uOk9/ffHsVjcO
         Udqs9svvlGp5inCQb+jEvRbVCBAMcw9SWmGuPGs98nMpJ/ZE89nhSP58EBY53QvfB8Pk
         VpVj7+i05Xsg9BU+XZ3LBXmNVE4B0ImyZC871ORSxafDv1MAOfFyo6hPLQUraHD2eA9T
         /GGPp+1CxYx/7JUYEpYXj65EKBShrkXTx5AJ19yRBVjG9jmJVV76NBuLQx3ZRA79KF3y
         c86vWZKDPxj20AXjJQZvNbU8cfjfp8xWK98PeYI8QckRq4eX5sGrguXHr1mZUsMzudzc
         +mKA==
X-Gm-Message-State: APzg51DCHeRgUv/D0OtgqMO4gMFlAUYkG/+ipYq7iHjNcnu5PTu7zU1F
        9GZBoGIwjbHGvwedfGjUC9S0eHFon1M=
X-Google-Smtp-Source: ANB0Vdb1jQ0tHaS4y4eKBa7SfJntcj9eKGJtZpMlu32JbDCH519RmcfwndPd7VGy4myZtAcpOIAOvQ==
X-Received: by 2002:a2e:350b:: with SMTP id z11-v6mr13021545ljz.55.1535791119984;
        Sat, 01 Sep 2018 01:38:39 -0700 (PDT)
Received: from kristrev-ThinkPad-X1-Carbon-2nd.lan (155.51-175-192.customer.lyse.net. [51.175.192.155])
        by smtp.gmail.com with ESMTPSA id n17-v6sm2152162ljb.82.2018.09.01.01.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 01:38:39 -0700 (PDT)
From:   Kristian Evensen <kristian.evensen@gmail.com>
To:     linux-wireless@vger.kernel.org, kvalo@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kristian Evensen <kristian.evensen@gmail.com>
Subject: [PATCH v2] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
Date:   Sat,  1 Sep 2018 10:38:34 +0200
Message-Id: <20180901083834.11201-1-kristian.evensen@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the use of CQM_RSSI_LIST with mt76-devices. The change has been
tested with the mt7602, mt7603 and mt7621 PCI wifi-cards. I passed a
list of RSSI thresholds to the driver, and when disconnecting/connecting
the antenna(s) I got an event each time the RSSI went above/below a
threshold.

While I have not been able to test the change with any of the mt76
USB-devices (no access to a device), the RX RSSI management code is
shared between the two device types. Thus, CQM should also work with the
mt76 USB-devices.

v1->v2:
* Updated commit message. Thanks Kalle Valo, Arend van Spriel,
Lorenzo Bianconi and Andrew Zaborowski.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 029d54bce9e8..3eb328ff8c0d 100644
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

