Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605BC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA5421871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="mtIClXkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAED2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:28:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33408 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfAED2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:28:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so19159213pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+BWAkzfWGnIvslaIoArFRRPgKKRTaPk9A/jc7qGGVqE=;
        b=mtIClXkKChPD7KZLM3ksRpWeMAIfaT3fPMbW1XfzChCgsumdbhDGQuOwIhPc1SHKLC
         5omSi5i53cFbJlJni6OGCatgfGj2wILetnzdhjndH9qISYJXscvu9xrgHrcqv/1XWBk5
         +JFvKBZLAyWT6sczrl4HN+armOJDORlOuj5oKYS+XOmQ1YJxiKjbTB9dlIi4EJWUGxkx
         FFKOQa0VZkhCVwsCkZSB6HmEbGTzMc5h7A0bmjBeI1SQbj1auusKciSc0qlRRT0LGzrr
         ktkWQDKS2demNi22jiCQbiWF9HsOPQ8h3rzphHfT4WNzNVCaoWHLCSh5pMt/qzgNvhRb
         UOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+BWAkzfWGnIvslaIoArFRRPgKKRTaPk9A/jc7qGGVqE=;
        b=JZ+4/1nIF5DTnmP2EBzlu0q1s6095VihzfJXUGp+ioLqLH2ijxWiGC4/xzFx02f8NS
         zlmxeKAxBuy6sNg4T70tVrGdL5M6HHmkAEf25FVeoquNA5GTx5J2aB87kJnabMTsQWSP
         0OHcyF9kTEx17IdW5GKzBl6dbbnNosSxEfZhpdCcAXMenbL9UUEt7FAUPSxvNd45relK
         0/EBfRrpOLV+U6bDEh+kaUTvaasYJtKXq9UfZq5CBmnx6E0Ntgd2pnNS/7zdNP0Ag1xe
         jXBoXZJmmZmH/oBNNyk56+vFTQX/E8YuALYgqOVJ3amZ91WglkRynRJIUJqeDgc8qHiZ
         y0xg==
X-Gm-Message-State: AJcUukcUjHLvySgdnnFoHYcT5FUm76rMqqpBlytW+/AKToj4rUB1hbyX
        o6Abv6TmlmfJAKhO5KQyjEsneQ==
X-Google-Smtp-Source: ALg8bN5ZVkV3t2P3LTi+/IJR7+/OwQsBXo+ra20GvRhHv4drZ23P6bqGrW4cDvsvtTlhd2AHS/B/QQ==
X-Received: by 2002:a63:e445:: with SMTP id i5mr3738999pgk.307.1546658910512;
        Fri, 04 Jan 2019 19:28:30 -0800 (PST)
Received: from localhost.localdomain (36-239-217-174.dynamic-ip.hinet.net. [36.239.217.174])
        by smtp.gmail.com with ESMTPSA id 7sm209307256pfm.8.2019.01.04.19.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 19:28:29 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matt Porter <mporter@linaro.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Markus Mayer <markus.mayer@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH] regulator: bcm590xx: Fix .enable_reg for BCM590XX_REG_VSR
Date:   Sat,  5 Jan 2019 11:28:17 +0800
Message-Id: <20190105032817.13994-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation missed the case BCM590XX_REG_VSR, so
bcm590xx_get_enable_register() returns 0 when id is BCM590XX_REG_VSR.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Matt,
Current code looks strange becasue bcm590xx_get_enable_register() returns 0
for BCM590XX_REG_VSR but there is a BCM590XX_VSRPMCTRL1 defined in the code.
I don't have the h/w, and I even cannot find the datasheet on the internet.
I might be wrong, but just in case this might fix a real bug.
Please help to review and test this patch.

Thanks,
Axel
 drivers/regulator/bcm590xx-regulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 92d6d7b10cf7..e49c0a7d5dd5 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -242,8 +242,12 @@ static int bcm590xx_get_enable_register(int id)
 		case BCM590XX_REG_SDSR2:
 			reg = BCM590XX_SDSR2PMCTRL1;
 			break;
+		case BCM590XX_REG_VSR:
+			reg = BCM590XX_VSRPMCTRL1;
+			break;
 		case BCM590XX_REG_VBUS:
 			reg = BCM590XX_OTG_CTRL;
+			break;
 		}
 
 
-- 
2.17.1

