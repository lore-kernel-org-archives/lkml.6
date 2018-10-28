Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BBEECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB5A20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGVNEWUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB5A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeJ1Pmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 11:42:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36519 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbeJ1Pmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 11:42:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so2395655pgv.3;
        Sat, 27 Oct 2018 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=3UmAG1INPLsZvGsCkv7tZzyCXG8GP3ES//qe0OzkhQI=;
        b=vGVNEWUDeojAVaAyi5opIBuEwQNIoHcY0SqqZbuvavyzJRfOtCk9vYibwHV+53/LrE
         s3QNzzlXHKQ5gm1ATkVRyvew+W0ZcNtxTTRnjXXKU4ttJuKrMxtfxt09zDOZ+hra/RrW
         Vnpqemb6hB4jP6WAjbrV1e+TGY/i8FMSAqS33Q4d3jGz5MKnIPL7XxMnk5b8xX2Bgh1J
         QkfIRzHVXH/5EaP8nd6NBqkeVR9Kvzhy56iAxd/6zDqyEvMkTdw419iXryokX/m9yVFB
         7GTjevv1SsiECfynDu8+IlWZK0XoJe/XR0y9YgX4AQvOxXdtR2U1AOSbe+HpTSTywFqn
         NtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=3UmAG1INPLsZvGsCkv7tZzyCXG8GP3ES//qe0OzkhQI=;
        b=ga097WDnlZMU4Gt/AXS8XYteGblIQQK8DaqAZ3Jo7SoDRo6uH6D4JbERbEF86osY3Q
         EXi0ZXnSY6ZDPtLJ8A7sTKV8jTFPJDcESOp9sbK8kf8AMrDcgHg6+VcnjtW7IJ98g3Z9
         hLDFQHbU+JYdwpMqD24XeqG1v7WFfKCsjILsJHHqq007PmEmHGanMmNJkQsXHKdOaDb2
         VKRnF85aFxcmPAqQ6x21nfG6TkA7BzkgMY+9VBOsoV/fxIr//hTPGL3kj+5EtU0cGMAJ
         FN39KSrk/P8MLszF0bIbyN5pOUDPbC/WC+5g8GNddfeGAnaazyOkBxkD7rxVyr6+pmAH
         luVQ==
X-Gm-Message-State: AGRZ1gK0POUny3923ENNCIn6D28XLZBYyOiiw/PCDn+GWV90z853IxNQ
        VH4H6YQ9qySnXwblvi/jO7Q=
X-Google-Smtp-Source: AJdET5e3IvcBmFR2GjqbIF2T8s6rgMr3bwetb07caJQtTXKqPYTpTbiZqsmzAI61vWegHAAYUfZZDw==
X-Received: by 2002:a62:3641:: with SMTP id d62-v6mr10203457pfa.97.1540709941765;
        Sat, 27 Oct 2018 23:59:01 -0700 (PDT)
Received: from sabyasachi ([45.116.191.194])
        by smtp.gmail.com with ESMTPSA id l16-v6sm25196412pfj.179.2018.10.27.23.59.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Oct 2018 23:59:00 -0700 (PDT)
Message-ID: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
X-Google-Original-Message-ID: <20181028065856.GA4783@sabyasachi.linux@gmail.com>
Date:   Sun, 28 Oct 2018 12:28:56 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        thomas.petazzoni@free-electrons.com, robin.murphy@arm.com,
        jacopo+renesas@jmondi.org
Cc:     jrdr.linux@gmail.com, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] arch/sh/mm/consistent.c: Use dma_zalloc_coherent
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced dma_alloc_coherent + memset with dma_zalloc_coherant

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/sh/mm/consistent.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f361..fc8d235 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -52,13 +52,12 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 	if (!memsize)
 		return 0;
 
-	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
+	buf = dma_zalloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
 		pr_warning("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
 
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
-- 
2.7.4

