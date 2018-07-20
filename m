Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4670420671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spTG4m+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4670420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbeGTSHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:07:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35838 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbeGTSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:07:00 -0400
Received: by mail-ed1-f65.google.com with SMTP id b10-v6so10324562edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zJuRzV2mmOHK1G7Hnufij81FU1lndavkRNxwpVgLfzY=;
        b=spTG4m+R6U2kFmWN1O9Tx/tZrAVr0ZvC1u9WUkZafIQb5dyJU11zavEkcbIznAR+/Q
         WV5h6A6XciFSuhZhL7Z0/0p6YM4zW7msfFEnw74FCT4jD/QpgGrWtksVdhtz9vBhFYIS
         Mi9ngk7JRN9/tFCwdU4Vf7tCFvYAcQlrsC3z1wPjoMhBi6myvOi1VjMiGBFfs9jBsAN9
         ZJSeFBnSvQSzwhGjrTdRW/HvNpYYOLqt2sH2WUmSRH2kOjqB13+JFSWrjKocAXC78/iB
         Y0sMRB75jEzAoUeCPoJSEcjv2tl/YtIow3dRclDxfrnA/Z4Znmij46C51tRo4xylolJ4
         Dcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zJuRzV2mmOHK1G7Hnufij81FU1lndavkRNxwpVgLfzY=;
        b=kBVfCcjlR0oc18ZDnX053JfECYFW7Jp2FILWOuwPC2MtKS6Fem5eT3KkpUVHPqKdbl
         /tPttiEPm+gGKisXMN+vljRU5j6JJwYakJjg3uA1qxCbdj+LegJfV2UZKz20WYd4Hgut
         dyhho8VcXeOmOXGmR98q5/ZtgyLAyKZYSPKsbcG4pSOEmItTw0TgK4DkTZjz01wGPMjs
         GZPnZyEnjFBMjqj9eL1/4Xj9iUAbgKqqQRYmSoO8j40R4hMoNAwZUrfkro+97OAWFtXH
         5DdpG2Z9TYTv1A6ZKPAHxSnWunbmIH9rP+9b2c8rB6WLIobLyI/U2bgqy8I6Tgex744y
         tc1A==
X-Gm-Message-State: AOUpUlE5qYtvdORQnNdX9516lHXMmvcQikaHwgbzE/DJGt9Hz97MHg+9
        xYYWYBjZ6E91XRlJl7YAOb0=
X-Google-Smtp-Source: AAOMgpcLH6w80FaC68s98RzBBCBHuwgW36vBLdiUI9zlpWpf1NmfKjJRXv8L65zg3Yw6JdRy/+pUlg==
X-Received: by 2002:a50:ac65:: with SMTP id w34-v6mr3553286edc.211.1532107066473;
        Fri, 20 Jul 2018 10:17:46 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.googlemail.com with ESMTPSA id i10-v6sm1498475edk.56.2018.07.20.10.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 10:17:45 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Cihangir Akturk <cakturk@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Paolo Cretaro <paolocretaro@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] staging: vboxvideo: Pass a new framebuffer to vbox_crtc_do_set_base
Date:   Fri, 20 Jul 2018 10:17:30 -0700
Message-Id: <1532107051-31102-2-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532107051-31102-1-git-send-email-steve_longerbeam@mentor.com>
References: <1532107051-31102-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This modifies vbox_crtc_do_set_base() to take a new framebuffer to
be activated, instead of the existing framebuffer attached to the crtc.
This change allows the function to be given the new framebuffer from
a page-flip request.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 drivers/staging/vboxvideo/vbox_mode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index b265fe9..688e80d 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -222,7 +222,9 @@ static bool vbox_set_up_input_mapping(struct vbox_private *vbox)
 }
 
 static int vbox_crtc_do_set_base(struct drm_crtc *crtc,
-				 struct drm_framebuffer *old_fb, int x, int y)
+				 struct drm_framebuffer *old_fb,
+				 struct drm_framebuffer *new_fb,
+				 int x, int y)
 {
 	struct vbox_private *vbox = crtc->dev->dev_private;
 	struct vbox_crtc *vbox_crtc = to_vbox_crtc(crtc);
@@ -245,7 +247,7 @@ static int vbox_crtc_do_set_base(struct drm_crtc *crtc,
 		vbox_bo_unreserve(bo);
 	}
 
-	vbox_fb = to_vbox_framebuffer(CRTC_FB(crtc));
+	vbox_fb = to_vbox_framebuffer(new_fb);
 	obj = vbox_fb->obj;
 	bo = gem_to_vbox_bo(obj);
 
@@ -281,7 +283,7 @@ static int vbox_crtc_do_set_base(struct drm_crtc *crtc,
 static int vbox_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 				   struct drm_framebuffer *old_fb)
 {
-	return vbox_crtc_do_set_base(crtc, old_fb, x, y);
+	return vbox_crtc_do_set_base(crtc, old_fb, CRTC_FB(crtc), x, y);
 }
 
 static int vbox_crtc_mode_set(struct drm_crtc *crtc,
-- 
2.7.4

