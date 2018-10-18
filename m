Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D74CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E889520658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0pPlEvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E889520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeJSCIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbeJSCIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F1021476;
        Thu, 18 Oct 2018 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885997;
        bh=uuKgPZ35YZuwf7ntnAIDG+kOAC3DZZSHHk0J0nj/h+I=;
        h=From:To:Cc:Subject:Date:From;
        b=u0pPlEvVaTUMA1v9tk0yfffvlR4QQ0KPslikCI3oO7mw8JOOkDY1j4uSBTxVQMKE2
         +biPSdyde4WBbOsuB8Oinn7GjCBsoiiKZ01cq6Orxtr25DHy2XyNI7549SA6c4EFgI
         mXSmpnYYdy8hKrwmyuAJxZzrotKxY+uX9c5KVPeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/48] 4.4.162-stable review
Date:   Thu, 18 Oct 2018 19:54:35 +0200
Message-Id: <20181018175427.133690306@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.162-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.162-rc1
X-KernelTest-Deadline: 2018-10-20T17:54+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.162 release.
There are 48 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 20 17:54:03 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.162-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.162-rc1

Long Li <longli@microsoft.com>
    HV: properly delay KVP packets when negotiation is in progress

Vitaly Kuznetsov <vkuznets@redhat.com>
    Drivers: hv: kvp: fix IP Failover

K. Y. Srinivasan <kys@microsoft.com>
    Drivers: hv: util: Pass the channel information during the init call

K. Y. Srinivasan <kys@microsoft.com>
    Drivers: hv: utils: Invoke the poll function after handshake

Stephen Warren <swarren@nvidia.com>
    usb: gadget: serial: fix oops when data rx'd after close

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Get rid of toolchain check

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Fix userspace r13 corruption

James Cowgill <jcowgill@debian.org>
    RISC-V: include linux/ftrace.h in asm-prototypes.h

Nathan Chancellor <natechancellor@gmail.com>
    net/mlx4: Use cpumask_available for eq->affinity_mask

Michael Schmitz <schmitzmic@gmail.com>
    Input: atakbd - fix Atari CapsLock behaviour

Andreas Schwab <schwab@linux-m68k.org>
    Input: atakbd - fix Atari keymap

Keerthy <j-keerthy@ti.com>
    clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs

Jozef Balga <jozef.balga@gmail.com>
    media: af9035: prevent buffer overflow on write

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Finish excising 'eagerfpu'

Rik van Riel <riel@redhat.com>
    x86/fpu: Remove struct fpu::counter

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Remove use_eager_fpu()

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: remove eager_fpu field of struct kvm_vcpu_arch

Eric Dumazet <edumazet@google.com>
    rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix wake-up interrupt race during resume

Maxime Chevallier <maxime.chevallier@bootlin.com>
    net: mvpp2: Extract the correct ethtype from the skb for tx csum offload

Ido Schimmel <idosch@mellanox.com>
    team: Forbid enslaving team device to itself

Shahed Shaikh <shahed.shaikh@cavium.com>
    qlcnic: fix Tx descriptor corruption on 82xx devices

Yu Zhao <yuzhao@google.com>
    net/usb: cancel pending work when unbinding smsc75xx

Sean Tranchetti <stranche@codeaurora.org>
    netlabel: check for IPV4MASK in addrinfo_get

Jeff Barnhill <0xeffeff@gmail.com>
    net/ipv6: Display all addresses in output of /proc/net/if_inet6

Sabrina Dubroca <sd@queasysnail.net>
    net: ipv4: update fnhe_pmtu when first hop's MTU changes

Eric Dumazet <edumazet@google.com>
    ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()

Paolo Abeni <pabeni@redhat.com>
    ip_tunnel: be careful when accessing the inner header

Paolo Abeni <pabeni@redhat.com>
    ip6_tunnel: be careful when accessing the inner header

Mahesh Bandewar <maheshb@google.com>
    bonding: avoid possible dead-lock

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Fix TX timeout during netpoll.

Hou Tao <houtao1@huawei.com>
    jffs2: return -ERANGE when xattr buffer is too small

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't print a warning when setting link state for disabled ports

Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
    i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Adrian Hunter <adrian.hunter@intel.com>
    perf script python: Fix export-to-postgresql.py occasional failure

Mikulas Patocka <mpatocka@redhat.com>
    mach64: detect the dot clock divider correctly on sparc

Jann Horn <jannh@google.com>
    mm/vmstat.c: fix outdated vmstat_text

Theodore Ts'o <tytso@mit.edu>
    ext4: add corruption check in ext4_xattr_set_entry()

Amber Lin <Amber.Lin@amd.com>
    drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: add new compatibility string for macb on sama5d3

Nicolas Ferre <nicolas.ferre@microchip.com>
    net: macb: disable scatter-gather for macb on sama5d3

