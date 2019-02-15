Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E2F2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLj6pOyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfBOCj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:39:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39900 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfBOCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:39:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so4176832pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 18:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=kLj6pOykfXcUG+qvmp8kJ2UtHrXBRj6IN3Rg/liMZsHGVPGT1Cp7dMXvFmX5uZCSeY
         B3KIkeIYAm0k1MB8GKNJ87FZ4Vy695j5l38NPs1xFMYDCLZUvhkvGy1mlKkfvT+k8GQ2
         sxhz7j+Ff8zJlO1XPDqtwuLtZpw+ZlgXtuuxCDdo1lQuxcTTQZL7hLUUEsrmJDB7raae
         ML3zxRkAZIlYzUwLc95t1N0v/NAKk5JyljdPIuHYJC9t4svAJVwEY6qRlPpJWfd+8Y21
         tfowupbrIJH1YLp3e5fxV5An+XpPk5PkF0zIASwVxYHrVgB2K7TOXw9wK0KqNnd5f49U
         yn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=AbvkiVbmNwrRIjJn6kDFIMSmb05zTvd7T8rZ4u58M3P6HYOtVxesi1opLlg7FgetlU
         kwwV57aI2WdG9WynM+ZAYE7MkRHorMeWf0UxwrjayQVPUu8sG+oMS7vp3GX36rrAFgbf
         myIxNywbLGT/yCJpDPZE0FWopv1UHouEFFDhds4XDFuzq6tM6PN4058Cx8zQqZz3xXy3
         rZa2WfzC+i9u9t9fdn/JsiBNTrbb0EgTgjfh2ss1GbvT4zITAWfnjczCUjcZ63iiWdYA
         +Gr/TBsAco5btvA62U4vRDSRxlyKWsoRii0gFDs8FcMMAXF/ZNul1/HcYExhFC9BOGGg
         srhQ==
X-Gm-Message-State: AHQUAuYWeVASo24KzB4JxvFZNx6TUfLtorP680uvvcEy2cJGfBfMuXwL
        iHnTcgG9/sbjPz5ZE1wShR4=
X-Google-Smtp-Source: AHgI3IY7ZJP/9c0JvwcJkUpHOWFlwfJrQShpMUSfzKDJXptrzyrCoFV9i84p4XJmD8juyeubZ7QRMQ==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr7294631pla.276.1550198387177;
        Thu, 14 Feb 2019 18:39:47 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.53.51])
        by smtp.gmail.com with ESMTPSA id k1sm4194873pgq.45.2019.02.14.18.39.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 18:39:46 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:14:07 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_map_pages_zero()
Message-ID: <20190215024407.GA26389@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages_zero() to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _zero suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..5414eb1 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_map_pages_zero(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

