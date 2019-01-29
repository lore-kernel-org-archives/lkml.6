Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E44C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F56E20869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfA2TKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:10:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbfA2TKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:10:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB45E89ACC;
        Tue, 29 Jan 2019 19:10:20 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37A0A5C57C;
        Tue, 29 Jan 2019 19:10:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v3 0/3] drm/i915: MST and wakeref leak fixes
Date:   Tue, 29 Jan 2019 14:09:58 -0500
Message-Id: <20190129191001.442-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 29 Jan 2019 19:10:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to fix a problem with suspend/resume that I introduced in
the atomic VCPI helpers for MST, I also ran into some issues with i915
varying from "not that bad" to "oh wow that's very bad". Here are the
fixes for those issues.

This series was originally just one patch,
"drm/i915: Don't send MST hotplugs during resume"

Lyude Paul (3):
  drm/i915: Block fbdev HPD processing during suspend
  drm/i915: Don't send MST hotplugs during resume
  drm/i915: Don't send hotplug in intel_dp_check_mst_status()

 drivers/gpu/drm/i915/intel_dp.c    | 13 ++++++------
 drivers/gpu/drm/i915/intel_drv.h   | 10 +++++++++
 drivers/gpu/drm/i915/intel_fbdev.c | 33 +++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 7 deletions(-)

-- 
2.20.1

