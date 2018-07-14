Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2366ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5142086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paJEdjHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5142086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeGNMR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:17:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33448 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbeGNMR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:17:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id t21-v6so26312473lji.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lXcW56/CMOcpxvZCM7o5ehXwc934F9ttx+ea4laRDj4=;
        b=paJEdjHQNPlIHEWxQbhJ1x5//qzPkhoSvimiuS14R3oF8avZzrL79qMWFsXqV6rHtm
         3J0ACCMmXPanE1I9syA+RJSRxkPH1H0NQS8SBdzpEDm2K5IxRlkvV1SfDPH5B14tuBYS
         oN3nleXB9LCAwwGws5V/DgVr8AV8F9IXfdeFmuI22trVQm3mw0CTw6rvbS/EN6Seep9c
         hG+V+v51k8wTK7Ehmx6jd8x1p+eRDWOO+PdkTLrCro72T3D8Vw5Mqo8DARgSWU4L5L/A
         BBK5bH9HE/1lsYuJd71sLF0xik6pzlHF+IdJcUDNy0LjBEdhwJPoELUM/hIvUP7IDMNM
         lm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXcW56/CMOcpxvZCM7o5ehXwc934F9ttx+ea4laRDj4=;
        b=k0zpn4VFOH+4jmDJOXlVArNPsptD3iyuXvW1Uad5cgoYh89lb8mZ0T2jqWnS/L1oxv
         FY49oV+TufBwsLYTvTBRgQ+1F1BBpxJl44XAjsBJIg3oitvoLTO7bwelUty0erUqMqI2
         dciXs9R12cSSjcd7H1yhym/DesL1k/BkCf6X6nNXYQr1E9nH/V/mromQfnp+0zWRyOrw
         AnkqYa0Ru4wTyGa1jESCnrTN6JFNX41qlBxO77OwHf47WtlwTAqQm+NQ8kyk/AN/Aq8o
         Ss5iroT04IJqaG1Vo/DHUlrtAtPD+4fn5UU/QDvm7IyNGULsn1zqimz71ixtkw8rrakR
         QVdg==
X-Gm-Message-State: AOUpUlHQ7loCpmlDAL7Ol8jiWIoGber7dGquwE9DwAyDJIn0m0agzYmU
        APPlm5TdKUf15PoAm2ii3zg=
X-Google-Smtp-Source: AAOMgpdtBGBmTILx6pNLyWLHyiXAwMP46lBZW2iWDAdy6kqWvKTUiGjErBoMD2LtMjRaUkpC/p/K6A==
X-Received: by 2002:a2e:7815:: with SMTP id t21-v6mr5333002ljc.61.1531569546473;
        Sat, 14 Jul 2018 04:59:06 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id r64-v6sm7284222lff.90.2018.07.14.04.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 04:59:05 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 4/4] ntb: idt: Alter the driver info comments
Date:   Sat, 14 Jul 2018 14:58:34 +0300
Message-Id: <20180714115834.3350-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since IDT PCIe-switch temperature sensor is now always available
irregardless of the EEPROM/BIOS settings, Kconfig and in-code
description should be properly altered. In addition lets update
the driver copyright lines.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/Kconfig      |  4 +---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 11 ++++++-----
 drivers/ntb/hw/idt/ntb_hw_idt.h |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
index b360e5613b9f..bacffd369494 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -23,9 +23,7 @@ config NTB_IDT
 	 BAR settings of peer NT-functions, the BAR setups can't be done over
 	 kernel PCI fixups. That's why the alternative pre-initialization
 	 techniques like BIOS using SMBus interface or EEPROM should be
-	 utilized. Additionally if one needs to have temperature sensor
-	 information printed to system log, the corresponding registers must
-	 be initialized within BIOS/EEPROM as well.
+	 utilized.
 
 	 If unsure, say N.
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 3d48267ae315..d7a4984ed423 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -4,7 +4,7 @@
  *
  *   GPL LICENSE SUMMARY
  *
- *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *   Copyright (C) 2016-2018 T-Platforms JSC All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify it
  *   under the terms and conditions of the GNU General Public License,
@@ -1825,10 +1825,11 @@ static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
  *                      7. Temperature sensor operations
  *
  *    IDT PCIe-switch has an embedded temperature sensor, which can be used to
- * warn a user-space of possible chip overheating. Since workload temperature
- * can be different on different platforms, temperature thresholds as well as
- * general sensor settings must be setup in the framework of BIOS/EEPROM
- * initializations. It includes the actual sensor enabling as well.
+ * check current chip core temperature. Since a workload environment can be
+ * different on different platforms, an offset and ADC/filter settings can be
+ * specified. Although the offset configuration is only exposed to the sysfs
+ * hwmon interface at the moment. The rest of the settings can be adjusted
+ * for instance by the BIOS/EEPROM firmware.
  *=============================================================================
  */
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 3517cd2e2baa..2f1aa121b0cf 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -4,7 +4,7 @@
  *
  *   GPL LICENSE SUMMARY
  *
- *   Copyright (C) 2016 T-Platforms All Rights Reserved.
+ *   Copyright (C) 2016-2018 T-Platforms JSC All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify it
  *   under the terms and conditions of the GNU General Public License,
-- 
2.12.0

