Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48A7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B7221A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B7221A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbeHHWiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:38:19 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34874 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729661AbeHHWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:38:18 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w78KH25F018184
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 16:17:02 -0400
Received: from mail-qk0-f200.google.com (mail-qk0-f200.google.com [209.85.220.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w78KGuCS011930
        for <linux-kernel@vger.kernel.org>; Wed, 8 Aug 2018 16:17:01 -0400
Received: by mail-qk0-f200.google.com with SMTP id f64-v6so3387678qkb.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 13:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:mime-version:date:message-id;
        bh=qRfUdlZyRUSOzzrFZN5Xgw1fUfxdmbVrndMuXCvgFMI=;
        b=nQH8oFqtqJT0KAPz+oGeybVTXz34TGm1wHD6yXN4sWarS/T32216S7nSfaQptGHq44
         feWHY1/boKPByZeWXajI9UoBZsB+AwbmNNIsQVGQHKTm6ztaNep31DRiHL9b0SzTyDaV
         gZT93SJYXPpFE57W/zvFxhtNgc02z63Dnh1iE434Z0xYo2Nb+r9TOzzxpD0URCIrRHFx
         ht7KmCKVbH/3GiDHxYrKwNJ1UOYxAoTzsXfgFZF8qJi/F7oud31UYIvGDZGsM1MtDKbU
         hX1Y4jtgwLqhV8l3OkD6IBJ9+bhp14Sgz+9K8yEgVrYzCwFEMZd4wcdt8XgNGahjVhxk
         OscA==
X-Gm-Message-State: AOUpUlH6PRQXX/3y+Q3YTLKu1QsJxbj77iC5ZaO2NGmABUG7cLjr5h+L
        /XLcaVmrhpxn2cxSBH9Kj4aDSeyqEQfAoVWmlAIbKr3lvht3Km74FkpWM/7UJereVjJpH4fAAx5
        yDoB92J2P8Bb6JwwKnHiF4et3J7Bc0w+e4yc=
X-Received: by 2002:a37:8ac2:: with SMTP id m185-v6mr3769369qkd.401.1533759416783;
        Wed, 08 Aug 2018 13:16:56 -0700 (PDT)
X-Google-Smtp-Source: AA+uWPxhTujOvemFcgwYj4fYbOOAX1HRiSUHsGRVLgvkn+GorfrlsexwaTwbGq/gtq/1+rJXHaek9Q==
X-Received: by 2002:a37:8ac2:: with SMTP id m185-v6mr3769354qkd.401.1533759416538;
        Wed, 08 Aug 2018 13:16:56 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4340::377])
        by smtp.gmail.com with ESMTPSA id z18-v6sm3615444qtz.89.2018.08.08.13.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 13:16:55 -0700 (PDT)
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
From:   valdis.kletnieks@vt.edu
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH] fix build for MediaTek MT7610U USB wireless dongle
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 08 Aug 2018 16:16:54 -0400
Message-ID: <145751.1533759414@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mt76x0 driver requires the mt76 core driver to actually function.
So add a 'select' to avoid embarrassing 'symbol unknown' errors
when attempting to modprobe it in a module tree that doesn't
include mt76.ko

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
Still need to figure out why it totally fails to see the 5gz band,
it works find on 2.4 but ends up locked at 72mbits/sec. Works
OK otherwise...

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 850611ad347a..b6c5f17dca30 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -11,6 +11,7 @@ config MT76x2_COMMON
 
 config MT76x0U
 	tristate "MediaTek MT76x0U (USB) support"
+	select MT76_CORE
 	depends on MAC80211
 	depends on USB
 	help

