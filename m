Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6E8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A7C2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QakvFgC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A7C2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeKHFsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:48:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36952 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeKHFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:48:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so12428969lfh.4;
        Wed, 07 Nov 2018 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Ca/oaZHdOkqaq3mknp73TodAa8FD7n+xhH62XjZakk=;
        b=QakvFgC0pyMYjsPmym9LP3PUl8Ma8Ys5jf4fDIoi25mTQtQgiHBHmicNWI4L32PneO
         LODuHwStrnuf2HO8A/U/0tvdn3h2/hdFztFWxKuPDQupKqdOhig0+eEqewmbRzLZhuvd
         TOOn5sb21cBM3QQbDXu1ui91X/oVHcxgUyElz5ft3dz28Ub2zxD3rFRsT2K7oAd581wT
         HbSODLbXPBmys09kNq1G9dl7drlFm6dAjLpYxLfNooPTRx290BDWZbJ4pAT0yohvYGGV
         8EkRkKAxgkWoYSKSS/EIaj0R1XIsmP7YP/mhdrnh3lltLeP/KYC0mkb8N3udOd3N1pho
         ceVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Ca/oaZHdOkqaq3mknp73TodAa8FD7n+xhH62XjZakk=;
        b=tY94+nA8aZ+4UYgpFP5SpO6Gfrywf3LEwhE6AptbzHjaGnojMlEKlYMYaiR5kelv/X
         szDM6gjyEECipivWT60lh89ByxxK5TYZuy12jpxWOq94ciP4axuMOEZRaPi4hhHSLq2o
         3LMNTmH4ibbPy5gTCyGokIIBm0UBt2uUUQNC1y31++n60ExDOltSrmwp1X5m3U+QIt6s
         blnKQs5WdoHIG6EsutJiO0sDMLiMrQhsAq+6WHEsxAr5uSbFojoAbEak7wZ06bu6qVHL
         mgYmzc3ZiOBaZ1Hqfyzx3n7rKlnHKu3H+9+fU86gl+rQ9+eeu5ueS4+7Mlq84/ztFiNg
         HpQw==
X-Gm-Message-State: AGRZ1gJGoP1spY3eOwMA40rhPoHSxkNrGJHLGPhfGOPSKKyarchqvbEa
        CMdPIDCrWxyUc3VNwgnNq+k=
X-Google-Smtp-Source: AJdET5clRlIdyBRHkByaegx+YWp92XqKHCthjec3i7Z0+jaBzbwgzKElnus4Y0udmAWwqe1WuaGV2w==
X-Received: by 2002:a19:df41:: with SMTP id q1mr1020009lfj.25.1541621775918;
        Wed, 07 Nov 2018 12:16:15 -0800 (PST)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id c19sm285650lfg.86.2018.11.07.12.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 12:16:15 -0800 (PST)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 2/3] ARM: OMAP1: ams-delta: Drop unused symbols from the board header
Date:   Wed,  7 Nov 2018 21:17:45 +0100
Message-Id: <20181107201746.14705-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those bitmap symbols defining pins of latch2 register, used with
read()/write() calls before the latch was converted to a GPIO device,
have been obsoleted by integer symbols defined inside the board file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index 06e4c64a47f8..2c3aff824cf0 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -28,10 +28,6 @@
 
 #if defined (CONFIG_MACH_AMS_DELTA)
 
-#define AMD_DELTA_LATCH2_SCARD_RSTIN	0x0400
-#define AMD_DELTA_LATCH2_SCARD_CMDVCC	0x0800
-#define AMS_DELTA_LATCH2_MODEM_CODEC	0x2000
-
 #define AMS_DELTA_GPIO_PIN_KEYBRD_DATA	0
 #define AMS_DELTA_GPIO_PIN_KEYBRD_CLK	1
 #define AMS_DELTA_GPIO_PIN_MODEM_IRQ	2
-- 
2.16.4

