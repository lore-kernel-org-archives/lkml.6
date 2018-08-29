Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E19C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E4205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ0bfeSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F2E4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeH2Ten (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:34:43 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:46342 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeH2Ten (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:34:43 -0400
Received: by mail-pg1-f173.google.com with SMTP id b129-v6so2476605pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J6hVXiSpP4fXof/5NV+hP4MEZFG14YBHJVShvueEB7g=;
        b=BQ0bfeSYwXxGO0JmQ9MT7C/kmiEQJNeZWqyOt1kgwoHaRdsSqoDUDQuwn+qse/B5lr
         gTSXMHUqY4HofTtGEdGrspA1ITEiL14S5Om/XA+YcfCtnepbHEIONbU3KG46ABgRxQ3W
         RsSNFLI42horDPG8ZAG1ocgSx8oCRQl5TmZ5DGVeXLG6tJnWDMu4eg/2IctYYay+TtGD
         iBtUAMgvFKzRKIhejgYE6UKDI830VLPXC7yYvi5usVgAVufGy4cz+usRdDkTIGDRYk04
         kYEvaibSGRwSCKo4tsgsIuasojMtohwwkfJ7w9vMn281SUThk03y5KiZ0muKA/oenfAV
         /XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J6hVXiSpP4fXof/5NV+hP4MEZFG14YBHJVShvueEB7g=;
        b=bxwvL+XBRr4Kd9/3KAM3cRT3dnCo3ixlCzAfHNPtn/M2kilO+fzs1rKZqbEdNbPnyO
         PsyWrEQmh/tuViCpUA9aptLwOW0CinVa+lzCQ6qbQ5cGmbwdGTJq6RuTMrY6Tunc5GGs
         RAKtIb5ftoD6U+uzfXF14tb5khKRxUNONEpFPWOQvXr4g8sV3YKRYtkR7RQn8tQ9fmN2
         iGG7IAdbpMkPJ3sqjpJCemuv0rWhdReW9dQO7+wTcnR65ywcVjPp5VQ1I1CYdvApBo38
         weP3/mB7paKvcvlG7c/FeW4wlBniNyMHTsb65+qaVi44vhMQpmCLYBiY/UpES7dC+tuc
         mJ9w==
X-Gm-Message-State: APzg51DrMpVwbFjqoT8s7Wt2eeENmFbqZ1bBDaVuhC2vkapgB/qvrDW7
        KnRIU2gQNHucsGnE0XmT1imHASnb
X-Google-Smtp-Source: ANB0VdYguM2sp/hRgwD+vloL5WK1vw337hgDyK/rgfymZTXOoJ+KeoIbTnfgrWZczW/Z3dVS8QgVhg==
X-Received: by 2002:a63:9751:: with SMTP id d17-v6mr6335508pgo.386.1535557033455;
        Wed, 29 Aug 2018 08:37:13 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([117.242.80.10])
        by smtp.gmail.com with ESMTPSA id s3-v6sm11742791pgj.84.2018.08.29.08.37.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 08:37:12 -0700 (PDT)
Date:   Wed, 29 Aug 2018 21:10:11 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        gustavo.padovan@collabora.com
Subject: [PATCH v2] drm/vkms: Use new return type vm_fault_t
Message-ID: <20180829154011.GA30885@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
---
v2: Updated patch title

 drivers/gpu/drm/vkms/vkms_drv.h | 2 +-
 drivers/gpu/drm/vkms/vkms_gem.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 07be29f..d5d04a8 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -65,7 +65,7 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 				       u32 *handle,
 				       u64 size);
 
-int vkms_gem_fault(struct vm_fault *vmf);
+vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
 
 int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
 		     struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index c7e3836..62e05dc 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -43,14 +43,14 @@ void vkms_gem_free_object(struct drm_gem_object *obj)
 	kfree(gem);
 }
 
-int vkms_gem_fault(struct vm_fault *vmf)
+vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vkms_gem_object *obj = vma->vm_private_data;
 	unsigned long vaddr = vmf->address;
 	pgoff_t page_offset;
 	loff_t num_pages;
-	int ret;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
 	num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
@@ -58,7 +58,6 @@ int vkms_gem_fault(struct vm_fault *vmf)
 	if (page_offset > num_pages)
 		return VM_FAULT_SIGBUS;
 
-	ret = -ENOENT;
 	mutex_lock(&obj->pages_lock);
 	if (obj->pages) {
 		get_page(obj->pages[page_offset]);
-- 
1.9.1

