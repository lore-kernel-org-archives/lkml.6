Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B665ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC502086B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGz/FXtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC502086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeGNMSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:18:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39578 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeGNMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:17:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so6208192lji.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FwZw+Vlttbdrdt3ctIXNZvaRDKvHEGTMXRdF8LOxb/Q=;
        b=lGz/FXtgcX8sns9Na4+UIf9QxEMxCSPcSs/zPCwhjfm6rOM8huTUQOl8eoQ+WrQEwR
         6C9g6US1csBY4qX1KBcu//CW5eu8TAqGSSOVBu+SmI12VDrQxf9Fh4RBefGKPAL0wcCU
         Irv6ScBqMdVyx4ZpYQtZGztIBg51y87Gl5KxcOVLkonoQNV08IR95x+pTl+xe9nZo27D
         CpzLNJuP2WdQIljowCzUm/s9HykN739HuVVi+6G3Z0pfi0tsKSFicPCHrG/ZesgQjq2z
         N9iGKUz9IXo914g/Cxj9wWOvBo72lnCM/MJ8hWUsUgCIXUmQ0FmauiE/tD/nGsxEkFHs
         RC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwZw+Vlttbdrdt3ctIXNZvaRDKvHEGTMXRdF8LOxb/Q=;
        b=ua4L7CXG4d3DLCFuUeM/RFpSQrR8UabRF258J+nF9PMAJLRWzl5GNWZJKhmpfjFnK4
         sNvPy7PmBxqYqEBld56vbkc4ZisrVaFVEedYTdUT54Dlml/TPT5NHQWJeBXZHpl1H1im
         WYExs6JS/aE6ptc2BW9Qb1tK/RCx201Kj8mJX8P1ukqH8VjePK/SqezcFT0JjJPjgsLf
         tM30trjNkp7QHIJ4nzhJwUFAnR9H5/er8t9kZXEy9Zf6CbfwCrVI+8BASelsvnOyFZg0
         0uumEvLE7pOW/ZcBZkcxCiXdUM9TrdgzAxfEruuD3NP/uhzi/thqS8legWoBEGJVLQrr
         LX0g==
X-Gm-Message-State: AOUpUlHTfX/mfFQN4w6hMkPd+DmsoOgNNBXGS2I0xhEzwv5Ll33wqwbs
        cQWtw+sw64rOedKjmgBs+hI=
X-Google-Smtp-Source: AAOMgpcLx7FwRm60yZ4Uy3dcaA+OsfWLNiQ+xH2jWzjUEC2h6HSUgzMGL+kIczbqcr9XSwKP4PHtvA==
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr22250ljh.45.1531569544845;
        Sat, 14 Jul 2018 04:59:04 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id r64-v6sm7284222lff.90.2018.07.14.04.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 04:59:04 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 3/4] ntb: idt: Discard temperature sensor IRQ handler
Date:   Sat, 14 Jul 2018 14:58:33 +0300
Message-Id: <20180714115834.3350-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDT PCIe-switch temperature sensor interface is very broken. First
of all only a few combinations of TMPCTL threshold enable bits
really cause the interrupts unmasked. Even if an individual bit
indicates the event unmasked, corresponding IRQ just isn't generated.
Most of the threshold enable bits combinations are in fact useless and
non of them can help to create a fully functional alarm interface.
So to speak, we can't create a well defined hwmon alarms based on
the IDT PCI-switch threshold IRQs.

Secondly a single threshold IRQ (not a combination of thresholds) can
be successfully enabled without the issue described above. But in this
case we experienced an enormous number of interrupts generated by
the chip if the temperature got near the enabled threshold value. Filter
adjustment didn't help much. It also doesn't provide a hysteresis settings.
Due to the temperature sample fluctuations near the threshold the
interrupts spate makes the system nearly unusable until the temperature
value finally settled so being pushed either to be fully higher or lower
the threshold.

