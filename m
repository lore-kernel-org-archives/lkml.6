Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F81DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484F420693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndnyjpt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484F420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeGSKTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:19:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41905 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbeGSKTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:19:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17-v6so6633167ljy.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kCYBh9I1ONQDTb/ucIUlDVT05KGAwtDynvydBai6V/Q=;
        b=ndnyjpt5O9SwFP0nffgPAjk3t6Aue3Fc3+4x11rges5JktEVVDExNNJeH5wRsvWFHY
         zJzY0Ewuhy8RRgC9qRy7zobujk2ie0bGoplQl4O1mPHXyQap8FBfrh89ADeKwmD2g0Pw
         gSL4UdzdfTIr0O6Dl+N3PXHN+c6LM8IyUZGpdlt/AJBbxd4GBap/jSrjWnpP3kCYIxeT
         vi0mvl7wYFGsu7Xh5vEa3VTk3WCV9PHaM9VoN+5sLYHsJOPnc637Rd/YQBKeoWpUvLqc
         wGP2n8qyQ8ZG6vshJmP6+XpsfzJbcnZI0BL6D2d+9bMDGskyQ3M5rULEBOwJ+EgBvYN/
         Ch2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kCYBh9I1ONQDTb/ucIUlDVT05KGAwtDynvydBai6V/Q=;
        b=Kx14qO4o+NklDHpgmEeCbuTjPqpL7DUH09Ii/vCnkxyqwakDKK7nz+HNEXONehcZiR
         SVbRqrwmmi4hpQFl2IkPM9b0xU6Koe+Rr6oAA+iP0+QQBMTbq89n6Pv+F7IH7MbYPwhV
         +nOgp8iT7w7a6SdvJ8pzYcMWYzK8XfKcogRGa3CstugHPM1CrpO46ctPLQnSAVu82vYY
         p8u2YM0CWiMBh3tvTF1rXGb37mCt3Nk1IZIgqwlZmQDZytEoDtdPt1iuH3uyPPIISzdS
         ky6sbOFT3dWK+PqXdowCzoRFAJlMJqfKuSKMu0AgJDN7U/40hH6JddbQ52JJiMBz+8Qw
         IXgQ==
X-Gm-Message-State: AOUpUlETpplXGC48B1gzK3IuutSbA+C81D4jofhlZ7vl01tgX6nfPV6H
        MAHKmAPA3U3rjNPMQPxtbkg=
X-Google-Smtp-Source: AAOMgpdT19xTUvAXvZVd6ouPLJcWorMln56JwUyJju4VYDp5XuysmwaPIbFWlcJVsYqBi9cUZ8H1pg==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr7513756lji.131.1531993042902;
        Thu, 19 Jul 2018 02:37:22 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id q72-v6sm1011863lja.6.2018.07.19.02.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 02:37:21 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        dan.carpenter@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3] drm: Replace NULL with error value in drm_prime_pages_to_sg
Date:   Thu, 19 Jul 2018 12:37:13 +0300
Message-Id: <20180719093713.3643-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Dan Carpenter has reported that there is the following static checker
warning:
	drivers/gpu/drm/drm_prime.c:317 drm_gem_map_dma_buf()
	warn: 'sgt' can also be NULL

314	sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
315
316	if (!IS_ERR(sgt)) {
317		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,

Problematic functions are xen_drm_front_gem_get_sg_table and
drm_gem_cma_prime_get_sg_table. Fix those by replacing NULL with error value.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/drm_gem_cma_helper.c    | 4 ++--
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 80a5115c3846..1d2ced882b66 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -436,7 +436,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
 
 	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
 	if (!sgt)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
 			      cma_obj->paddr, obj->size);
@@ -447,7 +447,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
 
 out:
 	kfree(sgt);
-	return NULL;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_prime_get_sg_table);
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index c85bfe7571cb..47ff019d3aef 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -179,7 +179,7 @@ struct sg_table *xen_drm_front_gem_get_sg_table(struct drm_gem_object *gem_obj)
 	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
 
 	if (!xen_obj->pages)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	return drm_prime_pages_to_sg(xen_obj->pages, xen_obj->num_pages);
 }
-- 
2.18.0

