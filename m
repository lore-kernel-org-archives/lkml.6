Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F490C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1ED2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500253;
	bh=QfzeNjQnMu7FynN1R+lmjIRLnvNXiMo4u2WF6EROtJ8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MD2Js2WuRwpuzCu6lr+Zk2oI1kJA6xAQj1YDk2Ul2JxMpQxVio1EOZqDqzmnjGJMu
	 TQT4BWPAnd2h4k2UMA27RVzVfgCnqPlHxAEYLqy1vhDPGgXD70c2jPbmnmwlKLjzyx
	 J7mMtjdRgBz9ir8UEZK45msvePQ7VpjvDN+q5nWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbfBROav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:30:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388341AbfBRN6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB22120842;
        Mon, 18 Feb 2019 13:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498304;
        bh=QfzeNjQnMu7FynN1R+lmjIRLnvNXiMo4u2WF6EROtJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=UBiJK75SLMLYrqbNzrHi7u0tQES30LbSjLklAbDWAcFHLGqqZMBLYe+u0isxKvBWC
         5AiZqQUiaJTjLLTFd++etZmEihjkyH2raIQUXNThidnVBq6fxyeoxyMvB0JXQjioiS
         e7bqSpjWWwN5eJLhIbftg6v5xvwk+8k1ZKbyO1BM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/58] 4.9.159-stable review
Date:   Mon, 18 Feb 2019 14:43:21 +0100
Message-Id: <20190218133508.567416115@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.159-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.159-rc1
X-KernelTest-Deadline: 2019-02-20T13:35+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.159 release.
There are 58 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb 20 13:34:40 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.159-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.159-rc1

Hugh Dickins <hughd@google.com>
    mm: stop leaking PageTables

Christian Lamparter <chunkeey@gmail.com>
    pinctrl: msm: fix gpio-hog related boot issues

Liping Zhang <zlpnobody@gmail.com>
    netfilter: nf_tables: fix mismatch in big-endian system

John Youn <johnyoun@synopsys.com>
    usb: dwc2: Remove unnecessary kfree

Eric Dumazet <edumazet@google.com>
    kaweth: use skb_cow_head() to deal with cloned skbs

Eric Dumazet <edumazet@google.com>
    ch9200: use skb_cow_head() to deal with cloned skbs

James Hughes <james.hughes@raspberrypi.org>
    smsc95xx: Use skb_cow_head to deal with cloned skbs

Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
    drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Nikos Tsironis <ntsironis@arrikto.com>
    dm thin: fix bug where bio that overwrites thin block ignores FUA

Borislav Petkov <bp@suse.de>
    x86/a.out: Clear the dump structure initially

Eric W. Biederman <ebiederm@xmission.com>
    signal: Restore the stop PTRACE_EVENT_EXIT

Hedi Berriche <hedi.berriche@hpe.com>
    x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Andreas Ziegler <andreas.ziegler@fau.de>
    tracing/uprobes: Fix output for multiple string arguments

Meelis Roos <mroos@linux.ee>
    alpha: Fix Eiger NR_IRQS to 128

Sergei Trofimovich <slyfox@gentoo.org>
    alpha: fix page fault handling for r16-r18 targets

Matti Kurkela <Matti.Kurkela@iki.fi>
    Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Jonathan Bakker <xc-racer2@live.ca>
    Input: bma150 - register input device after setting private data

Xiaoyao Li <xiaoyao.li@linux.intel.com>
    kvm: vmx: Fix entry number check for add_atomic_switch_msr()

Manuel Reinhardt <manuel.rhdt@gmail.com>
    ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Jurica Vukadin <jurica.vukadin@rt-rk.com>
    ALSA: hda - Add quirk for HP EliteBook 840 G5

Jiri Olsa <jolsa@redhat.com>
    perf/x86: Add check_period PMU callback

Ingo Molnar <mingo@kernel.org>
    perf/core: Fix impossible ring-buffer sizes warning

Mauro Ciancio <mauro@acadeu.com>
    Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"

Milian Wolff <milian.wolff@kdab.com>
    perf report: Include partial stacks unwound with libdw

Ross Lagerwall <ross.lagerwall@citrix.com>
    cifs: Limit memory used by lock request calls to a page

Nicholas Mc Guire <hofrat@osadl.org>
    gpio: pl061: handle failed allocations

Linus Walleij <linus.walleij@linaro.org>
    ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-lcdk: Correct the sound card name

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: da850-evm: Correct the sound card name

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: fix output H/V syncs

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: reject modes which require too much BW

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: fix single lane configuration

Tomi Valkeinen <tomi.valkeinen@ti.com>
    drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE

Sudeep Holla <sudeep.holla@arm.com>
    cpufreq: check if policy is inactive early in __cpufreq_get()

Chao Fan <fanc.fnst@cn.fujitsu.com>
    ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Daniel Axtens <dja@axtens.net>
    bnx2x: disable GSO where gso_size is too big for hardware

Daniel Axtens <dja@axtens.net>
    net: create skb_gso_validate_mac_len()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: fix the cockup in the previous patch

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: ensure that processor vtables is not lost after boot

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: per-CPU vtables to work around big.Little systems

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: add PROC_VTABLE and PROC_TABLE macros

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: clean up per-processor check_bugs method call

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: split out processor lookup

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: make lookup_processor_type() non-__init

Julien Thierry <julien.thierry@arm.com>
    ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

Julien Thierry <julien.thierry@arm.com>
    ARM: 8797/1: spectre-v1.1: harden __copy_to_user

Julien Thierry <julien.thierry@arm.com>
    ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization

Julien Thierry <julien.thierry@arm.com>
    ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()

