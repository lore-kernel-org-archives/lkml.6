Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A739C4151A
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655B22184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZQeve9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfAaDHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:07:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41674 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:07:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so795818pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2owR9Y+Fu1XiPkZWSyijL0gEQb0pHlWrbxT50sCCie8=;
        b=NZQeve9zbX4Ge5xvXA78Atzzs0uz6ecZSf2jwkaGy9naKq9UQ0tGyf9387X8jWOLDY
         4ZExfwm2IiQfWLdL33XwJ3bqjuvWu3hYYxHJMPAMFEaVhAeOUc/0AE0trX9/ICzKCOpS
         i+ewoNERn06fUr3RKBdUL5yInvTYP9sftxNuXJaahmRL+kntme6zlalSzoLx36Tmhh8C
         VinMhm7g3UqnH8SQWO1LKsOibcKBsobp48bdEEKBNKNSZzue/f6r7SLEkykVE53pLDdT
         dpMFxOI4SJeXn7LVUGa+EVhuKWGKqicsil2CZOCmz1DHhwtAFNoCWpswU1DfJptM3n6G
         R9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2owR9Y+Fu1XiPkZWSyijL0gEQb0pHlWrbxT50sCCie8=;
        b=MedSPBlFZeuhCKij5P/jY6UWqKabTA1F8I326LE3Tzk14JnR5UNf/h8nerDGau7ltp
         RCZ5qNLETtSCcWXAAoIgQBelq5GUMgf3Qs33AaRufIyAg3Y9YssCxavpICdr98sZmTYq
         PdqIGHPdeAGfG9P+ZMFI47OPUSL2VnrJ0tJ5wjAvjQC/qEVne0j8NDgg6/kihzDFlVgr
         yGcMNlF0t3NkeGz1J6FLdEnyBYN8V+d9o3LHcLsPN9u5EB9JsHHHPcaO/dvJBnr4CmVh
         DoLFIjbaWpGMA0GiByZ9r+XV4TY0+xBqI02tU9G7K6GOGSPzN6f0nB+meClxZqt1htLR
         977w==
X-Gm-Message-State: AJcUukdRcxvbimk98hWn+8PytHX9ObFsHbNSKPaTbnT9AJNjq05NPwX1
        e8usj894icgi5pYuMBtRMo0=
X-Google-Smtp-Source: ALg8bN6J223zMhkVRUiamGrLjZpFQzF4EOI76I5mSAxon5PpAWsE/WAQPINgw1LsAAmjinCuk+7zEA==
X-Received: by 2002:a63:7512:: with SMTP id q18mr27636577pgc.231.1548904049578;
        Wed, 30 Jan 2019 19:07:29 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id v184sm3913763pfb.182.2019.01.30.19.07.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:07:28 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:41:42 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        linux@armlinux.org.uk, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
Subject: [PATCHv2 5/9] drm/xen/xen_drm_front_gem.c: Convert to use
 vm_insert_range
Message-ID: <20190131031142.GA2339@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index 28bc501..b72cf11 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -224,8 +224,7 @@ struct drm_gem_object *
 static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 			struct vm_area_struct *vma)
 {
-	unsigned long addr = vma->vm_start;
-	int i;
+	int ret;
 
 	/*
 	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
@@ -246,18 +245,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
 	 * FIXME: as we insert all the pages now then no .fault handler must
 	 * be called, so don't provide one
 	 */
-	for (i = 0; i < xen_obj->num_pages; i++) {
-		int ret;
-
-		ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
-		if (ret < 0) {
-			DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
-			return ret;
-		}
+	ret = vm_insert_range(vma, xen_obj->pages, xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
 
-		addr += PAGE_SIZE;
-	}
-	return 0;
+	return ret;
 }
 
 int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.9.1

