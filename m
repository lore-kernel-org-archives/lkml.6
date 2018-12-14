Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CAC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECEA2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECEA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeLNB02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:26:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727638AbeLNB00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:26:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B75580F88;
        Fri, 14 Dec 2018 01:26:26 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42F56012B;
        Fri, 14 Dec 2018 01:26:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 01/15] drm/dp_mst: Remove bogus conditional in drm_dp_update_payload_part1()
Date:   Thu, 13 Dec 2018 20:25:30 -0500
Message-Id: <20181214012604.13746-2-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Dec 2018 01:26:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason we need this, it's just confusing looking.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Juston Li <juston.li@intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index ad0fb6d003be..9b1b5c9b1fa0 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1896,9 +1896,7 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
 			req_payload.num_slots = 0;
 		}
 
-		if (mgr->payloads[i].start_slot != req_payload.start_slot) {
-			mgr->payloads[i].start_slot = req_payload.start_slot;
-		}
+		mgr->payloads[i].start_slot = req_payload.start_slot;
 		/* work out what is required to happen with this payload */
 		if (mgr->payloads[i].num_slots != req_payload.num_slots) {
 
-- 
2.19.2

