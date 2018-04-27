Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840599-2-12980356595254692962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840598; b=YPlW5Y+kSryv1xNkobYBznbz1xzk7Ubjb+lpyISF8UEC+t3qKf
    9FuoH4yc9XW6M1kV/eXFn1QgeTQyxEH4ZeXb62TSqXE6QN3s5JAMSk3/EfBUwLy1
    tFaKBL9KHkmygz0VQpMGkAO6ZVbiLb3GgNQ6+cm7FBNGneIJTxGhSppP7/3rMr1y
    xUJZylidVCjF/uHPYVACdrTD5meFhbmto21ne2HFAfQvCxKGN+GdWpN6ty0h96od
    xp9fTrI7pWy0bvOBlgTS0i7IgrFFohWxI24mCyJpnfbRj91Edyr4zXIQ+PD/uEAa
    DynUrUqQLEjHLR9NWKjiDCOp/ZMp9mFiureA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524840598; bh=Eo1fj8ZuSCbihP5+G6MmVj6G5Uckio
    DyB5R+81ecbss=; b=iNLyV8MIOFudhzjwLbDQJST/bvTp4ipwCQynG41p4d/cPh
    Wd1QTc23essLu2GJQJHWQxUoq+qTH1f1c8Ev7OqVGwTThKRx5I9npnjqXTh10X/B
    MOWBgxWWpCm/6RhrJol/Y9SCr6Wia+gWksyDZF2yMjpLfq6/fi9Ij0I5u7aH8lb2
    pK5VLqd2GGgWsFaW9h9W880yT9viOrKA71TZO2LUoV0+TUl/uS5D3da02QGQKJKE
    UnbZLru49Afnnk8TnjDuIF+jUrbN3axiPMSCFwDC2eLjXxAk8Ox+H+8YJet5whvT
    I4UgPymjHgjg5qVFcrzue/0yFlF8XpFkULMRmCWw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDoMQdC6p0KuYgkiNZoubOJ1vksjgvEKKe8TjM0BMg5om+ZBoojEtrkl74rsOrMCQ+I4jlEJP9geCKXYhWJMktysUpvJrctndW/0JXMSS1cDmGCG8M/g
    KNYKnYj9T8yu4cdlyl528GdCybYFpHoPuRsltsKNIovn+7j85DKRmus2As1OJmuWpWY04hCYtPnW7qYkVh4vUKySM1L+6rL5f1NPeZHoMbP/7aR0AGTwQhOK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=D2BsPUkyXeIA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8
    a=VnNF1IyMAAAA:8 a=8981fWPbAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
    a=NXpJzYs8AAAA:8 a=Am4ss40yAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
    a=A7XncKjpAAAA:8 a=FOH2dFAWAAAA:8 a=zd2uoN0lAAAA:8 a=Qm8iP6mkAAAA:8
    a=LpQP-O61AAAA:8 a=bLk-5xynAAAA:8 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8
    a=mT4Y2u3Bp3NkwwBF6AMA:9 a=8pUw9mH_iePn_u_Y:21 a=hEOi9J431UnMkSya:21
    a=QEXdDO2ut3YA:10 a=opcdESBofxgA:10 a=6qWyXf6x9aoA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=o72u2rHnfW5qNJ_4I8LD:22
    a=cwV61pgf2j4Cq8VD9hE_:22 a=lf-hbUz_c89dky27wAWH:22 a=cvBusfyB2V15izCimMoJ:22
    a=R9rPLQDAdC6-Ub70kJmZ:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=kDhhxE42lZnxL3pOKqYK:22
    a=pioyyrs4ZptJ924tMmac:22 a=zSyb8xVVt2t83sZkrLMb:22 a=IawgGOuG5U0WyFbmm1f5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934376AbeD0Otg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934300AbeD0OH3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44F6218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/80] 4.14.38-stable review
Date: Fri, 27 Apr 2018 15:57:53 +0200
Message-Id: <20180427135732.928644313@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.38-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.38-rc1
X-KernelTest-Deadline: 2018-04-29T13:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.38 release.
There are 80 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr 29 13:57:13 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.38-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.38-rc1

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Only default only_lcd to true on Win8-ready _desktops_

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/uprobes: implement arch_uretprobe_is_alive()

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix IO error for newly defined devices

Sebastian Ott <sebott@linux.ibm.com>
    s390/cio: update chpid descriptor after resource accessibility event

Peter Xu <peterx@redhat.com>
    tracing: Fix missing tab for hwlat_detector print format

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Fix IO error at end of medium

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Fix array bounds check

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Select appropriate drive on device open

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Rename macros to avoid inconsistent inverted logic

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Remove extra put_disk() call from error path

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Don't log an error message for an invalid ioctl

Finn Thain <fthain@telegraphics.com.au>
    block/swim: Check drive type

Finn Thain <fthain@telegraphics.com.au>
    m68k/mac: Don't remap SWIM MMIO region

Robert Kolchmeyer <rkolchmeyer@google.com>
    fsnotify: Fix fsnotify_mark_connector race

