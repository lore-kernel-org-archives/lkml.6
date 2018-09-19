Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0915C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840C720671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxbUVKSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840C720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeITCTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:19:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35714 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:19:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so7158321wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA8aZydzuYLPNdwD8yFxyXZTSo2rU3cC8y8dv4BFBJE=;
        b=TxbUVKSxKJ6yfjLUG0ULff5vf1ILbbmxM/JHtMf6YVn1VXTK/Gpfjjp63ZjshXsfqH
         uyWex2siVobx7qRZAPfdq5lDAbjGcJcSb35h5xtpQJEJo2kVvlw6MVzshXWzweGhoBJ4
         6B2rfw//b6SGyJTU1C9Zn9+yvH7Zvy1HfpcHFIr/Gz9Y2lEOAODVMpOIBP3OkShPI1sQ
         OcsTt7wDLb4yWJyo9V9hXKEYcY0A2427XZkyTbK2tUpKX3cK6YDz+x34JsuMBKZhjVoZ
         4O9CMjpznMAhpk8iROlcgY2NKs7s0gKiovHE8OexcNFWnjLhF37DEr2ORmL3yDh0iHtP
         q3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SA8aZydzuYLPNdwD8yFxyXZTSo2rU3cC8y8dv4BFBJE=;
        b=Hk4IeNVKkElNV2Nok8oUX+geisW1V64dlNRT4yXQmM7lbC2UNaax9D67pmyLK9zALs
         wDCBUx20E+KabC7RmXfsm6S5BDhdHlvtXtgeSOwK32TdFXA4/U93zP65MvqXg9hgQrTh
         vgz6ry13iV6piUQT9/NIBMIhs+2wtkDuG3G2cSXuJhuNOb4rM5FH0B+HPun0GD3d4Q8O
         o4hqFEEphpbarmlqrgqZF25vQiS/Pxv5/T+QagWKAIRdS0bH9IClLs3//Vvj36cftrZF
         vEwrd1JMXuEiByE36TdMX6e/ezljvhAlo5Os5uDzdZYtxWfcS6OnmTVVD2g9A7xt7dnF
         YiEw==
X-Gm-Message-State: APzg51BKV/he3rHIaDwkw2F7hRlLsOFssq/XeWlGYoONvVCE7aUtmP2E
        YnBBgFxK36jFxbWlxbqIJGI=
X-Google-Smtp-Source: ANB0VdbNIqZX3C0s6ZMABp59GuXDnDXFZIF1u2UflL+ORLQkRYkAWXpjSM1oU6ryl2w/3tBHHV1f3g==
X-Received: by 2002:adf:f112:: with SMTP id r18-v6mr12764938wro.29.1537389613935;
        Wed, 19 Sep 2018 13:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id b10-v6sm18013637wrr.88.2018.09.19.13.40.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:40:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: remove 5 GHz code from Hal_GetChnlGroup88E()
Date:   Wed, 19 Sep 2018 22:39:58 +0200
Message-Id: <20180919204001.2358-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove code valid only for 5 GHz from Hal_GetChnlGroup88E().
This addresses the below TODO item.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c | 60 ++++---------------
 1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 607170775fa5..69693126e102 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -382,53 +382,19 @@ static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
 {
 	u8 bIn24G = true;
 
-	if (chnl <= 14) {
-		bIn24G = true;
-
-		if (chnl < 3)			/*  Channel 1-2 */
-			*pGroup = 0;
-		else if (chnl < 6)		/*  Channel 3-5 */
-			*pGroup = 1;
-		else	 if (chnl < 9)		/*  Channel 6-8 */
-			*pGroup = 2;
-		else if (chnl < 12)		/*  Channel 9-11 */
-			*pGroup = 3;
-		else if (chnl < 14)		/*  Channel 12-13 */
-			*pGroup = 4;
-		else if (chnl == 14)		/*  Channel 14 */
-			*pGroup = 5;
-	} else {
-		/* probably, this branch is suitable only for 5 GHz */
-
-		bIn24G = false;
-
-		if (chnl <= 40)
-			*pGroup = 0;
-		else if (chnl <= 48)
-			*pGroup = 1;
-		else	 if (chnl <= 56)
-			*pGroup = 2;
-		else if (chnl <= 64)
-			*pGroup = 3;
-		else if (chnl <= 104)
-			*pGroup = 4;
-		else if (chnl <= 112)
-			*pGroup = 5;
-		else if (chnl <= 120)
-			*pGroup = 5;
-		else if (chnl <= 128)
-			*pGroup = 6;
-		else if (chnl <= 136)
-			*pGroup = 7;
-		else if (chnl <= 144)
-			*pGroup = 8;
-		else if (chnl <= 153)
-			*pGroup = 9;
-		else if (chnl <= 161)
-			*pGroup = 10;
-		else if (chnl <= 177)
-			*pGroup = 11;
-	}
+	if (chnl < 3)			/*  Channel 1-2 */
+		*pGroup = 0;
+	else if (chnl < 6)		/*  Channel 3-5 */
+		*pGroup = 1;
+	else if (chnl < 9)		/*  Channel 6-8 */
+		*pGroup = 2;
+	else if (chnl < 12)		/*  Channel 9-11 */
+		*pGroup = 3;
+	else if (chnl < 14)		/*  Channel 12-13 */
+		*pGroup = 4;
+	else if (chnl == 14)		/*  Channel 14 */
+		*pGroup = 5;
+
 	return bIn24G;
 }
 
-- 
2.19.0

