Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36272C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF08D25C26
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZijcIzvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF08D25C26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934916AbeFYPNN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:13:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42394 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934850AbeFYPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:13:03 -0400
Received: by mail-wr0-f194.google.com with SMTP id w10-v6so14070116wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9cxHKShV56PWgIqeCTT7oiwH+AMPI4Oo5xRlCxbWT8I=;
        b=ZijcIzvyv2IfKFSZ5tc92lbgh3C2Gqxlo8IWt+xVPnxvVXi0602keeZrHFbWQ4oJvB
         go19W1qOfFQUYgw1bW9P0hundG64b9dkC+iCQrAm15BVVrVs06cXvGFvCqJJQjKuPlkE
         QNkr2R6Dcm4c4O1dnxRSj1K5UOEXR8u0cdf23fRWsGtyzhaC4aon1PqQRD58IIShLhCs
         yKn4y5SGJ1tYvsozFkdbX/uuGaqmp/fEQ0I7aKtcDdkUaTjQEa+vrIgBWp4cjGmRXHqt
         KDBzBMiBJGEwW9zBXBEbzHusKMScNqpXl+ROEKBfia/vXnvaml0Ccpr2Iz7mwiw58cDn
         qhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9cxHKShV56PWgIqeCTT7oiwH+AMPI4Oo5xRlCxbWT8I=;
        b=EuQNuf2PdBrrBl4YIngXTAj/rRGVlZT2ahqHsgT+Rjw+T71AJR4kCV9ZM+L5UTszja
         aOEU7I50xsOZRl5UIvKlTGoL6eXdvsX00e2wGI7dnOZR89yGhKfr0pwB6Ltd7o5soEcw
         8RAtuliukvhUAu58hyXsTaanHEAvR3NvOcAZKbJ9iMnPeY/Ho64eXldTlDhu4FSRYFin
         7bY5JfFnxR2A5ulm77Z+yRpkizo7HYLbdbh/7Q8KikHbaP+bvIZIdHsQkZ0l5663SVSz
         0pWNNLxm9cE9l9gD7877A3U8SojpBIaGug4MIgRcv6TzI4A8VJeflgakkJyLiZwDQcva
         JFwQ==
X-Gm-Message-State: APt69E1vvC5A68x8RdreXBjf1yWWEz/X49M3cxJepp2Sa1q7Vi4Sms0N
        WITcP8Rw4HKT6MyPrtSxg6xRjya9YS0=
X-Google-Smtp-Source: AAOMgpdF8uFzs1yWU9+DZzINGOg+KVEs+g3GqCY6QIFsIrp6f+7f2sX4Wd4qJN1x/OjGPQ1N++Zg6w==
X-Received: by 2002:adf:b187:: with SMTP id q7-v6mr3485410wra.79.1529939582613;
        Mon, 25 Jun 2018 08:13:02 -0700 (PDT)
Received: from arch.localdomain (x590e3931.dyn.telefonica.de. [89.14.57.49])
        by smtp.gmail.com with ESMTPSA id l78-v6sm15368283wmb.39.2018.06.25.08.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:13:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, dan.carpenter@oracle.com,
        andy.shevchenko@gmail.com,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/4] staging: rtl8723bs: fix comparsion to NULL - coding style
Date:   Mon, 25 Jun 2018 17:12:35 +0200
Message-Id: <20180625151238.23147-1-straube.linux@gmail.com>
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

