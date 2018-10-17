Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2A5ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EB820658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYQC55OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EB820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeJRCD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:03:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51666 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRCD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:03:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so2901273wmf.1;
        Wed, 17 Oct 2018 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xlPogxfmHt1DZaGCj5PyjdYUloKjkWNrXyFOeF4SI5E=;
        b=gYQC55ORdZoMIfCW2xzehG9fhGRRECJXR8y6kwRSMqTSUUxiAU7Txn4evLNJeSKuZP
         SQWoK3Id6Bmcoc727n496dmC6uSlXqL9UwjBdkWzcOuPt/Ym27Hy+GDMjb5CCYCwW6d/
         lYShzz0aKRXTb3FQKVdC5UVM5ft2+w8aNx2khqDJTB0p3CaupKPOuOSk6G9/gLWH9OKU
         pBKO5Mm/BuX3NcKfBltUlvPAUGJk0A66dgpdUuDfXi1r0xumJQMbbPUA+E+B8ELuXWFJ
         mxLS6b8hVz0pUUiJK98kKRmRohIuOWSIVkLbcQejJPz4Ose+f1Vx8Kqpd2GMfCZta/L+
         PSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xlPogxfmHt1DZaGCj5PyjdYUloKjkWNrXyFOeF4SI5E=;
        b=RsZ7RyYRTby4mXEVFsH5xBiEa9eyHoz/NGg2YD+NIVDzWnRoP7f1RQuYYYhbkNMOO7
         pDSvukUE2Yz2WLKkz8Nb+3pVYo/1VYA8Me/OuTV6atcUkafWYO1/+CS2V5ic/C2jjzHH
         ZnCOGHeyWQ+LefT1652Xhf3eeDnweHmqNHfRjcX8LYfSWWrro0QjNx2OkiyjuE7Rmk7X
         bddYjsC8OL56YorkQEbk4nBuNku9G8Bw0gF/SJmEIloYpZvZWh1QAGZScDD8pUIFGdtR
         xFOL8j3c/iYGh1LRvkMmxLXzNQ9xBRPFtQuNCv7WbnOLUn6XZmGvJKtyROAS/e6q1DGH
         g2aQ==
X-Gm-Message-State: ABuFfojRsil77O8Hj9z4rkAzWu2ERfvIHugDNL+uVNYvc9tW4Bymihw/
        c3maJ+E0hWa4dTt7ZribpsQ=
X-Google-Smtp-Source: ACcGV61H8n2MgA4vicmM603EdhQPQW+43E9Ra2FfZlLZLPfjF5bKZF1VMro5gG+LHmv3J1t+3H5sCg==
X-Received: by 2002:a1c:1183:: with SMTP id 125-v6mr4064977wmr.103.1539799625585;
        Wed, 17 Oct 2018 11:07:05 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id u5-v6sm18803928wru.16.2018.10.17.11.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:07:05 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] isdn: hfc_{pci,sx}: Avoid empty body if statements and use proper register accessors
Date:   Wed, 17 Oct 2018 11:06:57 -0700
Message-Id: <20181017180657.9410-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/isdn/hisax/hfc_pci.c:131:34: error: if statement has empty body
[-Werror,-Wempty-body]
        if (Read_hfc(cs, HFCPCI_INT_S1));
                                        ^
drivers/isdn/hisax/hfc_pci.c:131:34: note: put the semicolon on a
separate line to silence this warning

Use the format found in drivers/isdn/hardware/mISDN/hfcpci.c of casting
the return of Read_hfc to void, instead of using an empty if statement.

While we're at it, Masahiro Yamada pointed out that {Read,Write}_hfc
should be using a standard access method in hfc_pci.h. Use the one found
in drivers/isdn/hardware/mISDN/hfc_pci.h.

Link: https://github.com/ClangBuiltLinux/linux/issues/66
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/isdn/hisax/hfc_pci.c | 6 +++---
 drivers/isdn/hisax/hfc_pci.h | 4 ++--
 drivers/isdn/hisax/hfc_sx.c  | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 8e5b03161b2f..a63b9155b697 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -128,7 +128,7 @@ reset_hfcpci(struct IsdnCardState *cs)
 	Write_hfc(cs, HFCPCI_INT_M1, cs->hw.hfcpci.int_m1);
 
 	/* Clear already pending ints */
