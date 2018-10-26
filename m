Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F1ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A06620868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb25eA06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A06620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeJ0EDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:03:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36907 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0EDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:03:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id 131so1371965qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oG0AzlyfGvjB8pHJ3pxUdHABNxHH12Ws4GlnVqXoYBM=;
        b=Tb25eA06iteRptHaJBAaGhr2fpOwSPNGcb3DIpKXOwxSrvOdTCVSa58rqeJtZPnlGc
         BNId+QdHc1g9q2z7yOqG0gseEQqPxqlizUObJd7TvojPodxrfZubSI6R33JZ9yLAc/Y5
         5CfXQ6pf0FesKFob4LXYdLyVVaQoFWgqGOsijKZPmCT2i6tBy0RJ51LmpbvyjtwxIqfK
         VhKAsultR3p50RnwcIq339FIHuyE+Me1TbwNtyih3htDLgfRbEEHzlpKo/GGUTZbosUm
         wS7nbyeDN+UMmN+ceOFZsslWOtK99sb27GD+Ea0ESiQ97rKkFBTQ40iCmfvuVfg1lJPu
         RS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oG0AzlyfGvjB8pHJ3pxUdHABNxHH12Ws4GlnVqXoYBM=;
        b=gU9tW85A8FcQRIFRI4sSW1fskN9oiQJeS0aXAYVEbSHWgim+DRzgJ798fz5Jsav8LN
         X2WOisRbviDrrOzuv9+MXuUbmyGQDBcstp2E5cwAUxasljU039qmBkPYeHuUV+C7Ax69
         zck30Ydf3cUG0xJDzkfYhDeWF7gi3BrFz7u7Dk+AgffbazUGnr4KeDgOVpaEQu1KXRud
         Ok6UOg8nHpNKqZaGy6a+9DNlBe6wBpBJxM2Ffg00azxLGm1QqMIV3aERWLTOZB/aSOsi
         DvTqA/s11LbMMxRZK2udkfctguvhbI2Z6H3ASNGQd6s0w4NirlSy7Noe0DHJ5Mxd5ioi
         i4kA==
X-Gm-Message-State: AGRZ1gKUJWncK1Dt98G2AObXTPaASsGFarVo6+2lJQPnrkFDcKbDOL7o
        1ikFZwT5RkhXVkjo/6tSQYQ=
X-Google-Smtp-Source: AJdET5e/a+P/YAVjVA5hPQoWWhlMs8VAL4faMnzQMs57K1/qyTlhyrjSkwADiqx7A+X5laisg6Xh1Q==
X-Received: by 2002:a37:5003:: with SMTP id e3-v6mr4397179qkb.102.1540581903262;
        Fri, 26 Oct 2018 12:25:03 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c79-v6sm11289917qka.83.2018.10.26.12.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:25:02 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:24:58 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 6/6] drm/qxl: Use 'unsigned int' instead of 'bool'
Message-ID: <fcd9d7ea7eec1ac6a3ad9ad16e0fc9ef13c089fd.1540579956.git.shayenneluzmoura@gmail.com>
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'unsigned int' with bitfield instead of 'bool' to avoid alignment
issues and remove checkpatch.pl check:

CHECK: Avoid using bool structure members because of possible alignment
issues

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index d78bcb95df3e..14d3fa855708 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -88,10 +88,10 @@ struct qxl_bo {
 
 	/* Constant after initialization */
 	struct drm_gem_object		gem_base;
-	bool is_primary; /* is this now a primary surface */
-	bool is_dumb;
+	unsigned int is_primary:1; /* is this now a primary surface */
+	unsigned int is_dumb:1;
 	struct qxl_bo *shadow;
-	bool hw_surf_alloc;
+	unsigned int hw_surf_alloc:1;
 	struct qxl_surface surf;
 	uint32_t surface_id;
 	struct qxl_release *surf_create;
@@ -128,7 +128,7 @@ struct qxl_output {
 struct qxl_mman {
 	struct ttm_bo_global_ref        bo_global_ref;
 	struct drm_global_reference	mem_global_ref;
-	bool				mem_global_referenced;
+	unsigned int mem_global_referenced:1;
 	struct ttm_bo_device		bdev;
 };
 
@@ -229,7 +229,7 @@ struct qxl_device {
 
 	struct qxl_ram_header *ram_header;
 
-	bool primary_created;
+	unsigned int primary_created:1;
 
 	struct qxl_memslot	*mem_slots;
 	uint8_t		n_mem_slots;
-- 
2.19.1

