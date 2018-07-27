Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B13C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9479420862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTBGG9ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9479420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeG0JzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:55:23 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35918 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0JzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:55:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so2024040plb.3;
        Fri, 27 Jul 2018 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J889rd12xL5YGoOiZ8WcPmiP0cFPlFEW4HbfhYoZDyo=;
        b=jTBGG9ibPqZoV5HGZN9JnXsXopjUrW2GDRR5eUbphz4gS0ili7i9paBhwTK00/pvAx
         idOSUJ7KYzvEB/qYEtcfLFJPqxhdyfd/Cbf9sTUB9i9japWXzPvsyGfGYfguhI61ew6s
         uJhNq84Asmm9tX1zbVqSs7N9N8ivUoiMDVAvBO4jfXhyi07mHh+/XT2jKDnX6OtbRnbj
         EttaVaOqCzOyveeNff6PHmS++3JmvLBjJTw1ipEO7Aw04pD4mQnUjNed6GqbmpkRnPjM
         JM/MdlT1m7FqpQ4UNjNhvINIX3SBeBLipqk146/qecSJ4E7FCeWv1ukj4rv5oFxUyuT/
         3jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J889rd12xL5YGoOiZ8WcPmiP0cFPlFEW4HbfhYoZDyo=;
        b=MKyVIIinNCTRoLhyYoqNtsJOhxGCxB1uDe+aBpp1obekKpS4s2w4+jxSIhnWKMvYr4
         83JPHY2egxPEKixxGSE+cd36HipVSl+0oWO8qrVkzhovB5ekgcvKaYNuA+uXhrhmUslH
         XlzCk0n+NuK0qSntOVO8XW5ts/5eCX9XAwyjDlPBYq97k0+5PzafyWLMWK4WI+31fvFg
         VXoL6i4N/yD0426Srn7Vtydi9/Lqswm9QBbVPbbPvHJzu/Bd9MdlCEEX369rNCiIvzFs
         AVmaXYdOM7Hx2dk1EfNqhj3lhxMJZIagGgsF1DFbs8dhAydqqvcdqv1JzjI4QaaDxM/Z
         fmng==
X-Gm-Message-State: AOUpUlHsWfETXGzR4YCL2hSeImvU3WJGulN7Qo4RkyIDFT54DmVdtKZg
        KOtsppvY80AkWAOBLGbRcWk=
X-Google-Smtp-Source: AAOMgpc/zGqrYPAqJjQG20ttqfedBwLVNtTXJy6i1SIGFymVawksVAZ/eb/9GRiMNRXCUTkwnGxaWw==
X-Received: by 2002:a17:902:7481:: with SMTP id h1-v6mr5276370pll.183.1532680473960;
        Fri, 27 Jul 2018 01:34:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id j5-v6sm5024034pff.139.2018.07.27.01.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:34:33 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: phy: marvell: Replace mdelay() with msleep() in m88e1116r_config_init()
Date:   Fri, 27 Jul 2018 16:34:25 +0800
Message-Id: <20180727083425.14481-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

m88e1116r_config_init() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/phy/marvell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 25e2a099b71c..ed04346df235 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -646,7 +646,7 @@ static int m88e1116r_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
-	mdelay(500);
+	msleep(500);
 
 	err = marvell_set_page(phydev, MII_MARVELL_COPPER_PAGE);
 	if (err < 0)
-- 
2.17.0

