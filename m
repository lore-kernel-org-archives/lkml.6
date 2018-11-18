Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E024DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65A520817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="EJ6wAmzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65A520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKROpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:33 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:36078 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbeKROpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:33 -0500
Received: by mail-qk1-f179.google.com with SMTP id o125so43848437qkf.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CuHvWVwiKJSFYNf5+Mm4ozf+aLuV7qBvdXA+1sM3Rfc=;
        b=EJ6wAmzLVZ9qfZl87QDutieN+lONJJGZ+5u8l4ls7WgqWKqoGBhW9wssjNIhk2eO/V
         274ldl5zwLpkyy1l3vS4IM5AjxGNeqOfZdQlR24sY+64bbbSxRaJ50yCmwpNN2O4y/Uo
         EuuvPRi4zRFfNtL7gxxMbnQta1VF1NjvSdQz6avu2+N71nO2G3N4vYM6KeebTht61ExJ
         JXULGmZ+XWfjzP2pXY86pBqXRnA7CYZ9qWC/CNWoyIHWocsTBe3haJK5mL8QwCN+M1hp
         Y++psItCwI0NZc4dCtx3Wrh1GgI9bRwGfT6ww2djr+Wio5SVPgVuo78PUGvSoY6Dsrq9
         adQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CuHvWVwiKJSFYNf5+Mm4ozf+aLuV7qBvdXA+1sM3Rfc=;
        b=nxCaj5ZivCX46un372RGEOxwTEPX/rqQYzc6ztzkrnZhfdP6ZAUKp7+Us1DsQ9fDkC
         w2xRZz9xfmyYeNBVyWCoC/+dStDKJo7WserYohqgs7AibXJPNRAmI+MCjRYomHCBXhmO
         RWbzzEqEtOfwB7fQeeG/ZrEXPusWEtOrP6E+X/smjc2Ppn4sbLFx23Y4LNtfE61CXaIC
         imhNdDwhIL1fUgJmmxVwDrLmhQJUgwhrRqz0x68hVl2VFVtZVLaBaRwTwN7Lgt7cyUsF
         M4lNi7iIylJPbVBDPNF4gKVRPV8tvo8VR+rw5Px8zEbWIp0UgAZ1HbwBxXrQTy0+yKIT
         qwTA==
X-Gm-Message-State: AGRZ1gLYRg7+67uD/ITqXs7pnbmUQEcOQllFIy2lM/QdnyO/v+HstaNh
        ALsZqgGnedbyk5++bBHt4x/SMw==
X-Google-Smtp-Source: AJdET5e1GbB2sju49GlT6ggVvTcu3L/M4ReK3U/cDVhtFRadi8bgyE7BUa720AMiyhsc4TLqdqUEfA==
X-Received: by 2002:a0c:f313:: with SMTP id j19mr16650232qvl.200.1542515191449;
        Sat, 17 Nov 2018 20:26:31 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:31 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 5/7] staging:iio:ad2s90: Replace license text w/ SPDX identifier
Date:   Sun, 18 Nov 2018 02:25:38 -0200
Message-Id: <20181118042540.12697-6-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the license boilerplate text at the top of ad2s90.c
and, instead, adds the SPDX GPL-2.0 license identifier, which solves the
checkpatch.pl warning:
"WARNING: Missing or malformed SPDX-License-Identifier tag in line 1".

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Changed GPL-2.0-only identifier to GPL-2.0
 - Removed license boilerplate text
 - Rewritten patch message to reflect these modifications

 drivers/staging/iio/resolver/ad2s90.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index fe90f2056bff..9aa229ba47e7 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
  *
  * Copyright (c) 2010-2010 Analog Devices Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 #include <linux/types.h>
 #include <linux/mutex.h>
-- 
2.18.0

