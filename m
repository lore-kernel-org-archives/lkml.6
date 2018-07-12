Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19523C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C779420842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C779420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732573AbeGLRV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:21:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727092AbeGLRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:21:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0CD240201BF;
        Thu, 12 Jul 2018 17:11:02 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-214.rdu2.redhat.com [10.10.120.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A5A22142F20;
        Thu, 12 Jul 2018 17:11:02 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Ben Skeggs" <bskeggs@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Archit Taneja" <architt@codeaurora.org>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 0/2] drm/nouveau: Add support for dp_mst_info in debugfs
Date:   Thu, 12 Jul 2018 13:10:45 -0400
Message-Id: <20180712171056.26359-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 17:11:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 17:11:02 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hooks up the DRM helpers for dumping information on the current
status of each MST topology from nouveau's perspective to debugfs files,
similar to what i915 does (albeit, i915 labels their debugfs node for
this as i915_dp_mst_info).

Lyude Paul (2):
  drm/nouveau: Expose nv50 MST structures in disp.h
  drm/nouveau: Hook up dp_mst_info in debugfs

 drivers/gpu/drm/nouveau/dispnv50/disp.c   | 34 ----------------
 drivers/gpu/drm/nouveau/dispnv50/disp.h   | 35 +++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 47 ++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 36 deletions(-)

-- 
2.17.1

