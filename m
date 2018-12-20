Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345BDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E051321852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298184;
	bh=yGofCiSCsGb2XioTCIy2leeoS6lPSOJXV4X2BXHzfOk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KbGAoO12Di7dg2zswyCljhukxBR2L+RmQ6hanpTLa4z1XJ+5msN/BlKKgOQQYo5iw
	 2WKX6srALJTLmNeiOoBiK4yqV9PEta8+w20r93fEiJTAjyZag9QZTPBGPYVQflruyx
	 9+H4mIZDfK2KRhzNcPhiktWQmQxsiNPPWhuPFoaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbeLTJ3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732744AbeLTJ3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D7120656;
        Thu, 20 Dec 2018 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298178;
        bh=yGofCiSCsGb2XioTCIy2leeoS6lPSOJXV4X2BXHzfOk=;
        h=From:To:Cc:Subject:Date:From;
        b=d1MZpvC0YqOml6PGIRZp7R6Vj0Tb2YC5LQqX7WcYSsCXKjb+TPxu1hcxJhoUbGAjR
         XtJlr/PG5rM9f1BlxdnJFeFTxeOpgflMYf6wWOJuSptjZpH9ysCQV2io/nfailYKaD
         H7fGv+QsoZFE7INHbhqjWHR4IsjvVClBHO3JbvHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 00/67] 4.19.12-stable review
Date:   Thu, 20 Dec 2018 10:18:12 +0100
Message-Id: <20181220085903.562090333@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.12-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.12-rc1
X-KernelTest-Deadline: 2018-12-22T08:59+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.12 release.
There are 67 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec 22 08:58:49 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.12-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.12-rc1

Omar Sandoval <osandov@fb.com>
    Btrfs: fix missing delayed iputs on unmount

Israel Rukshin <israelr@mellanox.com>
    nvmet-rdma: fix response use after free

James Smart <jsmart2021@gmail.com>
    nvme: validate controller state before rescheduling keep alive

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier: fix violation of tLOW requirement for Fast-mode

Hans de Goede <hdegoede@redhat.com>
    i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node

Adamski, Krzysztof (Nokia - PL/Wroclaw) <krzysztof.adamski@nokia.com>
    i2c: axxia: properly handle master timeout

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix reset orphans race with close timeout

Steve French <stfrench@microsoft.com>
    cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)

Sam Bobroff <sbobroff@linux.ibm.com>
    drm/ast: Fix connector leak during driver unload

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather than "ARS-short"

Dan Williams <dan.j.williams@intel.com>
    tools/testing/nvdimm: Align test resources to 128M

James Zhu <James.Zhu@amd.com>
    drm/amdgpu/vcn: Update vcn.cur_state during suspend

Baruch Siach <baruch@tkos.co.il>
    net: mvpp2: fix phylink handling of invalid PHY modes

Baruch Siach <baruch@tkos.co.il>
    net: mvpp2: fix detection of 10G SFP modules

Russell King <rmk+kernel@armlinux.org.uk>
    thermal: armada: fix legacy validity test sense

Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
    ethernet: fman: fix wrong of_node_put() in probe function

Nathan Jones <nathanj439@gmail.com>
    ARM: 8816/1: dma-mapping: fix potential uninitialized return

Vladimir Murzin <vladimir.murzin@arm.com>
    ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart

Chris Cole <chris@sageembedded.com>
    ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address handling

Alexei Starovoitov <ast@kernel.org>
    bpf: check pending signals while verifying programs

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Fix build break when CONFIG_INET is off

Anderson Luiz Alves <alacn1@gmail.com>
    mv88e6060: disable hardware level MAC learning

Matteo Croce <mcroce@redhat.com>
    macvlan: return correct error value

Juha-Matti Tilli <juha-matti.tilli@iki.fi>
    libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix keyboard debounce configuration

Teika Kazura <teika@gmx.com>
    Input: synaptics - enable SMBus for HP 15-ay000

Dan Carpenter <dan.carpenter@oracle.com>
    clk: mmp: Off by one in mmp_clk_add()

Dan Carpenter <dan.carpenter@oracle.com>
    clk: mvebu: Off by one bugs in cp110_of_clk_get()

Evan Quan <evan.quan@amd.com>
    drm/amd/powerplay: issue pre-display settings for display change event

Wen Yang <wen.yang99@zte.com.cn>
    drm/msm: Fix error return checking

YueHaibing <yuehaibing@huawei.com>
    drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"

Sean Paul <seanpaul@chromium.org>
    drm/msm: dpu: Don't set legacy plane->crtc pointer

Todor Tomov <todor.tomov@linaro.org>
    drm/msm/hdmi: Enable HPD after HDMI IRQ is set up

Yangtao Li <tiny.windzz@gmail.com>
    ide: pmac: add of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    drivers/tty: add missing of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    drivers/sbus/char: add of_node_put()

Yangtao Li <tiny.windzz@gmail.com>
    sbus: char: add of_node_put()

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a potential race in xprt_connect()

Dave Kleikamp <dave.kleikamp@oracle.com>
    nfs: don't dirty kernel pages read by direct-io

Pan Bian <bianpan2016@163.com>
    liquidio: read sc->iq_no before release sc

David Miller <davem@davemloft.net>
    bpf: Fix verifier log string check for bad alignment.

Toni Peltonen <peltzi@peltzi.fi>
    bonding: fix 802.3ad state sent to partner when unbinding slave

Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
    net: aquantia: fix rx checksum offload bits

Thierry Reding <treding@nvidia.com>
    net: stmmac: Move debugfs init/exit to ->probe()/->remove()

