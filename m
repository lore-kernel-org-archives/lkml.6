Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9518020827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 00:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfAHA5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 19:57:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfAHA5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 19:57:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A47C058E2B;
        Tue,  8 Jan 2019 00:57:46 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B478A60E3F;
        Tue,  8 Jan 2019 00:57:41 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Jerry Zuo <Jerry.Zuo@amd.com>, "Daniel Vetter" <daniel@ffwll.ch>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Mikita Lipski" <mikita.lipski@amd.com>,
        "David Airlie" <airlied@linux.ie>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David Francis" <david.francis@amd.com>,
        linux-kernel@vger.kernel.org, "Anthony Koo" <anthony.koo@amd.com>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        "Bhawanpreet Lakha" <bhawanpreet.lakha@amd.com>,
        "David (ChunMing) Zhou" <david1.zhou@amd.com>,
        "Shirish S" <shirish.s@amd.com>, "Tony Cheng" <tony.cheng@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Maxime Ripard" <maxime.ripard@bootlin.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Sean Paul" <sean@poorly.run>
Subject: [PATCH 0/3] drm/amdgpu: Fix suspend/resume issues with MST
Date:   Mon,  7 Jan 2019 19:56:44 -0500
Message-Id: <20190108005651.25967-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 08 Jan 2019 00:57:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the suspend/issues that Jerry Zuo found in amdgpu, and add some
compiler warnings for drivers ignoring the return code of
drm_dp_mst_topology_mgr_resume() to help ensure we don't need to fix
this again in the future for someone else's driver.

Cc: Jerry Zuo <Jerry.Zuo@amd.com>

Lyude Paul (3):
  drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
  drm/amdgpu: Don't fail resume process if resuming atomic state fails
  drm/dp_mst: Add __must_check to drm_dp_mst_topology_mgr_resume()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 37 +++++++++++++------
 drivers/gpu/drm/drm_dp_mst_topology.c         |  3 +-
 include/drm/drm_dp_mst_helper.h               |  3 +-
 3 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.20.1

