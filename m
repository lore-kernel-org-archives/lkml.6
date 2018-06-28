Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC17C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D9121732
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=heimpold.de header.i=@heimpold.de header.b="dBKz/kZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D9121732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=heimpold.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935603AbeF1ToS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:44:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:16125 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935379AbeF1ToR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:44:17 -0400
X-Greylist: delayed 737 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 15:44:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530215055;
        s=strato-dkim-0002; d=heimpold.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=qulZJnIlAsMOskoUHHwa15FA6Hf8IgmvfWQP1Ly+bEs=;
        b=dBKz/kZFUOVcHFqveiQYPyORNRuYGsLe4m2yxV/WZD6c0SFi64Y2tTXY05Tln6QZUD
        3dq9MRWoW0Dp8tcDqw9LOKSs2uDXH556LmFiJE2OxH8GodUMvcvR3DTgBPSuJTfq9F2J
        yPeq+v2YPi3j7wcI0f+DDENRLz194WRZhrX50Q2b9aupDOsCmftBwn+G/IpQRMY+CQu5
        iwZurPz+SMHF9vddkZ2qlqN/O3wY6S/Ylc6TZyKk39Z+jRFYy4MPDpQ2ugkZXFj8sMy4
        +t992QU7bPYdm8SfFUYPnk0rWuigyVFpBVmtwMx9heOFcRKsnR8p9RD98BlAGCXHsDpl
        6NvA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EW8QnKjhhg/vO4pzqdNytq77N6ZPUGwIpLOmsCM+BB/JuKi9Rok/o3z9F9zUA=="
X-RZG-CLASS-ID: mo00
Received: from tonne.mhei.heimpold.itr
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id U07861u5SJVt2tz
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 28 Jun 2018 21:31:55 +0200 (CEST)
Received: from kerker.mhei.heimpold.itr (kerker.mhei.heimpold.itr [192.168.8.1])
        by tonne.mhei.heimpold.itr (Postfix) with ESMTP id E575A155082;
        Thu, 28 Jun 2018 21:31:53 +0200 (CEST)
From:   Michael Heimpold <mhei@heimpold.de>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Michael Heimpold <mhei@heimpold.de>
Subject: [PATCH] net: ethtool: fix spelling mistake: "tubale" -> "tunable"
Date:   Thu, 28 Jun 2018 21:31:14 +0200
Message-Id: <20180628193114.8236-1-mhei@heimpold.de>
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

