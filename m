Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC32DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640E926694
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAKBEIkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640E926694
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeFZIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:16:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46086 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752763AbeFZIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:14:51 -0400
Received: by mail-wr0-f195.google.com with SMTP id l14-v6so11169106wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9cxHKShV56PWgIqeCTT7oiwH+AMPI4Oo5xRlCxbWT8I=;
        b=VAKBEIkFrQd37KFCVtAd+N/C+esH2UahDqxntqgTvFxm2g0kHrCOS9AZLNAsAQy71Q
         whsSB4NnrEykjhqSWIc/oh9O51RK1YrEJA8BlGkD6dzNI8Pjdb2hYlPmxu2fjYMrBPjR
         dEer+PGeJEkRdupGmvZ5ivltofaG6U1BaPzsyo/mxbZuHrGfG8XQeBk0fPYmuNaIm/qJ
         CUCtVruRYvhU0q6aqT1oEAsimw/xOVKonMtKVNV5OfjzPjj5Jt0z0gvNsc1BjFhaulNi
         rKWDj6XjOjV9tNnxtUf666BtSnRAiwbVEk0/OoPnmaS1bU1YWJJ11+WdnuxBp670UyXT
         nMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9cxHKShV56PWgIqeCTT7oiwH+AMPI4Oo5xRlCxbWT8I=;
        b=jOJqmmAj00TR3rE4qPb/g1xxgB7YHcJ5x/uE4nHkBLWU6zwhRT5CIlgLQBH2/PhTbA
         VH/YNcWpwd0lCwRuv5O3a06dKjqJolruotDphU9cr1bqqZxp77pH/vTUjWlSghoys3pC
         rLEt/ZG6YgkGnjERKCzIEZs5zW7fsLVK1AeZEJjWiA+p6xxdWuOr2YCygYlBRnV/iAUy
         Q1qClCcPPLApJUcDTh3aqYNHDKlUkZTDXIAiBcjKu0ahnjSCWm71IzS9miIwvd3gGN2H
         iKJug7SS35yofZ4URVqoYHAu3d0YU7J2Kra9RDE9Du+fq3MVRBRoDqKao7gtewh6HwEy
         Jukg==
X-Gm-Message-State: APt69E2pApRvmsWCvJWx1WXQG96u/cssLQKpIn7w4weIgyFVosi8dK9B
        OxpvR2gG+oCScjznHEtFfN4=
X-Google-Smtp-Source: AAOMgpdr8AR1RU0SE6xjJKcaTw6C5zVScpi4P9q1CHEMwySvWbj29Sx22bVeC/mbNPitgNPrGeTPOw==
X-Received: by 2002:adf:d84a:: with SMTP id k10-v6mr433498wrl.26.1530000890746;
        Tue, 26 Jun 2018 01:14:50 -0700 (PDT)
Received: from arch.localdomain (x590c812a.dyn.telefonica.de. [89.12.129.42])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1946151wmt.31.2018.06.26.01.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:14:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 1/4] staging: rtl8723bs: fix comparsion to NULL - coding style
Date:   Tue, 26 Jun 2018 10:14:06 +0200
Message-Id: <20180626081409.9518-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comparsion to NULL issues found by checkpatch.
Use !x instead of x == NULL.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 0822e440204e..e55895632921 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -747,7 +747,7 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 	u8 match = false;
 	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-	if (ie_ptr == NULL)
+	if (!ie_ptr)
 		return match;
 
 	eid = ie_ptr[0];
@@ -1163,7 +1163,7 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	const unsigned char *addr;
 	int len;
 
-	if (mac_addr == NULL)
+	if (!mac_addr)
 		return;
 
 	if (rtw_initmac) {	/* 	Users specify the mac address */
-- 
2.18.0

