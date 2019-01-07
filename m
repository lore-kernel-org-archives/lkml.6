Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5C8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED40D2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfb0Huoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfAGRYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:24:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39665 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfAGRYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:24:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so449686pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=h5MALT2X5pDliyqWk6KlkEi5unDMEOp/ldBTKlH3kTk=;
        b=Hfb0HuohMJIyDMfHKGDS+Z0nlRBUfEo2wywrLh20vzNDHR+3MyOWMVfIZtei2Wk5jN
         sZCefk7LxhtCltmgRxk7AgLeVDSg896kX8+JESOQgOPc4ohkEglHWPSwMK6Lx9h1YI4t
         eyVMa6XQvrRJE0wZ9/+IE8HWirRsziX1M7M8n1s3EwIl5wOAXUe5VPlhN2GRFkTTDw2M
         GVQuQedtag/IOtufRaE6Bizs7iDpCtOE90mfuBV5+hbroG6RFdDFKDKA+udHnm/w6jn9
         vpFdQGBHy+866v29YO8QSe+Yl1TTiy4EgTjwOePFIB1r6NkWgkTBDp6IKmyRsKX0NeLj
         AjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h5MALT2X5pDliyqWk6KlkEi5unDMEOp/ldBTKlH3kTk=;
        b=STHz4ahGCAJKCnuv1nnTxHxKRiG59GvtHpxPH7R8hn5j9FcXAvD7p0ytkw5rfNUGcu
         ckYY455qyaJBShS/tGkp7dH3K9RjdCd2G9DT+pziIWgRA0TkilJp0c5TXxH+l7s/yHxE
         1M6C7tiD6Tnj+Q8YZ6NC26TDdkmREVTWk527Ve7ySdD53ts0gbNrT07ACdfz9KznGPN8
         nMmV5kHaNr/ir/PBtYCUvcDz20sEJnBAQSwJann7721Yt0NTH0rTyT7DCC5sOxN38h70
         ZwVoBSBJ4kXvCZWN6wzH5fTKo3M1oDUvd0Bx/ZOGDhS9cA0n4wwbegiEgt5ACQG3Vler
         eAJQ==
X-Gm-Message-State: AJcUukej5XUesH04wMWZ5ipVNHt2RD7nIT5mL7PF8wUzwUBJJNgidVHH
        225WE3p2EgVo478rdTTnpNs=
X-Google-Smtp-Source: ALg8bN6yPML3KHWfETYEKy6ZAhyax4PM9FZ88O6RVrdPTTSxfeug/qLYU8NI9NsZTLumjeNLFT0Kjg==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr60845311pln.324.1546881851351;
        Mon, 07 Jan 2019 09:24:11 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.19.175])
        by smtp.gmail.com with ESMTPSA id v15sm96759729pfn.94.2019.01.07.09.24.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 09:24:10 -0800 (PST)
Date:   Mon, 7 Jan 2019 22:58:06 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     linux@armlinux.org.uk, mhocko@suse.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: [PATCH] arch/arm/mm: Remove duplicate header
Message-ID: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate headers which are included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/mm/mmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f5cc1cc..dde3032 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -23,7 +23,6 @@
 #include <asm/sections.h>
 #include <asm/cachetype.h>
 #include <asm/fixmap.h>
-#include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
@@ -36,7 +35,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/pci.h>
-#include <asm/fixmap.h>
 
 #include "fault.h"
 #include "mm.h"
-- 
1.9.1

