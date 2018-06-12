Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4DD8BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CE02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiNeP3B2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933212AbeFLLjj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:39:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44481 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbeFLLjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:39:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id 36-v6so35457366lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 04:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i7ebp6igC4T0NhmXNPm/+Mux8LUEMtkEedO9jVa6348=;
        b=JiNeP3B2Hz84mS/IqmehbfTC8slPJKlCPyPtv0094XPBIDb4DMWTDoaaZa+JTtDnuw
         /xxArCbv31MMXWcrc/m6MkyoqC5e/4rvb7KwnHQCNSdH0iGRTIQIG9/W7IfPsPRdgXtp
         37d2IWEzsQ00ScCj6xhhKexeDhd3Wu/LVVfdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i7ebp6igC4T0NhmXNPm/+Mux8LUEMtkEedO9jVa6348=;
        b=bU176UkkBAe39NgkIlBnS4vU8ZP29N1zO7wNvrYw7AxSRO/jIBipGGRLTkUkljT/K8
         c0/07PlfCa7DskxbVzZeDSW9PyDzajGHjsq1RboQzwmeb9ql1cVBLaxOu6Pl9ZylGPBR
         W+l4NtMwR4mqTz4QtVf5p4lWtVNqhLzDI3NTXMk6tvkmZahqB2Gq1xyaf7ERyKqOpPrs
         cVPBQYbYani4lV4Pz5xiEFFjh4gEE3V/UOsccjldNnMAUizgO9jRuPo5lLRV71xg1rbn
         lhiPSOc5t2SgzAaTYk2vwnzp6Z63g0xXen741tf3XyioN6hnEsZc2VfxtLsWIE2hFb59
         y5Bg==
X-Gm-Message-State: APt69E1jjGc9RX5pbB3mMaBxtDQhCJHLtHaV0RpgCMAYKYu1vZ5+9A4T
        uUjjwsN3WEpN9OnR8df36BkfwQ==
X-Google-Smtp-Source: ADUXVKIhR4MjHV+GcPLDITHLQjaSPzerqhUEOON/MmN4f/P5BW2j7CHMqLh/dYDX8SybWlbYuXO8Cw==
X-Received: by 2002:a2e:6e19:: with SMTP id j25-v6mr2255933ljc.61.1528803576322;
        Tue, 12 Jun 2018 04:39:36 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id o11-v6sm186162lji.0.2018.06.12.04.39.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 04:39:35 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ath10k: do not mix spaces and tabs in Kconfig
Date:   Tue, 12 Jun 2018 13:39:05 +0200
Message-Id: <20180612113907.15043-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not mix spaces and tabs in Kconfig.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/net/wireless/ath/ath10k/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index 84f071ac0d84..54ff5930126c 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -1,15 +1,15 @@
 config ATH10K
-        tristate "Atheros 802.11ac wireless cards support"
-        depends on MAC80211 && HAS_DMA
+	tristate "Atheros 802.11ac wireless cards support"
+	depends on MAC80211 && HAS_DMA
 	select ATH_COMMON
 	select CRC32
 	select WANT_DEV_COREDUMP
 	select ATH10K_CE
-        ---help---
-          This module adds support for wireless adapters based on
-          Atheros IEEE 802.11ac family of chipsets.
+	---help---
+	  This module adds support for wireless adapters based on
+	  Atheros IEEE 802.11ac family of chipsets.
 
-          If you choose to build a module, it'll be called ath10k.
+	  If you choose to build a module, it'll be called ath10k.
 
 config ATH10K_CE
 	bool
@@ -41,12 +41,12 @@ config ATH10K_USB
 	  work in progress and will not fully work.
 
 config ATH10K_SNOC
-        tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
-        depends on ATH10K && ARCH_QCOM
-        ---help---
-          This module adds support for integrated WCN3990 chip connected
-          to system NOC(SNOC). Currently work in progress and will not
-          fully work.
+	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
+	depends on ATH10K && ARCH_QCOM
+	---help---
+	  This module adds support for integrated WCN3990 chip connected
+	  to system NOC(SNOC). Currently work in progress and will not
+	  fully work.
 
 config ATH10K_DEBUG
 	bool "Atheros ath10k debugging"
-- 
2.17.1

