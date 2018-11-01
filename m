Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9A1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62492081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV0XA6v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62492081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeKBAjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:39:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33138 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeKBAjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:39:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id i62-v6so1656405pfi.0;
        Thu, 01 Nov 2018 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wXjtpe+0/MV8+GRUrv1UDtAw8+JSi7AznzUuuZAOGVI=;
        b=HV0XA6v10NlOxaZ5ayJMvm63Gled41EqHXk8rWWK+ZuAC7ZPBm5H6dxrO524XPlhBm
         1dqUh0fVBf13S12DTtQZbIIKxdnd/QuQa38Hvy0E1+jt81NXDoUUA32qbgdJW8LRa9VJ
         VHJex92rvgVOz9i6zUx4IIV/IGt/nHenkcl8jxPABP03HSvaM0Ah2PUFlI6G2x/IPLc8
         jwwsjkORM7rgeXhbnsuu4IHL8VzgIegul6X3aJUA5ZEARIxEm8dxwGKGGHC44yKqtnjh
         iW4DNizS7kL3Iq0I6exNqT8KIa47ghDRCSG59VG4XNnkd5edAURnKcxrVQDO5czKs8Ba
         60JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wXjtpe+0/MV8+GRUrv1UDtAw8+JSi7AznzUuuZAOGVI=;
        b=f9rSDsqXK4CduVMQlYd8Hw/QCWU4wST/JCKiM3ArYEFW/2iiQxkKgaUI2dR9g5DNtb
         9qhcD7BGhuY5wBf3nqTnpSS+S1UbKeROwTJAo33i3KqorHE/HB0Lcu2hjlUE81BduJlw
         eKgf2A9S0TZ62RIETl9lAfPHhxWwlQiVBaOmbpt3STNmKsfKI6kIzfRK4Ed48KXjWmFA
         1Zoan0ubOHhFCsca7kg/gAcQo3BzLHigf7/eGLbSsZdTkT4yPFGNv5m+ovzSrKdZSPpl
         kj3AuHQKNep06pRDZF3TT/+AOrb1tSHi9OQ3wwg8897f2IUd74FIPWWJFcfntmh1Gu+B
         KOgA==
X-Gm-Message-State: AGRZ1gLQoeXWRpRDprmkdFqZqtGjumXnH1Vo906HAn+l9AyTfCVZKht0
        0hnSTy9fd4p5yrxMvAi/fnA=
X-Google-Smtp-Source: AJdET5eogdJz6WOwHU+pNmrf8aLqpxgKDhOHeI7F++bYRuPakwWwE0W5hjqYhvW0wGYHcVwECEUtZg==
X-Received: by 2002:a63:6782:: with SMTP id b124mr4372370pgc.151.1541086550735;
        Thu, 01 Nov 2018 08:35:50 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id d3-v6sm16905263pgi.91.2018.11.01.08.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:35:49 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] dmaengine: fix some typo
Date:   Thu,  1 Nov 2018 11:35:43 -0400
Message-Id: <20181101153543.22883-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma/ep93xx_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index a15592383d4e..7997e9bb7e10 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -993,7 +993,7 @@ ep93xx_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 	for (offset = 0; offset < len; offset += bytes) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1063,7 +1063,7 @@ ep93xx_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1141,7 +1141,7 @@ ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 	for (offset = 0; offset < buf_len; offset += period_len) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couln't get descriptor\n");
+			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
 			goto fail;
 		}
 
-- 
2.17.0

