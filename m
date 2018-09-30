Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD8C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457212075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 19:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AujDK67G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457212075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeJAC1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 22:27:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55737 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeJAC1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 22:27:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so6648949wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LrR+wOEiGDrBj/2806tm8dWl6qN4YR8XkCM4+929YMU=;
        b=AujDK67GgzNV5jhFHQsPN/+/SYo4+SGgsmKbwl4kF7ullca5iLyEZHwDKdMv2+mflk
         V7+UMqIuDbToSVZdmOUb/sWQDmTzzpX0w+kC7NR7a1jFs9HRzAQ/F4Zukw6pcykQHxAI
         5VJVbgkwe4l946glxtVAe0Jfgl3k1evgAwFXPT51fonqXx/yPk6nGKMTgEzClDWJHRJR
         carWQAB2cQap8tZnVcgkKndSDx6aLZk8YuJl7cFK5mbw0UWYMtHmvBDeYF1KC4vZWUJf
         /XNRcpzuVGbTjANcrWzua3dlulRBhWIpZc4aVr7H/EQl2svpCZwxca7/4EHNMnodYtmO
         B0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrR+wOEiGDrBj/2806tm8dWl6qN4YR8XkCM4+929YMU=;
        b=jgN9xbCkepVnZHQyn51In9tnFE3+Oluf99eLeIR13FcwzIwCOYkRhR8Q3JAIvzN8fg
         bmD0U5tRzXYVxGLLRZCyzHfQDXyQeQd2REIxsERGD0s7NuBZzAo0YO274k4Q1/gj3o8u
         zbBMqILztacYqJEFe1YgSsXjR/EbER3pRtapTkyzV60JUEUJzk8jXtsxou8rEnCq2hdN
         AM2MtuH/R8IUmOMsHjni3MlqdyYAUze2p6DWp/k2Zd24iCexlwxsk80fa2ajX86Fs7A+
         bLrKUWHfFFTIkE8WKdA9wpOEhfz/+PwINlpBGSEVuHgn8nz3ybiqlTsBp7Vcffp0sPbA
         qgew==
X-Gm-Message-State: ABuFfohQ1yoXbMBrT5utxRr5gQFeyW8wMMpV6vej6ci3nrlfZN6XzOCW
        SJhJE2BgMp1dd7p7mC+S5vt79Fdt
X-Google-Smtp-Source: ACcGV61+Fzsczv6jT9HqqFn0xaFvPgOTNLpPKZVGz30PLuFjOn9CYAKUa5f6MoC435NnHV88rQj/7g==
X-Received: by 2002:a1c:4406:: with SMTP id r6-v6mr7480938wma.4.1538337207131;
        Sun, 30 Sep 2018 12:53:27 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fd19.dynamic.kabel-deutschland.de. [31.18.253.25])
        by smtp.gmail.com with ESMTPSA id w26-v6sm6500775wmi.27.2018.09.30.12.53.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 12:53:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/19] staging: rtl8188eu: rename parameter of odm_QueryRxPwrPercentage()
Date:   Sun, 30 Sep 2018 21:52:58 +0200
Message-Id: <20180930195310.1531-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930195310.1531-1-straube.linux@gmail.com>
References: <20180930195310.1531-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename parameter of odm_QueryRxPwrPercentage() to avoid CamelCase.
AntPower -> antpower

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index ada59a671da4..dca39df3d8ba 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -14,14 +14,14 @@
 #define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig##txt##ic(dm_odm))
 #define READ_AND_CONFIG_TC(ic, txt) (ODM_ReadAndConfig_TC##txt##ic(dm_odm))
 
-static u8 odm_QueryRxPwrPercentage(s8 AntPower)
+static u8 odm_QueryRxPwrPercentage(s8 antpower)
 {
-	if ((AntPower <= -100) || (AntPower >= 20))
+	if ((antpower <= -100) || (antpower >= 20))
 		return 0;
-	else if (AntPower >= 0)
+	else if (antpower >= 0)
 		return 100;
 	else
-		return 100 + AntPower;
+		return 100 + antpower;
 }
 
 /*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
-- 
2.19.0

