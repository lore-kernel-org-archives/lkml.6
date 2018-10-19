Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACABBECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B14F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2ZEmrV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B14F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeJTCTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:19:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43035 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJTCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:19:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so16176670plb.10;
        Fri, 19 Oct 2018 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wzDha78i5qywHkhdoq9/v3g/cGmDZvH9ShmsZEDPwfk=;
        b=r2ZEmrV2jin4NC81QD4/jSMD4kZYU9yeN5ZerFlIdUa/tC1haDMbZJVByA+82C26kd
         H7TdXSUlI8W25k5MQnmIUxWF6dZNggOUT1XysunJR19tH9m8RGbGZoMdDaML7yp7ibWt
         1cZu2QFb8ZSlhPH+JJaPDY/WH/Z5z4k6VI3vcwENc5q6nQ9omvWnqqYuiDGN1N/juKhm
         wYmH77VHfwzBJ/nFZNPyfz4jaXwbTg37F4KREKb9F3/YI1+xuJE/mqzdcy54konRzyIO
         C3oBnqLm5YEizrTgdNbmHPbBnRvtOnPzOukGk/4iP0qhej7UoT0HhT/Uc6+8KhINtO54
         serg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wzDha78i5qywHkhdoq9/v3g/cGmDZvH9ShmsZEDPwfk=;
        b=OSXyE7ThKT+v/YMpPpRn4IvIT6kRgK6YEvKSfIJBPw0G16xNkb58ZvjqxqdWrGcPDm
         bnR2omjZJnCGiyJQ91GjCqxBsrhSzch/dWh0XpBbN84WUYjxzbcdcSUvrs2ZEgWj7l1C
         Y/E2loIiQkr74YveB1GBYW9fC+itIFvObO/HloUObysunh5ADDGBGiZaFhJzvnSveDJP
         DThJgirDKehcnKUWNVbdi5YVew5BMftk0LhInS5xV4jlqBfgny57Z/QfFyWNeEExoV5/
         CUDwP/fUGcWFWTOED9CkIlyyG4V1Lu0QRZ/bNWmhhhip/HfmQEWGej2XrEVofcBd3K2b
         gR7A==
X-Gm-Message-State: ABuFfoghvN9KKVM67ueeeBAwiHrtIXdF10lgjI61w0tX0ACyFnY54flt
        6ttTQwn/KE3E1Mgou6HqoZHGlnSb
X-Google-Smtp-Source: ACcGV61+F909cTPz3VOGVBoyj/HtCdPPsh4A9elFViSk3+s+UWlC7I/eNKqhFVO2dxnODSGg07FGOw==
X-Received: by 2002:a17:902:6803:: with SMTP id h3-v6mr2596987plk.177.1539972756417;
        Fri, 19 Oct 2018 11:12:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n17-v6sm31459894pfj.84.2018.10.19.11.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:12:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     jonas.gorski@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs
Date:   Fri, 19 Oct 2018 11:12:32 -0700
Message-Id: <20181019181233.10227-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM-based 63xx DSL platforms have the spi-bcm63xx-hsspi controller
present, allow using this driver there as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 671d078349cc..5bc8bdcf46ee 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -129,7 +129,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.17.1

