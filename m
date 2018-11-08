Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C2C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16A320883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Rg6zjjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16A320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbeKIHpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732527AbeKIHpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:45:50 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F662147D;
        Thu,  8 Nov 2018 22:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714898;
        bh=4TqRkP8K+hP6s+EO4aXrBWpcAT8GUITleAHM+hwW6TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Rg6zjjVAGomeBjSmzwh5c1kQF7hrqLJOQOo5dHjIMnM2XQ9aqx2nL3XSHhTYy+j3
         yfCUsqKKyD/W//LzXi+K+n3BFspmbruNWqNnM85fEvmAzbgsVSc9LMzRNV4r0G6VTu
         jJF94qujO0At+yyB0Pbyih1wf+Nl2iG5CaRFPkeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clint Taylor <clinton.a.taylor@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Shashank Sharma <shashank.sharma@intel.com>
Subject: [PATCH 4.14 14/31] drm/edid: VSDB yCBCr420 Deep Color mode bit definitions
Date:   Thu,  8 Nov 2018 13:52:38 -0800
Message-Id: <20181108215130.876606314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clint Taylor <clinton.a.taylor@intel.com>

commit 9068e02f58740778d8270840657f1e250a2cc60f upstream.

HDMI Forum VSDB YCBCR420 deep color capability bits are 2:0. Correct
definitions in the header for the mask to work correctly.

Fixes: e6a9a2c3dc43 ("drm/edid: parse ycbcr 420 deep color information")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107893
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Clint Taylor <clinton.a.taylor@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Shashank Sharma <shashank.sharma@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1538776335-12569-1-git-send-email-clinton.a.taylor@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    2 +-
 include/drm/drm_edid.h     |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4223,7 +4223,7 @@ static void drm_parse_ycbcr420_deep_colo
 	struct drm_hdmi_info *hdmi = &connector->display_info.hdmi;
 
 	dc_mask = db[7] & DRM_EDID_YCBCR420_DC_MASK;
-	hdmi->y420_dc_modes |= dc_mask;
+	hdmi->y420_dc_modes = dc_mask;
 }
 
 static void drm_parse_hdmi_forum_vsdb(struct drm_connector *connector,
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -214,9 +214,9 @@ struct detailed_timing {
 #define DRM_EDID_HDMI_DC_Y444             (1 << 3)
 
 /* YCBCR 420 deep color modes */
-#define DRM_EDID_YCBCR420_DC_48		  (1 << 6)
-#define DRM_EDID_YCBCR420_DC_36		  (1 << 5)
-#define DRM_EDID_YCBCR420_DC_30		  (1 << 4)
+#define DRM_EDID_YCBCR420_DC_48		  (1 << 2)
+#define DRM_EDID_YCBCR420_DC_36		  (1 << 1)
+#define DRM_EDID_YCBCR420_DC_30		  (1 << 0)
 #define DRM_EDID_YCBCR420_DC_MASK (DRM_EDID_YCBCR420_DC_48 | \
 				    DRM_EDID_YCBCR420_DC_36 | \
 				    DRM_EDID_YCBCR420_DC_30)