-	if (Read_hfc(cs, HFCPCI_INT_S1));
+	(void) Read_hfc(cs, HFCPCI_INT_S1);
 
 	Write_hfc(cs, HFCPCI_STATES, HFCPCI_LOAD_STATE | 2);	/* HFC ST 2 */
 	udelay(10);
@@ -158,7 +158,7 @@ reset_hfcpci(struct IsdnCardState *cs)
 	/* Finally enable IRQ output */
 	cs->hw.hfcpci.int_m2 = HFCPCI_IRQ_ENABLE;
 	Write_hfc(cs, HFCPCI_INT_M2, cs->hw.hfcpci.int_m2);
-	if (Read_hfc(cs, HFCPCI_INT_S1));
+	(void) Read_hfc(cs, HFCPCI_INT_S1);
 }
 
 /***************************************************/
@@ -1537,7 +1537,7 @@ hfcpci_bh(struct work_struct *work)
 					cs->hw.hfcpci.int_m1 &= ~HFCPCI_INTS_TIMER;
 					Write_hfc(cs, HFCPCI_INT_M1, cs->hw.hfcpci.int_m1);
 					/* Clear already pending ints */
-					if (Read_hfc(cs, HFCPCI_INT_S1));
+					(void) Read_hfc(cs, HFCPCI_INT_S1);
 					Write_hfc(cs, HFCPCI_STATES, 4 | HFCPCI_LOAD_STATE);
 					udelay(10);
 					Write_hfc(cs, HFCPCI_STATES, 4);
diff --git a/drivers/isdn/hisax/hfc_pci.h b/drivers/isdn/hisax/hfc_pci.h
index 4e58700a3e61..4c3b3ba35726 100644
--- a/drivers/isdn/hisax/hfc_pci.h
+++ b/drivers/isdn/hisax/hfc_pci.h
@@ -228,8 +228,8 @@ typedef union {
 } fifo_area;
 
 
-#define Write_hfc(a, b, c) (*(((u_char *)a->hw.hfcpci.pci_io) + b) = c)
-#define Read_hfc(a, b) (*(((u_char *)a->hw.hfcpci.pci_io) + b))
+#define Write_hfc(a, b, c) (writeb(c, (a->hw.hfcpci.pci_io) + b))
+#define Read_hfc(a, b) (readb((a->hw.hfcpci.pci_io) + b))
 
 extern void main_irq_hcpci(struct BCState *bcs);
 extern void releasehfcpci(struct IsdnCardState *cs);
diff --git a/drivers/isdn/hisax/hfc_sx.c b/drivers/isdn/hisax/hfc_sx.c
index 4d3b4b2f2612..c4f3f37adfc8 100644
--- a/drivers/isdn/hisax/hfc_sx.c
+++ b/drivers/isdn/hisax/hfc_sx.c
@@ -381,7 +381,7 @@ reset_hfcsx(struct IsdnCardState *cs)
 	Write_hfc(cs, HFCSX_INT_M1, cs->hw.hfcsx.int_m1);
 
 	/* Clear already pending ints */
-	if (Read_hfc(cs, HFCSX_INT_S1));
+	(void) Read_hfc(cs, HFCSX_INT_S1);
 
 	Write_hfc(cs, HFCSX_STATES, HFCSX_LOAD_STATE | 2);	/* HFC ST 2 */
 	udelay(10);
@@ -411,7 +411,7 @@ reset_hfcsx(struct IsdnCardState *cs)
 	/* Finally enable IRQ output */
 	cs->hw.hfcsx.int_m2 = HFCSX_IRQ_ENABLE;
 	Write_hfc(cs, HFCSX_INT_M2, cs->hw.hfcsx.int_m2);
-	if (Read_hfc(cs, HFCSX_INT_S2));
+	(void) Read_hfc(cs, HFCSX_INT_S2);
 }
 
 /***************************************************/
@@ -1288,7 +1288,7 @@ hfcsx_bh(struct work_struct *work)
 					cs->hw.hfcsx.int_m1 &= ~HFCSX_INTS_TIMER;
 					Write_hfc(cs, HFCSX_INT_M1, cs->hw.hfcsx.int_m1);
 					/* Clear already pending ints */
-					if (Read_hfc(cs, HFCSX_INT_S1));
+					(void) Read_hfc(cs, HFCSX_INT_S1);
 
 					Write_hfc(cs, HFCSX_STATES, 4 | HFCSX_LOAD_STATE);
 					udelay(10);
-- 
2.19.1

