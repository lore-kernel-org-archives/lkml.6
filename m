Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2139AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeJBUNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:13:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33284 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeJBUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:13:14 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1F5B266;
        Tue,  2 Oct 2018 13:29:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Daniel Stone <daniels@collabora.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 127/228] drm/vc4: Add missing formats to vc4_format_mod_supported().
Date:   Tue,  2 Oct 2018 06:23:44 -0700
Message-Id: <20181002132508.045871938@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

[ Upstream commit 1e871d65e375280757833d9fce91dda71980bdf5 ]

Daniel's format_mod_supported() patch predated Dave's for NV21/61, and
I didn't catch that when rebasing.  This is a problem since the
formats are now getting validated before being passed to the driver's
atomic hooks.

Signed-off-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Stone <daniels@collabora.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.org>
Fixes: 423ad7b3cbd1 ("drm/vc4: Advertise supported modifiers for planes")
Link: https://patchwork.freedesktop.org/patch/msgid/20180316220435.31416-2-eric@anholt.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/vc4/vc4_plane.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -874,7 +874,9 @@ static bool vc4_format_mod_supported(str
 	case DRM_FORMAT_YUV420:
 	case DRM_FORMAT_YVU420:
 	case DRM_FORMAT_NV12:
+	case DRM_FORMAT_NV21:
 	case DRM_FORMAT_NV16:
+	case DRM_FORMAT_NV61:
 	default:
 		return (modifier == DRM_FORMAT_MOD_LINEAR);
 	}


