Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3018C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F62D27842
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F62D27842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754802AbeF1TPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:15:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753207AbeF1TPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53D6540711FE;
        Thu, 28 Jun 2018 19:15:19 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EADED1116717;
        Thu, 28 Jun 2018 19:15:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] drm/amdgpu: s/disp_detetion_ports/disp_detection_ports/
Date:   Thu, 28 Jun 2018 15:14:53 -0400
Message-Id: <20180628191505.10015-3-lyude@redhat.com>
In-Reply-To: <20180628191505.10015-1-lyude@redhat.com>
References: <20180628191505.10015-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 19:15:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 28 Jun 2018 19:15:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jim Qu <Jim.Qu@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index daa06e7c5bb7..a3896412a019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -32,7 +32,7 @@ struct amdgpu_atpx_functions {
 	bool switch_start;
 	bool switch_end;
 	bool disp_connectors_mapping;
-	bool disp_detetion_ports;
+	bool disp_detection_ports;
 };
 
 struct amdgpu_atpx {
@@ -156,7 +156,7 @@ static void amdgpu_atpx_parse_functions(struct amdgpu_atpx_functions *f, u32 mas
 	f->switch_start = mask & ATPX_GRAPHICS_DEVICE_SWITCH_START_NOTIFICATION_SUPPORTED;
 	f->switch_end = mask & ATPX_GRAPHICS_DEVICE_SWITCH_END_NOTIFICATION_SUPPORTED;
 	f->disp_connectors_mapping = mask & ATPX_GET_DISPLAY_CONNECTORS_MAPPING_SUPPORTED;
-	f->disp_detetion_ports = mask & ATPX_GET_DISPLAY_DETECTION_PORTS_SUPPORTED;
+	f->disp_detection_ports = mask & ATPX_GET_DISPLAY_DETECTION_PORTS_SUPPORTED;
 }
 
 /**
-- 
2.17.1

