Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784BC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0167C217BF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0167C217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbeHDLCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:02:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48204 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbeHDLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:02:54 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 12EB489C;
        Sat,  4 Aug 2018 09:02:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.17 00/31] 4.17.13-stable review
Date:   Sat,  4 Aug 2018 11:00:35 +0200
Message-Id: <20180804082632.304529527@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.13-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.17.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.17.13-rc1
X-KernelTest-Deadline: 2018-08-06T08:26+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.17.13 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Aug  6 08:26:21 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.17.13-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.17.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.17.13-rc1

Tony Battersby <tonyb@cybernetics.com>
    scsi: sg: fix minor memory leak in error path

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/atomic: Initialize variables in drm_atomic_helper_async_check() to make gcc happy

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/atomic: Check old_plane_state->crtc in drm_atomic_helper_async_check()

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar formats

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: padlock-aes - Fix Nano workaround data corruption

Jack Morgenstein <jackm@dev.mellanox.co.il>
    RDMA/uverbs: Expand primary and alt AV port checks

Rafał Miłecki <rafal@milecki.pl>
    brcmfmac: fix regression in parsing NVRAM for multiple devices

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: add more card IDs for 9000 series

Mike Rapoport <rppt@linux.vnet.ibm.com>
    userfaultfd: remove uffd flags from vma->vm_flags if UFFD_EVENT_FORK fails

Jane Chu <jane.chu@oracle.com>
    ipc/shm.c add ->pagesize function to shm_vm_ops

Yi Wang <wang.yi59@zte.com.cn>
    audit: fix potential null dereference 'context->module.name'

Roman Kagan <rkagan@virtuozzo.com>
    kvm: x86: vmx: fix vpid leak

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Remove %ebx handling from error_entry/exit

Len Brown <len.brown@intel.com>
    x86/apic: Future-proof the TSC_DEADLINE quirk for SKX

Brijesh Singh <brijesh.singh@amd.com>
    x86/efi: Access EFI MMIO data as unencrypted when SEV is active

Jiang Biao <jiang.biao2@zte.com.cn>
    virtio_balloon: fix another race between migration and ballooning

Jeremy Cline <jcline@redhat.com>
    net: socket: Fix potential spectre v1 gadget in sock_is_registered

Jeremy Cline <jcline@redhat.com>
    net: socket: fix potential spectre v1 gadget in socketcall

Anton Vasilyev <vasilyev@ispras.ru>
    can: ems_usb: Fix memory leak on ems_usb_disconnect()

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardenings

Linus Torvalds <torvalds@linux-foundation.org>
    squashfs: more metadata hardening

Feras Daoud <ferasda@mellanox.com>
    net/mlx5e: IPoIB, Set the netdevice sw mtu in ipoib enhanced flow

Or Gerlitz <ogerlitz@mellanox.com>
    net/mlx5e: Set port trust mode to PCP as default

Eli Cohen <eli@mellanox.com>
    net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager

YueHaibing <yuehaibing@huawei.com>
    rxrpc: Fix user call ID check in rxrpc_service_prealloc_one

Jose Abreu <Jose.Abreu@synopsys.com>
    net: stmmac: Fix WoL for PCI-based setups

Jeremy Cline <jcline@redhat.com>
    netlink: Fix spectre v1 gadget in netlink_create()

Florian Fainelli <f.fainelli@gmail.com>
    net: dsa: Do not suspend/resume closed slave_dev

Eric Dumazet <edumazet@google.com>
    ipv4: frags: handle possible skb truesize change

Eric Dumazet <edumazet@google.com>
    inet: frag: enforce memory limits earlier

Eric Dumazet <edumazet@google.com>
    bonding: avoid lockdep confusion in bond_get_stats()


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/x86/entry/entry_64.S                          | 18 ++----
 arch/x86/kernel/apic/apic.c                        |  3 +
 arch/x86/kvm/vmx.c                                 |  7 +--
 arch/x86/platform/efi/efi_64.c                     |  2 +-
 drivers/crypto/padlock-aes.c                       |  8 ++-
 drivers/gpu/drm/drm_atomic_helper.c                |  8 ++-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  3 +
 drivers/infiniband/core/uverbs_cmd.c               | 59 ++++++++++++++++--
 drivers/net/bonding/bond_main.c                    | 14 ++++-
 drivers/net/can/usb/ems_usb.c                      |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  4 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   | 40 ++++++++++++-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |  3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c      | 69 ++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  5 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 22 +++++++
 drivers/scsi/sg.c                                  |  1 +
 drivers/virtio/virtio_balloon.c                    |  2 +
 fs/squashfs/block.c                                |  2 +
 fs/squashfs/fragment.c                             | 13 ++--
 fs/squashfs/squashfs_fs_sb.h                       |  1 +
 fs/squashfs/super.c                                |  5 +-
 fs/userfaultfd.c                                   |  4 +-
 ipc/shm.c                                          | 12 ++++
 kernel/auditsc.c                                   | 13 ++--
 mm/hugetlb.c                                       |  7 +++
 net/dsa/slave.c                                    |  6 ++
 net/ipv4/inet_fragment.c                           |  6 +-
 net/ipv4/ip_fragment.c                             |  5 ++
 net/netlink/af_netlink.c                           |  2 +
 net/rxrpc/call_accept.c                            |  4 +-
 net/socket.c                                       |  5 +-
 35 files changed, 309 insertions(+), 55 deletions(-)


