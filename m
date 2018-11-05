Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EDFC32789
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1914D2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 02:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsOh+L3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1914D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeKELkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 06:40:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKELkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 06:40:12 -0500
Received: by mail-pf1-f194.google.com with SMTP id j13-v6so3622073pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 18:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=BE0uneAliIQj15grJEVBKhotfSmzBF425o7pPM7Pdi0=;
        b=WsOh+L3X85l+AVl8iWwhF61y56BMomC7JcfybqEb18fTsiPW9eVeoFq9tlOMuGyKpZ
         wIatB6Q9wisJOHNOUwohP66/9xIZUVIUTL3Vq7ABv74pJbiUL78Ip29L/oWFQ0pZVqgf
         QRL8sNObfnj78kq8r6vIRAJDQvB648C6J3G2TSzWFPIdko8fPaTUbQSSrpVhz4eiRh0S
         iNB1Hzl1zZ3OOYUFooHRo3McQ+Cbl3/Uios4jIf7xj23UxlwrCfoEJfx11BS6CcfItXw
         WTDlhoE9X44kyf3XvBIQxh4r24S9EeybiKL1+mM/DbApGVcwc2kUZyLGjf7RVVOgaETA
         Mkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=BE0uneAliIQj15grJEVBKhotfSmzBF425o7pPM7Pdi0=;
        b=MQ4EtlWrdltKvyVGNeeinWh6XtlxsOsPYBtviqfkOVA25h0kdynSKU09DusBAO1peT
         +Laho5mmcl9gCQXAf4KE0oG5CG5TQQv2fa3scDfk0pa548NXxReC5+P8KQhrFcOuDZZ5
         AQIB6srpEG5H9KPCkXW6ru18f43v43tYjPqQTArxRooRkoOYWLrNYdfQynjhqEV+wW5Q
         XIpE3ItWGgil7OxlTz27EvGO5DCij1eoyylg7Sq/vvEgTa+osICEmgcLCVpnIsfAghCg
         lar4RfXUf0tTMx2PRjj+4kAnW8Bw4lFByaeBXoBFhtFfhgV3v8X6jNsoI40AvJh/cT1H
         FKJQ==
X-Gm-Message-State: AGRZ1gKLyqe8Ktx5neIiebPWG1kOqQ2H007PYrqGtvd9YsYqLA0Lmo/C
        56mApcy1lGNKAKhRQYVpsy4=
X-Google-Smtp-Source: AJdET5dr//wPfB84hiFTbmIBg9mCDUjMeAJli08gGvf5l5f2cy6EuyRU249AetEVAn3RMrVkkCxGDQ==
X-Received: by 2002:a63:ed09:: with SMTP id d9-v6mr18341226pgi.305.1541384574644;
        Sun, 04 Nov 2018 18:22:54 -0800 (PST)
Received: from sabyasachi ([45.116.191.235])
        by smtp.gmail.com with ESMTPSA id a189-v6sm11349126pfa.116.2018.11.04.18.22.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 18:22:53 -0800 (PST)
Message-ID: <5bdfa97d.1c69fb81.4aef7.c9f7@mx.google.com>
X-Google-Original-Message-ID: <20181105022248.GA4159@sabyasachi.linux@gmail.com>
Date:   Mon, 5 Nov 2018 07:52:48 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     jrdr.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] arch/powerpc: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_alloc_coherent + memset with dma_zalloc_coherent

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/powerpc/sysdev/fsl_rmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index 88b35a3d..8b0ebf3 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -756,15 +756,13 @@ fsl_open_outb_mbox(struct rio_mport *mport, void *dev_id, int mbox, int entries)
 	}
 
 	/* Initialize outbound message descriptor ring */
-	rmu->msg_tx_ring.virt = dma_alloc_coherent(priv->dev,
+	rmu->msg_tx_ring.virt = dma_zalloc_coherent(priv->dev,
 				rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE,
 				&rmu->msg_tx_ring.phys, GFP_KERNEL);
 	if (!rmu->msg_tx_ring.virt) {
 		rc = -ENOMEM;
 		goto out_dma;
 	}
-	memset(rmu->msg_tx_ring.virt, 0,
-			rmu->msg_tx_ring.size * RIO_MSG_DESC_SIZE);
 	rmu->msg_tx_ring.tx_slot = 0;
 
 	/* Point dequeue/enqueue pointers at first entry in ring */
-- 
2.7.4

