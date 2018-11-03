Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FB4C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6BA2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An/WQscM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6BA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbeKDIMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:12:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54882 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeKDIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:12:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so4893154wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ilLtNyJOTulSaUOsN7S1q+/Jraq6p9HPr2whDx+X/DA=;
        b=An/WQscMUmtoo85/b6kLi5W/1mEEFz61sT/YjrfYlf54ZPCRjL7sH408DvQyfOwWpN
         BdIjC/zT+KlvxY7j/gtpaVL72JvMtr+i+0d6qej0f9zcOk6AoqQceqaZ7/3IVoZEAAgX
         uYKr2kilKdaGBFDvZdDceaHBsNbTqvKZRV1p1OBm/7Kl9aS0q+WHUOe/iDRYWaWnZkbd
         PFwJN4ugvgmmPErOF8+NHKeDMkF6ClR7G76JHehUEPduyaYbm2g0FYDkmbO85mrbvPjz
         KmulGAZC/+6D1f6qztH4IxGvzDvPYBt5bfq75EYiMpjPfnC8ZtAGalvw5czHYIa3JmKN
         VIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ilLtNyJOTulSaUOsN7S1q+/Jraq6p9HPr2whDx+X/DA=;
        b=fzx9LKcI5TgkM5o4nNm0ovJPxzMbaxVaMBhTDu2R1ZalfZGpfJQl5sWp1NOAjYEoxR
         zgAx+D/gQ+RuruxtYGi5vq46ymXgFwDZdU8NKXzxKeHCuuE3ZwzHuRn6lToIPVJVN7Z5
         dIQx2s32qzvy2mJw5OvABKb02zCwLXNTQxDd6g2ziuboSSKxE5XdDzKciBJiV2EYNQKh
         ErWXTwO/Hq7Kbj4Rd8iCHb5RCELKPx+UCU1L+IBf3j7WrPiMYKxJhhPO5A73SCtQIA95
         S9G/auKs3579rxGA3Yt7ltDp1FEQe2HFlnIW0gjvkN7OfQ8qGjOjTNx5ZZ1+AGje2Ms1
         0Ftg==
X-Gm-Message-State: AGRZ1gILuvgCvRejoTwKXR7FxcbK2DlsJfuFBSF/vdPC6Xwt9Uy5vp8H
        Y8aYDkWlVptBWsvd+d9PE/c=
X-Google-Smtp-Source: AJdET5fap9LEZcO0lWJ8V0c55iI78w+H+sCwMBtbfnef34Pc0IzN6GG/KuUn4aQ1pM/CnG5Yy/Ri4w==
X-Received: by 2002:a1c:1d12:: with SMTP id d18-v6mr1832020wmd.31.1541285975246;
        Sat, 03 Nov 2018 15:59:35 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l42-v6sm13949388wre.37.2018.11.03.15.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 15:59:34 -0700 (PDT)
Date:   Sat, 3 Nov 2018 23:59:32 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] IRQ fixes
Message-ID: <20181103225932.GA62024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

   # HEAD: 3424243e39e8ec138486926949e3668e7553125d irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in probe function

An irqchip driver fix and a memory (over-)allocation fix.

 Thanks,

	Ingo

------------------>
Dan Carpenter (1):
      irqchip/irq-mvebu-sei: Fix a NULL vs IS_ERR() bug in probe function

Michael Kelley (1):
      irq/matrix: Fix memory overallocation


 drivers/irqchip/irq-mvebu-sei.c | 4 ++--
 kernel/irq/matrix.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 566d69a2edbc..add4c9c934c8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -384,9 +384,9 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 
 	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sei->base = devm_ioremap_resource(sei->dev, sei->res);
-	if (!sei->base) {
+	if (IS_ERR(sei->base)) {
 		dev_err(sei->dev, "Failed to remap SEI resource\n");
-		return -ENODEV;
+		return PTR_ERR(sei->base);
 	}
 
 	/* Retrieve the SEI capabilities with the interrupt ranges */
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 6e6d467f3dec..1f0985adf193 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,7 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS) * sizeof(unsigned long))
+#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
 
 struct cpumap {
 	unsigned int		available;
