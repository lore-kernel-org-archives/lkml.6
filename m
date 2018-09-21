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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B412C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3954A2156E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtNp2pQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3954A2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeIVEDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:03:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39336 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeIVEDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:03:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so14157807wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePbJ17DjNf7I7zTxOpZuDZhf+LZcpq+S97lhzE0CA5k=;
        b=MtNp2pQAP92DRhNDhg2vKTqu2+G2d57C92tkk7+bXrNT7tga5FCtmAIk/XX/e1hWBU
         dOfsPphJ0vY3Khp6+XdS8hFxM5oD2kI4Ay1RjfBfR8CPRqXv8wzcvktrwpqa00EOlqCS
         p1MJOPoFCXaVEj7OLoSYC9kQMUVx4lSCJTh74OjcUru1dz+oMfTn1LNsqNPuUyQx5KT4
         6gFSBHepM4w2wihUY+fVHhEYk3P3G1Dop+fKM8+Shh8PCKUOXc1J1SSPKL9KVfhKr+j9
         0XGtQyF7Bvs+rWURlAJlD86Fst00tyrNF95mYHmND86SzZnM5CIG9DQ/wEqzc9g4wcfU
         N9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePbJ17DjNf7I7zTxOpZuDZhf+LZcpq+S97lhzE0CA5k=;
        b=mR1ZKAXzVybdf6syNM7jpO/oIqTLXIdz8UnlSqeSVVl45Jjl8DbzqZrv8Hk7WtkYeI
         S6JYYp5WQW3qyuadJdpZJX6wAT7sdPHsP8mgL8XIovVF5bmp1SgsRFCIUTpf1dkMbb2h
         v5ggzeTKmMOkl22zxs62/btF4ssWY2C9QvSJyWoLYStkdaMkFWBXynau3fDcNCL792km
         GP0R2ONpg/Uxioe2No1WGyi24P7tCNj9/EYEoOZ1DfS/NeohhuPIs5s2L0un0Rafbsfi
         hc1iZ/bmeCGpqQQq1zfwjcjyPLTPvcvywDfg7SA5dComtVZnWdCRnDXQjIvpCKqnmiOW
         x1RQ==
X-Gm-Message-State: APzg51BtDS14Xe/FHdOQWtwUpcak9XKMwiKmQddDidVBZYwGgU8k2x9E
        Feuya2W6Uvporsmv07g5BsUuNY8nh5mvTw==
X-Google-Smtp-Source: ANB0Vdbm3uTxY9+5uQReds27/+DjB7FNHQPMq1zu5Qvf5Tm7bm7/LAb1Bsy1/MI5GTeN85EV4NhcGg==
X-Received: by 2002:adf:8367:: with SMTP id 94-v6mr39375430wrd.258.1537567930164;
        Fri, 21 Sep 2018 15:12:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 66-v6sm7243889wmw.34.2018.09.21.15.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:12:09 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtlwifi: Use proper enumerated types for Wi-Fi only interface
Date:   Fri, 21 Sep 2018 15:12:02 -0700
Message-Id: <20180921221202.20448-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:1264:34: warning:
implicit conversion from enumeration type 'enum btc_chip_interface' to
different enumeration type 'enum wifionly_chip_interface'
[-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_PCI;
                                             ~ ^~~~~~~~~~~~
drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:1267:34: warning:
implicit conversion from enumeration type 'enum btc_chip_interface' to
different enumeration type 'enum wifionly_chip_interface'
[-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_USB;
                                             ~ ^~~~~~~~~~~~
drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c:1270:34: warning:
implicit conversion from enumeration type 'enum btc_chip_interface' to
different enumeration type 'enum wifionly_chip_interface'
[-Wenum-conversion]
                wifionly_cfg->chip_interface = BTC_INTF_UNKNOWN;
                                             ~ ^~~~~~~~~~~~~~~~
3 warnings generated.

Use the values from the correct enumerated type, wifionly_chip_interface.

BTC_INTF_UNKNOWN = WIFIONLY_INTF_UNKNOWN = 0
BTC_INTF_PCI = WIFIONLY_INTF_PCI = 0
BTC_INTF_USB = WIFIONLY_INTF_USB = 0

Link: https://github.com/ClangBuiltLinux/linux/issues/171
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
index 4d1f9bf53c53..85a7490e6bbd 100644
--- a/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/staging/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -1261,13 +1261,13 @@ bool exhalbtc_initlize_variables_wifi_only(struct rtl_priv *rtlpriv)
 
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

