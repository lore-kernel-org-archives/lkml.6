Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB69DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A247E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A247E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbeHWMJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:53 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B086C8B1;
        Thu, 23 Aug 2018 08:41:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ayan Kumar halder <ayan.halder@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 048/324] drm/mali-dp: Rectify the width and height passed to rotmem_required()
Date:   Thu, 23 Aug 2018 09:51:54 +0200
Message-Id: <20180823074958.203804015@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ayan Kumar Halder <ayan.halder@arm.com>

[ Upstream commit c6cf387ec56c19028333274747bbb4ae145a2d13 ]

The width and height needs to be swapped

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Reviewed-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
[rebased on top of v4.18-rc1]
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/arm/malidp_planes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -236,8 +236,8 @@ static int malidp_de_plane_check(struct
 	if (state->rotation & MALIDP_ROTATED_MASK) {
 		int val;
 
-		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_h,
-						     state->crtc_w,
+		val = mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
+						     state->crtc_h,
 						     fb->format->format);
 		if (val < 0)
 			return val;


