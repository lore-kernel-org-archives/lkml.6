Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B894C6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093D820858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093D820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJIGiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJIGiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1718A3082A23;
        Mon,  8 Oct 2018 23:24:48 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5C056888C;
        Mon,  8 Oct 2018 23:24:39 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Gustavo Padovan" <gustavo@padovan.org>,
        "Sean Paul" <seanpaul@chromium.org>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
Subject: [PATCH v7 0/5] Fix legacy DPMS changes with MST
Date:   Mon,  8 Oct 2018 19:24:29 -0400
Message-Id: <20181008232437.5571-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Oct 2018 23:24:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next version of https://patchwork.freedesktop.org/series/49878/

Still no functional changes, just removing a duplicate s-b to make CI
happy.

Lyude Paul (5):
  drm/atomic_helper: Disallow new modesets on unregistered connectors
  drm/nouveau: Fix nv50_mstc->best_encoder()
  drm/i915: Don't unset intel_connector->mst_port
  drm/i915: Skip vcpi allocation for MSTB ports that are gone
  drm/i915: Fix intel_dp_mst_best_encoder()

 drivers/gpu/drm/drm_atomic_helper.c     | 21 ++++++++++++-
 drivers/gpu/drm/i915/intel_dp_mst.c     | 41 ++++++++++++-------------
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 14 +++------
 3 files changed, 44 insertions(+), 32 deletions(-)

-- 
2.17.1