All of these issues makes the temperature sensor alarm interface useless
and even at some point dangerous to be used in the driver. In this case
it is safer to completely discard it and disable the temperature alarm
interrupts.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 41 +----------------------------------------
 drivers/ntb/hw/idt/ntb_hw_idt.h |  5 ++---
 2 files changed, 3 insertions(+), 43 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index af767a13556a..3d48267ae315 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2076,38 +2076,6 @@ static struct attribute *idt_temp_attrs[] = {
 ATTRIBUTE_GROUPS(idt_temp);
 
 /*
- * idt_temp_isr() - temperature sensor alarm events ISR
- * @ndev:	IDT NTB hardware driver descriptor
- * @ntint_sts:	NT-function interrupt status
- *
- * It handles events of temperature crossing alarm thresholds. Since reading
- * of TMPALARM register clears it up, the function doesn't analyze the
- * read value, instead the current temperature value just warningly printed to
- * log.
- * The method is called from PCIe ISR bottom-half routine.
- */
-static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
-{
-	unsigned long mdeg;
-
-	/* Read the current temperature value */
-	idt_read_temp(ndev, IDT_TEMP_CUR, &mdeg);
-
-	/* Read the temperature alarm to clean the alarm status out */
-	/*(void)idt_sw_read(ndev, IDT_SW_TMPALARM);*/
-
-	/* Clean the corresponding interrupt bit */
-	idt_nt_write(ndev, IDT_NT_NTINTSTS, IDT_NTINTSTS_TMPSENSOR);
-
-	dev_dbg(&ndev->ntb.pdev->dev,
-		"Temp sensor IRQ detected %#08x", ntint_sts);
-
-	/* Print temperature value to log */
-	dev_warn(&ndev->ntb.pdev->dev, "Temperature %hhd.%hhuC",
-		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
-}
-
-/*
  * idt_init_temp() - initialize temperature sensor interface
  * @ndev:	IDT NTB hardware driver descriptor
  *
@@ -2189,7 +2157,7 @@ static int idt_init_isr(struct idt_ntb_dev *ndev)
 		goto err_free_vectors;
 	}
 
-	/* Unmask Message/Doorbell/SE/Temperature interrupts */
+	/* Unmask Message/Doorbell/SE interrupts */
 	ntint_mask = idt_nt_read(ndev, IDT_NT_NTINTMSK) & ~IDT_NTINTMSK_ALL;
 	idt_nt_write(ndev, IDT_NT_NTINTMSK, ntint_mask);
 
@@ -2204,7 +2172,6 @@ err_free_vectors:
 	return ret;
 }
 
-
 /*
  * idt_deinit_ist() - deinitialize PCIe interrupt handler
  * @ndev:	IDT NTB hardware driver descriptor
@@ -2265,12 +2232,6 @@ static irqreturn_t idt_thread_isr(int irq, void *devid)
 		handled = true;
 	}
 
-	/* Handle temperature sensor interrupt */
-	if (ntint_sts & IDT_NTINTSTS_TMPSENSOR) {
-		idt_temp_isr(ndev, ntint_sts);
-		handled = true;
-	}
-
 	dev_dbg(&ndev->ntb.pdev->dev, "IDT IRQs 0x%08x handled", ntint_sts);
 
 	return handled ? IRQ_HANDLED : IRQ_NONE;
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 032f81cb4d44..3517cd2e2baa 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -688,15 +688,14 @@
  * @IDT_NTINTMSK_DBELL:		Doorbell interrupt mask bit
  * @IDT_NTINTMSK_SEVENT:	Switch Event interrupt mask bit
  * @IDT_NTINTMSK_TMPSENSOR:	Temperature sensor interrupt mask bit
- * @IDT_NTINTMSK_ALL:		All the useful interrupts mask
+ * @IDT_NTINTMSK_ALL:		NTB-related interrupts mask
  */
 #define IDT_NTINTMSK_MSG		0x00000001U
 #define IDT_NTINTMSK_DBELL		0x00000002U
 #define IDT_NTINTMSK_SEVENT		0x00000008U
 #define IDT_NTINTMSK_TMPSENSOR		0x00000080U
 #define IDT_NTINTMSK_ALL \
-	(IDT_NTINTMSK_MSG | IDT_NTINTMSK_DBELL | \
-	 IDT_NTINTMSK_SEVENT | IDT_NTINTMSK_TMPSENSOR)
+	(IDT_NTINTMSK_MSG | IDT_NTINTMSK_DBELL | IDT_NTINTMSK_SEVENT)
 
 /*
  * NTGSIGNAL register fields related constants
-- 
2.12.0

