Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3559911-1519410605-2-17080512240670975140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519410603; b=JzCiPJCJtX1J9/SaPE5n28ZxqbLslrJB4ssRT92SvuFNG5B
    ExtjImctPFJMFM0F9c/iI+7/5AmYWDRntq3VnJdAVAlufwlar0UOTZbp+6z8D1vu
    PHpu8XcCZJh7mcvZcCe0lsNWsxMhDE24uU9Mmccmil9TiUBO31kqdGzC/a/clEA7
    mlfDXeiHCRrpvwIWQRIWwo8uXPMymCSSh7mjADR37FZbYK3gwuUHo2VPHWOhI+3W
    OCaABqj7voUXkwU2VgrjIGIS55eCf8xCf0GNA1SR+vSN5n6ZZoA6A00nYiXy/R0K
    voezB0y0bIgViYdAddIJZ5ROZpkYcMPlpuS2q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519410603; bh=FWZXc68LuXVv9bTu3cT0z+b0jJ
    /XruYvospronvca7M=; b=GsXsrXVD2gs+QAWPrMSFLYCPaa4Endo4ltpN05JrgW
    ZBD4TYyiID9fXykVBv2qkSB0/uznE/OOlabe3WWWpyCKKygrx0YOW8U0wJLjW3MF
    pAlti7dFpKvuGT1yrivNbnzwLBjtvT4HMN6hRcmpNX3TEggK9MfzheDUTXqLtPYz
    gkeFSmP4XqcVqR2dhlcz5ruS0TQiCRKxf1pAZkK8aBegIsNGQYAjeHNeYNPJXvFj
    WvmjX8XPQN51bOu+/5cgVbS03dsoyUDcmX47RbI3qXWDs31g8x7lmDUPyFzNhFlS
    +V2+25g/EHQ6do9KGf+c132m3VuCw6bUhcOMxIZ9J1Pg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeBWSaB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:30:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeBWS37 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:29:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/58] 3.18.96-stable review
Date: Fri, 23 Feb 2018 19:25:59 +0100
Message-Id: <20180223170206.724655284@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.96-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.96-rc1
X-KernelTest-Deadline: 2018-02-25T17:02+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.96 release.
There are 58 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 25 17:01:41 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.96-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.96-rc1

Kamil Konieczny <k.konieczny@partner.samsung.com>
    crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Ready" exceptions simultaneously

Jia-Ju Bai <baijiaju1990@163.com>
    hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Jan Beulich <JBeulich@suse.com>
    xen: XEN_ACPI_PROCESSOR is Dom0-only

Karol Herbst <kherbst@redhat.com>
    x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Dave Young <dyoung@redhat.com>
    mm/early_ioremap: Fix boot hang with earlyprintk=efi,keep

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    dmaengine: jz4740: disable/unprepare clk if probe fails

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.

Takuo Koguchi <takuo.koguchi@gmail.com>
    spi: sun4i: disable clocks in the remove function

Eric Biggers <ebiggers3@gmail.com>
    509: fix printing uninitialized stack memory when OID is empty

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid illegal values

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid devision by zero

Zumeng Chen <zumeng.chen@gmail.com>
    gianfar: fix a flooded alignment reports because of padding issue.

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: prevent prefix I/O error

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    powerpc/perf: Fix oops when grouping different pmu events

Greg Ungerer <gerg@linux-m68k.org>
    m68k: add missing SOFTIRQENTRY_TEXT linker section

Will Deacon <will.deacon@arm.com>
    scripts/kernel-doc: Don't fail with status != 0 if error encountered with -none

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: s5k6aa: describe some function parameters

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    perf bench numa: Fixup discontiguous/sparse numa nodes

Jiri Olsa <jolsa@kernel.org>
    perf top: Fix window dimensions change handling

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am4372: Correct the interrupts_properties of McASP

Keerthy <j-keerthy@ti.com>
    ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Randy Dunlap <rdunlap@infradead.org>
    usb: build drivers/usb/common/ when USB_SUPPORT is set

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: keep usbip_device sockfd state in sync with tcp_socket

Paolo Abeni <pabeni@redhat.com>
    dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Arnd Bergmann <arnd@arndb.de>
    video: fbdev/mmp: add MODULE_LICENSE

Arnd Bergmann <arnd@arndb.de>
    ASoC: ux500: add MODULE_LICENSE tag

Paul Moore <paul@paul-moore.com>
    selinux: ensure the context is NUL terminated in security_context_to_sid_core()

David Howells <dhowells@redhat.com>
    Provide a function to create a NUL-terminated string from unterminated data

Willem de Bruijn <willemb@google.com>
    net: avoid skb_warn_bad_offload on IS_ERR

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Paolo Abeni <pabeni@redhat.com>
    netfilter: on sockopt() acquire sock lock only in the required scope

Dmitry Vyukov <dvyukov@google.com>
    netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()

Eric Dumazet <edumazet@google.com>
    netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}

Dmitry Vyukov <dvyukov@google.com>
    netfilter: x_tables: fix int overflow in xt_alloc_table_info()

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Add __GFP_NOWARN for system contig heap

Eric Biggers <ebiggers@google.com>
    crypto: x86/twofish-3way - Fix %rbp usage

Paul Moore <paul@paul-moore.com>
    selinux: skip bounded transition processing if the policy isn't loaded

Cong Wang <xiyou.wangcong@gmail.com>
    xfrm: check id proto in validate_tmpl()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() failed.

