Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12561C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9E6218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KfrvKrTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfBKRPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:15:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36026 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbfBKRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:15:32 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so28092itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 09:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6VLQrtxsrRyUJQoYK/7PyNUwOou0q93pgP+Jf+5Bam0=;
        b=KfrvKrTrTjjkjv4ROKtE8LnNrdUU1o3PKZp8X6AqbrA4uh/SJ31M6TLZeRO0iYAK00
         uTdQSQCaLhoh8SLuO8stbpF80ej8p0Sjrq6WksA4ye9jQnymIKTaCZWmIIolyBQ/9Xoo
         VGjsgrCnYplKQi6j2RCbCAvxWqh6/bEWpQtHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6VLQrtxsrRyUJQoYK/7PyNUwOou0q93pgP+Jf+5Bam0=;
        b=Qpp7BsTn2E3Ig4FnNdpnPUavBEbS91LNdiFc2NBd+V+u4duFWhFtgnmreNh1+JUR1X
         EHTU98Vnl4hHyNIN1UpLGiSNMEh7PpDmmoDqCNLlAaxwXFuqg8E5gb+T0nPqaZoTw/6v
         RzPvuYhPH+xCzecfbZB9EcseJ8czOgGiOJLde7mR7i6ID5yjRaVXI5iHuiiryw3FvaZ3
         IrPVRtgkCax+LUFvPMcEU9lLd2p/1wmHw32zw3pY23HXbtk6MbWgJ96+7Pa8St3ezcZ7
         /F73hNzvsKQ/b6QjugezBiajSHnHhoH/b7DMSXF4jqDUvlv5g0spNs6SjOA4c8YkcO+L
         IYyw==
X-Gm-Message-State: AHQUAuYN3WegNkeL69P50JEqfwKVdfZ/SF0YdJ0DnPEWymqBgwx9UWca
        HldKQvPigov6xW6EYOm0oAn00brhXq1mNg+JVaoxMzoqVOE=
X-Google-Smtp-Source: AHgI3IblMrv7LS4eQ/LFKfa/GhJSPVY5nMN7+MuSKCQKIr/VbJx1JRa/yaPp6ochHariHaqFy/H77ol7UeHkxp8A8eQ=
X-Received: by 2002:a24:6115:: with SMTP id s21mr357618itc.62.1549905331207;
 Mon, 11 Feb 2019 09:15:31 -0800 (PST)
MIME-Version: 1.0
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 11 Feb 2019 18:15:20 +0100
Message-ID: <CAKMK7uHU37VLbe4RBZ3GOow+=pupYAHotkVrpqJeiUcpSfjX8Q@mail.gmail.com>
Subject: [PULL] topic/component-typed
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "DRM maintainer tools announcements, discussion, and development" 
        <dim-tools@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's the typed component topic branch.

drm-intel maintainers: Please pull, I need this for the mei hdcp work from Ram.

drm-misc maintainers: Please pull, there's a drm doc patch follow-up
that I want to stuff into drm-misc-next.

Greg: The drm side missed our feature cutoff, so will only land in 5.2.
Probably good if you pull this into drivers-core so it lands a bit
quicker. You&Arnd will also get a topic pull later on with the MEI bits
for char-misc tree, which needs to be based on top of this tree here.

Takashi: Since the drm side only lands in 5.2 might be good if you
pull this in too to avoid conflicts.

Cheers, Daniel

topic/component-typed-2019-02-11:
typed componented support + i915/snd-hda changes

This is needed by the new MEI-HDCP support in i915, so will need to go
in through drm and drivers-misc trees at least.

Cheers, Daniel

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm-intel
tags/topic/component-typed-2019-02-11

for you to fetch changes up to 8857c7d065e900a0b3829c97634c99501b606541:

  i915/snd_hdac: I915 subcomponent for the snd_hdac (2019-02-08 16:58:59 +0100)

----------------------------------------------------------------
typed componented support + i915/snd-hda changes

This is needed by the new MEI-HDCP support in i915, so will need to go
in through drm and drivers-misc trees at least.

----------------------------------------------------------------
Daniel Vetter (3):
      component: Add documentation
      components: multiple components for a device
      i915/snd_hdac: I915 subcomponent for the snd_hdac

 Documentation/driver-api/component.rst   |  17 +++
 Documentation/driver-api/device_link.rst |   3 +
 Documentation/driver-api/index.rst       |   1 +
 drivers/base/component.c                 | 206 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/i915/intel_audio.c       |   4 +-
 include/drm/i915_component.h             |   4 +
 include/linux/component.h                |  76 ++++++++++++
 include/sound/hda_component.h            |   5 +-
 sound/hda/hdac_component.c               |   4 +-
 sound/hda/hdac_i915.c                    |   6 +-
 10 files changed, 308 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/driver-api/component.rst

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
