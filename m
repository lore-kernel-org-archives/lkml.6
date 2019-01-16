Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8BF206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfAPUiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:38:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfAPUiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:38:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46DC9A8BB;
        Wed, 16 Jan 2019 20:38:07 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 605A55D96E;
        Wed, 16 Jan 2019 20:38:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maxime Ripard" <maxime.ripard@bootlin.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>
Subject: [PATCH 0/3] drm/dp_mst: Misc drive-by fixes
Date:   Wed, 16 Jan 2019 15:37:56 -0500
Message-Id: <20190116203759.31820-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 20:38:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two not terribly important fixes, and one actually important fix. Should
be pretty easy to review :)

Lyude Paul (3):
  drm/dp_mst: Remove lock check in drm_atomic_get_mst_topology_state()
  drm/dp_mst: Fix potential topology ref leak in
    drm_dp_atomic_find_vcpi_slots()
  drm/dp_mst: Fix topology ref leak in drm_dp_mst_allocate_vcpi()

 drivers/gpu/drm/drm_dp_mst_topology.c | 53 ++++++++-------------------
 include/drm/drm_dp_mst_helper.h       | 20 +++++++++-
 2 files changed, 33 insertions(+), 40 deletions(-)

-- 
2.20.1

