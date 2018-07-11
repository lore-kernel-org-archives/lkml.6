Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB29CC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1627213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=heimpold.de header.i=@heimpold.de header.b="qT81Tcuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1627213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=heimpold.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389413AbeGKVUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:20:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:16274 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732761AbeGKVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1531343656;
        s=strato-dkim-0002; d=heimpold.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=qulZJnIlAsMOskoUHHwa15FA6Hf8IgmvfWQP1Ly+bEs=;
        b=qT81Tcucrc1bn7dFjTnbslSCOto98j3jCzQHL+us6h676eSa+/bcfUThQBDgfGiqqB
        g8CSbzRZ5o0AJlo5605iiR1Xie//gEptrf74vQl/wJSXmMuD5r81BzwGYYAeZUBAGhBb
        0sTvZmocApFg56yyHseH9rkvE1eJ17dsvUQ/lUPYgXxRpfoNEnOhzZ3+6IFuJ04CoAd2
        4ipYHW4vaaOxY/wsQJl3tNt+UXwJUowk4+bBrb/+vPsXNUH5PBQiDU2C3B0/KbPmn8kC
        5PRvroo4rmeifdeAt2iJ7i/WvDhEurmReA4P3tS2k1a+2QhcCucQgoUtd/PUn8xulKuD
        3ETA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZPUGwIpLOmsCM+BB/JuKi9Rok/o3z+V90Po+4"
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 43.12 DYNA|AUTH)
        with ESMTPSA id D04789u6BLB5BIr
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 11 Jul 2018 23:11:05 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id 221C4140C06;
        Wed, 11 Jul 2018 23:11:04 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH] net: ethtool: fix spelling mistake: "tubale" -> "tunable"
Date:   Wed, 11 Jul 2018 23:10:55 +0200
Message-Id: <20180711211055.14318-1-mhei@heimpold.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 include/uapi/linux/ethtool.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 4ca65b56084f..7363f18e65a5 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -226,7 +226,7 @@ enum tunable_id {
 	ETHTOOL_TX_COPYBREAK,
 	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
 	/*
-	 * Add your fresh new tubale attribute above and remember to update
+	 * Add your fresh new tunable attribute above and remember to update
 	 * tunable_strings[] in net/core/ethtool.c
 	 */
 	__ETHTOOL_TUNABLE_COUNT,
-- 
2.17.1

