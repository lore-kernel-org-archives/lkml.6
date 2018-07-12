Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA02C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3B620852
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3B620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGLRN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:13:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbeGLRN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:13:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F596DFFA;
        Thu, 12 Jul 2018 17:03:02 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-214.rdu2.redhat.com [10.10.120.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01A4F10FFE4D;
        Thu, 12 Jul 2018 17:02:58 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Archit Taneja" <architt@codeaurora.org>,
        "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 0/3] drm/nouveau: Fix runtime PM leaks
Date:   Thu, 12 Jul 2018 13:02:51 -0400
Message-Id: <20180712170256.13018-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 17:03:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 17:03:02 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the latest version of
https://patchwork.freedesktop.org/series/45862/ . One new patch has been
added that also addresses some additional issues I found with
pmops_runtime_idle that would stop nouveau from suspending the GPU when
running under X.

Additionally,
"drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_commit()" has had
it's CC to stable removed.

Lyude Paul (3):
  drm/nouveau: Fix runtime PM leak in drm_open()
  drm/nouveau: Fix runtime PM leak in nv50_disp_atomic_commit()
  drm/nouveau: Remove bogus crtc check in pmops_runtime_idle

 drivers/gpu/drm/nouveau/dispnv50/disp.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 17 ++++-------------
 2 files changed, 5 insertions(+), 14 deletions(-)

-- 
2.17.1

