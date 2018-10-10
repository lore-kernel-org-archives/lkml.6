Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5403C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3CB214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh/7SAhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3CB214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJKDlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:41:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55290 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKDlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:41:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so6791596wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QdKs4VoBZCcjaXkvd8JpQp/x8LRuJwP4siF6yLFKmjA=;
        b=nh/7SAhjYvSSnhbNr5jgbo5S0NFqSpxWOPcSpqt8LAX3S6GA0BI8efENB109cTj9K6
         Uk0Rvq7pzi36uNIDS1cZk/68AtNIfRJEOkurKSzbCXO+dMSL9HCw831DEQ9GaaICvC/S
         onkmEN25xl5LPItseR39ISlRnGEvponuzaSAYnLetsbhvDYdwMQK7CKsrrQq5sfhvRSV
         WrYLNyV05TwuhnpJD38JX0LTkpK+FxCQmLnWjsgdQjhYc/sDtHjJNGZPIW3iVVSdlQ96
         1UN8R4LuHIJbXv6wUlghtdNnXGglNB5JSoAj/j21LPhe1UpjJcuhDMYJHiTj98rIuJHJ
         KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QdKs4VoBZCcjaXkvd8JpQp/x8LRuJwP4siF6yLFKmjA=;
        b=Ku4BC998cEQxJffg2zABOA7j4He7APJyTU+oU5rk2UdOW7W+kjv0CGP6WMpX8CMbSz
         vh/qPoPAj9PQCy3k7C0+mhX0U4bUYo3UaKMjlTdyvsCbEOWsr9gk/FT5XPEXwnfTsXSJ
         0qLmyMU4DVSAXuoxCO6Edzvwk6DkNrx4M4V9xG/b9BmWm81sP4oTkh1XRKl8gEgXMUJq
         d5SgeshMl0ro/S/FE7f7xw38xRUIMxohi9+CsfHQnfWfsfVaq7akKXdTuxKmWV9CYGow
         KDPVsmBF1Yzx9Xve0mnJb6xYD0rYUEifK+Nynb3vi1+t8oOmSinomz3fWnMCGAlQ4/m9
         DEAg==
X-Gm-Message-State: ABuFfoj3WSmQnHqeEH76yu9jDcpUvcl6v2wmIq4shq330snwTTJ44p0i
        eictg3SB41Lls/mTwprbVhU=
X-Google-Smtp-Source: ACcGV60PO8YczSisOPuGiLK5g6wsi/NsvHirDljtPeA4A66ez1YpadeIuXE9P4DWbJAXtqqEaR+8gg==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr2156035wmf.33.1539202684742;
        Wed, 10 Oct 2018 13:18:04 -0700 (PDT)
Received: from fisher.lan (244.185.7.51.dyn.plus.net. [51.7.185.244])
        by smtp.gmail.com with ESMTPSA id h64-v6sm14953382wmh.27.2018.10.10.13.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:18:03 -0700 (PDT)
From:   Craig Kewley <craigkewley@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sean Paul <seanpaul@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Craig Kewley <craigkewley@gmail.com>
Subject: [PATCH] staging: vboxvideo: make a couple of funcs static
Date:   Wed, 10 Oct 2018 20:17:05 +0000
Message-Id: <20181010201705.15220-1-craigkewley@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Sparse warnings:
drivers/staging/vboxvideo/vbox_mode.c:309:6: warning:
symbol 'vbox_primary_atomic_disable' was not declared. Should it be static?

drivers/staging/vboxvideo/vbox_mode.c:452:6: warning:
symbol 'vbox_cursor_atomic_disable' was not declared. Should it be static?

Signed-off-by: Craig Kewley <craigkewley@gmail.com>
---
 drivers/staging/vboxvideo/vbox_mode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vboxvideo/vbox_mode.c b/drivers/staging/vboxvideo/vbox_mode.c
index 042e4f384df9..deed28c7a1db 100644
--- a/drivers/staging/vboxvideo/vbox_mode.c
+++ b/drivers/staging/vboxvideo/vbox_mode.c
@@ -306,8 +306,8 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
 				    plane->state->src_y >> 16);
 }
 
-void vbox_primary_atomic_disable(struct drm_plane *plane,
-				 struct drm_plane_state *old_state)
+static void vbox_primary_atomic_disable(struct drm_plane *plane,
+					struct drm_plane_state *old_state)
 {
 	struct drm_crtc *crtc = old_state->crtc;
 
@@ -449,8 +449,8 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
 	mutex_unlock(&vbox->hw_mutex);
 }
 
-void vbox_cursor_atomic_disable(struct drm_plane *plane,
-				struct drm_plane_state *old_state)
+static void vbox_cursor_atomic_disable(struct drm_plane *plane,
+				       struct drm_plane_state *old_state)
 {
 	struct vbox_private *vbox =
 		container_of(plane->dev, struct vbox_private, ddev);
-- 
2.17.1

