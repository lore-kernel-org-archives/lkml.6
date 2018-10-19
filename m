Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA0C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B30421476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv9sNWVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B30421476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJSJP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:15:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39084 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeJSJP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:15:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so2061783wmd.4;
        Thu, 18 Oct 2018 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ewm+Lru7lQ3h1cCP4FZphrqBVpr2C/synoyBOcdCNss=;
        b=Vv9sNWVM5eLRJKw55R8A5VF+mm8CiXymv3Gwq08cSDp73Qg18z2ApCly2pfpBfzDX3
         XBKNctBzzY6Y4VYcEofx7UcxZ2ZpTuv1nBRcypM+76NY763CG5R6KxJSMB5lXVweHNNk
         f01VGN0JJOl/wWwDJYi1X2DZSJ31fJDPyoBRwVP7PiGrPfXcrbHY7FFF7mjJIOG8Fn5S
         Mbu/aBSHvb5zpaVurxgeBqYxq33AFSp23BudNEbq2WP5aBcsR4nsr6leHewPd/uY+0Mj
         e0gzd0Rdd5myA29nPWaRF/y1K/1QsgmgAJ0RoReZ8wopot7yaiLm5U+XIbZc7LYr3/Ct
         uH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ewm+Lru7lQ3h1cCP4FZphrqBVpr2C/synoyBOcdCNss=;
        b=pSbRzRNODbZvEpFRZEPF4O2Xc7SF51Iy0qCH4i+GmEtWJigKHjtrHhATIILEXFel6P
         V8AKAD9wtLkFliuqjLeR7TlifQbbnjmp9EG3W4dvTV42PHUZgWRuyibGlrE+2lIMB5vf
         6emHydOYyOrpJSXlFtsYGVTSl3Q4+y/xkYiuGGAQ5nhjKD9gF5/klA28Zzm9zfgNKlWg
         aIxmf6G5qbKxIfz2yXuxik0oeOLSFP1izO0FjkTbFA9+SlCH2jV2RIVITLDKsf24tTQM
         EWxaYeEO+BZNHTOq8EKWxrCLyvWGgT2rFsT+77uSWb3XRl4zf0J2Sc1YNGaRrJX6Ryid
         N7wQ==
X-Gm-Message-State: ABuFfoiQJvkCaZ9Dm9i8dei9JTBScYhCB5scPa8JvHZLbiun+efO0GkK
        iUUKL7gd2RhAP49TQMEZxwU=
X-Google-Smtp-Source: ACcGV61CMHOa/KDr99J9EUlQg9mWmiYBs/640/qElxN9HVC+vBJeiipDHgyOed6xqrE4irJZLDdbMw==
X-Received: by 2002:a1c:8085:: with SMTP id b127-v6mr2550351wmd.146.1539911533826;
        Thu, 18 Oct 2018 18:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 77-v6sm3255388wmv.6.2018.10.18.18.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 18:12:13 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] isdn: hfc_{pci,sx}: Avoid empty body if statements
Date:   Thu, 18 Oct 2018 18:11:04 -0700
Message-Id: <20181019011103.32087-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018034935.16819-1-natechancellor@gmail.com>
References: <20181018034935.16819-1-natechancellor@gmail.com>
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

In my attempt to hide the warnings because I thought they didn't serve
any purpose[1], Masahiro Yamada pointed out that {Read,Write}_hfc in
hci_pci.c should be using a standard register access method; otherwise,
the compiler will just remove the if statements.

For hfc_pci, use the versions of {Read,Write}_hfc found in
drivers/isdn/hardware/mISDN/hfc_pCI.h while converting pci_io to be
'void __iomem *' (and clean up ioremap) then remove the empty if
statements.

For hfc_sx, {Read,Write}_hfc are already use a proper register accessor
(inb, outb) so just remove the unnecessary if statements.

[1]: https://lore.kernel.org/lkml/20181016021454.11953-1-natechancellor@gmail.com/

Link: https://github.com/ClangBuiltLinux/linux/issues/66
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Remove unnecessary cast to void, just remove if statements (thanks to
  review from Masahiro).

* Clean up commit message.

v2 -> v3:

* Convert hfc_pci to properly use readb/writeb to avoid static checker
  issues.

 drivers/isdn/hisax/hfc_pci.c | 11 +++++------
 drivers/isdn/hisax/hfc_pci.h |  4 ++--
 drivers/isdn/hisax/hfc_sx.c  |  6 +++---
 drivers/isdn/hisax/hisax.h   |  2 +-
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 8e5b03161b2f..ea0e4c6de3fb 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -86,7 +86,7 @@ release_io_hfcpci(struct IsdnCardState *cs)
 	pci_free_consistent(cs->hw.hfcpci.dev, 0x8000,
 			    cs->hw.hfcpci.fifos, cs->hw.hfcpci.dma);
 	cs->hw.hfcpci.fifos = NULL;
-	iounmap((void *)cs->hw.hfcpci.pci_io);
+	iounmap(cs->hw.hfcpci.pci_io);
 }
 
 /********************************************************************************/
@@ -128,7 +128,7 @@ reset_hfcpci(struct IsdnCardState *cs)
 	Write_hfc(cs, HFCPCI_INT_M1, cs->hw.hfcpci.int_m1);
 
 	/* Clear already pending ints */
