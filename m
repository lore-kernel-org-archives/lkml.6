Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757311AbeD0B0O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:26:14 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:40424 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757283AbeD0B0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:26:12 -0400
X-Google-Smtp-Source: AB8JxZoovpNNiiucokQ1ytGNdA5ckWvf8sbPOK+at9JbLc2calTx/7FzOMvB4PtEYvXATw28JEc1Gg==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, michal.simek@xilinx.com, corbet@lwn.net,
        atull@kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/4] FPGA Manager Patches for 4.18
Date: Thu, 26 Apr 2018 18:26:01 -0700
Message-Id: <20180427012605.28981-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's Alan's reworked patchset changing the API
for creating and registering FPGA Managers, Bridges and
Regions following your suggestions on the API.

These go on top of Paolo and Alan's patches that you
queued up the other day.

Thanks,

Moritz

Alan Tull (4):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: change api, don't use drvdata
  fpga: bridge: change api, don't use drvdata
  fpga: region: change api, add fpga_region_create/free

 Documentation/fpga/fpga-mgr.txt     | 35 ++++++++++---
 Documentation/fpga/fpga-region.txt  |  3 +-
 drivers/fpga/altera-cvp.c           | 19 +++++--
 drivers/fpga/altera-fpga2sdram.c    | 21 ++++++--
 drivers/fpga/altera-freeze-bridge.c | 22 ++++++--
 drivers/fpga/altera-hps2fpga.c      | 24 +++++++--
 drivers/fpga/altera-pr-ip-core.c    | 18 ++++++-
 drivers/fpga/altera-ps-spi.c        | 20 ++++++--
 drivers/fpga/fpga-bridge.c          | 70 +++++++++++++++++---------
 drivers/fpga/fpga-mgr.c             | 78 +++++++++++++++++++----------
 drivers/fpga/fpga-region.c          | 69 +++++++++++++++++++------
 drivers/fpga/ice40-spi.c            | 21 ++++++--
 drivers/fpga/machxo2-spi.c          | 20 ++++++--
 drivers/fpga/of-fpga-region.c       | 14 +++---
 drivers/fpga/socfpga-a10.c          | 14 ++++--
 drivers/fpga/socfpga.c              | 19 +++++--
 drivers/fpga/ts73xx-fpga.c          | 20 ++++++--
 drivers/fpga/xilinx-pr-decoupler.c  | 22 ++++++--
 drivers/fpga/xilinx-spi.c           | 20 ++++++--
 drivers/fpga/zynq-fpga.c            | 14 ++++--
 include/linux/fpga/fpga-bridge.h    |  9 ++--
 include/linux/fpga/fpga-mgr.h       | 10 ++--
 include/linux/fpga/fpga-region.h    | 11 ++--
 23 files changed, 429 insertions(+), 144 deletions(-)

-- 
2.17.0
