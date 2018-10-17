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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE550ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9109E214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UstTV3xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9109E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJRCBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:01:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38688 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeJRCBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:01:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so3114449wme.3;
        Wed, 17 Oct 2018 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwmDRFAXk8IJbF45OLxiQ5WR/eywmGic65f22BWyPCw=;
        b=UstTV3xjP1pxh8GT7mfdfQVyTVNlMLdTa0ZUBXE7jYuAfHmNTW9l3ehE5hGvDWBfiT
         IOFx+/J/RQ7ZBZ8IU/plrR4Dv4pPH1Z6aDcz2OlnK+oYWuCkxQVWbzCeYqrOoHaIyQNN
         EVBG5LvB3ypN6TrS+5G67dzzUwr4mq7UPqTDykaul8dUIRyx3Clj6Xhz+QRDMo82tkWe
         mHuS9nainqU2zxLMeS9W27Q7QOvxVxCZcivcdV35zdi0i83lLOQPcZf/l4kGKtbGMleK
         ViNPaSO+qmDIes4Az+qRDxWquZjrtfP35uUYnEBVcSZpZ4MVfWod7sVEBEPiGnrEKjzL
         BJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jwmDRFAXk8IJbF45OLxiQ5WR/eywmGic65f22BWyPCw=;
        b=Kmj0lrac/Kgo8VkQF+L5KRh0n4RgCfPbvoW3djl8qD4Bn1xWKtFvYHFAD/YUHuefeD
         RUJ/321cr8lzghI8JGRUmQSUHbNaiL2Cwn3UhY1IR6LsDexm4Rnwtz1j6JZMIe7+EWCN
         zyssA13vufEfEaXqkvAcbVFcWw4OanIvqbPPPgCFBQ3mLrfhlf/e/VOsm2OxR1CQUCuC
         JTm2G6EI5xtMOzRYFrPQdApIgZDollXByg8R62hpQ1eWnrZJlLLlyK/l8TEm6fp6mLjY
         6Sq07UUmjA804wXBKP3b8237Co4sHEhVtXjuzSPpVZ7C+1q3xXu3MRF3Ma9xPbIWvvSu
         3dmw==
X-Gm-Message-State: ABuFfoiQ8WJNyoU75KOhzmulPv3EGlOMw3rvs9ZRYq5IF35feXXmc2VM
        lmelSpkkWFJegWj09Ju6Nbs=
X-Google-Smtp-Source: ACcGV62qk42F3jfa9xcu6KuY53LkskVHzpQx8+nySq1nGEKskP/33bqR5h2CjeYNHGINbPMvxPFWcg==
X-Received: by 2002:a1c:1782:: with SMTP id 124-v6mr4063120wmx.133.1539799465840;
        Wed, 17 Oct 2018 11:04:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a11-v6sm23754491wrp.3.2018.10.17.11.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:04:24 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Chas Williams <3chas3@gmail.com>
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] atm: zatm: Fix empty body Clang warnings
Date:   Wed, 17 Oct 2018 11:04:19 -0700
Message-Id: <20181017180419.8955-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/atm/zatm.c:513:7: error: while loop has empty body
[-Werror,-Wempty-body]
        zwait;
             ^
drivers/atm/zatm.c:513:7: note: put the semicolon on a separate line to
silence this warning

Get rid of this warning by using an empty do-while loop. While we're at
it, add parentheses to make it clear that this is a function-like macro.

Link: https://github.com/ClangBuiltLinux/linux/issues/42
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/atm/zatm.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index e89146ddede6..d5c76b50d357 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -126,7 +126,7 @@ static unsigned long dummy[2] = {0,0};
 #define zin_n(r) inl(zatm_dev->base+r*4)
 #define zin(r) inl(zatm_dev->base+uPD98401_##r*4)
 #define zout(v,r) outl(v,zatm_dev->base+uPD98401_##r*4)
-#define zwait while (zin(CMR) & uPD98401_BUSY)
+#define zwait() do {} while (zin(CMR) & uPD98401_BUSY)
 
 /* RX0, RX1, TX0, TX1 */
 static const int mbx_entries[NR_MBX] = { 1024,1024,1024,1024 };
@@ -140,7 +140,7 @@ static const int mbx_esize[NR_MBX] = { 16,16,4,4 }; /* entry size in bytes */
 
 static void zpokel(struct zatm_dev *zatm_dev,u32 value,u32 addr)
 {
-	zwait;
+	zwait();
 	zout(value,CER);
 	zout(uPD98401_IND_ACC | uPD98401_IA_BALL |
 	    (uPD98401_IA_TGT_CM << uPD98401_IA_TGT_SHIFT) | addr,CMR);
@@ -149,10 +149,10 @@ static void zpokel(struct zatm_dev *zatm_dev,u32 value,u32 addr)
 
 static u32 zpeekl(struct zatm_dev *zatm_dev,u32 addr)
 {
-	zwait;
+	zwait();
 	zout(uPD98401_IND_ACC | uPD98401_IA_BALL | uPD98401_IA_RW |
 	  (uPD98401_IA_TGT_CM << uPD98401_IA_TGT_SHIFT) | addr,CMR);
-	zwait;
+	zwait();
 	return zin(CER);
 }
 
@@ -241,7 +241,7 @@ static void refill_pool(struct atm_dev *dev,int pool)
 	}
 	if (first) {
 		spin_lock_irqsave(&zatm_dev->lock, flags);
-		zwait;
+		zwait();
 		zout(virt_to_bus(first),CER);
 		zout(uPD98401_ADD_BAT | (pool << uPD98401_POOL_SHIFT) | count,
 		    CMR);
@@ -508,9 +508,9 @@ static int open_rx_first(struct atm_vcc *vcc)
 	}
 	if (zatm_vcc->pool < 0) return -EMSGSIZE;
 	spin_lock_irqsave(&zatm_dev->lock, flags);
