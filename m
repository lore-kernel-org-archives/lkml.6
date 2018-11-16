Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F807C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFE32086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFE32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbeKQJjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:39:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbeKQJjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:39:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 502994E91F;
        Fri, 16 Nov 2018 23:24:58 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CED385D739;
        Fri, 16 Nov 2018 23:24:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Roman Li <Roman.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Shirish S <shirish.s@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/amd/dm: Understand why attaching path/tile properties are needed
Date:   Fri, 16 Nov 2018 18:24:39 -0500
Message-Id: <20181116232443.1709-3-lyude@redhat.com>
In-Reply-To: <20181116232443.1709-1-lyude@redhat.com>
References: <20181116232443.1709-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 16 Nov 2018 23:24:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Path property is used for userspace to know what MST connector goes to
what actual DRM DisplayPort connector, the tiling property is for tiling
configurations. Not sure what else there is to figure out.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0cca1809fdcd..1b0d209d8367 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -345,9 +345,6 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	drm_connector_attach_encoder(&aconnector->base,
 				     &aconnector->mst_encoder->base);
 
-	/*
-	 * TODO: understand why this one is needed
-	 */
 	drm_object_attach_property(
 		&connector->base,
 		dev->mode_config.path_property,
-- 
2.19.1

