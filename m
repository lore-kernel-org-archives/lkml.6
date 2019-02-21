Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800A42083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FKi6+dNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfBUP76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:59:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40971 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfBUP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:59:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so23563968eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XR6ZBCWgK5wboQt0iQNXa8mMwBSvMUFgihwssVG9NGQ=;
        b=FKi6+dNc9MA+1XPGc67AB3vw8XMAeDh1hPXxVNfV4PfLLEypi68wsXXGX403hXicyv
         Nbakar0SnJILgqEB7A/ScmOsY5h//IW65fSiLoE5iie1we+X+2BwBx1nkW9QQXPYpRCM
         exZhyDVaooCXagZgmOqKefblESTq/qceeVrCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XR6ZBCWgK5wboQt0iQNXa8mMwBSvMUFgihwssVG9NGQ=;
        b=COiuE4DB/tbnGTCtaXPDr8o+XdWsgxlUqmIFshgtuNzZfYei5IF2izjjOOQFRXk2Ah
         78qX7x8mfy7ztIQ7FIJbMiNXxzRkM7IjLip9adRBqWDq3oNfMafm3W2FxiOZyUvneBvt
         JoawSQ5FtC3pzvdYXirUQephT8DlCkqDRsTksFQgpldZAOYDUuaOmS8lbnE9UtR4QpFs
         2vOPG9rmU4/vvC5AHx+h38E/rRezgBJoDB8fb0ASxtRxQ+9qMG/+xV/ii97e+iHlfcE3
         Bch0mFOKXhcnmUb99IM4B71R1W4SMmoGeim+U/cc0eZWVkaJXn1i1mdUdVokiXkew/lv
         dM1w==
X-Gm-Message-State: AHQUAuYpj++aqRfjCbNnyagTvM0lUM7JnJkAG7ddWONxT8puwxErQN2Z
        oi+J1ykYWXWtluL8vEndTCNgbQ==
X-Google-Smtp-Source: AHgI3IZuw0fRc5rZo+bNAEhk/0ngtKG8sWBPSl5ErLvb/cx9p2T2kwK2dERicKMnKHpLSsaOebCoMw==
X-Received: by 2002:a17:906:68f:: with SMTP id u15mr27391171ejb.147.1550764796630;
        Thu, 21 Feb 2019 07:59:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p30sm6488346edd.85.2019.02.21.07.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 07:59:55 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH] staging/vboxvideo: Another FIXME item
Date:   Thu, 21 Feb 2019 16:59:51 +0100
Message-Id: <20190221155951.19855-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found while grepping around.

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/staging/vboxvideo/vbox_irq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/vboxvideo/vbox_irq.c b/drivers/staging/vboxvideo/vbox_irq.c
index 195484713365..89944134ea86 100644
--- a/drivers/staging/vboxvideo/vbox_irq.c
+++ b/drivers/staging/vboxvideo/vbox_irq.c
@@ -123,6 +123,11 @@ static void vbox_update_mode_hints(struct vbox_private *vbox)
 
 	validate_or_set_position_hints(vbox);
 	drm_modeset_lock_all(dev);
+	/*
+	 * FIXME: this needs to use drm_connector_list_iter and some real
+	 * locking for the actual data it changes, not the deprecated
+	 * drm_modeset_lock_all() shotgun approach.
+	 */
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		vbox_conn = to_vbox_connector(connector);
 
-- 
2.20.1

