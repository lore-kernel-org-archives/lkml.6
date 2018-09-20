Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3356C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B46D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI3Fg7tM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B46D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeIUBCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:02:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36755 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388353AbeIUBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:02:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so4881873pgo.3;
        Thu, 20 Sep 2018 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SYGS1sO45oTnl/Q5rUo6wcZ37D2M/AQANkRaLyz2Pkk=;
        b=CI3Fg7tMnhefk4JKXISb2UIP7ylqoK5ak3BpJlkRm+2cY9NgkUwyN9CWpDLPP6jJBd
         13Cl707QI8Nw3Yqjy9lpWoPrHSuKZvx6os3VhbSgfCMS52q7SJoUGpUbrzb+43FkcRcZ
         aqA804VLIW4qJGg9xuea3N1MvhuSB3G4OL+0b8XKDCoR5PgcWoVasTwELt98FXZ70Rt+
         ItY8Q0LwEDUw2uHb8abUey1A4BopMavyfxkZFXwcb1Xsf4evqq1BFhT/oi74vZfVfSVj
         h3xcXlsdB7LoTKMxvzovwuC1KKUS0MqwpHXoT/wnKdtzEmK/dohTefM/qy/ZR207ePC+
         bPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SYGS1sO45oTnl/Q5rUo6wcZ37D2M/AQANkRaLyz2Pkk=;
        b=IXsKbN8hRCwCS1Pl3tp/OtazBf3n8N0/+R4erG1SUybCCjogI+rVILOGm1WD+qQDwR
         9Qu3qONpGrjkvqklcXwcTv3C/VgZUIV3rAEMZIYXFo01YypoJ/DXjBPXRWClrwnQME9L
         HC0sR3jsRfAxrDKyTUqqPgcQHgpiN7sXvAZimU9XQxPjMn02M62VNB+2S1oc1jHmh/EV
         zh+qWhkIutEjaqeyrKXDKRXa2m55dQPuhfx/zSwmZkHW/12imXgfPjoR7TDmY7OsAHIm
         lYllvjPM7krMY1Qu+mHl4SwhcXIH4zuBwfO2MZNWsv3/83QldJvMtBxUSuBQyNkqbJYQ
         2BvA==
X-Gm-Message-State: APzg51AA3ZB58WzGHeMul2ehV1m8ELESVf36UzdaBHBbKcTGtBPqkfjo
        kGx1BndniYniO5W94TmhEybH6rkg
X-Google-Smtp-Source: ANB0VdYATQedfJeT7IhTs2qqs3FQyNnqSvfDjWJiUK1ZGAy+9pG3+C7TdLVulm1n4sbYakuiSVoXMQ==
X-Received: by 2002:a62:b2d3:: with SMTP id z80-v6mr43490436pfl.79.1537471053336;
        Thu, 20 Sep 2018 12:17:33 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n9-v6sm40665601pfg.21.2018.09.20.12.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:17:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>, Tejun Heo <tj@kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 7/9] ata: ahci_brcm: Allow using driver or DSL SoCs
Date:   Thu, 20 Sep 2018 12:16:44 -0700
Message-Id: <20180920191646.18198-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920191646.18198-1-f.fainelli@gmail.com>
References: <20180920191646.18198-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom STB AHCI controller is the same as the one found on DSL
SoCs, so we will utilize the same driver on these systems as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 39b181d6bd0d..99698d7fe585 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -121,7 +121,8 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
+		   ARCH_BCM_63XX
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  Broadcom SoC's.
-- 
2.17.1

