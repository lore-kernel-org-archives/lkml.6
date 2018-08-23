Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D489C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316A620661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316A620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbeHWSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:53:59 -0400
Received: from foss.arm.com ([217.140.101.70]:48104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeHWSx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:53:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 989E47A9;
        Thu, 23 Aug 2018 08:23:51 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FBD23F2EA;
        Thu, 23 Aug 2018 08:23:49 -0700 (PDT)
From:   Brian Starkey <brian.starkey@arm.com>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@fooishbar.org, airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org
Cc:     linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com, tfiga@chromium.org,
        hoegsberg@chromium.org
Subject: [RFC PATCH v2 0/3] Groundwork for AFBC YUV formats
Date:   Thu, 23 Aug 2018 16:23:40 +0100
Message-Id: <20180823152343.6474-1-brian.starkey@arm.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second round of RFC for adding a bunch of new YUV formats
for Mali/AFBC. I've included a proper AFBC documentation file too, for
posterity.

Some of the new formats don't have an integer number of
bytes-per-pixel, so I've added a bpp field to drm_format_info
(patch 1), keen to hear thoughts on that.

These three patches don't make a huge amount of sense in isolation, so
we'll pull them into a more comprehensive series for AFBC support to
merge them later.

Thanks,
-Brian

Brian Starkey (3):
  drm/fourcc: Add 'bpp' field for formats with non-integer
    bytes-per-pixel
  drm/fourcc: Add remaining fourccs for Mali
  drm/afbc: Add AFBC modifier usage documentation

 Documentation/gpu/afbc.rst                   | 226 +++++++++++++++++++++++++++
 Documentation/gpu/drivers.rst                |   1 +
 MAINTAINERS                                  |   1 +
 drivers/gpu/drm/drm_fb_cma_helper.c          |   6 +-
 drivers/gpu/drm/drm_fb_helper.c              |   8 +-
 drivers/gpu/drm/drm_fourcc.c                 |  57 +++++++
 drivers/gpu/drm/drm_framebuffer.c            |  41 ++++-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c |   3 +-
 include/drm/drm_fourcc.h                     |   4 +
 include/uapi/drm/drm_fourcc.h                |  17 ++
 10 files changed, 351 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/gpu/afbc.rst

-- 
2.16.1

