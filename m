Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1471BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D685220827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vO+UYBrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfAHT5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:57:39 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43036 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbfAHT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so4395100lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhLHqKV8ZqJzYdMYFl7lpMzt0UBk0gRoGf+aJ87pnvg=;
        b=vO+UYBrOjfk0xkNOzupyQpfS+u3SRAIH5yAFrxdgBZz1I6BXvNscbHje3js6kw+nXm
         DYiDhyZq8h9O/OyDUxFOIlIM6KrZv2IJ90D5FS5A9eOTWsfV2Rsas5c3dTm2GNihOBUu
         GeVjrLv+MCUCCMCV3lsASSIvMxKrA84C5I9lgVSFVn7fvJeEFDfWOESuZtIrWEEWVs5s
         ENvByDWHsDJ1tEXw8XMY1OwknfqzONpeFkOD5oRVnr7swKmMYHjrhT2HFNwXdi+wHXqI
         M5GZl9CXNcXDjCyYI1xEv/Nphs95a0hmOhRvBzAXojaY3kHeFs5KkbCTosY66MiKjJXg
         Qjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UhLHqKV8ZqJzYdMYFl7lpMzt0UBk0gRoGf+aJ87pnvg=;
        b=AUDdrnceEIuM7i0mZi3KJyBF4GEJnIcd1OKSWQc9xmZ08Y+JLfIUy628IG2VSSeUgr
         4Q76IbkyU7lnphKiSGZtbYYQix1+spYYqwabkqQS2QqT8iOUFXICuBhbNr4Uaj6hKQgk
         b3+Hlt2ckJ2M6nKaS8N7q3Azi45qGSQPonxRTqg3+suwucAeY/biLkROCjziNVmTmmCD
         PNKlSCikXURfsFN6yZNX3JG4UgLye3zdhXGPA3QQFrrkE7aKihC0KR7CBJp5JEMqL+89
         7OZRLqG5YR+SH2psNGFeCniLrSwiftg0Wk7t6ifX/ahnP53+iDp2CtJZtmayQhyeu7UF
         cErw==
X-Gm-Message-State: AJcUukds5ltZ/n52SCWYAaMFSW263BqJrjrRjE5ezGovJWp67MWGw04l
        KGlJIk2MqAgwBM6j5srCYgU=
X-Google-Smtp-Source: ALg8bN4kth/slCSVVPi5BzQppB3HtGxMNfg2zzqP+dDgtVJuRfZlWzAUSvsXt5YmVDHrxEzjDhWE/w==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr1800131ljg.150.1546975793809;
        Tue, 08 Jan 2019 11:29:53 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:53 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 03/12] drm: make drm_framebuffer.h self contained
Date:   Tue,  8 Jan 2019 20:29:30 +0100
Message-Id: <20190108192939.15255-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add forward declaration and pull in include
file to make drm_framebuffer.h self contained.

While add it order include files alphabetically.

The use of TASK_COMM_LEN is the reason for including sched.h.
I could not see any good way to avoid this dependency,
and users of drm_framebuffer.comm already use
TASK_COMM_LEN to check for length etc.

v2:
- Added forward declaration of drm_gem_object (Noralf)
- Added ack from Noralf

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_framebuffer.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index c94acedfb08e..f0b34c977ec5 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -23,13 +23,17 @@
 #ifndef __DRM_FRAMEBUFFER_H__
 #define __DRM_FRAMEBUFFER_H__
 
-#include <linux/list.h>
 #include <linux/ctype.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+
 #include <drm/drm_mode_object.h>
 
-struct drm_framebuffer;
-struct drm_file;
+struct drm_clip_rect;
 struct drm_device;
+struct drm_file;
+struct drm_framebuffer;
+struct drm_gem_object;
 
 /**
  * struct drm_framebuffer_funcs - framebuffer hooks
-- 
2.12.0

