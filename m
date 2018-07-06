Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42645C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B3F240A5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B3F240A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbeGFFrP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:47:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932265AbeGFFrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:47:13 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CFEEB14;
        Fri,  6 Jul 2018 05:47:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/46] 4.17.5-stable review
Date:   Fri,  6 Jul 2018 07:46:21 +0200
Message-Id: <20180706054524.595521988@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.5-rc1
X-KernelTest-Deadline: 2018-07-08T05:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.5 release.
There are 46 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jul  8 05:45:10 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.5-rc1

Sean Nyekjaer <sean.nyekjaer@prevas.dk>
    ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Andrey Ryabinin <aryabinin@virtuozzo.com>
    x86/mm: Don't free P4D table when it is folded at runtime

Neil Armstrong <narmstrong@baylibre.com>
    ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_chain()

Florian Westphal <fw@strlen.de>
    netfilter: xt_connmark: fix list corruption on rmmod

Vincent Bernat <vincent@bernat.im>
    netfilter: ip6t_rpfilter: provide input interface for route lookup

Kenneth Graunke <kenneth@whitecape.org>
    drm/i915: Enable provoking vertex fix on Gen9 systems.

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Turn off g4x DP port in .post_disable()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disallow interlaced modes on g4x DP outputs

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix PIPESTAT irq ack on i965/g4x

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Allow DBLSCAN user modes with eDP/LVDS/DSI

Shirish S <shirish.s@amd.com>
    drm/amd/display: release spinlock before committing updates to stream

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Count disabled CRTCs in commit tail earlier

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: GPU vs CPU page size fixes in amdgpu_vm_bo_split_mapping

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Update pin_size values before unpinning BO

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Make amdgpu_vram_mgr_bo_invisible_size always accurate

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Refactor amdgpu_vram_mgr_bo_invisible_size helper

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu: Use kvmalloc_array for allocating VRAM manager nodes array

Harry Wentland <harry.wentland@amd.com>
    drm/amdgpu: Don't default to DC support for Kaveri and older

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"

Stefan Agner <stefan@agner.ch>
    drm/atmel-hlcdc: check stride values in the first plane

Jeremy Cline <jcline@redhat.com>
    drm/qxl: Call qxl_bo_unref outside atomic context

Lyude Paul <lyude@redhat.com>
    drm/i915/dp: Send DPCD ON for MST before phy_up

Mikita Lipski <mikita.lipski@amd.com>
    drm/amd/display: Clear connector's edid pointer

Oliver O'Halloran <oohall@gmail.com>
    drm/sti: Depend on OF rather than selecting it

Junwei Zhang <Jerry.Zhang@amd.com>
    drm/amdgpu: fix clear_all and replace handling in the VM (v2)

Lyude Paul <lyude@redhat.com>
    drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()

Huang Rui <ray.huang@amd.com>
    drm/amdgpu: fix the missed vcn fw version report

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Add APU support in vi_set_vce_clocks

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Add APU support in vi_set_uvd_clocks

Alexander Potapenko <glider@google.com>
    vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Johan Hovold <johan@kernel.org>
    serdev: fix memleak on module unload

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: 8250_pci: Remove stalled entries in blacklist

Leonard Crestez <leonard.crestez@nxp.com>
    iio: mma8452: Fix ignoring MMA8452_INT_DRDY

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Return an ERR_PTR in ion_map_kernel

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Access echo_* variables carefully.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    n_tty: Fix stall at n_tty_receive_char_special().

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: Fix kernel oops in trace_xhci_free_virt_device

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: Fix for incorrect status data issue

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    usb: typec: ucsi: acpi: Workaround for cache mode issue

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    acpi: Add helper for deactivating memory region

Peter Chen <peter.chen@nxp.com>
    usb: typec: tcpm: fix logbuffer index is wrong if _tcpm_log is re-entered

William Wu <william.wu@rock-chips.com>
    usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub

Karoly Pados <pados@pados.hu>
    USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add CESINEL device ids

Houston Yaroschoff <hstn@4ever3.net>
    usb: cdc_acm: Add quirk for Uniden UBC125 scanner


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/imx6q.dtsi                       |  2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |  7 ++
 arch/x86/include/asm/pgalloc.h                     |  3 +
 drivers/acpi/osl.c                                 | 72 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 10 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         | 24 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       | 39 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    | 77 +++++++++++++++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 22 +++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |  2 +-
 drivers/gpu/drm/i915/i915_irq.c                    | 12 +++-
 drivers/gpu/drm/i915/i915_reg.h                    |  5 ++
 drivers/gpu/drm/i915/intel_crt.c                   | 20 ++++++
 drivers/gpu/drm/i915/intel_ddi.c                   |  8 ++-
 drivers/gpu/drm/i915/intel_display.c               | 16 ++++-
 drivers/gpu/drm/i915/intel_dp.c                    | 34 +++++-----
 drivers/gpu/drm/i915/intel_dp_mst.c                | 14 +++-
 drivers/gpu/drm/i915/intel_dsi.c                   |  6 ++
 drivers/gpu/drm/i915/intel_dvo.c                   |  6 ++
 drivers/gpu/drm/i915/intel_hdmi.c                  |  6 ++
 drivers/gpu/drm/i915/intel_lrc.c                   | 12 +++-
 drivers/gpu/drm/i915/intel_lvds.c                  |  5 ++
 drivers/gpu/drm/i915/intel_sdvo.c                  |  6 ++
 drivers/gpu/drm/i915/intel_tv.c                    | 12 +++-
 drivers/gpu/drm/qxl/qxl_display.c                  |  7 +-
 drivers/gpu/drm/sti/Kconfig                        |  3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 25 -------
 drivers/iio/accel/mma8452.c                        |  2 +-
 drivers/staging/android/ion/ion_heap.c             |  2 +-
 drivers/tty/n_tty.c                                | 55 +++++++++-------
 drivers/tty/serdev/core.c                          |  1 +
 drivers/tty/serial/8250/8250_pci.c                 |  2 -
 drivers/tty/vt/vt.c                                |  4 +-
 drivers/usb/class/cdc-acm.c                        |  3 +
 drivers/usb/dwc2/hcd_queue.c                       |  2 +-
 drivers/usb/host/xhci-mem.c                        |  4 +-
 drivers/usb/host/xhci-trace.h                      | 36 ++++++++--
 drivers/usb/serial/cp210x.c                        | 14 ++++
 drivers/usb/typec/tcpm.c                           |  7 +-
 drivers/usb/typec/ucsi/ucsi.c                      | 13 ++++
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  5 ++
 include/linux/acpi.h                               |  3 +
 net/ipv6/netfilter/ip6t_rpfilter.c                 |  2 +
 net/netfilter/nf_tables_core.c                     |  3 +-
 net/netfilter/xt_connmark.c                        |  2 +-
 50 files changed, 489 insertions(+), 150 deletions(-)