Jose Abreu <joabreu@synopsys.com>
    ARC: io.h: Implement reads{x}()/writes{x}()

Christian König <christian.koenig@amd.com>
    drm/amdgpu: wait for IB test on first device open

Christian König <christian.koenig@amd.com>
    drm/ttm: fix LRU handling in ttm_buffer_object_transfer

Sean Paul <seanpaul@chromium.org>
    drm/msm: Grab a vblank reference when waiting for commit_done

Abhinav Kumar <abhinavk@codeaurora.org>
    drm/msm/dsi: configure VCO rate for 10nm PLL driver

Rob Clark <robdclark@gmail.com>
    drm/msm: fix handling of cmdstream offset

Dan Carpenter <dan.carpenter@oracle.com>
    drm/msm/gpu: Fix a couple memory leaks in debugfs

Sharat Masetty <smasetty@codeaurora.org>
    drm/msm: Fix task dump in gpu recovery

YiFei Zhu <zhuyifei1999@gmail.com>
    x86/earlyprintk/efi: Fix infinite loop on some screen widths

Roman Li <Roman.Li@amd.com>
    drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)

Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
    net: ethernet: ave: Replace NET_IP_ALIGN with AVE_FRAME_HEADROOM

Yonghong Song <yhs@fb.com>
    tools/bpf: add addition type tests to test_btf

Martin KaFai Lau <kafai@fb.com>
    tools/bpf: fix two test_btf unit test cases

Cathy Avery <cavery@redhat.com>
    scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload

Fred Herard <fred.herard@oracle.com>
    scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: check bus state before reinitializing

Vitaly Kuznetsov <vkuznets@redhat.com>
    Input: hyper-v - fix wakeup from suspend-to-idle

Alexey Khoroshilov <khoroshilov@ispras.ru>
    mac80211_hwsim: fix module init error paths for netlink

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Remove race conditions in user_sdma send path

Peter Zijlstra <peterz@infradead.org>
    locking/qspinlock, x86: Provide liveness guarantee

Peter Zijlstra <peterz@infradead.org>
    locking/qspinlock: Re-order code


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/io.h                          |  72 ++++
 arch/arm/mm/cache-v7.S                             |   8 +-
 arch/arm/mm/cache-v7m.S                            |  14 +-
 arch/arm/mm/dma-mapping.c                          |   2 +-
 arch/x86/include/asm/qspinlock.h                   |  21 ++
 arch/x86/platform/efi/early_printk.c               |   2 +-
 drivers/acpi/nfit/core.c                           |   2 +-
 drivers/ata/libata-core.c                          |   1 +
 drivers/clk/mmp/clk.c                              |   2 +-
 drivers/clk/mvebu/cp110-system-controller.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |   3 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   2 +
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        |   3 +
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |   2 -
 drivers/gpu/drm/ast/ast_fb.c                       |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   2 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |   4 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |   6 +
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |   1 +
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c          |  10 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   5 +
 drivers/gpu/drm/msm/msm_debugfs.c                  |  15 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |   9 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   2 +-
 drivers/gpu/drm/msm/msm_rd.c                       |   5 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   4 +-
 drivers/hid/hid-hyperv.c                           |   2 +-
 drivers/i2c/busses/i2c-axxia.c                     |  40 ++-
 drivers/i2c/busses/i2c-rcar.c                      |   9 +-
 drivers/i2c/busses/i2c-scmi.c                      |  10 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |  19 +-
 drivers/i2c/busses/i2c-uniphier.c                  |   8 +-
 drivers/ide/pmac.c                                 |   1 +
 drivers/infiniband/hw/hfi1/user_sdma.c             |  24 +-
 drivers/infiniband/hw/hfi1/user_sdma.h             |   9 +-
 drivers/input/keyboard/omap4-keypad.c              |  18 +-
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/hyperv-keyboard.c              |   2 +-
 drivers/net/bonding/bond_3ad.c                     |   3 +
 drivers/net/dsa/mv88e6060.c                        |  10 +-
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |   2 +-
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c  |   4 +-
 drivers/net/ethernet/freescale/fman/fman.c         |   5 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  34 +-
 drivers/net/ethernet/mellanox/mlx4/Kconfig         |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  10 +-
 drivers/net/ethernet/socionext/sni_ave.c           |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  23 +-
 drivers/net/macvlan.c                              |   7 +-
 drivers/net/wireless/mac80211_hwsim.c              |  12 +-
 drivers/nvme/host/core.c                           |  10 +-
 drivers/nvme/target/rdma.c                         |   3 +-
 drivers/sbus/char/display7seg.c                    |   1 +
 drivers/sbus/char/envctrl.c                        |   2 +
 drivers/scsi/libiscsi.c                            |   4 +-
 drivers/scsi/vmw_pvscsi.c                          |   4 +-
 drivers/thermal/armada_thermal.c                   |   2 +-
 drivers/tty/serial/suncore.c                       |   1 +
 drivers/vhost/vsock.c                              |  22 +-
 fs/btrfs/disk-io.c                                 |  51 +--
 fs/cifs/Kconfig                                    |   2 +-
 fs/nfs/direct.c                                    |   9 +-
 kernel/bpf/verifier.c                              |   3 +
 kernel/locking/qspinlock.c                         |  71 ++--
 net/sunrpc/xprt.c                                  |  11 +-
 tools/testing/nvdimm/test/nfit.c                   |  35 +-
 tools/testing/selftests/bpf/test_btf.c             | 375 ++++++++++++++++++++-
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 71 files changed, 868 insertions(+), 222 deletions(-)


