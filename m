Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4037EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7DE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545390624;
	bh=bMKR6v+Nx30QQGClN+v0/3R+hCfqucBxJXv5WDoGDXs=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=qL1ry3x+jAby5mp5R0mlDuj4sKXHmgBEDRAWMzFfGbinVv7gt0KKi2mEmGXc5WbNT
	 sAqQgkoLSjLAP9euKfh50Wrr4Hik3gfQifjNH1nWwB3dfIJ96LW0ihWAuCuasKcSI1
	 472d+39wBdMbvwTJfKCalX2SWheB1Xr1h9rohNVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbeLULKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:10:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34126 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbeLULKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:10:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id r62so4482565oie.1;
        Fri, 21 Dec 2018 03:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8jTfp1UZOjXRP0H8i7rIDBSl/QOQDcHlnoRDZCJ638c=;
        b=i9hE6ZlcacCtxEZX/kSZ3/wABWrW5yWA01w1hQb6aGByl0fk5dT3xj3B2rhE9YB+iP
         LPs4AXuR4P2rsG/vRWzLYHknFzCRKMXiruqsK1KLVlKt/EyxVXvLgedlSHeYZ5Doxb3z
         wH0nFHwBO/ywwYsQK56bma+N37TiqMwvQPw8WWLXkeTYhAEKQEBOtFjg83cwbanXKkfx
         VpYfDsHHo76DHppBCRIr3X+z6RYw8PnWJLZiWHJQknS0NCO/FQSeSyonvQuH/Fb/jyCH
         CIkImqoTp5DAq1VeMBuxcLtPUZipaRf5/SR6TqbhNK/6myv6LCIS48bvZlGcYNljKRx2
         rCCQ==
X-Gm-Message-State: AJcUukfQBEEwZGyWnU4VBq8R3BQKN9CBw3xmTRsJTTpJEqnJq4Hk8Pjf
        /7wFp+HkBn+Vtt+2XDw5oisi6uv8eSzgCMIv1j4=
X-Google-Smtp-Source: ALg8bN4jX1tRikvK8qY1pg0uT4eTyVW2tmteTOqfra4n6ZCsnef0hRoRF4B89V/VOSanzOEonAI3sLANekNxqnPijoA=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr1101813oic.33.1545390621547;
 Fri, 21 Dec 2018 03:10:21 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Dec 2018 12:10:10 +0100
Message-ID: <CAJZ5v0ja-twfG-0a7=JewPeyQxc2FmqPaN8Vi5ZVTNDjcFCX8g@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v4.21-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This goes early due to the upcoming holidays period.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.21-rc1

with top-most commit f569da8c994c2254a106bdb537aa271399e288ec

 device property: fix fwnode_graph_get_next_endpoint() documentation

on top of commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436

 Linux 4.20-rc4

to receive device properties framework updates for 4.21-rc1.

These introduce "software nodes" that are analogous to the DT and ACPI
firmware nodes except that they can be created by drivers themselves
and do a couple of assorted cleanups.

Specifics:

 - Introduce "software nodes", analogous to the DT and ACPI firmware
   nodes except that they can be created by kernel code, in order to
   complement fwnodes representing real firmware nodes when they are
   incomplete (for example missing device properties) and to supply
   the primary fwnode when the firmware lacks hardware description
   for a device completely, and replace the "property_set" struct
   fwnode_handle type with software nodes (Heikki Krogerus).

 - Clean up the just introduced software nodes support and fix a comment
   in the graph-handling code (Colin Ian King, Marco Felsch).

Thanks!


---------------

Colin Ian King (1):
      drivers: base: swnode: remove need for a temporary string for
the node name

Heikki Krogerus (6):
      driver core: platform: Remove duplicated device_remove_properties() call
      drivers core: Prepare support for multiple platform notifications
      ACPI / glue: Add acpi_platform_notify() function
      drivers: base: Introducing software nodes to the firmware node framework
      device property: Move device_add_properties() to swnode.c
      device property: Remove struct property_set

Marco Felsch (1):
      device property: fix fwnode_graph_get_next_endpoint() documentation

---------------

 .../ABI/testing/sysfs-devices-software_node        |  10 +
 drivers/acpi/bus.c                                 |   1 -
 drivers/acpi/glue.c                                |  21 +-
 drivers/acpi/internal.h                            |   1 -
 drivers/base/Makefile                              |   2 +-
 drivers/base/core.c                                |  34 +-
 drivers/base/platform.c                            |   1 -
 drivers/base/property.c                            | 513 +---------------
 drivers/base/swnode.c                              | 675 +++++++++++++++++++++
 include/linux/acpi.h                               |  10 +
 include/linux/property.h                           |  12 +
 11 files changed, 766 insertions(+), 514 deletions(-)
