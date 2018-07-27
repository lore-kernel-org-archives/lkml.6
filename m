Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC7C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA8D20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl/mB2CF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA8D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbeG0Jd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:33:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44947 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0Jd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:33:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so2790165pgp.11;
        Fri, 27 Jul 2018 01:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ImWczVLvgfhXTYlS+279+a3ix3EerorPzRjL0CAm+kk=;
        b=Gl/mB2CF9kSApTzebrFQPRfV5mMTXAOCWeQSIykh2zRYEo5KP5GvTX8KjjRqT+ANqa
         dhj/vT0AsOUEGAIm2uRGBDIiyo/gxrwLDrthruuncjfNWuIOUX+Tubg/8Le8IAyVOZQh
         Ta2A453VmNpv1hsPgqCaKYGtTVzlDTrqu2Tf9+7X+U1cXBx/OZd7vsxW79gShuyEh3Di
         2wKo0DGcTSGTTx8go0crELrVp5FDpbxHbWliMDnCJc4QDW2sc3puwEF/tcCcG/TVLx3J
         XULh43Ad4D2J18BeBLPCkSo4qnb7EHmGDI4WRxS+pFaOmD2bfq1EtbRwn638wvdsbyn8
         kUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ImWczVLvgfhXTYlS+279+a3ix3EerorPzRjL0CAm+kk=;
        b=VvhW6CobfB3nCxxdTotp5EajWenhXKL6AYJFeWpoBjushiJjIOo02cVbxcohAD/tJK
         /BBGb7epkEBk6nN7hqSnrkgFMk3FVhaPzn0ceDJShDbRX89M8lCPzOTobfDfOwMOh2dp
         XeuYp7rs3Z0OVKHKhMf/yNDzYInZrA1ccLBquoeepyDX6rP9ZMD0/UmZnRYDDW+1ce27
         GqfLzbYmmQ49N8AW/TgAVDCWj9lwuIHvtoi0Awq0kW2C11et++6rW6fEJof6f3AMcF9g
         /FqwsiNh8b0L1YtxiMPLtSCNr8myspCBoiab7tRNbYDlWW8LTi56gp49EApnU8Hqp+ix
         gKyw==
X-Gm-Message-State: AOUpUlGqV7JbNnMSYHNSCybcDZ7s3FFvw8iM9rw2CeGkgq2I59qPjL5z
        coIHYLIZh+1dpInp2HgK+ZB5/BLb
X-Google-Smtp-Source: AAOMgpfYHjeOa+g5aEy65PzYVd1Ac4CD1V/6H9nlisRrZyHWz4D70jYXD31H9yX/hG6Qt0bpvaLa8w==
X-Received: by 2002:a62:a018:: with SMTP id r24-v6mr5659199pfe.144.1532679193155;
        Fri, 27 Jul 2018 01:13:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id k64-v6sm7447221pfg.141.2018.07.27.01.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:13:12 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] video: fbdev: add the dependency of broadsheetfb in Kconfig
Date:   Fri, 27 Jul 2018 16:12:57 +0800
Message-Id: <20180727081257.3571-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

broadsheetfb is a platform driver and it should not be used on x86.
It should be used only by single ARM PXA board, so adding the 
dependency in Kconfig.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index d94254263ea5..ec91d7a2d8b8 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2241,7 +2241,7 @@ config FB_MX3
 
 config FB_BROADSHEET
 	tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
-	depends on FB
+	depends on FB && (ARCH_PXA || COMPILE_TEST)
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
-- 
2.17.0

