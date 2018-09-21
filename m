Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5AA21476
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQwq3fgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5AA21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbeIVD73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:59:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45548 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391541AbeIVD73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:59:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so14153658wrb.12;
        Fri, 21 Sep 2018 15:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA07kWLbLZOO9e1jBHTdKYB0px0V/fOGcDCUkiz3N+U=;
        b=iQwq3fgBrPWcw5S/JTmQ/UGpAsp+y1xy6gTcsQuiuj33I4+QmgcU8qb64n9vqweSTb
         Hw5IW0tuOTvVWQqr/FMBmKUexklrpInelYqpLqljlnDuteq7fWdZi77fhWRI4FpY6+qw
         kozHAQtUZk0jcG4cjQ8nN7kOS8EgPXqSBvOqR7NaMPhNhw0VT1C750drX62OljrtbMfB
         mMWpfbOUXN8dKQ40809zhUCwZ6JOT637oxuFW0jhkonOEtdMY+LYza5fRfWj+QHRHxIq
         h0CL6FTo9CM1js2ZkhZMrQ2piGx8K1r2Y/cas9bTAgtS7pj/M+jgibtgrShiqXEDS+8N
         pEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA07kWLbLZOO9e1jBHTdKYB0px0V/fOGcDCUkiz3N+U=;
        b=YWnhZDPrBjdzCoV1vdeXTnMtDi8hWoWskDwLSjYqGhs9KvTlLkUhNP7xGEI1Eae5th
         o0QLx9+KvSpNwnZKz2VITZCtn8+j69DT3ZcxQPnT17USsFlkB5q08H0IPKQ5DoDFB+rX
         /oKRkipN5WqMrfsp5Vrpu1UP1UntXIHqscE6L3SzZKtCoXcdgRgc9k9RceWtWGnZa39c
         teZnvL3QyujKn8oHgCTpxpFo9CWNRv1Ojn2R88VAqOne40c5/O4xZN1ome1rIuiPvGEQ
         j9vINMt7Yv1kBkLXhgRLRRZQtWN3ga7Vehyb/oX87L1jCw8c7Uj/tjK6xVvIgefhro49
         nuUA==
X-Gm-Message-State: APzg51BXPFQ68LH8P4muvBR33TwL/c/vGeKd4qt6plT5VuSx27t4CSWc
        x1Ws9j/vqb9hXLdVbHv9hoeIVqyRn8rGFw==
X-Google-Smtp-Source: ANB0VdarBl/3noxrQX1M2pzRcMLqONUvi+kq/vV7gA5dmENeTjWmjqfBLizcE+d0C4nCA4v7faRVfw==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr40303274wrs.89.1537567718221;
        Fri, 21 Sep 2018 15:08:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f6-v6sm20848823wrr.68.2018.09.21.15.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:08:37 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] rtlwifi: btcoex: Use proper enumerated types for Wi-Fi only interface
Date:   Fri, 21 Sep 2018 15:08:24 -0700
Message-Id: <20180921220824.18344-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1327:34:
warning: implicit conversion from enumeration type 'enum
btc_chip_interface' to different enumeration type 'enum
wifionly_chip_interface' [-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_PCI;
                                             ~ ^~~~~~~~~~~~
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1330:34:
warning: implicit conversion from enumeration type 'enum
btc_chip_interface' to different enumeration type 'enum
wifionly_chip_interface' [-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_USB;
                                             ~ ^~~~~~~~~~~~
drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c:1333:34:
warning: implicit conversion from enumeration type 'enum
btc_chip_interface' to different enumeration type 'enum
wifionly_chip_interface' [-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
                                             ~ ^~~~~~~~~~~~~~~~
3 warnings generated.

Use the values from the correct enumerated type, wifionly_chip_interface.

BTC_INTF_UNKNOWN = WIFIONLY_INTF_UNKNOWN = 0
BTC_INTF_PCI = WIFIONLY_INTF_PCI = 0
BTC_INTF_USB = WIFIONLY_INTF_USB = 0

Link: https://github.com/ClangBuiltLinux/linux/issues/135
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 .../net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index b026e80940a4..6fbf8845a2ab 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -1324,13 +1324,13 @@ bool exhalbtc_initlize_variables_wifi_only(struct rtl_priv *rtlpriv)
 
 	switch (rtlpriv->rtlhal.interface) {
 	case INTF_PCI:
-		wifionly_cfg->chip_interface = BTC_INTF_PCI;
+		wifionly_cfg->chip_interface = WIFIONLY_INTF_PCI;
 		break;
 	case INTF_USB:
-		wifionly_cfg->chip_interface = BTC_INTF_USB;
+		wifionly_cfg->chip_interface = WIFIONLY_INTF_USB;
 		break;
 	default:
-		wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
+		wifionly_cfg->chip_interface = WIFIONLY_INTF_UNKNOWN;
 		break;
 	}
 
-- 
2.19.0

