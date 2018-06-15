Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 303B9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38ED208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9I/889J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38ED208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965571AbeFOJyV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:54:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33066 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936122AbeFOJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:54:20 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so13787949lfy.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ue+8N8jMs6Lx6W/PV4IckKQIXpNf2ocGTfZxnN3lAYc=;
        b=m9I/889JiIQwQlqMpIVZual8ZNXoGmosxmKmlefi+1GLRQLZnVHPWnykIten4reY2d
         46SvuNKTZXYp7rpLxHrXISw9l+I1K9a8O1LIrs4+qSl6BLwN1EGPG3BRL5SX4LNLvQXk
         2xVB4paG1YpY71k7Lz0c92z9zNNrvdmEcMmTtzOId7CtZnGNZViDiPNjV7R4UWBa9oBl
         RnyADPlkYVtk9vMkL78UOj2ZMCxLrrcKDyx8ebghn2b0KVzncbUYuAeMpzcLvaR1RJ0B
         C97tD1bWB7E4BUMKcb5HDxut1Ry/9SJO88GocF/LlnakZYUCLM9ON20ouammOFsAoxOw
         4npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ue+8N8jMs6Lx6W/PV4IckKQIXpNf2ocGTfZxnN3lAYc=;
        b=QJ+UeLoGnutGMiOwZpf5G4DGxvt5/Thg2L0gDTW0+btlBnXfS9JHJJt7PLdU5HPnUG
         4wAK5IZz0NBIHvg7cGAtLlcTANcRN8xNd0BMxY9t7LbZ3p0k57dZQQd/nuRmUBpbXW5a
         bPAOQUnzCyBPjsxgF2KDXIp1jqtwdfxfEdhD5pPI8NqLXY72n9XqVrc6bw5/i5+28nM0
         H7tF19G/KDlw4J+1pvxeZbCz1REKVLTfzbL0cYOMSRvjlQT83hzZqx7BKlMT9tazTVG9
         rq4KXHpXa1VpQXtA7c2NIxmCh4CsJiDqlI2nXtF5RflpF4XC3k10vamXq+gcQMjoSg4j
         M4fA==
X-Gm-Message-State: APt69E1uL7MQFYbYD9W/1LszLOp46aYFMYJOAku6Pjf0wXck+19V9cId
        Sd/ZnxQV8Rk4+25x54g3aII=
X-Google-Smtp-Source: ADUXVKILXg3hMsBfGqHRUmECqoUEXXmm/cyo9hwwUOWe3myV5YXjdZBEk1gHAlzmPlsHBwEvugFvRQ==
X-Received: by 2002:a19:8e4e:: with SMTP id q75-v6mr772644lfd.95.1529056459227;
        Fri, 15 Jun 2018 02:54:19 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id 74-v6sm240914lfp.32.2018.06.15.02.54.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 02:54:18 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com,
        dan.carpenter@oracle.com
Cc:     andr2000@gmail.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH] drm/xen-front: Replace NULL with error value in xen_drm_front_gem_get_sg_table
Date:   Fri, 15 Jun 2018 12:54:09 +0300
Message-Id: <20180615095409.5685-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
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

And one of the problematic functions is xen_drm_front_gem_get_sg_table.
Fix this by replacing NULL with error value.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.17.1

