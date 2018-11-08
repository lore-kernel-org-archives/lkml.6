Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11980ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C432820989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL6ORx0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C432820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeKIHqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731402AbeKIHqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:08 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF412089F;
        Thu,  8 Nov 2018 22:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714917;
        bh=QR070ZqjUr0hB3gFPMsySRkPbwiJD80fxCTi0UyRfg4=;
        h=From:To:Cc:Subject:Date:From;
        b=VL6ORx0dzZO3phYvOZ33SSetwphkk2HfZKqmN3prYE/fFu68xmkFdiTRjVe/q5Z1k
         8nzXd3aHkZcdr5YNQ9o4Vs2GlotZVxFEVQFpC19B+iM4rwo+/HlvViPABkiVEuvJSk
         3daUvuV0qJoPXw0uEmcepWucF+zrIM2VBNxZfdw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/31] 4.14.80-stable review
Date:   Thu,  8 Nov 2018 13:52:24 -0800
Message-Id: <20181108215129.641434673@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.80-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.80-rc1
X-KernelTest-Deadline: 2018-11-10T21:51+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.80 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Nov 10 21:51:09 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.80-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.80-rc1

Christophe Leroy <christophe.leroy@c-s.fr>
    net: fs_enet: do not call phy_stop() in interrupts

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on context switch if there is an FPU

Nathan Chancellor <natechancellor@gmail.com>
    x86/time: Correct the attribute on jiffies' definition

Peter Zijlstra <peterz@infradead.org>
    x86/percpu: Fix this_cpu_read()

Zhimin Gu <kookoo.gu@intel.com>
    x86, hibernate: Fix nosave_regions setup for hibernation

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Force inlining of cyc2ns bits

Phil Auld <pauld@redhat.com>
    sched/fair: Fix throttle_list starvation with low CFS quota

Mikhail Nikiforov <jackxviichaos@gmail.com>
    Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Alan Stern <stern@rowland.harvard.edu>
    USB: fix the usbfs flag sanitization for control transfers

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usb: gadget: storage: Fix Spectre v1 vulnerability

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

Oliver Neukum <oneukum@suse.com>
    cdc-acm: fix race between reset and control messaging

Tobias Herzog <t-herzog@gmx.de>
    cdc-acm: correct counting of UART states in serial state notification

Tobias Herzog <t-herzog@gmx.de>
    cdc-acm: do not reset notification buffer index upon urb unlinking

Gustavo A. R. Silva <gustavo@embeddedor.com>
    IB/ucm: Fix Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    RDMA/ucma: Fix Spectre v1 vulnerability

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    drm: fb-helper: Reject all pixel format changing requests

Clint Taylor <clinton.a.taylor@intel.com>
    drm/edid: VSDB yCBCr420 Deep Color mode bit definitions

Kai-Heng Feng <kai.heng.feng@canonical.com>
    drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ptp: fix Spectre v1 vulnerability

Al Viro <viro@zeniv.linux.org.uk>
    cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Brian Foster <bfoster@redhat.com>
    xfs: truncate transaction does not modify the inobt

Linus Walleij <linus.walleij@linaro.org>
    gpio: mxs: Get rid of external API call

Amir Goldstein <amir73il@gmail.com>
    fsnotify: fix ignore mask logic in fsnotify()

Dmitry Osipenko <digetx@gmail.com>
    clk: tegra: Add quirk for getting CDEV1/2 clocks on Tegra20

Sasha Levin <sashal@kernel.org>
    Revert "ARM: tegra: Fix ULPI regression on Tegra20"

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix partial copy of map_ptr when dst is scalar

Johan Hovold <johan@kernel.org>
    USB: serial: option: add two-endpoints device-id flag

Kristian Evensen <kristian.evensen@gmail.com>
    USB: serial: option: improve Quectel EP06 detection

Amir Goldstein <amir73il@gmail.com>
    vfs: swap names of {do,vfs}_clone_file_range()

Alan Chiang <alanx.chiang@intel.com>
    eeprom: at24: Add support for address-width property


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/boot/dts/tegra20.dtsi                     |  2 +-
 arch/x86/include/asm/fpu/internal.h                |  2 +-
 arch/x86/include/asm/percpu.h                      |  8 +-
 arch/x86/kernel/setup.c                            |  2 +-
 arch/x86/kernel/time.c                             |  2 +-
 arch/x86/kernel/tsc.c                              |  6 +-
 drivers/clk/tegra/clk-tegra114.c                   |  2 +-
 drivers/clk/tegra/clk-tegra124.c                   |  2 +-
 drivers/clk/tegra/clk-tegra20.c                    | 32 +++++++-
 drivers/clk/tegra/clk-tegra210.c                   |  2 +-
 drivers/clk/tegra/clk-tegra30.c                    |  2 +-
 drivers/clk/tegra/clk.c                            |  5 +-
 drivers/clk/tegra/clk.h                            |  2 +-
 drivers/gpio/gpio-mxs.c                            |  4 +-
 drivers/gpu/drm/drm_edid.c                         |  5 +-
 drivers/gpu/drm/drm_fb_helper.c                    | 91 +++++++---------------
 drivers/infiniband/core/ucm.c                      |  3 +
 drivers/infiniband/core/ucma.c                     |  3 +
 drivers/input/mouse/elan_i2c_core.c                |  1 +
 drivers/misc/eeprom/at24.c                         | 17 ++++
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  | 16 +++-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |  1 +
 drivers/ptp/ptp_chardev.c                          |  4 +
 drivers/usb/class/cdc-acm.c                        | 16 ++--
 drivers/usb/core/devio.c                           |  4 +-
 drivers/usb/gadget/function/f_mass_storage.c       |  3 +
 drivers/usb/serial/option.c                        | 15 +++-
 drivers/usb/usbip/vhci_hcd.c                       | 57 ++++++++++----
 fs/cachefiles/namei.c                              |  2 +-
 fs/ioctl.c                                         |  2 +-
 fs/nfsd/vfs.c                                      |  3 +-
 fs/notify/fsnotify.c                               | 14 ++--
 fs/overlayfs/copy_up.c                             |  2 +-
 fs/read_write.c                                    | 17 +++-
 fs/xfs/libxfs/xfs_trans_resv.c                     |  9 +--
 include/drm/drm_edid.h                             |  6 +-
 include/linux/bpf_verifier.h                       |  3 +
 include/linux/fs.h                                 | 17 +---
 kernel/bpf/verifier.c                              | 10 ++-
 kernel/sched/fair.c                                | 22 +++++-
 kernel/sched/sched.h                               |  2 +
 42 files changed, 255 insertions(+), 167 deletions(-)


