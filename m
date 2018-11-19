Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B6520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbf2yJHs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B6520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeKTBjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:39:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42513 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbeKTBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:39:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so10524245pfr.9;
        Mon, 19 Nov 2018 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pRP+Mlg1M2SVg/V3Mss+fT5cPKpd7B1CJyuMOceuwcU=;
        b=sbf2yJHsQB48hTl42oxpCXXDgM0D08p0Lsa3cOVgKZzeDrA1tXhi61l46G0eJ5wV0q
         XQkwrw3Wb6SpQIKbyvuc75QnSIqgcM/ft9usdKA3doBRXVu7L8zsMEljDQFa/ttFlw6T
         8MrrOhXGa9uKfotVYiTXvDpNeVeY1+Xowyw73fuaqsV3c+Nq+rd9lBpeXSMIHzBGixb9
         UtWAtwn/i/KyZVl3IkO8uk3w1AMrq7BX6yX8iQt8pRSPaAm6Z+W39pyc5ZUc3a7qHoJD
         cSuP6hcaWokugsNhcL0rna3ZU2zojPC7q9RI7JVCtdkoijkiQVktuv5PjOXpx/IYT6eI
         1zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pRP+Mlg1M2SVg/V3Mss+fT5cPKpd7B1CJyuMOceuwcU=;
        b=cle1LG2aSme3PIOI7LmhLlYZqh+o4OWIQ4978uIDpzigiOX2LHBFuYwAnJMX2HZXR8
         MyrKvcInLW+WkDraB5SfjTpcKCD3HyKlzNnPb8Ju4YMVVqJnBdWx+uK56jn9WNEaNSG3
         aYrKizbpHW+PRVadeCnHWbKiiwvi8pJoTXwClGx4iIVOPYDHy3VXzH3MJETTOaLi8lTA
         qPUa99cXTMQDyGmHc78T6DUnFO/qfvAan07y2E6L3m1L9mddsXcInVACWGDwviHvliCy
         +rl+1AhW53zOWPtquChKYBRI9GGkQK9FX/1v5PI8+VVR52FIRMg+yG1OGWIhbevWysJp
         cVxg==
X-Gm-Message-State: AGRZ1gL8duL+KZmOpNai7BqleEqllz9b7NT7uhAmDxWfGLbyA8Snq3uj
        7mrnmUu+pSqY4Au8TPRwFGw=
X-Google-Smtp-Source: AJdET5ftykNSV0s9r2Tmky6U/uyP4PDoH+8Prq0crcYHDM8cfYiBYERx8NvY7oPz2fY7TCkvH3tQSA==
X-Received: by 2002:a62:ce0e:: with SMTP id y14mr9986763pfg.100.1542640538701;
        Mon, 19 Nov 2018 07:15:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id a73-v6sm47759772pfj.38.2018.11.19.07.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 07:15:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] dmaengine: ep93xx_dma: fix misspell
Date:   Mon, 19 Nov 2018 10:15:31 -0500
Message-Id: <20181119151531.17989-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

couln't -> couldn't

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma/ep93xx_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index f674eb5fbbef..594a88f4f99c 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -997,7 +997,7 @@ ep93xx_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 	for (offset = 0; offset < len; offset += bytes) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1069,7 +1069,7 @@ ep93xx_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1149,7 +1149,7 @@ ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 	for (offset = 0; offset < buf_len; offset += period_len) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
-- 
2.17.0

