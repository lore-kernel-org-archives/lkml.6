Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E0ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D1E20779
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfe+xl++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D1E20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeJVEBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:01:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37070 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeJVEBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:01:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id c15-v6so2921181eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiYy/f0dRIULz85Iwzz64MH8rAKKtYrF7yUZPoHQgY4=;
        b=Gfe+xl++8TBFHT7KaVz+cwPAXADrCpQXj+5NNcKMPz76BstBjPedZG/gR1lAjhKf87
         95TMFJa9fgg0JGk+v/cRbcBl2u3L6+DNKFoHTPKKygjZIbgNWNVgfblPO79dKY8RknOj
         U6e+Mv/Cl2/OnZ6x1bjKgU0OQ2xWcCNa8XtEgvk0zg3JVdX629Ge5fGbFoGwACseHNXF
         FgAxgs5xsdKVCZVO7huMqjl7y3GV1ZbzyH5MzNCd02VMl/aePux+4RgsuQ++WaB9tkZe
         zl4m1dRwZlGuelnD4fHh40FhK6NDTWifLiP7DKKQgNdR8Cy1bPp5VgjEg0KicXmV0fIP
         MlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KiYy/f0dRIULz85Iwzz64MH8rAKKtYrF7yUZPoHQgY4=;
        b=FAwZ03fcl/iqpF0gM6HrxJY1mSsSfoh9ImD0rYrFYMYVAQ6Lkoi5Hy1FsI8ZAhkalq
         Y5kDeTKiz7DACpBamDXT71GEU2X4TTuPPxPX3e0+DIMB/WAw3RJdiSYF4yqEna2oJjz8
         47z6lUB0Lfg1iRQUZCgQKiGTPyr8XiDxnR1K/ueyj749Mv7FKAlBUkgJJE9QLH7sGelr
         wRsJg+TG6muFfmYvcutmpNGLKauLPNZEIN3nTordhK8lGXvtawNWLLW9d0vorcFoCRBY
         /5xCyBu36jdUV/0qWlF5VYShoqBJMrAxDK2XD3lSKqArJ4OwmGA86ed9Jp5WCfAfg9xV
         /2XA==
X-Gm-Message-State: ABuFfoiZFg5PtD6F9meGBWXFSMigGBL6gE9j3Q+wLnleaQl1EhsnaI6t
        7mqKQrihsnOHrdDTfSzzRCcsP16j
X-Google-Smtp-Source: ACcGV61sH6q+6t2cP5S5tlqXjqhvlLtvip63kBk+gyqDt1M9qs8M+qOxF9g1cCxXMXEj7dNE13Nqww==
X-Received: by 2002:a17:906:1659:: with SMTP id n25-v6mr35078054ejd.24.1540151178274;
        Sun, 21 Oct 2018 12:46:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id w11-v6sm6159566ejv.4.2018.10.21.12.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 12:46:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/4] staging: rtl8188eu: simplify odm_evm_db_to_percentage()
Date:   Sun, 21 Oct 2018 21:45:25 +0200
Message-Id: <20181021194528.15542-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clamp() to simplify code in odm_evm_db_to_percentage().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2:
Added patch with suggestions from Joe Perches applied.

 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index 82d6b2e18b29..0c034b19d3dd 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -53,20 +53,11 @@ static s32 odm_signal_scale_mapping(struct odm_dm_struct *dm_odm, s32 currsig)
 static u8 odm_evm_db_to_percentage(s8 value)
 {
 	/*  -33dB~0dB to 0%~99% */
-	s8 ret_val;
-
-	ret_val = value;
-
-	if (ret_val >= 0)
-		ret_val = 0;
-	if (ret_val <= -33)
-		ret_val = -33;
-
-	ret_val = 0 - ret_val;
-	ret_val *= 3;
+	s8 ret_val = clamp(-value, 0, 33) * 3;
 
 	if (ret_val == 99)
 		ret_val = 100;
+
 	return ret_val;
 }
 
-- 
2.19.1

