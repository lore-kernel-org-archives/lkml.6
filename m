Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CA8C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A1E218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 12:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ow7kLqyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfAZM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 07:26:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46050 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAZMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 07:25:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so8758620lfa.12;
        Sat, 26 Jan 2019 04:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9twS2QoSt8OMiLUBo9Uw/6B13OKa/JTRtA6RHr+fMq0=;
        b=ow7kLqyY+x5tFrWeDc4f0GyWZDf4mggYO24/ctRMb4vLMkXDSsxJcreAk5xX7UFoCi
         gNHDtPpk+N4vyMKBexCv9shyG3tAnTrqL++w4Dcs7V48aS3/zEnZ+oGuJVhyDxeD/oPB
         qE2T+HbEk7z59OBZ1vrAvPxwwFklf3+ul3+tOD4sKXS8D6hmcb+iIoZCeyI8zbsjc70Z
         Ri8ETEBBW03DgWC8FLade1Lp145ea6tUXbJ3yWiZYmfGBAH+zH+4Kj9UE/n3Ar5/OnDc
         z3N71Fm+DE9xKnISdFERY3V2bSCYc6GXIl0tUg8p4Brn7lSKQnrYQ830A7Iu5WERJPcJ
         Bfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=9twS2QoSt8OMiLUBo9Uw/6B13OKa/JTRtA6RHr+fMq0=;
        b=JXWrXv1md8KS4Ko1ll9X9cnL6zjOi+9nWgmO4eMfRcKq/kV6cnng0RTC7t0bBKc6Z4
         RKNi24NE1HAi8vBj8gamAa8i1rGT8+ogwZ00h2M7wQS2pqMIpWSX2WEqmCDMlMVMc02W
         b12AA2svt7s5931jTwQjkpAJ00MSyO5M/5Od4/O8oyZnqtllpZmp1BJZAfXX9ff9Gw1G
         no8FMaCRQJQXsKv5GZuXtpT4zF0FXOIvMoH7WbmA8whNxgoHN55ZIehN/8XLVWgy8+gJ
         LJZtkay930jmFheopPx0heICrgsyVzfgIL0gHcvPHPzXXNCOZPFLOX3HEoWPuRBTIBT4
         pRSw==
X-Gm-Message-State: AJcUukdE873k6JC3anmSo6CCdoCw9LF6WFnlB496vqlxA56HHgJv+8BZ
        USCXm0vlD0z/TYY1fw69XdY=
X-Google-Smtp-Source: ALg8bN41JPeqErlxqq72LNy4AT/nf5VWpQfe4/qZZbpOn53Qs0emFQMJP9tsat4oaZutMtvXGR/F7g==
X-Received: by 2002:a19:5402:: with SMTP id i2mr11129889lfb.128.1548505553968;
        Sat, 26 Jan 2019 04:25:53 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id j138sm2070288lfg.64.2019.01.26.04.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 04:25:53 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v6 4/5] drm: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 26 Jan 2019 13:25:26 +0100
Message-Id: <20190126122527.11647-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190126122527.11647-1-sam@ravnborg.org>
References: <20190126122527.11647-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused drm/ to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on x86, arm, alpha, ia64 allmodconfig/allyesconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_damage_helper.c  | 1 +
 drivers/gpu/drm/drm_modeset_helper.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index e16aa5ae00b4..ee67c96841fa 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -32,6 +32,7 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_damage_helper.h>
+#include <drm/drm_device.h>
 
 /**
  * DOC: overview
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index 890eee07892d..da483125e063 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -22,8 +22,10 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
 /**
-- 
2.12.0

