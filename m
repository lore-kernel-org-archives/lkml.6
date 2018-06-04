Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeFDGkn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:40:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:24439 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeFDGkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:40:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,475,1520924400";
   d="scan'208";a="64069201"
From: "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To: Rob Herring <robh+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        hean.loong.ong@intel.com, Ong@vger.kernel.org
Subject: [PATCHv9 0/3] Intel FPGA Video and Image Processing Suite
Date: Mon,  4 Jun 2018 14:40:01 +0800
Message-Id: <1528094404-3542-1-git-send-email-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong, Hean Loong <hean.loong.ong@intel.com>

The FPGA FrameBuffer Soft IP could be seen  as the GPU and the DRM driver patch here is allocating memory for information to be streamed from the ARM/Linux to the display port.
Basically the driver just wraps the information such as the pixels to be drawn by the FPGA FrameBuffer 2.

The piece of hardware in discussion is the SoC FPGA where Linux runs on the ARM chip and the FGPA is driven by its NIOS soft core with its own proprietary firmware.

For example the application from the ARM Linux would have to write information on the /dev/fb0 with the information stored in the SDRAM to be fetched by the FPGA framebuffer IP and displayed on the Display Port Monitor.

Ong Hean Loong (2):
  ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
  ARM:drm ivip Intel FPGA Video and Image Processing Suite

Ong, Hean Loong (1):
  ARM:dt-bindings:display Intel FPGA Video and Image Processing Suite

 .../devicetree/bindings/display/altr,vip-fb2.txt   |   99 ++++++++++
 arch/arm/configs/socfpga_defconfig                 |    5 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/ivip/Kconfig                       |   14 ++
 drivers/gpu/drm/ivip/Makefile                      |    9 +
 drivers/gpu/drm/ivip/intel_vip_conn.c              |   95 ++++++++++
 drivers/gpu/drm/ivip/intel_vip_core.c              |  161 ++++++++++++++++
 drivers/gpu/drm/ivip/intel_vip_drv.h               |   52 ++++++
 drivers/gpu/drm/ivip/intel_vip_of.c                |  193 ++++++++++++++++++++
 10 files changed, 631 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
 create mode 100644 drivers/gpu/drm/ivip/Kconfig
 create mode 100644 drivers/gpu/drm/ivip/Makefile
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c
