Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC0C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E513C21887
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 08:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E513C21887
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeHNLnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:43:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:33134 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbeHNLnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:43:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 01:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,237,1531810800"; 
   d="scan'208";a="64771395"
Received: from helong-vb.png.intel.com ([10.226.243.17])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2018 01:57:18 -0700
From:   "Hean-Loong, Ong" <hean.loong.ong@intel.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        David Airlie <airlied@linux.ie>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, hean.loong.ong@intel.com,
        yves.vandervennet@intel.com, chin.liang.see@intel.com,
        Ong@vger.kernel.org
Subject: [PATCH10 0/3] Intel FPGA Video and Image Processing Suite
Date:   Tue, 14 Aug 2018 16:57:06 +0800
Message-Id: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong, Hean Loong <hean.loong.ong@intel.com>

The FPGA FrameBuffer Soft IP could be seen  as the GPU and the DRM driver patch 
here is allocating memory for information to be streamed from the ARM/Linux 
to the display port. Basically the driver just wraps the information such as 
the pixels to be drawn by the FPGA FrameBuffer 2.

The piece of hardware in discussion is the SoC FPGA where Linux runs on the 
ARM chip and the FGPA is driven by its NIOS soft core with its own proprietary firmware.

For example the application from the ARM Linux would have to write information 
on the /dev/fb0 with the information stored in the SDRAM to be fetched by the 
FPGA framebuffer IP and displayed on the Display Port Monitor.


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
 drivers/gpu/drm/ivip/Makefile                      |    9 +
 drivers/gpu/drm/ivip/intel_vip_conn.c              |   95 ++++++++++
 drivers/gpu/drm/ivip/intel_vip_core.c              |  161 ++++++++++++++++
 drivers/gpu/drm/ivip/intel_vip_drv.h               |   52 ++++++
 drivers/gpu/drm/ivip/intel_vip_of.c                |  193 ++++++++++++++++++++
 10 files changed, 595 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
 create mode 100644 drivers/gpu/drm/ivip/Kconfig
 create mode 100644 drivers/gpu/drm/ivip/Makefile
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_conn.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_core.c
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_drv.h
 create mode 100644 drivers/gpu/drm/ivip/intel_vip_of.c