Julien Thierry <julien.thierry@arm.com>
    ARM: 8794/1: uaccess: Prevent speculative use of the current addr_limit

Julien Thierry <julien.thierry@arm.com>
    ARM: 8793/1: signal: replace __put_user_error with __put_user

Julien Thierry <julien.thierry@arm.com>
    ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()

Julien Thierry <julien.thierry@arm.com>
    ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state

Julien Thierry <julien.thierry@arm.com>
    ARM: 8789/1: signal: copy registers using __copy_to_user()

Hauke Mehrtens <hauke@hauke-m.de>
    uapi/if_ether.h: prevent redefinition of struct ethhdr

Adrian Bunk <bunk@kernel.org>
    eeprom: at24: add support for 24c2048

Adrian Bunk <bunk@kernel.org>
    dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string


-------------

Diffstat:

 .../devicetree/bindings/eeprom/eeprom.txt          |  5 +-
 Makefile                                           |  4 +-
 arch/alpha/include/asm/irq.h                       |  6 +-
 arch/alpha/mm/fault.c                              |  2 +-
 arch/arm/boot/dts/da850-evm.dts                    |  2 +-
 arch/arm/boot/dts/da850-lcdk.dts                   |  2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  4 +-
 arch/arm/include/asm/assembler.h                   | 11 ++++
 arch/arm/include/asm/cputype.h                     |  1 +
 arch/arm/include/asm/proc-fns.h                    | 61 +++++++++++++++----
 arch/arm/include/asm/thread_info.h                 |  4 +-
 arch/arm/include/asm/uaccess.h                     | 49 +++++++++++++--
 arch/arm/kernel/bugs.c                             |  4 +-
 arch/arm/kernel/head-common.S                      |  6 +-
 arch/arm/kernel/setup.c                            | 40 ++++++++-----
 arch/arm/kernel/signal.c                           | 70 ++++++++++++----------
 arch/arm/kernel/smp.c                              | 32 ++++++++++
 arch/arm/kernel/sys_oabi-compat.c                  |  8 ++-
 arch/arm/lib/copy_from_user.S                      |  6 +-
 arch/arm/lib/copy_to_user.S                        |  6 +-
 arch/arm/lib/uaccess_with_memcpy.c                 |  3 +-
 arch/arm/mach-integrator/impd1.c                   |  6 +-
 arch/arm/mm/proc-macros.S                          | 10 ++++
 arch/arm/mm/proc-v7-bugs.c                         | 17 +-----
 arch/arm/vfp/vfpmodule.c                           | 20 +++----
 arch/x86/events/core.c                             | 14 +++++
 arch/x86/events/intel/core.c                       |  9 +++
 arch/x86/events/perf_event.h                       | 16 ++++-
 arch/x86/ia32/ia32_aout.c                          |  6 +-
 arch/x86/include/asm/uv/bios.h                     |  8 ++-
 arch/x86/kvm/vmx.c                                 |  3 +-
 arch/x86/platform/uv/bios_uv.c                     | 23 ++++++-
 drivers/acpi/numa.c                                |  6 +-
 drivers/cpufreq/cpufreq.c                          |  7 +--
 drivers/firmware/efi/runtime-wrappers.c            |  7 +++
 drivers/gpu/drm/bridge/tc358767.c                  | 41 ++++++++++---
 drivers/gpu/drm/i915/i915_gem.c                    | 12 +++-
 drivers/input/misc/bma150.c                        |  9 +--
 drivers/input/mouse/elan_i2c_core.c                |  2 +-
 drivers/input/mouse/elantech.c                     |  9 +++
 drivers/md/dm-thin.c                               | 55 +++++++++++++++--
 drivers/misc/eeprom/Kconfig                        |  2 +-
 drivers/misc/eeprom/at24.c                         |  1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 18 ++++++
 drivers/net/usb/ch9200.c                           |  9 +--
 drivers/net/usb/kaweth.c                           | 18 ++----
 drivers/net/usb/smsc95xx.c                         | 12 ++--
 drivers/pinctrl/qcom/pinctrl-msm.c                 | 23 +++++--
 drivers/usb/dwc2/hcd.c                             |  1 -
 fs/cifs/file.c                                     |  8 +++
 fs/cifs/smb2file.c                                 |  4 ++
 include/linux/perf_event.h                         |  5 ++
 include/linux/skbuff.h                             | 16 +++++
 include/net/netfilter/nf_tables.h                  | 29 +++++++++
 include/uapi/linux/if_ether.h                      |  3 +
 include/uapi/linux/libc-compat.h                   |  6 ++
 kernel/events/core.c                               | 16 +++++
 kernel/events/ring_buffer.c                        |  2 +-
 kernel/signal.c                                    |  7 ++-
 kernel/trace/trace_uprobe.c                        |  9 ++-
 mm/memory.c                                        | 21 +++++--
 net/core/skbuff.c                                  | 63 +++++++++++++++----
 net/ipv4/netfilter/nft_masq_ipv4.c                 |  8 +--
 net/ipv4/netfilter/nft_redir_ipv4.c                |  8 +--
 net/ipv6/netfilter/nft_masq_ipv6.c                 |  8 +--
 net/ipv6/netfilter/nft_redir_ipv6.c                |  8 +--
 net/netfilter/nft_ct.c                             | 10 ++--
 net/netfilter/nft_meta.c                           | 42 ++++++-------
 net/netfilter/nft_nat.c                            |  8 +--
 net/sched/sch_tbf.c                                | 10 ----
 sound/pci/hda/patch_conexant.c                     |  1 +
 sound/usb/pcm.c                                    |  9 ++-
 tools/perf/util/unwind-libdw.c                     |  2 +-
 73 files changed, 725 insertions(+), 268 deletions(-)


