Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12570C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E2220657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Ut6ZwrPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E2220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeKBMDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:03:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40377 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeKBMDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:03:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9-v6so293873pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dUMTS37gBEZypK54YuiT13KTFjnvL6JSY0p+eJPnHVg=;
        b=Ut6ZwrPdDXdP+3GMloWtQeyr3mTneivdFdsA7Xn4cLv//LB3JxBbBJaxBCHVfJ9czD
         /8Hmar800mQc1jE+KQgcfs6Fu+12z7z3Vmkiebxqhat7mlHxftd4ptzdT7qTfuoANrIl
         X63fH/fqCaHIrN0fCylUYxu+R56G31Y8QHVKhW8KDP2LE684PvYnKlNg8cZvzTL3V3SN
         ml9i6arT4KJj1bM9QLjWs8VrbA1QfaFfpf146zoOkGbaVqkniAkrApRnFhTJ736cq8WA
         nDvTZlX6phNcnJ0O3RsFc8JiFugSLK2bjsV1Uy98rkQSPGVkcpVbYuna1udSbYsjpAjL
         3ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dUMTS37gBEZypK54YuiT13KTFjnvL6JSY0p+eJPnHVg=;
        b=g5O0oU5QreMyAe1GtglC/aoOHnCFLqX36DUpJKSpBHRUO+n+Nh6CT/KTitNkDQq5L8
         RF2McOUDvWOjisyqVc/uEEkzGK+Cehg8vXocO8tXQ+6299F/itUVXH3HOpbiQVm7Ao0Q
         9hvyKXqlhESl13dm5kO2kobazWacMSN/uBFpDujw3teLzUAweFoCKSR1KBaNDFk6zXEm
         yOFNQmwjCJQvyfjRUTq48pIt+yCQgF9FnIuJTU+6NmU8cgtHnbFy/nfwc0TA8cAx3cXe
         6xvScTFh+Y+zG5fzvh6th2v/TcfJ0dhySSGpHD5G9ySM+PJZ8ksgnmo99nl2I0a7VkqX
         H+Sg==
X-Gm-Message-State: AGRZ1gKS0m8Y0/ZPTlXX36etEZBcs7cjIiCFYejbF5WULurWpGGXcB8H
        bdmypoQqZ2xIqU6RVSmqoVxavA==
X-Google-Smtp-Source: AJdET5f3+mQFAT9Ze4cnlZynh3AXjyk4mwENq+Q7BGEQkPx/pE81kezGJvKLOZduQRVG27oYb3m+0w==
X-Received: by 2002:a17:902:29e3:: with SMTP id h90-v6mr10138964plb.158.1541127456370;
        Thu, 01 Nov 2018 19:57:36 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id t77-v6sm15099944pfj.79.2018.11.01.19.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 19:57:34 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] pinctrl: mediatek: Fix dependencies for EINT_MTK
Date:   Thu,  1 Nov 2018 19:57:28 -0700
Message-Id: <20181102025728.963-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following config-time warning:

WARNING: unmet direct dependencies detected for EINT_MTK
  Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && (PINCTRL_MTK [=n] || PINCTRL_MTK_MOORE [=n] || COMPILE_TEST [=n])
  Selected by [y]:
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && OF [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n])

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/pinctrl/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 9d142e1da567..50efc9cc8ee7 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -3,7 +3,7 @@ menu "MediaTek pinctrl drivers"
 
 config EINT_MTK
 	bool "MediaTek External Interrupt Support"
-	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
+	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
 	select GPIOLIB
 	select IRQ_DOMAIN
 
-- 
2.11.0

