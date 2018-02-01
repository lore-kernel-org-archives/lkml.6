Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeBAND0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:03:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeBANDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:03:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v11 0/4] fw_cfg: add DMA operations & etc/vmcoreinfo support
Date: Thu,  1 Feb 2018 14:02:56 +0100
Message-Id: <20180201130300.9962-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds DMA operations support to the qemu fw_cfg kernel
module and populates "etc/vmcoreinfo" with vmcoreinfo location
details (since qemu 2.11).

v11:
- add #include <linux/crash_core.h> in last patch,
  fixing kbuild .config test

Marc-André Lureau (4):
  fw_cfg: add DMA register
  fw_cfg: do DMA read operation
  crash: export paddr_vmcoreinfo_note()
  fw_cfg: write vmcoreinfo details

 drivers/firmware/qemu_fw_cfg.c | 268 ++++++++++++++++++++++++++++++++++++-----
 kernel/crash_core.c            |   1 +
 2 files changed, 237 insertions(+), 32 deletions(-)

-- 
2.16.0.rc1.1.gef27df75a1
