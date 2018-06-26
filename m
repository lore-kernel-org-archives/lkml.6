Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3052668E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdXWcTSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3052668E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFZIQM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:16:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42187 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752708AbeFZIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:14:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so637808wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QCB2jOEyla75iCTIJg5GkES40Ud8smj1zIgzC1TXi/8=;
        b=PdXWcTSlhKaPKeNpX4/YGQd9Bsmu4Io5YGfXVQBjI5oP1gBdU+KT/ye4w7ox89OHKh
         LNPch4vFWccLdHCtHKQeAlEMLQ/Wx/x0H3VGD4gQrc3VWB5loRRy6Y5152BU+wJF8NAR
         RjavIlNq/csLG4F8KsmNJxIV4wqsEAaUmXGu0C1euR/PDuP+vGRPI3IVy9KpnA7WkEHj
         Jm7XlXLrbUsNqvW8Lz66Qy92y+WU8rYO8ep3t5H7fHVYzEFJNZH4cZGnYaNH+IyG4QPb
         +1Riy6Oe+PxqHfjAFR1eqDYkeNCAEi5VQuBhGeonfMdePe7PA5Aib1OBP/FHCzzan8VL
         BTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QCB2jOEyla75iCTIJg5GkES40Ud8smj1zIgzC1TXi/8=;
        b=UGHQcTOL/9Om07wML2/6r+UNetvnpCjypDCLcu80eioyoWjR9HQAplPLkDiYrxf4aB
         22rQYCXAtrhbEZY5gxhWJLWybWxG4mSMHaDlftzrlozzHoodQ88n03GwKtUeDZF54KYl
         Z+3l1jiLewMi+Ho/wj+o0fMiG8AeiKKlqqeQYPzdwByddFzJ3jP3kReEgXBiYXtiTDGZ
         2Zv/h1TWEjZGkIenFaT+doNGIRsJP1R97rZ440c+Il44g/i116ZW6EV7IHdLg50CYkAZ
         7Lb+QpZzBkGRgoIO5DVKbJj3RbpBL8A7SWHbopgSGSW7DURWiz2Mbj3W8oyIJPRt8YA7
         IsNw==
X-Gm-Message-State: APt69E08nEt3mgJ0GMYIEo14c3aaK8q/c5VtDrYezHJbTc9u6bkxCfSM
        jjB9cYcGnww+txq0jvUyjio=
X-Google-Smtp-Source: AAOMgpecgnDODFyndr2o98YLEvM01pTdFCFBZD5UtUsL8rHZnG9WfvLVZPwuceLhIRx1ZbBo9a81zw==
X-Received: by 2002:a5d:4392:: with SMTP id i18-v6mr564783wrq.156.1530000893448;
        Tue, 26 Jun 2018 01:14:53 -0700 (PDT)
Received: from arch.localdomain (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1946151wmt.31.2018.06.26.01.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:14:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 2/4] staging: rtl8723bs: refactor rtw_macaddr_cfg()
Date:   Tue, 26 Jun 2018 10:14:07 +0200
Message-Id: <20180626081409.9518-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626081409.9518-1-straube.linux@gmail.com>
References: <20180626081409.9518-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using is_broadcast_ether_addr() and is_zero_ether_addr() instead of
testing each byte of the mac[] array for 0xff and 0x00 shortens the
code and improves readability.

If np == NULL, of_get_property() returns NULL, hence the "np" check
is not needed.

Instead of a fixed default mac address use a random one to reduce the
likelihood of mac address collision.

Thanks to Joe Perches and Dan Carpenter.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_ieee80211.c    | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e55895632921..7aa00d1391f7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1177,24 +1177,13 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 		memcpy(mac, mac_addr, ETH_ALEN);
 	}
 
-	if (((mac[0] == 0xff) && (mac[1] == 0xff) && (mac[2] == 0xff) &&
-	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
-	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
-		if (np &&
-		    (addr = of_get_property(np, "local-mac-address", &len)) &&
+	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
+		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
 		    len == ETH_ALEN) {
 			memcpy(mac_addr, addr, ETH_ALEN);
 		} else {
-			mac[0] = 0x00;
-			mac[1] = 0xe0;
-			mac[2] = 0x4c;
-			mac[3] = 0x87;
-			mac[4] = 0x00;
-			mac[5] = 0x00;
-			/*  use default mac addresss */
-			memcpy(mac_addr, mac, ETH_ALEN);
-			DBG_871X("MAC Address from efuse error, assign default one !!!\n");
+			eth_random_addr(mac_addr);
+			DBG_871X("MAC Address from efuse error, assign random one !!!\n");
 		}
 	}
 
-- 
2.18.0

