Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647742173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2TA0EkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfAGRdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:33:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45391 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAGRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:33:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so474695pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TzVTvpAb35f1kBJYpNhxLKE+jFS6+lVH81Gm2pSVJtA=;
        b=U2TA0EkXWafeqV/8dfLqyaRgnqSywKjYnqmKweV9JCahl3CmndgmX9GYhDBOXVvfAH
         1+reOQexuH0r+hR52y6v3NFynnAhXDKz1yBvJVupq73GfHJaekpUEjZZ5VERnswkkztC
         u1kw31yXXta8dPiYKRQzXf9kkWAGlHvuM2y+xARUfNZwBu/pNrcdqfwJ5IAzxaNbQSnj
         wZ+BNwAeUkxGvhgqzN2y4PnZ8nyVHwHdKL5fiHu9odP7SjkeOBKiOVTDm/VrYD6ngYmR
         CvqhST1ELZSx7jqRTucSaWSqKvHoZcJgHdXNkuZykezKqeaRIapcmUfattd4H0HkJPaN
         459A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TzVTvpAb35f1kBJYpNhxLKE+jFS6+lVH81Gm2pSVJtA=;
        b=d4h1+Nd2OZCPwE+IzPc6CIZ5XQy449Lgx2jDepZj+pcWMxRswayhsKM8N9hWwj0SMN
         40DkVifKNXF/eyycFbVTLs5LYrClWFV69uvApby+fS3uRj64xj8S5U+Z+MrLJ6JQzJwl
         QlwgTLRmSusajRvamjTBzVlJqVEMeHO0a1mkv2cAKVw9NU1LkEsgmBHDWikwjFZNHjji
         MU1rw5IEQ9mm0XLQuW1Hbu5ZBzpD/KhkM+OD1hPBA73Cd0Eb1ZsZ+Aedg1ZKDdmIexZR
         M0WKz42zsz+H7e++0W70R7ctvhbfYB57efvSaDAYYpfklmLhwmeMWOvyrY3fV1FndtCJ
         qqhQ==
X-Gm-Message-State: AJcUukfyxNEfy/jOoJBHITyyX/isOFxZ7PipdvDKEan2Gc9k5SQ61a9M
        ihqdRW9S4XtQlW+LdQLLfGo=
X-Google-Smtp-Source: ALg8bN6TbNX0GSsEHpfdKPKqRQG1e1izikJ//pKVOnmmq2WtZeqa16bHPW+0/ZMzrx+AOnX27tZbsg==
X-Received: by 2002:a63:4101:: with SMTP id o1mr11609715pga.447.1546882400351;
        Mon, 07 Jan 2019 09:33:20 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.19.175])
        by smtp.gmail.com with ESMTPSA id t13sm117651332pgr.42.2019.01.07.09.33.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Jan 2019 09:33:19 -0800 (PST)
Date:   Mon, 7 Jan 2019 23:07:19 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     sstabellini@kernel.org, linux@armlinux.org.uk
Cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com, sabyasachi.linux@gmail.com
Subject: [PATCH] arch/arm/xen: Remove duplicate header
Message-ID: <20190107173719.GA30197@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/arm/xen/mm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index cb44aa2..e1d44b9 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -7,7 +7,6 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
 #include <linux/swiotlb.h>
 
-- 
1.9.1