Dan Carpenter <dan.carpenter@oracle.com>
    cdrom: information leak in cdrom_ioctl_media_changed()

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: mptsas: Disable WRITE SAME

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    commoncap: Handle memory allocation failure.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "mm/hmm: fix header file if/else/endif maze"

Klaus Goger <klaus.goger@theobroma-systems.com>
    arm64: dts: rockchip: remove vdd_log from rk3399-puma

Michal Simek <michal.simek@xilinx.com>
    microblaze: Setup dependencies for ASM optimized lib functions

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct module section names for expoline code revert

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct nospec auto detection init order

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add sysfs attributes for spectre

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: report spectre mitigation via syslog

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add automatic detection of the spectre defense

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move nobp parameter functions to nospec-branch.c

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/entry.S: fix spurious zeroing of r0

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: do not bypass BPENTER for interrupt system calls

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)

Martin Schwidefsky <schwidefsky@de.ibm.com>
    KVM: s390: force bp isolation for VSIE

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: introduce execute-trampolines for branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: run user space and KVM guests with modified branch prediction

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add options to change branch prediction behaviour for the kernel

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/alternative: use a copy of the facility bit mask

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add optimized array_index_mask_nospec

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: scrub registers on kernel entry and KVM exit

Martin Schwidefsky <schwidefsky@de.ibm.com>
    KVM: s390: wire up bpb feature

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: enable CPU alternatives unconditionally

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: introduce CPU alternatives

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "microblaze: fix endian handling"

Michael S. Tsirkin <mst@redhat.com>
    virtio_net: fix adding vids on big-endian

Michael S. Tsirkin <mst@redhat.com>
    virtio_net: split out ctrl buffer

Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
    net: ethernet: ti: cpsw: fix tx vlan priority mapping

Cong Wang <xiyou.wangcong@gmail.com>
    llc: fix NULL pointer deref for SOCK_ZAPPED

Cong Wang <xiyou.wangcong@gmail.com>
    llc: hold llc_sap before release_sock()

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: check on metadata length

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: handle malformed tlv length

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: clear tp->packets_out when purging write queue

Alexander Aring <aring@mojatatu.com>
    net: sched: ife: signal not finding metaid

Doron Roberts-Kedes <doronrk@fb.com>
    strparser: Fix incorrect strp->need_bytes value.

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Only use the SFP supported transceiver signals

Doron Roberts-Kedes <doronrk@fb.com>
    strparser: Do not call mod_delayed_work with a timeout of LONG_MAX

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Improve KR auto-negotiation and training

Xin Long <lucien.xin@gmail.com>
    sctp: do not check port in sctp_inet6_cmp_addr

Tom Lendacky <thomas.lendacky@amd.com>
    amd-xgbe: Add pre/post auto-negotiation phy hooks

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Guillaume Nault <g.nault@alphalink.fr>
    pppoe: check sockaddr length in pppoe_connect()

Eric Dumazet <edumazet@google.com>
    tipc: add policy for TIPC_NLA_NET_ADDR

Willem de Bruijn <willemb@google.com>
    packet: fix bitfield update race

Xin Long <lucien.xin@gmail.com>
    team: fix netconsole setup over team

Ursula Braun <ubraun@linux.vnet.ibm.com>
    net/smc: fix shutdown in state SMC_LISTEN

Paolo Abeni <pabeni@redhat.com>
    team: avoid adding twice the same option to the event list

Wolfgang Bumiller <w.bumiller@proxmox.com>
    net: fix deadlock while clearing neighbor proxy table

Eric Dumazet <edumazet@google.com>
    tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets

Eric Dumazet <edumazet@google.com>
    net: af_packet: fix race in PACKET_{R|T}X_RING

Jann Horn <jannh@google.com>
    tcp: don't read out-of-bounds opsize

Cong Wang <xiyou.wangcong@gmail.com>
    llc: delete timers synchronously in llc_sk_free()

Eric Dumazet <edumazet@google.com>
    net: validate attribute sizes in neigh_dump_table()

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: check sockaddr length in pppol2tp_connect()

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: limit the length of option strings

Ahmed Abdelsalam <amsalam20@gmail.com>
    ipv6: sr: fix NULL pointer dereference in seg6_do_srh_encap()- v4 pkts

Eric Dumazet <edumazet@google.com>
    ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Xin Long <lucien.xin@gmail.com>
    bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    Revert "ath10k: send (re)assoc peer command when NSS changed"

James Bottomley <James.Bottomley@HansenPartnership.com>
    tpm: add retry logic

Winkler, Tomas <tomas.winkler@intel.com>
    tpm: tpm-interface: fix tpm_transmit/_cmd kdoc

Tomas Winkler <tomas.winkler@intel.com>
    tpm: cmd_ready command can be issued only after granting locality

Paweł Jabłoński <pawel.jablonski@intel.com>
    i40e: Fix attach VF to VM issue

