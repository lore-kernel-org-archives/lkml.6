Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3832C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC962082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 02:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfBKCLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 21:11:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:41293 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfBKCLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 21:11:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2019 18:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,357,1544515200"; 
   d="scan'208";a="137551007"
Received: from helong-vb.png.intel.com ([10.226.243.17])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2019 18:11:21 -0800
From:   "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rienk de Jong <rienk.dejong@quest-innovations.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, hean.loong.ong@intel.com,
        chin.liang.see@intel.com, Ong@vger.kernel.org
Subject: [PATCHv11 0/3] Intel FPGA Video and Image Processing Suite
Date:   Mon, 11 Feb 2019 10:11:07 +0800
Message-Id: <20190211021110.2717-1-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong, Hean Loong <hean.loong.ong@intel.com>

The FPGA FrameBuffer Soft IP could be seen  as the GPU and the DRM driver 
patch here is allocating memory for information to be streamed from the 
ARM/Linux to the display port. 

Basically the driver just wraps the information such as the pixels 
to be drawn by the FPGA FrameBuffer 2.

The piece of hardware in discussion is the SoC FPGA where Linux runs on 
the ARM chip and the FGPA is driven by its NIOS soft core with its own 
proprietary firmware.

For example the application from the ARM Linux would have to write 
information on the /dev/fb0 with the information stored in the 
SDRAM to be fetched by the FPGA framebuffer IP and displayed 
on the Display Port Monitor.


Ong Hean Loong (2):
  ARM:socfpga-defconfig Intel FPGA Video and Image Processing Suite
  ARM:drm ivip Intel FPGA Video and Image Processing Suite

Ong, Hean Loong (1):
  ARM:dt-bindings:display Intel FPGA Video and Image Processing Suite

 .../devicetree/bindings/display/altr,vip-fb2.txt   |   63 +++++++
 arch/arm/configs/socfpga_defconfig                 |    5 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/ivip/Kconfig                       |   14 ++
 drivers/gpu/drm/ivip/Makefile                      |    7 +
 drivers/gpu/drm/ivip/intel_vip_conn.c              |   87 ++++++++++
 drivers/gpu/drm/ivip/intel_vip_core.c              |  152 +++++++++++++++++
 drivers/gpu/drm/ivip/intel_vip_drv.h               |   40 +++++
 drivers/gpu/drm/ivip/intel_vip_of.c                |  177 ++++++++++++++++++++
 10 files changed, 548 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
 create mode 100644 drivers/gpu/drm/ivip/Kconfig
 create mode 100644 drivers/gpu/drm/ivip/Makefile
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c

