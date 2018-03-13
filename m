Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3447179-1520954919-2-9341267216792971633
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954918; b=DN64askW6kPsvENS7AOjOqU5NK9vtfi1h0M9Ac8Q8GujGOk
    /Vm0wvouYe1NmIj9/ZMeXPRBimfqh7VlqtC6W82atQG76luwZ1Z+8a8pWuvihsLL
    BTrO8oFZwJ4rN3a/mBEgt7FqmnjXVqneHSRaBJaCStnBfnUQq7ZFKWhyvWjr3mCi
    bwtvnOG38Qdb6JsSrcieK7TGHl8X9QH68kQO25kZ/Z3dAQrGMp3GKlzNsxBY8984
    boRx+qI96ROWLzqe4MRiE46fX/RtY3KHLErbIzYrZJAx7pnd5BbbT4sGfSZN4rvY
    j02BbwB0GNeMVmGxgrhVb1Mg0vjUuQSR/AoyX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520954918; bh=HL9IzvhTqQie9HLUAdnZuY7PSD
    e5ACUXT4zd+WMRDCM=; b=M2n3I99sZNjvXXjPmHkQJkJS9L5SAX94cItaH8zT7B
    ui17U0BcgOS9DQzlJq69gGEJOoYHuUWX3sQSdtMklb+DHT9xhn/ZRfHnvPDasad5
    RR6iEHg/isOaPq7GsUcYSmTqj12m/zKullkCFvINyujPRScD0Fd8s2DQIbqjTuv0
    B826/r9oYR9bsAxFvrsukFtDTMtZ6zY+EaY9rC4Npeg0HIT3ZBKkocnILz9F8R2Z
    XNCsxtzCPi8yeWH4JT68fB5T/2IFcVuTIe4jIc0LW6WZSUQKGA/X2QiZINb25Nua
    3bzYL2zEguekXr8q0ZKO9RdwoMwZtxOcs0KxtZyKcM3Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeCMP2e (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:28:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbeCMP2b (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:28:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Ben Skeggs <bskeggs@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.15 025/146] drm/nouveau: prefer XBGR2101010 for addfb ioctl
Date: Tue, 13 Mar 2018 16:23:12 +0100
Message-Id: <20180313152322.395691464@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilia Mirkin <imirkin@alum.mit.edu>

commit c20bb155c2c5acb775f68be5d84fe679687c3c1e upstream.

Nouveau only exposes support for XBGR2101010. Prior to the atomic
conversion, drm would pass in the wrong format in the framebuffer, but
it was always ignored -- both userspace (xf86-video-nouveau) and the
kernel driver agreed on the layout, so the fact that the format was
wrong didn't matter.

With the atomic conversion, nouveau all of a sudden started caring about
the exact format, and so the previously-working code in
xf86-video-nouveau no longer functioned since the (internally-assigned)
format from the addfb ioctl was wrong.

This change adds infrastructure to allow a drm driver to specify that it
prefers the XBGR format variant for the addfb ioctl, and makes nouveau's
nv50 display driver set it. (Prior gens had no support for 30bpp at all.)

Signed-off-by: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: stable@vger.kernel.org # v4.10+
Acked-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180203191123.31507-1-imirkin@alum.mit.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_framebuffer.c      |    4 ++++
 drivers/gpu/drm/nouveau/nv50_display.c |    1 +
 include/drm/drm_drv.h                  |    1 +
 3 files changed, 6 insertions(+)

--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -118,6 +118,10 @@ int drm_mode_addfb(struct drm_device *de
 	r.pixel_format = drm_mode_legacy_fb_format(or->bpp, or->depth);
 	r.handles[0] = or->handle;
 
+	if (r.pixel_format == DRM_FORMAT_XRGB2101010 &&
+	    dev->driver->driver_features & DRIVER_PREFER_XBGR_30BPP)
+		r.pixel_format = DRM_FORMAT_XBGR2101010;
+
 	ret = drm_mode_addfb2(dev, &r, file_priv);
 	if (ret)
 		return ret;
--- a/drivers/gpu/drm/nouveau/nv50_display.c
+++ b/drivers/gpu/drm/nouveau/nv50_display.c
@@ -4426,6 +4426,7 @@ nv50_display_create(struct drm_device *d
 	nouveau_display(dev)->fini = nv50_display_fini;
 	disp->disp = &nouveau_display(dev)->disp;
 	dev->mode_config.funcs = &nv50_disp_func;
+	dev->driver->driver_features |= DRIVER_PREFER_XBGR_30BPP;
 	if (nouveau_atomic)
 		dev->driver->driver_features |= DRIVER_ATOMIC;
 
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -55,6 +55,7 @@ struct drm_mode_create_dumb;
 #define DRIVER_ATOMIC			0x10000
 #define DRIVER_KMS_LEGACY_CONTEXT	0x20000
 #define DRIVER_SYNCOBJ                  0x40000
+#define DRIVER_PREFER_XBGR_30BPP        0x80000
 
 /**
  * struct drm_driver - DRM driver structure