Neil Armstrong <narmstrong@baylibre.com>
    drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "pinctrl: intel: Initialize GPIO properly when used through irqchip"


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Makefile                                           |   4 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  11 -
 arch/microblaze/Kconfig.platform                   |   1 +
 arch/microblaze/Makefile                           |  17 +-
 arch/microblaze/lib/fastcopy.S                     |   4 -
 arch/s390/Kconfig                                  |  47 ++++
 arch/s390/Makefile                                 |  10 +
 arch/s390/include/asm/alternative.h                | 149 ++++++++++++
 arch/s390/include/asm/barrier.h                    |  24 ++
 arch/s390/include/asm/facility.h                   |  18 ++
 arch/s390/include/asm/kvm_host.h                   |   3 +-
 arch/s390/include/asm/lowcore.h                    |   7 +-
 arch/s390/include/asm/nospec-branch.h              |  17 ++
 arch/s390/include/asm/processor.h                  |   4 +
 arch/s390/include/asm/thread_info.h                |   4 +
 arch/s390/include/uapi/asm/kvm.h                   |   5 +-
 arch/s390/kernel/Makefile                          |   6 +-
 arch/s390/kernel/alternative.c                     | 112 +++++++++
 arch/s390/kernel/early.c                           |   5 +
 arch/s390/kernel/entry.S                           | 250 ++++++++++++++++++---
 arch/s390/kernel/ipl.c                             |   1 +
 arch/s390/kernel/module.c                          |  65 +++++-
 arch/s390/kernel/nospec-branch.c                   | 169 ++++++++++++++
 arch/s390/kernel/processor.c                       |  18 ++
 arch/s390/kernel/setup.c                           |  14 +-
 arch/s390/kernel/smp.c                             |   7 +-
 arch/s390/kernel/uprobes.c                         |   9 +
 arch/s390/kernel/vmlinux.lds.S                     |  37 +++
 arch/s390/kvm/kvm-s390.c                           |  12 +
 arch/s390/kvm/vsie.c                               |  30 +++
 drivers/acpi/acpi_video.c                          |  27 ++-
 drivers/block/swim.c                               |  49 ++--
 drivers/block/swim3.c                              |   6 +-
 drivers/cdrom/cdrom.c                              |   2 +-
 drivers/char/tpm/tpm-interface.c                   | 131 ++++++++---
 drivers/char/tpm/tpm.h                             |   1 +
 drivers/char/tpm/tpm_crb.c                         | 108 ++++++---
 drivers/char/tpm/tpm_tis_core.c                    |   4 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   3 +
 drivers/message/fusion/mptsas.c                    |   1 +
 drivers/net/bonding/bond_main.c                    |   3 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   8 +
 drivers/net/ethernet/amd/xgbe/xgbe-debugfs.c       |  16 ++
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |   1 +
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c          |  24 +-
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c           |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        | 196 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h               |   9 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  11 +
 drivers/net/ethernet/ti/cpsw.c                     |   2 +-
 drivers/net/ppp/pppoe.c                            |   4 +
 drivers/net/team/team.c                            |  38 +++-
 drivers/net/virtio_net.c                           |  68 +++---
 drivers/net/wireless/ath/ath10k/mac.c              |   5 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |  23 +-
 drivers/s390/block/dasd_alias.c                    |  13 +-
 drivers/s390/char/Makefile                         |   2 +
 drivers/s390/cio/chsc.c                            |  14 +-
 include/linux/fsnotify_backend.h                   |   4 +-
 include/linux/hmm.h                                |   9 +-
 include/linux/if_vlan.h                            |   7 +-
 include/linux/tpm.h                                |   2 +-
 include/net/ife.h                                  |   3 +-
 include/net/llc_conn.h                             |   1 +
 include/net/tcp.h                                  |   1 +
 include/uapi/linux/kvm.h                           |   1 +
 kernel/trace/trace_entries.h                       |   2 +-
 net/core/dev.c                                     |   2 +-
 net/core/neighbour.c                               |  40 ++--
 net/dns_resolver/dns_key.c                         |  13 +-
 net/ife/ife.c                                      |  38 +++-
 net/ipv4/tcp.c                                     |   7 +-
 net/ipv4/tcp_input.c                               |   7 +-
 net/ipv6/route.c                                   |   2 +
 net/ipv6/seg6_iptunnel.c                           |   2 +-
 net/l2tp/l2tp_ppp.c                                |   7 +
 net/llc/af_llc.c                                   |  14 +-
 net/llc/llc_c_ac.c                                 |   9 +-
 net/llc/llc_conn.c                                 |  22 +-
 net/packet/af_packet.c                             |  83 ++++---
 net/packet/internal.h                              |  10 +-
 net/sched/act_ife.c                                |   9 +-
 net/sctp/ipv6.c                                    |  60 ++---
 net/smc/af_smc.c                                   |  10 +-
 net/strparser/strparser.c                          |   9 +-
 net/tipc/netlink.c                                 |   3 +-
 security/commoncap.c                               |   2 +
 88 files changed, 1842 insertions(+), 371 deletions(-)
