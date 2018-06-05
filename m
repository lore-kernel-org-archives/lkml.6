Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeFEUgs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:36:48 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:35432
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751807AbeFEUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:36:47 -0400
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 0/8] Drivers: hv: Miscellaneous fixes/improvements 
Date: Tue,  5 Jun 2018 13:35:36 -0700
Message-Id: <20180605203536.29751-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.1
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfFoSvIHJU3e+QySuHvM2Y3lATCGlJuIog+/PKVVlwrjn8DevfLqERzIbV/ssr58LPmVsm7g+Fhnesr9DEgNdwjak0AeuTbKpfTLTIT2dv+Qnx5Xho36s
 8xKVadFB2lcTBQLXWiG5F6F50TJier41ZRwlgzbXgGCv9vddDw45sSRNRb57419t0CN+dzkDS/OzuGZL5Cr6tgGc2VChxHdhr4lAUWPJEdaxfwGsgLeoAqOl
 h5xD3cPS+NSBlk6i2xdO/CZ+Z6oAb+LYR2TtLgoyLV9Nq/v12m1EFLy32BZegHgWI4c/S0XKXVXJOhDstZuZsBAyjrYJd2S2k33NZjq41yjVYwWBSE3or0yg
 9VSVWgU0KbvB1kLv5y3B3TJGIcLQyx26EHSrWmDCVzQQTThqHnCsy+EDI0eZw3kyVzMsxEX73ptYLZii+IXUbr/qSKPfY0YyNBF8ZYOTKht1ErsSBUQV9YFN
 1XRcOvaAHl8v/BHOCofRB8R9KaNkxQCU6EB0lVkPihxlowBH3jkoPsue0OcToIwDQ8DK6KXbE1iWVY+U
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "K. Y. Srinivasan" <kys@microsoft.com>

Some miscellaneous fixes/improvements. 

Arjan van de Ven (1):
  use the new async probing feature for the hyperv drivers

Dexuan Cui (1):
  Drivers: hv: vmbus: Fix the offer_in_progress in vmbus_process_offer()

Michael Kelley (4):
  x86/hyperv: Add interrupt handler annotations
  Drivers: hv: vmbus: Add comments on ring buffer signaling
  Drivers: hv: vmbus: Remove x86 MSR refs in arch independent code
  Drivers: hv: vmbus: Make TLFS #define names architecture neutral

Olaf Hering (1):
  tools: hv: update lsvmbus to be compatible with python3

Vitaly Kuznetsov (1):
  Tools: hv: vss: fix loop device detection

 arch/x86/hyperv/hv_init.c             |  4 +-
 arch/x86/include/asm/hyperv-tlfs.h    | 12 ++---
 arch/x86/include/asm/mshyperv.h       | 12 +++--
 arch/x86/kernel/cpu/mshyperv.c        |  6 +--
 drivers/hid/hid-hyperv.c              |  3 ++
 drivers/hv/channel_mgmt.c             |  4 +-
 drivers/hv/hv.c                       | 30 ++++++-------
 drivers/hv/hv_balloon.c               |  3 ++
 drivers/hv/hv_util.c                  |  3 ++
 drivers/hv/ring_buffer.c              | 65 ++++++++++++++++++++++-----
 drivers/input/serio/hyperv-keyboard.c |  3 ++
 drivers/net/hyperv/netvsc_drv.c       |  3 ++
 drivers/scsi/storvsc_drv.c            |  3 ++
 drivers/video/fbdev/hyperv_fb.c       |  6 +++
 include/linux/hyperv.h                | 31 +++++++++----
 tools/hv/hv_vss_daemon.c              | 65 +++++++++++++++++++++++++--
 tools/hv/lsvmbus                      | 12 ++---
 17 files changed, 201 insertions(+), 64 deletions(-)

-- 
2.17.1
