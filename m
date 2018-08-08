Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D932C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CC821722
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I63qzMOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CC821722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHHLzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:55:08 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36163 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHLzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:55:07 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so790948plb.3;
        Wed, 08 Aug 2018 02:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/4eagA+EXhAGII73zyhEHSPifk9mbQKD5+XOQtu1rb0=;
        b=I63qzMOfErj1tVM1QDyNLzKHJpfXUVUAu2iLemT8x3uEYqFUIWChAMrkDVjfm3R5k2
         Z+usIvvHdCAzIU8jiVNh+DhlN+PrhXsk2lVHutuLBoGQ7d4d/vw/6jHFEDKJbSuyhAM/
         Cch/eN4AAVujUToh63nylvt4Q497iRSgahWpKaJg0SAxbvYZ4HI+mesilqdCbPZfjQCL
         sHek/dlgGX1VMrM/1pWK5F/0V+2bwm9g2xUIu6J6rqSKKKY6DrAuBXqwPhfHRvdaVeU5
         lU1HaZXN0cq96X+46X0Szp7edSauXqwlbydIWltccjNfHsh/zDNwdqODA7w1MzEFog67
         WxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/4eagA+EXhAGII73zyhEHSPifk9mbQKD5+XOQtu1rb0=;
        b=WW5Y2ldAcPRJipOFg+rLiR/xIeus8sn5DJ1MvraILgroXQGusWc5YyzO3+fIu6Gr/O
         HuSEVup1rH5SxO3fhWgFgczA803knUBwvlooGkAo0jHAoQGn4zSjF526CbvkvZ80eYEd
         9taRlgNgkDaR7o7bhR6ZStVSNJjAHJxGl2WRgV0jlIu5ljol2+YbtpgbYsyqFKh7LtK8
         XRar4fHKTxxPwTlEJKquaQFmzfbEcPdzysSXMHVieQDbDjxrjkfpI9f5P/oN+7b78WxJ
         Y+7tZCTF5aPFVAXCbqqmW32/Ay921YFnA5dgwWA26J9KIYs4JEo0qDxu8rI7gFwnzOeb
         qp3A==
X-Gm-Message-State: AOUpUlGVbtc/o+nzDqPA+dSj1Pr6r88n+4DsNuZAJmOABW7vkhAXD798
        /hzc/t/0SYGnhujTvIO4inWtrJIouA==
X-Google-Smtp-Source: AA+uWPyxdibBXxiXSPw6DZdPnxmNYXCDi975vrTATzBx3uunbQmWo5uKA8vF1MNaEwUzZa46+8U0wA==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr1873018plo.105.1533720974819;
        Wed, 08 Aug 2018 02:36:14 -0700 (PDT)
Received: from workstation.iballbatonwifi.com ([103.72.176.152])
        by smtp.gmail.com with ESMTPSA id z20-v6sm8876007pfd.99.2018.08.08.02.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 02:36:14 -0700 (PDT)
From:   Abishek V Ashok <abishekvashok@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Abishek V Ashok <abishekvashok@gmail.com>
Subject: [PATCH] ddk750_mode.c: Wraps line to 80 charecters
Date:   Wed,  8 Aug 2018 15:05:52 +0530
Message-Id: <20180808093552.2248-1-abishekvashok@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splits definition of function programModeRegisters into two lines such
that each line is less than 80 characters.

Signed-off-by: Abishek V Ashok <abishekvashok@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 7e22d093b..57cf9e6a5 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -13,8 +13,8 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
-						  unsigned long dispControl)
+static unsigned long displayControlAdjust_SM750LE(
+		struct mode_parameter *pModeParam, unsigned long dispControl)
 {
 	unsigned long x, y;
 
-- 
2.18.0

