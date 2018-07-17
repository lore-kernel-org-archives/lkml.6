Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56134ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105B820C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs5RPsRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105B820C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeGQJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:56:43 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:37689 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:56:42 -0400
Received: by mail-lj1-f175.google.com with SMTP id v9-v6so383415ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oILbyhkA9LWw+9jYecudW8QW535E6dsRmCcW5MWsh/Y=;
        b=Vs5RPsRzrxtZiSG4o/OYkAyicABWkkeedP0op14pGvKOauKqGYduAaiV5ZrQJPCkNX
         vFk+33m4B5Rb6t4po4Bd8O2STHNZvehks9X8x/EAlxbN9NkLSgD0VADPJong8+Jjbhuo
         OUwKTyov51z6CAQsQojCUWkhBapDNhMffri7YATrwDDuoL5Y6jb5vE3VceqSD7nvBe9+
         FkRbuGUtzre7Vtu3e5m/v6806tbC+1AemNWs4B+Pxl+/zmEsqBcc0Hr/7YqFxNykE23i
         5VlTksCgqcGL2b6brJehl3h6h4+rpMv32ejFUq+nlV2kKp3CsIjD+2TXMTC2zjnpi/g1
         vKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oILbyhkA9LWw+9jYecudW8QW535E6dsRmCcW5MWsh/Y=;
        b=VJ6QWRjdzq52v19TDz536nI33cW27cMRjdMfaaKrhHhHH+nkZISM9OSNkuLICWp83D
         o6WRVCpGVN9i6ja2Ei3ziFRUq4aVF9NEB4ISO6xdai/XLBRNQfIjEKNrgbyGG7132JkI
         yDzYeeiRIpDsicSzCC12zTcX2oMHE62hMiCILtUbMufrbqwroFy8CgVJJAjRf64XeUZj
         gcdJx1+My/kyQqaHmX8zbmtaXidZl9d/Jvth3pq0Jm5EJ8JsGNYWQfqpuphiWx3yX0Ie
         iQdNWdrpnVmyUANedNMMybXCRtjlBj8WV1vBLCaqynqTHQE8/QeDSC2lRV3PuFgvUUmd
         sJKg==
X-Gm-Message-State: AOUpUlHyKBhsMLKpjikVev45ZZJdokCKmPUXVGa8pQ/kO686sf1JyCAs
        x40+197vjdE4zbp/IfhcpfQ=
X-Google-Smtp-Source: AAOMgpd+S7W+LZBJ0MdKvAlHqfl6ESdmANv8I4SBJiFRWGbbfTfTbpTMR69Av88dXA2f9YYrTPT7+w==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr805589ljc.71.1531819501606;
        Tue, 17 Jul 2018 02:25:01 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id l1-v6sm94224lji.41.2018.07.17.02.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 02:25:01 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 4/4] ntb: idt: Alter the driver info comments
Date:   Tue, 17 Jul 2018 12:24:37 +0300
Message-Id: <20180717092437.18918-5-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
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
index 2ed147368fa8..f8948cf515ce 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -24,9 +24,7 @@ config NTB_IDT
 	 BAR settings of peer NT-functions, the BAR setups can't be done over
 	 kernel PCI fixups. That's why the alternative pre-initialization
 	 techniques like BIOS using SMBus interface or EEPROM should be
-	 utilized. Additionally if one needs to have temperature sensor
-	 information printed to system log, the corresponding registers must
-	 be initialized within BIOS/EEPROM as well.
+	 utilized.
 
 	 If unsure, say N.
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 55321086d59a..8706b8e0864a 100644
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
@@ -1824,10 +1824,11 @@ static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
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

