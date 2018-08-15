Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA46C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ABB2152C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ABB2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHOVxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:53:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbeHOVxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 388A177741;
        Wed, 15 Aug 2018 19:00:25 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB0537C49;
        Wed, 15 Aug 2018 19:00:20 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v8 0/5] Fix connector probing deadlocks from RPM bugs
Date:   Wed, 15 Aug 2018 15:00:10 -0400
Message-Id: <20180815190018.15396-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 15 Aug 2018 19:00:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 15 Aug 2018 19:00:25 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Next version of https://patchwork.freedesktop.org/series/46815/

Same as previous version, but some small changes made to commit messages
and acks/rbs have been added

Lyude Paul (5):
  drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
  drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
  drm/nouveau: Fix deadlock with fb_helper with async RPM requests
  drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()
  drm/nouveau: Fix deadlocks in nouveau_connector_detect()

 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 42 +++++++++++----
 drivers/gpu/drm/nouveau/nouveau_display.c   |  9 ++--
 drivers/gpu/drm/nouveau/nouveau_drm.c       |  1 -
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     | 57 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h     |  5 ++
 6 files changed, 102 insertions(+), 14 deletions(-)

-- 
2.17.1

