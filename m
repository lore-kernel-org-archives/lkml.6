Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FD3C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1536221A08
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="HPWPB0ZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1536221A08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754441AbeFUSWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:22:53 -0400
Received: from mout01.posteo.de ([185.67.36.65]:56577 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754384AbeFUSWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:22:52 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CDE6A20D50
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1529605370; bh=82u3r2NDNr3GAMpTtgkGi3wsVHpKji9eMXMN9Vv755Q=;
        h=From:To:Cc:Subject:Date:From;
        b=HPWPB0ZCn/cYePdqxRa5tuheIyaYfl327PEBhNVP9sAD4d8608NpViZcKNJixUtvR
         f5aYZSiEFX0wCxxdV/Ei8Ks/OTIBwg3yyNVYTnZjdsRM3LyjMkwJnLqI5v8xzp7jj1
         twNQJMve6/HyedUBxEbYRMzptMVqYhKqGqTn8EB7yUZ5nRHGYYMdcKtsHA5oalcroO
         2CybrBf9IMu20u7hF/bLqjxkVWscrZth5ZgHRdztmTw0IuhCls0BU5EWzxIJbh0pm3
         ydEZVjYjiLc0Wna5HINI+L0p/vEvJ7A+ezwe4VHKcz3Rq2OseALABplzorquwJFEFv
         8v4gwgK823Sbw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 41BVRt0dtfz9rxT;
        Thu, 21 Jun 2018 20:22:50 +0200 (CEST)
From:   Michael Straube <michael.straube@posteo.de>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <michael.straube@posteo.de>
Subject: [PATCH] staging: rtl8723bs: do not use assignment in if condition
Date:   Thu, 21 Jun 2018 20:22:30 +0200
Message-Id: <20180621182230.27823-1-michael.straube@posteo.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error 'do not use assignment in if condition'.

Signed-off-by: Michael Straube <michael.straube@posteo.de>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index e55895632921..87a4ced41028 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
 	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
 	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
-		if (np &&
-		    (addr = of_get_property(np, "local-mac-address", &len)) &&
-		    len == ETH_ALEN) {
+		addr = of_get_property(np, "local-mac-address", &len);
+		if (np && addr && len == ETH_ALEN) {
 			memcpy(mac_addr, addr, ETH_ALEN);
 		} else {
 			mac[0] = 0x00;
-- 
2.17.1

