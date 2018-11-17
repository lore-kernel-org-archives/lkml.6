Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F8C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867B2208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867B2208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeKQMFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQMFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:05:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D00F308424B;
        Sat, 17 Nov 2018 01:50:32 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1BE16E3E1;
        Sat, 17 Nov 2018 01:50:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     "David Airlie" <airlied@linux.ie>,
        "Maxime Ripard" <maxime.ripard@bootlin.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org, "Sean Paul" <sean@poorly.run>,
        "Ben Skeggs" <bskeggs@redhat.com>
Subject: [PATCH 0/2] drm/nouveau: Fix DP AUX RPM issues
Date:   Fri, 16 Nov 2018 20:50:21 -0500
Message-Id: <20181117015024.5771-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 17 Nov 2018 01:50:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's some fixes for the less important DP AUX issues I mentioned a
while back.

Lyude Paul (2):
  drm/dp: Add ->pre/post_transfer() hooks for drm_dp_aux
  drm/nouveau: Grab an rpm reference before/after DP AUX transactions

 drivers/gpu/drm/drm_dp_helper.c             |  5 ++
 drivers/gpu/drm/nouveau/nouveau_connector.c | 36 ++++++++
 drivers/gpu/drm/nouveau/nouveau_drm.c       | 12 ++-
 drivers/gpu/drm/nouveau/nouveau_drv.h       |  8 ++
 include/drm/drm_dp_helper.h                 | 91 +++++++++++++++++++++
 5 files changed, 151 insertions(+), 1 deletion(-)

-- 
2.19.1

