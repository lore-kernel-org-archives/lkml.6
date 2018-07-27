Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D76DC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2D9208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ae2Gi3rK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2D9208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeG0Qco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:32:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33971 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732097AbeG0Qco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:32:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so4740143ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxAuQ126foWoK3G5Zo6tw8R8NIWUb0DYcwyySeq2UL4=;
        b=ae2Gi3rKMQQOEAi6sLgY68hl1NEPV4OBwZWUFQRJJMZtEc5Z7gB2+U1r9uYOoRmR5+
         r2WCTn4DRtiCTsHliQ1KcRMq9ckkvoCB7mdBJ66d6pKInh1ND7Fueg1BxazZXJpxGm5E
         mVAkSdyz2ojY40TYwGjCxuwSJb4fKS67C3OgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxAuQ126foWoK3G5Zo6tw8R8NIWUb0DYcwyySeq2UL4=;
        b=dSjfB3yypFPuhzKwaFUSIDi6mJX3trm9b4FzU1by7GQ+oHv0rsXG0RZ9k/ybne5bXa
         HJoYCgh/jcEFQEuvmWqTTR+vU64A5G20FakJlAb4HeA1hIFVKx3LQu2vRg+ivntypQSI
         CqBBIUIoegg0WJvdghlV7xjfF0WQsTiQ3lsJXm+Ruagx/KEUaa948hFmh3/4A5brVrWY
         /b+OGYHkogCTAzwfJhrI493W8bv3be3pQdrZI2+g1yG+GxXLTmFlJCYCnlBxiTjFtE7L
         2nMYDprRvaurjxda5WWWJN/s/7ixFLKJMOrb2gt/74zEPiR719Z9D2MxGfIi/eBDcsgH
         XvvA==
X-Gm-Message-State: AOUpUlFxIQaNDjZZ2jwVuCEbs1M5dcQGN2eEwbqu8nRjtfidG3KXk32b
        WsDf4WX38OGY0r02yTXUWDdTJw==
X-Google-Smtp-Source: AAOMgpeN0y1KGPjoBPFWPuTtqojhBkuDt8O3QvcJXQWomBmBxRwzjfnlU3kotq0ThBohZTye4YGuOQ==
X-Received: by 2002:a2e:40c:: with SMTP id 12-v6mr5476272lje.146.1532704222074;
        Fri, 27 Jul 2018 08:10:22 -0700 (PDT)
Received: from localhost (c-2c3d70d5.07-21-73746f28.bbcust.telenor.se. [213.112.61.44])
        by smtp.gmail.com with ESMTPSA id q19-v6sm724241lji.14.2018.07.27.08.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 08:10:21 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rtc: sh: remove unused variable rtc_dev
Date:   Fri, 27 Jul 2018 17:10:15 +0200
Message-Id: <20180727151015.3930-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building rtc-sh, rtc_dev isn't used in function __sh_rtc_periodic.
drivers/rtc/rtc-sh.c: In function ‘__sh_rtc_periodic’:
drivers/rtc/rtc-sh.c:146:21: warning: unused variable ‘rtc_dev’ [-Wunused-variable]
  struct rtc_device *rtc_dev = rtc->rtc_dev;
                     ^~~~~~~
Remove the declaration of rtc_dev to dispose the warning.

Fixes: ec623ff014c4 ("rtc: sh: remove dead code")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/rtc/rtc-sh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-sh.c b/drivers/rtc/rtc-sh.c
index 25ec6a937858..51ba414798a8 100644
--- a/drivers/rtc/rtc-sh.c
+++ b/drivers/rtc/rtc-sh.c
@@ -143,7 +143,6 @@ static int __sh_rtc_alarm(struct sh_rtc *rtc)
 
 static int __sh_rtc_periodic(struct sh_rtc *rtc)
 {
-	struct rtc_device *rtc_dev = rtc->rtc_dev;
 	unsigned int tmp, pending;
 
 	tmp = readb(rtc->regbase + RCR2);
-- 
2.18.0

