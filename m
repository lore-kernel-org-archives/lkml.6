Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1535720862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe9i77Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1535720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbeHAU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:59:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36307 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeHAU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:59:57 -0400
Received: by mail-pl0-f66.google.com with SMTP id e11-v6so9233310plb.3;
        Wed, 01 Aug 2018 12:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2bcAVrZoQ7gAipHE91JvHi55mUc8nI6vJrJeUPIxQl8=;
        b=Oe9i77Or2we4nkTOI3QlSylkILSQlRmtsyZu3/zMwWeRc4qRb7jSwYYStwR39m89Fn
         MppvoeG+v2N1GHkm+z3owZLboiSVuSzxuQ1MFhFipaTle2Z/fphNwRtXPo5vNbvU5zwt
         ze+HludXA9g3oTqXqZ7wpaWhlhAtjNYPhRCGXAMVVtPBxhYmBSXZ0kcaG0kHfOowmgVU
         q6dZLHNGotICdZ6gwQ1AKd60aBHXeOCmgXYiEVCWq+60Rfdc4iDKWpDDF7MjruilqDmU
         UljkZV/658foI2l0JKpMuQljBQ+Fpu2VOvPOiesE0Bxa2SzWO/Lg6vYCKcpbEo7y4Jk+
         biAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2bcAVrZoQ7gAipHE91JvHi55mUc8nI6vJrJeUPIxQl8=;
        b=nH9sl+qLeaC+snXelEeVve8C5PYIw8Ar0iVZhEiID+pmRpWN7u1C6CarkBznsGcBiW
         2iy4a978Bfegco/qzH/Cgi6FtT9OhlvQDCmubud86uQHd4S6tevuP+EeUaXSzLUb7faE
         0Kcl4/SiOR+hT2mDKmttgOh6l2dW7f0pjx81RUr1ZMmCQjbpM12Eh1qC9/UkAoWXBqIU
         x6/Cb3CMOFJ9+xK2imzkFRuM4tOhowbNqP1ntE0fUg6i+e91oSGWfd2jc1/4Jhu91LXR
         QeKuWVnEI7nio09RiDbGgrTVLy/6CfJubhRAfSel1c+FzqN92vzbdVP9dCsjl0q3aQYk
         hKlA==
X-Gm-Message-State: AOUpUlHyxgvbavXzTgppvDFl5orJRdKDeDF90WlteJKxu+zlsbTo7bJn
        aADwK+Txo2vicjouP/Mkyfg2GWbh
X-Google-Smtp-Source: AAOMgpcrUv1K1RlUs4gBNFom7IamXDbBx7bYx707mtmVDm6cx3rGiIBqcQuYlUdT3U3tn6UBsgQYHA==
X-Received: by 2002:a17:902:7793:: with SMTP id o19-v6mr26412193pll.306.1533150762593;
        Wed, 01 Aug 2018 12:12:42 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.googlemail.com with ESMTPSA id u42-v6sm31171336pgn.1.2018.08.01.12.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 12:12:41 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR FREESCALE
        IMX), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 04/14] gpu: ipu-v3: Fix U/V offset macros for planar 4:2:0
Date:   Wed,  1 Aug 2018 12:12:17 -0700
Message-Id: <1533150747-30677-5-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
References: <1533150747-30677-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The U and V offset macros for planar 4:2:0 (U_OFFSET, V_OFFSET, and
UV_OFFSET), are not correct. The height component to the offset was
calculated as:

(pix->width * y / 4)

But this does not produce correct offsets for odd values of y (luma
line #). The luma line # must be decimated by two to produce the
correct U/V line #, so the correct formula is:

(pix->width * (y / 2) / 2)

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/gpu/ipu-v3/ipu-cpmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-cpmem.c b/drivers/gpu/ipu-v3/ipu-cpmem.c
index 9f2d9ec..e68e473 100644
--- a/drivers/gpu/ipu-v3/ipu-cpmem.c
+++ b/drivers/gpu/ipu-v3/ipu-cpmem.c
@@ -530,17 +530,17 @@ static const struct ipu_rgb def_bgra_16 = {
 
 #define Y_OFFSET(pix, x, y)	((x) + pix->width * (y))
 #define U_OFFSET(pix, x, y)	((pix->width * pix->height) +		\
-				 (pix->width * (y) / 4) + (x) / 2)
+				 (pix->width * ((y) / 2) / 2) + (x) / 2)
 #define V_OFFSET(pix, x, y)	((pix->width * pix->height) +		\
 				 (pix->width * pix->height / 4) +	\
-				 (pix->width * (y) / 4) + (x) / 2)
+				 (pix->width * ((y) / 2) / 2) + (x) / 2)
 #define U2_OFFSET(pix, x, y)	((pix->width * pix->height) +		\
 				 (pix->width * (y) / 2) + (x) / 2)
 #define V2_OFFSET(pix, x, y)	((pix->width * pix->height) +		\
 				 (pix->width * pix->height / 2) +	\
 				 (pix->width * (y) / 2) + (x) / 2)
 #define UV_OFFSET(pix, x, y)	((pix->width * pix->height) +	\
-				 (pix->width * (y) / 2) + (x))
+				 (pix->width * ((y) / 2)) + (x))
 #define UV2_OFFSET(pix, x, y)	((pix->width * pix->height) +	\
 				 (pix->width * y) + (x))
 
-- 
2.7.4