Arnd Bergmann <arnd@arndb.de>
    media: r820t: fix r820t_write_reg for KASAN

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: s5pv210: add interrupt-parent for ohci

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix racy pool initializations

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix crash due to not cleaning up tree log block's dirty bits

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix deadlock in run_delalloc_nocow

Nicolas Pitre <nicolas.pitre@linaro.org>
    console/dummy: leave .con_font_get set to NULL

Johan Hovold <johan@kernel.org>
    video: fbdev: atmel_lcdfb: fix display-timings lookup

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    ext4: correct documentation for grpid mount option

Zhouyi Zhou <zhouzhouyi@gmail.com>
    ext4: save error to disk in __ext4_grp_locked_error()

Julia Lawall <Julia.Lawall@lip6.fr>
    drm/radeon: adjust tested variable

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix regression by incorrect ioctl_mutex usages

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix spics gpio controller's warning

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear13xx: Fix dmas cells

Viresh Kumar <viresh.kumar@linaro.org>
    arm: spear600: Add missing interrupt-parent of rtc

Eugene Syromiatnikov <esyr@redhat.com>
    s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Bjorn Andersson <bjorn.andersson@linaro.org>
    PM / devfreq: Propagate error from devfreq_add_device()

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ETH ports


-------------

Diffstat:

 Documentation/devicetree/bindings/dma/snps-dma.txt |   2 +-
 Documentation/filesystems/ext4.txt                 |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/am4372.dtsi                      |   6 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |   1 +
 arch/arm/boot/dts/spear1310-evb.dts                |   2 +-
 arch/arm/boot/dts/spear1340.dtsi                   |   4 +-
 arch/arm/boot/dts/spear13xx.dtsi                   |   6 +-
 arch/arm/boot/dts/spear600.dtsi                    |   1 +
 arch/arm/mach-omap2/prm33xx.c                      |  12 ---
 arch/m68k/kernel/vmlinux-nommu.lds                 |   2 +
 arch/m68k/kernel/vmlinux-std.lds                   |   2 +
 arch/m68k/kernel/vmlinux-sun3.lds                  |   2 +
 arch/powerpc/perf/core-book3s.c                    |   4 +-
 arch/s390/kernel/compat_linux.c                    |   8 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       | 112 +++++++++++----------
 arch/x86/kvm/x86.c                                 |  34 +++++--
 arch/x86/mm/ioremap.c                              |   4 +-
 arch/x86/mm/kmmio.c                                |  12 ++-
 drivers/Makefile                                   |   1 +
 drivers/crypto/s5p-sss.c                           |  13 ++-
 drivers/devfreq/devfreq.c                          |   2 +-
 drivers/dma/dma-jz4740.c                           |   4 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |   2 +-
 drivers/infiniband/hw/mlx4/main.c                  |  13 +--
 drivers/media/i2c/s5k6aa.c                         |   5 +
 drivers/media/tuners/r820t.c                       |  13 ++-
 drivers/net/ethernet/freescale/gianfar.c           |   6 +-
 drivers/net/ethernet/mellanox/mlx4/qp.c            |   3 +
 drivers/net/hippi/rrunner.c                        |   2 +-
 drivers/s390/block/dasd_eckd.c                     |  16 +--
 drivers/spi/spi-sun4i.c                            |   2 +-
 drivers/staging/android/ion/ion_system_heap.c      |   2 +-
 drivers/usb/usbip/stub_dev.c                       |   3 +
 drivers/usb/usbip/vhci_hcd.c                       |   2 +
 drivers/video/console/dummycon.c                   |   1 -
 drivers/video/fbdev/atmel_lcdfb.c                  |   8 +-
 drivers/video/fbdev/mmp/core.c                     |   5 +
 drivers/xen/Kconfig                                |   2 +-
 fs/btrfs/inode.c                                   |   5 +-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/btrfs/tree-log.c                                |   9 ++
 fs/ext4/super.c                                    |   1 +
 include/linux/string.h                             |   1 +
 include/net/red.h                                  |  13 ++-
 lib/oid_registry.c                                 |   8 +-
 mm/early_ioremap.c                                 |   2 +-
 mm/util.c                                          |  24 +++++
 mm/vmscan.c                                        |   3 +
 net/core/dev.c                                     |   2 +-
 net/decnet/af_decnet.c                             |  62 ++++++------
 net/ipv4/ip_sockglue.c                             |  14 +--
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  16 ++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |   6 +-
 net/ipv6/ipv6_sockglue.c                           |  17 +---
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |  18 ++--
 net/netfilter/x_tables.c                           |  10 +-
 net/netfilter/xt_RATEEST.c                         |  22 +++-
 net/sched/sch_choke.c                              |   3 +
 net/sched/sch_gred.c                               |   3 +
 net/sched/sch_red.c                                |   2 +
 net/sched/sch_sfq.c                                |   3 +
 net/xfrm/xfrm_user.c                               |  24 +++++
 scripts/kernel-doc                                 |   2 +-
 security/selinux/ss/services.c                     |  21 ++--
 sound/core/seq/seq_clientmgr.c                     |  23 +++--
 sound/soc/ux500/mop500.c                           |   4 +
 sound/soc/ux500/ux500_pcm.c                        |   5 +
 tools/perf/bench/numa.c                            |  56 ++++++++++-
 tools/perf/builtin-top.c                           |  15 ++-
 70 files changed, 485 insertions(+), 236 deletions(-)
