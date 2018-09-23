Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26178ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9A9214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g97WCU8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9A9214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeIWM2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:28:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39164 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeIWM2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 08:28:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so6977665wmq.4;
        Sat, 22 Sep 2018 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H333hdIv99u4O3EPtOYXC4qj6MMzuzW/SZ5pBDZ3X9A=;
        b=g97WCU8PmQSX+1ZhRX4h2jZxCZmYoGJF8CoyhwFKbMepY0TepddeTzuLcn1COo7G74
         x+x7uOK4cj5skddCp+OzyJLS5etJ9KATyaOXWkKkZfNq/90hL+BAevfYkMi+cbxfWfO/
         jPeTSKGdedYiK82NGPDBUCJ3+2iDgrCS8vZ294imCVvuVGn844mGYK5nk9+OLq+l584Q
         VhAOw6eTwKlEQFSDqV/FpUfN99KYtQo/P2+TUjZ1a8yQy6lQuiiBoRAz7lG2OeJK8nU2
         kdBNKMXDaRUXy5Iw37hxzEl8qh0l9wIbUJW9POg348HXU85twUP5cZPYZSCuF4/kJp8s
         gHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H333hdIv99u4O3EPtOYXC4qj6MMzuzW/SZ5pBDZ3X9A=;
        b=sY7wom+1US2OUWQlmpJ73ZJtVTz6JRip48fXpD/FtgVamn9KM8rxlcyAw85TDNaNw0
         TCFTa4mSNvz0I+h8E0Z/EsiG382Pt4csznx8nENnpxz9cmmA88gPGtkmaVzvxZS0nV4w
         j9xys/f/kzCwlQLXaPW3frI3GbzBOeJmo0yUa9g2/xO4R69ZQcTRW0dOBeBqf/ELFuP5
         Rcl2rSW0lXrAB9R6MZPi9h8wLKEEthtALOBAzdacCGR5MLEDdLPiH9kZAyd78IjNC9tv
         a5tA/cNJ+zcz6bOu3xCNnEhhEWLbkUvDkHw/41WGHg77PiGhGYJ2ngMLSeFi5mL7Ffhp
         zjPg==
X-Gm-Message-State: APzg51AvW3p4umYz+kOBQ6/V6t5vIyCtxnN0//l7dZ/dRE/+Feqfhg60
        hQ7XVzq0QkOBglbIE29htC0=
X-Google-Smtp-Source: ACcGV611pYZBQ+HZHm8TsshsvwKn5gcG/++gg0zK7xQBvY5dQ3wYw5KplR4om5tTQPl2bu9Qm49DWg==
X-Received: by 2002:a1c:e286:: with SMTP id z128-v6mr3122463wmg.30.1537684321550;
        Sat, 22 Sep 2018 23:32:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k5-v6sm30046778wrc.14.2018.09.22.23.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 23:32:00 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] rtlwifi: btcoex: Use proper enumerated types for Wi-Fi only interface
Date:   Sat, 22 Sep 2018 23:31:15 -0700
Message-Id: <20180923063114.11446-1-natechancellor@gmail.com>
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
BTC_INTF_PCI = WIFIONLY_INTF_PCI = 1
BTC_INTF_USB = WIFIONLY_INTF_USB = 2

Link: https://github.com/ClangBuiltLinux/linux/issues/135
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix enum values in commit message (previously all 0)

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

