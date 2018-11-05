Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EAFECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E0020819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flV+iVsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E0020819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeKEMp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:45:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKEMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:45:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id f12-v6so2543478plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 19:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=wYFxU3IgUhH7Pg9xyygtwXTqyyinwl8/Zz4uYWqkSjM=;
        b=flV+iVsRR0fS+JvDKGdjZC17a+0ab2sA9mrg/ownHRB1YGDS+KKYNcF4ktpjVFm5q6
         jyJXdBbBYv4FHBZnV/Vie2CuIuVI7R7pC6HeWOQKQahjQu/gGTEKAsrpAGyWcPwpeHWp
         ORVGdi1Qrzd2Rq91lFr4V22ovcz+I/rrV5xBk0DUfPxFW8rgwRvUmu2Ke0Z7c4ZhroFY
         DjXBgOmQndPnVRN02olXNHW1YXaIhTq92UxgNfPr3HhZGbDiFxnkgoDt0j5kGqX2CSBW
         m6sk86PgOKapT/irSk9/+EptlMz/tU5ifF4XRjbYK2CrxWJaYyVtFH60Wgl6qkTPdE6F
         P6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=wYFxU3IgUhH7Pg9xyygtwXTqyyinwl8/Zz4uYWqkSjM=;
        b=Z+IDiQOhXCiXUmJIyge6zIKyHWvOkMwpexqJddepGu3XYLaeTnXuATZ+ZlMm5GX7Cc
         Ss9OggLvdm2ud9ewqsCtDI9AAYm1JEUA+ydg5HMO3r4MC7RBo4qJ4eCLlJigBbKE39WB
         aJgKM+InwZCJy8VtcbNnYGjlWjFRV/QJwlXX9LMQ00FAi+koW/icWIMojDRFa0rgwuFc
         d/996yqnJX3F8tPkgUouLaszvLr8ewEprIkAqWjGQ02RzRZEnT5UUzJPKtjhXrMmOzGv
         2OLQ59lsz9SZdcqxsMz/YAjLoGisrifsV5JS4qmtMsojztEdtXi3B2XLh8ZBmEDW3T7N
         xRMA==
X-Gm-Message-State: AGRZ1gIhMDs2kHf4JVjaUBCnF9mwqgWpma6wCnD/B7CYtLPu+8XepCq6
        hCXMOz/chUXw0j/PP3q9xAnNg67Jrp4=
X-Google-Smtp-Source: AJdET5c2enpqGILU2L4gaIWZulXIPLzP5lJZbt5P6hNRj8/1XfZsPqhKeDvURoW9x67UxqpRbH9S2Q==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6-v6mr20455502plb.321.1541388508206;
        Sun, 04 Nov 2018 19:28:28 -0800 (PST)
Received: from sabyasachi ([45.116.191.235])
        by smtp.gmail.com with ESMTPSA id a19-v6sm25626919pfi.138.2018.11.04.19.28.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 19:28:27 -0800 (PST)
Message-ID: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
X-Google-Original-Message-ID: <20181105032823.GA4558@sabyasachi.linux@gmail.com>
Date:   Mon, 5 Nov 2018 08:58:23 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        joe@perches.com, darren@stevens-zone.net, christophe.leroy@c-s.fr,
        geoff@infradead.org
Cc:     jrdr.linux@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
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
 arch/powerpc/platforms/pasemi/dma_lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 53384eb..d18d164 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
 
 	chan->ring_size = ring_size;
 
-	chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
+	chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
 					     ring_size * sizeof(u64),
 					     &chan->ring_dma, GFP_KERNEL);
 
 	if (!chan->ring_virt)
 		return -ENOMEM;
 
-	memset(chan->ring_virt, 0, ring_size * sizeof(u64));
-
 	return 0;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_ring);
-- 
2.7.4