-	if (Read_hfc(cs, HFCPCI_INT_S1));
+	Read_hfc(cs, HFCPCI_INT_S1);
 
 	Write_hfc(cs, HFCPCI_STATES, HFCPCI_LOAD_STATE | 2);	/* HFC ST 2 */
 	udelay(10);
@@ -158,7 +158,7 @@ reset_hfcpci(struct IsdnCardState *cs)
 	/* Finally enable IRQ output */
 	cs->hw.hfcpci.int_m2 = HFCPCI_IRQ_ENABLE;
 	Write_hfc(cs, HFCPCI_INT_M2, cs->hw.hfcpci.int_m2);
-	if (Read_hfc(cs, HFCPCI_INT_S1));
+	Read_hfc(cs, HFCPCI_INT_S1);
 }
 
 /***************************************************/
@@ -1537,7 +1537,7 @@ hfcpci_bh(struct work_struct *work)
 					cs->hw.hfcpci.int_m1 &= ~HFCPCI_INTS_TIMER;
 					Write_hfc(cs, HFCPCI_INT_M1, cs->hw.hfcpci.int_m1);
 					/* Clear already pending ints */
-					if (Read_hfc(cs, HFCPCI_INT_S1));
+					Read_hfc(cs, HFCPCI_INT_S1);
 					Write_hfc(cs, HFCPCI_STATES, 4 | HFCPCI_LOAD_STATE);
 					udelay(10);
 					Write_hfc(cs, HFCPCI_STATES, 4);
@@ -1692,7 +1692,7 @@ setup_hfcpci(struct IsdnCard *card)
 		printk(KERN_WARNING "HFC-PCI: No IRQ for PCI card found\n");
 		return (0);
 	}
-	cs->hw.hfcpci.pci_io = (char *)(unsigned long)dev_hfcpci->resource[1].start;
+	cs->hw.hfcpci.pci_io = ioremap(dev_hfcpci->resource[1].start, 256);
 	printk(KERN_INFO "HiSax: HFC-PCI card manufacturer: %s card name: %s\n", id_list[i].vendor_name, id_list[i].card_name);
 
 	if (!cs->hw.hfcpci.pci_io) {
@@ -1716,7 +1716,6 @@ setup_hfcpci(struct IsdnCard *card)
 		return 0;
 	}
 	pci_write_config_dword(cs->hw.hfcpci.dev, 0x80, (u32)cs->hw.hfcpci.dma);
-	cs->hw.hfcpci.pci_io = ioremap((ulong) cs->hw.hfcpci.pci_io, 256);
 	printk(KERN_INFO
 	       "HFC-PCI: defined at mem %p fifo %p(%lx) IRQ %d HZ %d\n",
 	       cs->hw.hfcpci.pci_io,
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
index 4d3b4b2f2612..12af628d9b2c 100644
--- a/drivers/isdn/hisax/hfc_sx.c
+++ b/drivers/isdn/hisax/hfc_sx.c
@@ -381,7 +381,7 @@ reset_hfcsx(struct IsdnCardState *cs)
 	Write_hfc(cs, HFCSX_INT_M1, cs->hw.hfcsx.int_m1);
 
 	/* Clear already pending ints */
-	if (Read_hfc(cs, HFCSX_INT_S1));
+	Read_hfc(cs, HFCSX_INT_S1);
 
 	Write_hfc(cs, HFCSX_STATES, HFCSX_LOAD_STATE | 2);	/* HFC ST 2 */
 	udelay(10);
@@ -411,7 +411,7 @@ reset_hfcsx(struct IsdnCardState *cs)
 	/* Finally enable IRQ output */
 	cs->hw.hfcsx.int_m2 = HFCSX_IRQ_ENABLE;
 	Write_hfc(cs, HFCSX_INT_M2, cs->hw.hfcsx.int_m2);
-	if (Read_hfc(cs, HFCSX_INT_S2));
+	Read_hfc(cs, HFCSX_INT_S2);
 }
 
 /***************************************************/
@@ -1288,7 +1288,7 @@ hfcsx_bh(struct work_struct *work)
 					cs->hw.hfcsx.int_m1 &= ~HFCSX_INTS_TIMER;
 					Write_hfc(cs, HFCSX_INT_M1, cs->hw.hfcsx.int_m1);
 					/* Clear already pending ints */
-					if (Read_hfc(cs, HFCSX_INT_S1));
+					Read_hfc(cs, HFCSX_INT_S1);
 
 					Write_hfc(cs, HFCSX_STATES, 4 | HFCSX_LOAD_STATE);
 					udelay(10);
diff --git a/drivers/isdn/hisax/hisax.h b/drivers/isdn/hisax/hisax.h
index 338d0408b377..40080e06421c 100644
--- a/drivers/isdn/hisax/hisax.h
+++ b/drivers/isdn/hisax/hisax.h
@@ -703,7 +703,7 @@ struct hfcPCI_hw {
 	unsigned char nt_mode;
 	int nt_timer;
 	struct pci_dev *dev;
-	unsigned char *pci_io; /* start of PCI IO memory */
+	void __iomem *pci_io; /* start of PCI IO memory */
 	dma_addr_t dma; /* dma handle for Fifos */
 	void *fifos; /* FIFO memory */
 	int last_bfifo_cnt[2]; /* marker saving last b-fifo frame count */
-- 
2.19.1

