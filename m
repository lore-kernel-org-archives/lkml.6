Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDCC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61924214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMHizEOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61924214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeIWM34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:29:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46365 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIWM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 08:29:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id z3-v6so4706202wrr.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 23:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FJ3TdFIYF/rRo2mvsg/nfN8pN44Hpull4OCxpr45UQ=;
        b=tMHizEOSWJkHVn4+Dl2bBQKjnUPJO9XsKuYEJp2t5MACvVFpRWeaHXj1M6gKevqm0J
         QP6WGGRi7OjMYNEna3kjZqDTF1k37TiplE+75RQhwAP5Fkeit/ROnl4sY20gAEPHRjB5
         i4fRJXRhK7dKfvj5uVMd5Bz6a1VSTkqeLOlqaSoRzsYXTvarUGHVXZVAfT4U5hutnU5G
         VDvSg6n7Z/75KNvb1DhWzzuo0Xxkk8MdYrEINDF4AANh8HyL0JxmQ8odvxVDe+i3bH8g
         LbStBtrjVEpk/dt53o0uG28lg8qhOeOhAzlH4TpXHvc1cdw3QplIwyX2PH9/+hGL1rVa
         tC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9FJ3TdFIYF/rRo2mvsg/nfN8pN44Hpull4OCxpr45UQ=;
        b=Y+Iuyx8EUKRcBUZ4bLzfBZsb6R48ePpksFWJvk6G6VzPEWGmVJnkQB+1dA0jbNFOxh
         I1M2LquDocURnFd/4AZSr5tHmDSn+Ubf8Oqvy4Jld31A8Kaqw/z/e1g1VKUo8F4HX+eF
         Z37wDpuRpe+6P45YfeAFSqe3gnyrd5fjbBolKs2XToUqpLMLAxnO7HWZjc44ElIBY6Tt
         /AK2KiK1ibJBUAt8gopuvYWNo86YHZOhAcl7Jr95688oG/y4mgyYZyv5llUeYFjO/59l
         RRFkHk9GYvrbgq2RIrp07UF1B2fWOJyhQIpMgobKar2ABGYtuWBKm67li5VXxkf334m9
         6ngg==
X-Gm-Message-State: ABuFfohvmQLv9AQxXKST5ukMreZyagoMtDJMN59HCkxg30xnbujGC7Ck
        TFUtQHk1Az9v/3hzDFKXhic=
X-Google-Smtp-Source: ACcGV63jDiU0tz31+qsUQc9T79GTY+wdy/D8tJgu2qE8z1j1Y2Cmr2D5cD09O1WAP0PsmUqBmA4Htw==
X-Received: by 2002:adf:93a5:: with SMTP id 34-v6mr3941993wrp.244.1537684414054;
        Sat, 22 Sep 2018 23:33:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id w94-v6sm35548875wrc.38.2018.09.22.23.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 23:33:33 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] staging: rtlwifi: Use proper enumerated types for Wi-Fi only interface
Date:   Sat, 22 Sep 2018 23:33:01 -0700
Message-Id: <20180923063300.12202-1-natechancellor@gmail.com>
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
BTC_INTF_PCI = WIFIONLY_INTF_PCI = 1
BTC_INTF_USB = WIFIONLY_INTF_USB = 2

Link: https://github.com/ClangBuiltLinux/linux/issues/171
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix enum values in commit message (previously all 0)

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

