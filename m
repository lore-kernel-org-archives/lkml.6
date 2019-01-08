Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBCBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D59E214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfAHOvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:51:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:41354 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfAHOvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:51:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 64DEC209D7; Tue,  8 Jan 2019 15:51:15 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D1CC206DC;
        Tue,  8 Jan 2019 15:51:15 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 0/4] drm/vc4: Add a load tracker 
Date:   Tue,  8 Jan 2019 15:50:52 +0100
Message-Id: <20190108145056.2276-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a third iteration of the VC4 load tracking series, which was
initially developed by Boris Brezillon and that I have now taken over.

This new version aggregates a standalone patch adding a debugfs entry,
which was updated since its last revision. A new preliminary patch is
also introduced, which fixes underrun reports when reconfiguring the
display pipeline.

A detailed changelog is available on each patch when applicable.

Cheers,

Paul

Boris Brezillon (2):
  drm/vc4: Report underrun errors
  drm/vc4: Add a load tracker to prevent HVS underflow errors

Paul Kocialkowski (2):
  drm/vc4: Wait for display list synchronization when completing commit
  drm/vc4: Add a debugfs entry to disable/enable the load tracker

 drivers/gpu/drm/vc4/vc4_debugfs.c |  10 +++
 drivers/gpu/drm/vc4/vc4_drv.c     |   1 +
 drivers/gpu/drm/vc4/vc4_drv.h     |  25 +++++++
 drivers/gpu/drm/vc4/vc4_hvs.c     | 104 ++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_kms.c     | 118 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/vc4/vc4_plane.c   |  57 +++++++++++++++
 drivers/gpu/drm/vc4/vc4_regs.h    |  48 ++++--------
 7 files changed, 327 insertions(+), 36 deletions(-)

-- 
2.20.1

