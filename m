Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEF7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53875263BD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53875263BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934581AbeFZBJY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:09:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933294AbeFZBJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:09:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA52D406E87A;
        Tue, 26 Jun 2018 01:09:21 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-29.rdu2.redhat.com [10.10.122.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195DB111DCEB;
        Tue, 26 Jun 2018 01:09:19 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     amd-gfx@lists.freedesktop.org
Cc:     "Alex Deucher" <alexander.deucher@amd.com>,
        "Monk Liu" <monk.liu@amd.com>, "David Airlie" <airlied@linux.ie>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Rex Zhu" <rex.zhu@amd.com>,
        "Felix Kuehling" <felix.kuehling@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Shaoyun Liu" <shaoyun.liu@amd.com>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Jean Delvare" <jdelvare@suse.de>, "Lyude Paul" <lyude@redhat.com>,
        "Junwei Zhang" <jerry.zhang@amd.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Huang Rui" <ray.huang@amd.com>
Subject: [PATCH 0/4] Fix HPD detection in runtime suspend
Date:   Mon, 25 Jun 2018 21:09:03 -0400
Message-Id: <20180626010916.20300-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 01:09:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 01:09:21 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does what it says on the label, more information in the patches

Lyude Paul (4):
  drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
  drm/amdgpu: s/disp_detetion_ports/disp_detection_ports/
  drm/amdgpu: Add amdgpu_atpx_get_dhandle()
  drm/amdgpu: Dynamically probe for ATIF handle

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  46 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      | 132 +++++++++++++++---
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  |  10 +-
 3 files changed, 125 insertions(+), 63 deletions(-)

-- 
2.17.1

