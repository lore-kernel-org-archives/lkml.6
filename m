Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBDQJJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 11:09:09 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44513 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeBDQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 11:09:03 -0500
X-Google-Smtp-Source: AH8x227/xd8zGD8i+Ot2foF04Hv1DppdY7m6Ox/rL5LtT06ZkGcZtW95VGhFguXdiZt2MNFHolnW0g==
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin.kudzu.us>
Date: Sun, 4 Feb 2018 11:08:59 -0500
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB bug fixes for v4.16
Message-ID: <20180204160859.GA20908@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB bug fixes, removal of a driver, and updated to the
NTB tools to take advants of the multiport interface.  They've been in
linux-next for a little while.  Please consider pulling them for 4.16.

Thanks,
Jon



The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.16

for you to fetch changes up to 3b28c987fb9547ca9aac73241d0e281cf646387c:

  NTB: ntb_perf: fix cast to restricted __le32 (2018-01-28 22:17:24 -0500)

----------------------------------------------------------------
Bug fixes galore, removal of the ntb atom driver, and updates to the ntb
tools and tests to support the multi-port interface

----------------------------------------------------------------
Allen Hubbe (1):
      MAINTAINERS: NTB: Update contact info

Arnd Bergmann (2):
      ntb_hw_switchtec: fix logic error
      NTB: ntb_perf: fix printing of resource_size_t

Colin Ian King (2):
      NTB: switchtec_ntb: fix spelling mistake: "peforming" -> "performing"
      NTB: ntb_tool: fix memory leak on 'buf' on error exit path

Dan Carpenter (1):
      ntb_perf: Fix an error code in perf_copy_chunk()

Dave Jiang (1):
      ntb: remove Intel Atom NTB driver support

Doug Meyer (1):
      NTB: ntb_hw_switchtec: Fix peer BAR bug in switchtec_ntb_init_shared_mw

Greg Kroah-Hartman (1):
      ntb: remove unneeded DRIVER_LICENSE #defines

Jon Mason (1):
      NTB: switchtec_ntb: Add new line on appropriate printks

Kelvin Cao (1):
      ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups

Logan Gunthorpe (9):
      ntb_hw_switchtec: Keep track of the number of LUT windows used by the driver
      ntb_hw_switchtec: Create helper function to setup reserved LUT MWs
      ntb_hw_switchtec: Make switchtec_ntb_init_req_id_table() more general
      ntb_hw_switchtec: Expand PFF CSR registers
      ntb_hw_switchtec: Add initialization code for crosslink
      ntb_hw_switchtec: Crosslink doorbells and messages
      ntb_hw_switchtec: Force down the link before initializing
      ntb_transport: Fix bug with max_mw_size parameter
      ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()

Serge Semin (16):
      NTB: Rename NTB messaging API methods
      NTB: Set dma mask and dma coherent mask to NTB devices
      NTB: Fix UB/bug in ntb_mw_get_align()
      NTB: ntb_pp: Add full multi-port NTB API support
      NTB: ntb_tool: Add full multi-port NTB API support
      NTB: ntb_perf: Add full multi-port NTB API support
      NTB: ntb_test: Safely use paths with whitespace
      NTB: ntb_test: Add ntb_tool port tests
      NTB: ntb_test: Update ntb_tool link tests
      NTB: ntb_test: Update ntb_tool DB tests
      NTB: ntb_test: Update ntb_tool Scratchpad tests
      NTB: ntb_test: Add ntb_tool Message tests
      NTB: ntb_test: Update ntb_tool MW tests
      NTB: ntb_test: Update ntb_perf tests
      NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
      NTB: ntb_perf: fix cast to restricted __le32

Wei Yongjun (1):
      ntb_hw_switchtec: Make function switchtec_ntb_remove() static

 MAINTAINERS                             |    2 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c         |    4 +
 drivers/ntb/hw/idt/ntb_hw_idt.c         |   37 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c     |  313 +-----
 drivers/ntb/hw/intel/ntb_hw_intel.h     |   58 -
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c  |  603 ++++++++--
 drivers/ntb/ntb.c                       |    4 +-
 drivers/ntb/ntb_transport.c             |    3 +
 drivers/ntb/test/ntb_perf.c             | 1824 ++++++++++++++++++++----------
 drivers/ntb/test/ntb_pingpong.c         |  450 +++++---
 drivers/ntb/test/ntb_tool.c             | 1827 +++++++++++++++++++++----------
 include/linux/ntb.h                     |   51 +-
 include/linux/switchtec.h               |   23 +-
 tools/testing/selftests/ntb/ntb_test.sh |  307 ++++--
 14 files changed, 3551 insertions(+), 1955 deletions(-)