Jongsung Kim <neidhard.kim@lge.com>
    stmmac: fix valid numbers of unicast filter entries

Yu Zhao <yuzhao@google.com>
    sound: enable interrupt after dma buffer initialization

Tony Lindgren <tony@atomide.com>
    mfd: omap-usb-host: Fix dts probe of children

Lei Yang <Lei.Yang@windriver.com>
    selftests/efivarfs: add required kernel configs

Danny Smith <danny.smith@axis.com>
    ASoC: sigmadsp: safeload should not have lower byte limit

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: wm8804: Add ACPI support


-------------

Diffstat:

 Documentation/devicetree/bindings/net/macb.txt     |  1 +
 Documentation/kernel-parameters.txt                |  5 --
 Makefile                                           |  4 +-
 arch/arc/Makefile                                  | 14 ----
 arch/arm/boot/dts/sama5d3_emac.dtsi                |  2 +-
 arch/powerpc/kernel/tm.S                           | 20 +++++-
 arch/riscv/include/asm/asm-prototypes.h            |  7 ++
 arch/x86/crypto/crc32c-intel_glue.c                | 17 ++---
 arch/x86/include/asm/cpufeatures.h                 |  1 -
 arch/x86/include/asm/fpu/internal.h                | 37 +----------
 arch/x86/include/asm/fpu/types.h                   | 34 ----------
 arch/x86/include/asm/kvm_host.h                    |  1 -
 arch/x86/kernel/fpu/core.c                         | 41 ++----------
 arch/x86/kernel/fpu/signal.c                       |  8 +--
 arch/x86/kvm/cpuid.c                               |  5 +-
 arch/x86/kvm/x86.c                                 | 10 ---
 drivers/clocksource/timer-ti-32k.c                 |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |  2 +-
 drivers/hv/hv_fcopy.c                              |  2 +-
 drivers/hv/hv_kvp.c                                | 40 +++++++++++-
 drivers/hv/hv_snapshot.c                           |  4 +-
 drivers/hv/hv_util.c                               |  1 +
 drivers/hv/hyperv_vmbus.h                          |  5 ++
 drivers/i2c/busses/i2c-scmi.c                      |  1 +
 drivers/input/keyboard/atakbd.c                    | 74 ++++++++--------------
 drivers/media/usb/dvb-usb-v2/af9035.c              |  6 +-
 drivers/mfd/omap-usb-host.c                        | 11 ++--
 drivers/net/bonding/bond_main.c                    | 43 +++++--------
 drivers/net/ethernet/broadcom/bcmsysport.c         | 22 +++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 13 +++-
 drivers/net/ethernet/cadence/macb.c                |  8 +++
 drivers/net/ethernet/marvell/mvpp2.c               | 10 +--
 drivers/net/ethernet/mellanox/mlx4/eq.c            |  3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |  8 ++-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |  3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |  3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     | 12 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  5 +-
 drivers/net/team/team.c                            |  5 ++
 drivers/net/usb/smsc75xx.c                         |  1 +
 drivers/usb/gadget/function/u_serial.c             |  2 +-
 drivers/usb/host/xhci-hub.c                        | 18 +++---
 drivers/video/fbdev/aty/atyfb.h                    |  3 +-
 drivers/video/fbdev/aty/atyfb_base.c               |  7 +-
 drivers/video/fbdev/aty/mach64_ct.c                | 10 +--
 fs/ext4/xattr.c                                    | 22 ++++---
 fs/jffs2/xattr.c                                   |  6 +-
 include/linux/hyperv.h                             |  1 +
 include/linux/netdevice.h                          |  7 ++
 include/net/bonding.h                              |  7 +-
 include/net/ip_fib.h                               |  1 +
 mm/vmstat.c                                        |  1 -
 net/core/dev.c                                     | 28 +++++++-
 net/core/rtnetlink.c                               |  6 ++
 net/ipv4/fib_frontend.c                            | 12 ++--
 net/ipv4/fib_semantics.c                           | 50 +++++++++++++++
 net/ipv4/ip_sockglue.c                             |  3 +-
 net/ipv4/ip_tunnel.c                               |  9 +++
 net/ipv6/addrconf.c                                |  4 +-
 net/ipv6/ip6_tunnel.c                              | 13 +++-
 net/netlabel/netlabel_unlabeled.c                  |  3 +-
 sound/hda/hdac_controller.c                        |  8 ++-
 sound/soc/codecs/sigmadsp.c                        |  3 +-
 sound/soc/codecs/wm8804-i2c.c                      | 15 ++++-
 tools/perf/scripts/python/export-to-postgresql.py  |  9 +++
 tools/testing/selftests/efivarfs/config            |  1 +
 67 files changed, 404 insertions(+), 340 deletions(-)


