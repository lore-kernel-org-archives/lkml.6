Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4893E218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1BPxKgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfAaT0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40450 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfAaT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so3680455lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=KVhTFpGFN6usKmuhNARu99Z+Px/nEIsJQCxHO9zQbdc=;
        b=B1BPxKgruSsXx5MRo14dMGoSsoBE56fNoPrqmE+nfYJkv4eizAMdCuWWlnlbmBkchT
         BoyGIMtQoyhLMXqk+kqukPYzG3MH18zhFix3ie2Ms0gjvhWwT8wpSvtBaCQbfOF9dS5H
         2Conr+vZPbvxelYJLUFRKEYWJZ3IlrLuvlR+hhZP1hG+53SGj+8zlFI2wTqM0et1yqbR
         Gsr96RkShpXMXZdKzJvFOKwWgZW/ftM3qgYN3D2kg1x3jloiluLNPXyDC7wT7QTXNf+6
         csOUhBQg4z3sV+SNAtAWlXZkQLJqb1KW6JETqpxZe82swKqs/Ez7A5P46yEFaRg9OPFz
         qGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=KVhTFpGFN6usKmuhNARu99Z+Px/nEIsJQCxHO9zQbdc=;
        b=uf8Rs5s8Id59jw2qEATgNqlUhcvy1Ba2Xn4g2F7zpy2JaVa9efyvT49RCJ9OnFW4/M
         LZbgAkSWDbyCfBSd3P7FiCjjmuLdTmwYa0YInfsch4q42yfnQNJ/KzwCR+NQhLHzMtoa
         NEqhCu/mP3oM4zRvxtwjV2Y1R7xdnT6wzKGYFb3Bt3dIsJRmnCtN03NWZG+Ewovm1u66
         LgqKsB7fn6llxIE99JDLblPKAg9PR4+uj6b36Y0imckwQMB90zdRMYhfferjzV8m6V2k
         XrwIhjoxwjSXoIM1H6DcN3cNEeMTTJQMTFeI7Gb5t2RYAWH6BTZtU0ar2m0yN4sYbbV2
         YEQA==
X-Gm-Message-State: AJcUukepAjVe00tEk7Z7DfXeSA5NWlLsn01X1ExSKfQR3Y5JrulMvtVH
        zQz5VKtJVG524pyl5vyhFCkfMb+N
X-Google-Smtp-Source: ALg8bN5tlHlCdnqQhVb1WUIrb3YCIMkMLTVtaeumjdcukqxYEb8I2p1wMBzgmn/Xd072SzOq/J6/+g==
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr26536679ljk.80.1548962792043;
        Thu, 31 Jan 2019 11:26:32 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:31 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:00 +0100
Message-Id: <20190131192619.9763-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry et al.

While reviewing a number of new panel drivers there was a
certain pattern in the feedback:
- the now deprecated drmP.h file was used
- dev_err() and friends was used

This patch-set address the above items in the panel
drivers in drm/panel/
The hope is that new panel drivers will no longer inherit bad
patterns from the existing drivers.

The use of DRM_DEV* is not accepted by everyone, so this conversion
was split up in smaller bits.
If some drivers do not want to use DRM_DEV* then just drop the relevant patch.

All patches are build tested on x86/arm.

The DRM_DEV* patches depends on the drmP.h removal.

One extra patch sneaked in "panel-innolux: drop unused variable"
This is a fix for an unused variable and was added to flush my panel patches.

Note: Waiting for key storage (for gpg key) before I start the process getting
commit rights, so I rely on someone else (Thierry?) to commit this.

Patches are made on top of drm-misc-next as of a few days ago.

Comments welcome!

	Sam

Sam Ravnborg (19):
      drm/panel: drop drmP.h usage
      drm/panel: panel-innolux: drop unused variable
      drm/panel: samsung: use DRM_DEV*
      drm/panel: arm-versatile: use DRM_DEV*
      drm/panel: truly: use DRM_DEV*
      drm/panel: sitronix: use DRM_DEV*
      drm/panel: ilitek: use DRM_DEV*
      drm/panel: innolux: use DRM_DEV*
      drm/panel: jdi: use DRM_DEV*
      drm/panel: lg: use DRM_DEV*
      drm/panel: lvds: use DRM_DEV*
      drm/panel: olimex: use DRM_DEV*
      drm/panel: orisetech: use DRM_DEV*
      drm/panel: panasonic: use DRM_DEV*
      drm/panel: raspberrypi: use DRM_DEV*
      drm/panel: raydium: use DRM_DEV*
      drm/panel: seiko: use DRM_DEV*
      drm/panel: sharp: use DRM_DEV*
      drm/panel: simple: use DRM_DEV*

 drivers/gpu/drm/panel/panel-arm-versatile.c        | 21 +++--
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c       | 97 ++++++++++++----------
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      | 14 ++--
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      | 17 ++--
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c     | 66 ++++++++-------
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |  4 +-
 drivers/gpu/drm/panel/panel-lg-lg4573.c            | 25 +++---
 drivers/gpu/drm/panel/panel-lvds.c                 | 39 +++++----
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c | 28 ++++---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c   | 15 ++--
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   | 19 +++--
 .../gpu/drm/panel/panel-raspberrypi-touchscreen.c  | 25 +++---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      | 11 ++-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       | 18 ++--
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c      | 21 +++--
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   | 15 ++--
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      | 32 ++++---
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        | 18 ++--
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    | 66 ++++++++++-----
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c    | 27 +++---
 drivers/gpu/drm/panel/panel-simple.c               | 22 +++--
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c     | 16 ++--
 drivers/gpu/drm/panel/panel-truly-nt35597.c        | 10 ++-
 23 files changed, 375 insertions(+), 251 deletions(-)
