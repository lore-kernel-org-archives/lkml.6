Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00201C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C3B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C3B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933525AbeFUNnE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:43:04 -0400
Received: from kozue.soulik.info ([108.61.200.231]:40758 "EHLO
        kozue.soulik.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbeFUNnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:43:03 -0400
Received: from misaki.sumomo.pri (unknown [IPv6:2001:470:b30d:2:ec4:7aff:fe92:7ff4])
        by kozue.soulik.info (Postfix) with ESMTPA id E6660100CDA;
        Thu, 21 Jun 2018 22:43:42 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     Randy Li <ayaka@soulik.info>, hjc@rock-chips.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.dufresne@collabora.com, gustavo@padovan.org,
        seanpaul@chromium.org, airlied@linux.ie
Subject: [PATCH v2 0/2] Add support for a YUV 10bits pixel format
Date:   Thu, 21 Jun 2018 21:42:41 +0800
Message-Id: <20180621134243.9557-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the last time, I got some feedback and not a clear guide on what
I should do. So just give more comment on describing this 10bits format.
Whether I should add bpp instead cpp in drm_format_info and update a
numbers of functions is up to you guys.

And I don't any other driver would request 10bits yuv format support,
so I can't add the pixel format they don't use as I did a year ago.
You would ignore those patches.

Randy Li (2):
  drm/fourcc: add a 10bits fully packed variant of NV12
  drm/rockchip: Support 10 bits yuv format in vop

 drivers/gpu/drm/drm_fourcc.c                |  1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 27 +++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |  2 ++
 include/uapi/drm/drm_fourcc.h               |  7 +++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.14.4

