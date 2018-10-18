Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA662145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfUMZplS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA662145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJRLvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:51:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39295 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeJRLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:51:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so4187922wmd.4;
        Wed, 17 Oct 2018 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHFGW0D8ab0RJqiMixyEMSYgryVmwW9AqI1O0T5KHnQ=;
        b=AfUMZplSqD2EqGJ/+rxnMQkUsRj1XM19yntd8uwX/88C3YiJqnU9oN9X1lbJhhBjTX
         9sotJmo2ZKW+HVOCbC8iAqavtxgEfBkdq4DvmM1E4ZfTZPBxKGvpan+zeZM1fKGfpyNE
         MIpaJQx6T9ew1p7RPx/nfYbCytw16TnwV5NoAD5Q0HhvhTcWdfskLneLGvACgoG7RDC0
         3/vZ42IaJF03lrcJio/XjKeUQA7DUVYaV9O7Q41jxr2XlXzBaZikNGwo3prlogoueYf1
         pfkwwmUFqSm7ITpHaif/oRhNLGKyEp1FLz+bwvzjdtLdhUVT0uvzzaHSN95GyTXZ5Jx+
         J1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHFGW0D8ab0RJqiMixyEMSYgryVmwW9AqI1O0T5KHnQ=;
        b=UZ1ZBzcEl3ErbB+V8+U2pmVSoyu05bBfFhHk+kAbckntq7++LBo81JsUWp1Ae6i38g
         BTY+AELHBEC8w4otm/tV7C3HOl2TvrchY7duRYtKICGuAZwr/Vkb1YO5V1tKCk43NaJy
         UafSG9N9Bh6Cn6a5f4YZUybWQ4L7ulZx5TI+XMSYtkOI0wnkm6FZi+9AkCeOvoJfw2D/
         UKKALz+dT4mjXX+xe/bUWILJ55jHZ3Nibc6h9v8mnke3YSsaoXm0TDK8ZkAfI6BThpxe
         ax1TTTAGbWe5GDi8V87ktWSSYjDJyFPvL/CmvcGrf0fgNcbFmSmTiZRDfK8SzXO//c8M
         dDRQ==
X-Gm-Message-State: ABuFfoib9/OYTMyzwjX94gUbx1CLUuBIKWROS/7GFZAdJhU97pjpoL6R
        9NqgyRn8zyiNxwo7SxsCJwovAbbFPRLbIQ==
X-Google-Smtp-Source: ACcGV60sq5XtzKc7SPbku86b+KBGqYTbN8EkERfeIyJIM7UbIkS0umvRqxdlLOpnWBo09o+l1+8kXQ==
X-Received: by 2002:a1c:89cd:: with SMTP id l196-v6mr5302545wmd.7.1539834755725;
        Wed, 17 Oct 2018 20:52:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d16-v6sm15698195wrw.78.2018.10.17.20.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 20:52:35 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] isdn: hfc_{pci,sx}: Avoid empty body if statements
Date:   Wed, 17 Oct 2018 20:49:36 -0700
Message-Id: <20181018034935.16819-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181017180657.9410-1-natechancellor@gmail.com>
References: <20181017180657.9410-1-natechancellor@gmail.com>
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
drivers/isdn/hardware/mISDN/hfc_pCI.h then remove the empty if statements.

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

 drivers/isdn/hisax/hfc_pci.c | 6 +++---
 drivers/isdn/hisax/hfc_pci.h | 4 ++--
 drivers/isdn/hisax/hfc_sx.c  | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index 8e5b03161b2f..7bcd104e9dfe 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
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
-- 
2.19.1

