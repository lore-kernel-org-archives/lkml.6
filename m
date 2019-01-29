Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58965C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE620856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfA2Sjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:39:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbfA2Sjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:39:33 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5490AB42C;
        Tue, 29 Jan 2019 18:39:32 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC0815D6A6;
        Tue, 29 Jan 2019 18:39:30 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, "David Airlie" <airlied@linux.ie>,
        "Maxime Ripard" <maxime.ripard@bootlin.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 0/3] drm/dp_mst: Fix regressions from new atomic VCPI helpers
Date:   Tue, 29 Jan 2019 13:39:24 -0500
Message-Id: <20190129183928.26779-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 29 Jan 2019 18:39:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the extra issues I discovered upstream after the introduction
of my rework of the atomic VCPI helpers that occur during
suspend/resume.

Lyude Paul (3):
  drm/dp_mst: Fix unbalanced malloc ref in drm_dp_mst_deallocate_vcpi()
  drm/atomic: Add drm_atomic_state->suspend_or_resume
  drm/i915: Always allocate VCPI during system resume

 drivers/gpu/drm/drm_atomic_helper.c   | 16 ++++++++--
 drivers/gpu/drm/drm_dp_mst_topology.c | 44 ++++++++++++++++++++++-----
 drivers/gpu/drm/i915/intel_display.c  |  4 +--
 drivers/gpu/drm/i915/intel_dp_mst.c   |  9 ++++--
 include/drm/drm_atomic.h              | 11 +++++++
 include/drm/drm_atomic_helper.h       |  3 +-
 6 files changed, 71 insertions(+), 16 deletions(-)

-- 
2.20.1

