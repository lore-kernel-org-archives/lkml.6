Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59792C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29020213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6/a4r0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfB0UcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:32:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37628 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0UcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:32:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id w6so16247928wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBvY/wy9GyaxskAnlN72iI7ujMfPftK0wneAAI5cYL8=;
        b=q6/a4r0KumHLEPPeSiQ4cLAINe8ULr2B3Vd0UdowzUPkg7SJd7/7DOIbeqdg72nVWZ
         WR7t0OpDXqMvpicTYRlpAoSFGp+vfrFr7IeVMrbyr4mzlUcTGFKVK7pBbe8itAbe+UME
         TwGDOzC6kjTnWc2KsMlvPjdIPUz/R9qfjWLkXbPKRBr/6sEOrjh7fJMQnYaGLIhIGTjH
         5ZKe3FiK0vTQWJhYZCG3fZf9P4q5Nv8BNmnlglw+ow0bfRoxi/bwmHgWCQDbKJ37CBxV
         GsaDqLg8mCElUm3aeiZ6dXE/NjPiUNCAYmtfN6enim5A0K/UPt5bP+raobuGJMzTxERz
         MX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBvY/wy9GyaxskAnlN72iI7ujMfPftK0wneAAI5cYL8=;
        b=Hn+kYtmZoIbxFCIUjkyaT4DXnC25NzOmKes1jAhY+9ybaWtSQr51LiE7uWDEEyjVDU
         wtISlACH5XeYIKpTlbtgC9PDdsDz6uM63c80BX6dS8FQCgS0i6w1xRJZmb2mQwXxNV9g
         kk80tP7XzjoBv8JnYquNWHeJxULmID5/R+N8oQxF+5ZLrR98g9ZWJG+8SoI28XM74fvc
         acb2Z6pdb+1hsnKATT3g+T4X/B+buS0xXBtYFTIaGX5U1YOTLM4xEpAIuNrrml2TSDm5
         FexKpSyl2KM3BEQhjJFprPRXHhFvKyhTIyeTPOU8pqQSUBmcBCTuPj0hADEuUJRfBdQH
         YBGQ==
X-Gm-Message-State: APjAAAXn2FNdN/+UfCN+5PcXIJH8E9O6VK9YIZ1d0V//R2HOk0XDDGLc
        nOQrBQf9ix7rgcuRZvssBWY=
X-Google-Smtp-Source: APXvYqy+2/s7bmHgXs+FqiJO5l8g9xtJ4M4TgDWHMB/z/c+fvT076HXJs1tB9n231HppxnUnk5LoAA==
X-Received: by 2002:a5d:620f:: with SMTP id y15mr3563773wru.101.1551299530217;
        Wed, 27 Feb 2019 12:32:10 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb76.dynamic.kabel-deutschland.de. [95.90.187.118])
        by smtp.gmail.com with ESMTPSA id z12sm1933589wmf.31.2019.02.27.12.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 12:32:09 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove unused P2P_PRIVATE_IOCTL_SET_LEN
Date:   Wed, 27 Feb 2019 21:31:50 +0100
Message-Id: <20190227203150.14445-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190227203150.14445-1-straube.linux@gmail.com>
References: <20190227203150.14445-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defined P2P_PRIVATE_IOCTL_SET_LEN is not used in the driver code,
so remove it from wifi.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/wifi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 873aea9cf83a..5e91b9428c16 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -791,8 +791,6 @@ enum ht_cap_ampdu_factor {
 #define	WPS_CM_SW_DISPLAY_P		0x2008
 #define	WPS_CM_LCD_DISPLAY_P		0x4008
 
-#define	P2P_PRIVATE_IOCTL_SET_LEN		64
-
 /*	=====================WFD Section===================== */
 /*	For Wi-Fi Display */
 #define	WFD_ATTR_DEVICE_INFO		0x00
-- 
2.21.0

