Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935008AbeBMQhD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:37:03 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:41722 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934958AbeBMQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:37:01 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        kvm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] vfio: platform: Improve reset support
Date: Tue, 13 Feb 2018 17:36:53 +0100
Message-Id: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series improves reset support for vfio-platform:
  - The first patch fixes a bug I ran into while working on this.
  - The second patch implements generic DT reset support, for devices
    that are connected to an SoC-internal reset controller and can be
    reset in a generic way.  This avoids having to write/change a
    vfio-specific reset driver for each and every device to be
    passed-through to a guest.

This has been tested using the R-Car Gen3 GPIO Pass-Through Prototype
posted last week: the GPIO module is reset before QEMU opens the vfio
device, and reset again after QEMU has released it, as can be witnessed
by the LEDs on the Salvator-XS board.

Thanks for your comments!

Geert Uytterhoeven (2):
  vfio: platform: Fix reset module leak in error path
  vfio: platform: Add generic DT reset support

 drivers/vfio/platform/vfio_platform_common.c  | 38 ++++++++++++++++++++++-----
 drivers/vfio/platform/vfio_platform_private.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