-	zwait;
+	zwait();
 	zout(uPD98401_OPEN_CHAN,CMR);
-	zwait;
+	zwait();
 	DPRINTK("0x%x 0x%x\n",zin(CMR),zin(CER));
 	chan = (zin(CMR) & uPD98401_CHAN_ADDR) >> uPD98401_CHAN_ADDR_SHIFT;
 	spin_unlock_irqrestore(&zatm_dev->lock, flags);
@@ -571,21 +571,21 @@ static void close_rx(struct atm_vcc *vcc)
 		pos = vcc->vci >> 1;
 		shift = (1-(vcc->vci & 1)) << 4;
 		zpokel(zatm_dev,zpeekl(zatm_dev,pos) & ~(0xffff << shift),pos);
-		zwait;
+		zwait();
 		zout(uPD98401_NOP,CMR);
-		zwait;
+		zwait();
 		zout(uPD98401_NOP,CMR);
 		spin_unlock_irqrestore(&zatm_dev->lock, flags);
 	}
 	spin_lock_irqsave(&zatm_dev->lock, flags);
-	zwait;
+	zwait();
 	zout(uPD98401_DEACT_CHAN | uPD98401_CHAN_RT | (zatm_vcc->rx_chan <<
 	    uPD98401_CHAN_ADDR_SHIFT),CMR);
-	zwait;
+	zwait();
 	udelay(10); /* why oh why ... ? */
 	zout(uPD98401_CLOSE_CHAN | uPD98401_CHAN_RT | (zatm_vcc->rx_chan <<
 	    uPD98401_CHAN_ADDR_SHIFT),CMR);
-	zwait;
+	zwait();
 	if (!(zin(CMR) & uPD98401_CHAN_ADDR))
 		printk(KERN_CRIT DEV_LABEL "(itf %d): can't close RX channel "
 		    "%d\n",vcc->dev->number,zatm_vcc->rx_chan);
@@ -699,7 +699,7 @@ printk("NONONONOO!!!!\n");
 	skb_queue_tail(&zatm_vcc->tx_queue,skb);
 	DPRINTK("QRP=0x%08lx\n",zpeekl(zatm_dev,zatm_vcc->tx_chan*VC_SIZE/4+
 	  uPD98401_TXVC_QRP));
-	zwait;
+	zwait();
 	zout(uPD98401_TX_READY | (zatm_vcc->tx_chan <<
 	    uPD98401_CHAN_ADDR_SHIFT),CMR);
 	spin_unlock_irqrestore(&zatm_dev->lock, flags);
@@ -891,12 +891,12 @@ static void close_tx(struct atm_vcc *vcc)
 	}
 	spin_lock_irqsave(&zatm_dev->lock, flags);
 #if 0
-	zwait;
+	zwait();
 	zout(uPD98401_DEACT_CHAN | (chan << uPD98401_CHAN_ADDR_SHIFT),CMR);
 #endif
-	zwait;
+	zwait();
 	zout(uPD98401_CLOSE_CHAN | (chan << uPD98401_CHAN_ADDR_SHIFT),CMR);
-	zwait;
+	zwait();
 	if (!(zin(CMR) & uPD98401_CHAN_ADDR))
 		printk(KERN_CRIT DEV_LABEL "(itf %d): can't close TX channel "
 		    "%d\n",vcc->dev->number,chan);
@@ -926,9 +926,9 @@ static int open_tx_first(struct atm_vcc *vcc)
 	zatm_vcc->tx_chan = 0;
 	if (vcc->qos.txtp.traffic_class == ATM_NONE) return 0;
 	spin_lock_irqsave(&zatm_dev->lock, flags);
-	zwait;
+	zwait();
 	zout(uPD98401_OPEN_CHAN,CMR);
-	zwait;
+	zwait();
 	DPRINTK("0x%x 0x%x\n",zin(CMR),zin(CER));
 	chan = (zin(CMR) & uPD98401_CHAN_ADDR) >> uPD98401_CHAN_ADDR_SHIFT;
 	spin_unlock_irqrestore(&zatm_dev->lock, flags);
@@ -1557,7 +1557,7 @@ static void zatm_phy_put(struct atm_dev *dev,unsigned char value,
 	struct zatm_dev *zatm_dev;
 
 	zatm_dev = ZATM_DEV(dev);
-	zwait;
+	zwait();
 	zout(value,CER);
 	zout(uPD98401_IND_ACC | uPD98401_IA_B0 |
 	    (uPD98401_IA_TGT_PHY << uPD98401_IA_TGT_SHIFT) | addr,CMR);
@@ -1569,10 +1569,10 @@ static unsigned char zatm_phy_get(struct atm_dev *dev,unsigned long addr)
 	struct zatm_dev *zatm_dev;
 
 	zatm_dev = ZATM_DEV(dev);
-	zwait;
+	zwait();
 	zout(uPD98401_IND_ACC | uPD98401_IA_B0 | uPD98401_IA_RW |
 	  (uPD98401_IA_TGT_PHY << uPD98401_IA_TGT_SHIFT) | addr,CMR);
-	zwait;
+	zwait();
 	return zin(CER) & 0xff;
 }
 
-- 
2.19.1

