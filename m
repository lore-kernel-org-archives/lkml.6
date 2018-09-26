Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345EAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486C21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="WZXN6A1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C486C21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeI0C4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:56:41 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:55530 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0C4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:56:41 -0400
Received: from trochilidae.toradex.int (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5A8CB5C1879;
        Wed, 26 Sep 2018 22:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537994516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=0Z25r6oVJp2M5hi051ceLrzOZRIaSZawxsQHUxg3Ct0=;
        b=WZXN6A1TfdUOVY0Hv1tM54f2LGPjJsiX9HpwWLCzf+dq736z1f+1Ebz47X3ftXFxO0GjQr
        L784h6S1f0qJylexN7dZh4skPpoyiKBxH+vmlRLspRBSr/Jux9lZaYBmZl+Y74DhsRPnhF
        MYAR+ZKhrfJOTUc8kXASzE2ViCRiZk4=
From:   Stefan Agner <stefan@agner.ch>
To:     stefan@agner.ch, alison.wang@nxp.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/fsl-dcu: drop unused drm_crtc_index()
Date:   Wed, 26 Sep 2018 22:41:49 +0200
Message-Id: <20180926204150.29829-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of drm_crtc_index() is unused. Remove the call and
the unused variable.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This is a split version of a patch posted a while ago:
https://lore.kernel.org/patchwork/patch/903786/

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
index 0e3752437e44..05d1c9977395 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c
@@ -85,9 +85,8 @@ static void fsl_dcu_drm_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
 	struct drm_connector *con = &fsl_dev->connector.base;
 	struct drm_display_mode *mode = &crtc->state->mode;
-	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, index, pol = 0;
+	unsigned int hbp, hfp, hsw, vbp, vfp, vsw, pol = 0;
 
-	index = drm_crtc_index(crtc);
 	clk_set_rate(fsl_dev->pix_clk, mode->clock * 1000);
 
 	/* Configure timings: */
-- 
2.19.0

