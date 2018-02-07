Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeBGBmu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:42:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754303AbeBGBmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:42:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v13 0/4] fw_cfg: add DMA operations & etc/vmcoreinfo support
Date: Wed,  7 Feb 2018 02:35:21 +0100
Message-Id: <20180207013525.1634-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds DMA operations support to the qemu fw_cfg kernel
module and populates "etc/vmcoreinfo" with vmcoreinfo location
details (entry added since qemu 2.11 with -device vmcoreinfo).

v13:
- reorder patch series, introduce DMA write before DMA read
- do some measurements of DMA read speed-ups

v12:
- fix virt_to_phys(NULL) panic with CONFIG_DEBUG_VIRTUAL=y
- do not use DMA read, except for kmalloc() memory we allocated
  ourself (only fw_cfg_register_dir_entries() so far)

v11:
- add #include <linux/crash_core.h> in last patch,
  fixing kbuild .config test

Marc-André Lureau (4):
  crash: export paddr_vmcoreinfo_note()
  fw_cfg: add DMA register
  fw_cfg: write vmcoreinfo details
  RFC: fw_cfg: do DMA read operation

 drivers/firmware/qemu_fw_cfg.c | 257 ++++++++++++++++++++++++++++++++++++-----
 kernel/crash_core.c            |   1 +
 2 files changed, 230 insertions(+), 28 deletions(-)

-- 
2.16.1.73.g5832b7e9f2
