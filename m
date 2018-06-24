Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36A6C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCAE24FC6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCAE24FC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbeFXPbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:31:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbeFXPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:31:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 26C7D2C;
        Sun, 24 Jun 2018 15:31:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/64] 4.16.18-stable review
Date:   Sun, 24 Jun 2018 23:21:41 +0800
Message-Id: <20180624142743.613370789@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.18-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.18-rc1
X-KernelTest-Deadline: 2018-06-26T14:27+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----------------
NOTE: This will be the last 4.16.y release.  After this release, this
tree will be end-of-life.  You should have moved to the 4.17.y tree by
now.
----------------

This is the start of the stable review cycle for the 4.16.18 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Jun 26 14:27:22 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.18-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.18-rc1

Vlastimil Babka <vbabka@suse.cz>
    mm, page_alloc: do not break __GFP_THISNODE by zonelist reset

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    fs/binfmt_misc.c: do not allow offset overflow

Michael S. Tsirkin <mst@redhat.com>
    vhost: fix info leak due to uninitialized memory

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Correct logical maximum Y for 2nd-gen Intuos Pro large

Even Xu <even.xu@intel.com>
    HID: intel_ish-hid: ipc: register more pm callbacks to support hibernation

Martin Brandenburg <martin@omnibond.com>
    orangefs: report attributes_mask and attributes for statx

Martin Brandenburg <martin@omnibond.com>
    orangefs: set i_size on new symlink

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: fw: harden page loading code

Tony Luck <tony.luck@intel.com>
    x86/intel_rdt: Enable CMT and MBM on new Skylake stepping

Thomas Gleixner <tglx@linutronix.de>
    genirq/migration: Avoid out of line call if pending is not set

Thomas Gleixner <tglx@linutronix.de>
    genirq/affinity: Defer affinity setting if irq chip is busy

Thomas Gleixner <tglx@linutronix.de>
    genirq/generic_pending: Do not lose pending affinity update

Thomas Gleixner <tglx@linutronix.de>
    irq_remapping: Use apic_ack_irq()

Thomas Gleixner <tglx@linutronix.de>
    x86/platform/uv: Use apic_ack_irq()

Thomas Gleixner <tglx@linutronix.de>
    x86/ioapic: Use apic_ack_irq()

Thomas Gleixner <tglx@linutronix.de>
    x86/apic: Provide apic_ack_irq()

Thomas Gleixner <tglx@linutronix.de>
    x86/apic/vector: Prevent hlist corruption and leaks

Dou Liyang <douly.fnst@cn.fujitsu.com>
    x86/vector: Fix the args of vector_alloc tracepoint

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Keith Busch <keith.busch@intel.com>
    nvme/pci: Sync controller reset for AER slot_reset

Hans de Goede <hdegoede@redhat.com>
    libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Dan Carpenter <dan.carpenter@oracle.com>
    libata: zpodd: small read overflow in eject_tray()

Chen Yu <yu.c.chen@intel.com>
    cpufreq: governors: Fix long idle detection logic in load calculation

Suman Anna <s-anna@ti.com>
    cpufreq: ti-cpufreq: Fix an incorrect error return value

Tao Wang <kevin.wangtao@hisilicon.com>
    cpufreq: Fix new policy initialization during limits updates via sysfs

Tejun Heo <tj@kernel.org>
    bdi: Move cgroup bdi_writeback to a dedicated low concurrency workqueue

Roman Pen <roman.penyaev@profitbricks.com>
    blk-mq: reinit q->tag_set_list entry only after grace period

Josef Bacik <jbacik@fb.com>
    nbd: use bd_set_size when updating disk size

Josef Bacik <jbacik@fb.com>
    nbd: update size when connected

Josef Bacik <jbacik@fb.com>
    nbd: fix nbd device deletion

Shirish Pargaonkar <shirishpargaonkar@gmail.com>
    cifs: For SMB2 security informaion query, check for minimum sized security descriptor instead of sizeof FileAllInformation class

Mark Syms <mark.syms@citrix.com>
    CIFS: 511c54a2f69195b28afb9dd119f03787b1625bb4 adds a check for session expiry

Steve French <stfrench@microsoft.com>
    smb3: on reconnect set PreviousSessionId field

Steve French <stfrench@microsoft.com>
    smb3: fix various xid leaks

Tony Luck <tony.luck@intel.com>
    x86/MCE: Fix stack out-of-bounds write in mce-inject.c: Flags_read()

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G4

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 830 G5

Bo Chen <chenbo@pdx.edu>
    ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/conexant - Add fixup for HP Z2 G4 workstation

Hui Wang <hui.wang@canonical.com>
    ALSA: hda/realtek - Enable mic-mute hotkey for several Lenovo AIOs

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Disable the quirk for Nura headset

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: Don't use inode pages for device replace

Su Yue <suy.fnst@cn.fujitsu.com>
    btrfs: return error value if create_io_em failed in cow_file_range

Omar Sandoval <osandov@fb.com>
    Btrfs: fix memory and mount leak in btrfs_ioctl_rm_dev_v2()

Omar Sandoval <osandov@fb.com>
    Btrfs: fix clone vs chattr NODATASUM race

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    driver core: Don't ignore class_dir_create_and_add() failure.

Jan Kara <jack@suse.cz>
    ext4: fix fencepost error in check for inode count overflow during resize

Theodore Ts'o <tytso@mit.edu>
    ext4: correctly handle a zero-length xattr with a non-zero e_value_offs

Theodore Ts'o <tytso@mit.edu>
    ext4: bubble errors from ext4_find_inline_data_nolock() up to ext4_iget()

Theodore Ts'o <tytso@mit.edu>
    ext4: do not allow external inodes for inline data

Lukas Czerner <lczerner@redhat.com>
    ext4: update mtime in ext4_punch_hole even if no blocks are released

Jan Kara <jack@suse.cz>
    ext4: fix hole length detection in ext4_ind_map_blocks()

Daniel Borkmann <daniel@iogearbox.net>
    tls: fix use-after-free in tls_push_record

Dexuan Cui <decui@microsoft.com>
    hv_netvsc: Fix a network regression after ifdown/ifup

Willem de Bruijn <willemb@google.com>
    net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload holds vlan

Paolo Abeni <pabeni@redhat.com>
    udp: fix rx queue len reported by diag and proc interface

Cong Wang <xiyou.wangcong@gmail.com>
    socket: close race condition between sock_close() and sockfs_setattr()

Frank van der Linden <fllinden@amazon.com>
    tcp: verify the checksum of the first data segment in a new connection

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_simple: fix parsing of TCA_DEF_DATA

Alvaro Gamez Machado <alvaro.gamez@hazent.com>
    net: phy: dp83822: use BMCR_ANENABLE instead of BMSR_ANEGCAPABLE for DP83620

Zhouyang Jia <jiazhouyang09@gmail.com>
    net: dsa: add error handling for pskb_trim_rcsum

Julian Anastasov <ja@ssi.bg>
    ipv6: allow PMTU exceptions to local routes

Bjørn Mork <bjorn@mork.no>
    cdc_ncm: avoid padding beyond end of skb

Xiangning Yu <yuxiangning@gmail.com>
    bonding: re-evaluate force_primary when the primary slave name changes


-------------

Diffstat:

 Makefile                                       |  4 +-
 arch/x86/include/asm/apic.h                    |  2 +
 arch/x86/include/asm/trace/irq_vectors.h       |  2 +-
 arch/x86/kernel/apic/io_apic.c                 |  2 +-
 arch/x86/kernel/apic/vector.c                  | 18 ++++++-
 arch/x86/kernel/cpu/intel_rdt.c                |  2 +
 arch/x86/kernel/cpu/mcheck/mce-inject.c        |  2 +-
 arch/x86/platform/uv/uv_irq.c                  |  7 +--
 block/blk-mq.c                                 |  3 +-
 drivers/ata/libata-core.c                      |  3 --
 drivers/ata/libata-zpodd.c                     |  2 +-
 drivers/base/core.c                            | 14 +++++-
 drivers/block/nbd.c                            | 17 ++++++-
 drivers/cpufreq/cpufreq.c                      |  2 +
 drivers/cpufreq/cpufreq_governor.c             | 12 ++---
 drivers/cpufreq/ti-cpufreq.c                   |  2 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c        | 22 +++------
 drivers/hid/wacom_sys.c                        |  8 +++
 drivers/iommu/amd_iommu.c                      |  2 +-
 drivers/iommu/intel_irq_remapping.c            |  2 +-
 drivers/iommu/irq_remapping.c                  |  5 --
 drivers/iommu/irq_remapping.h                  |  2 -
 drivers/net/bonding/bond_options.c             |  1 +
 drivers/net/hyperv/netvsc_drv.c                |  4 +-
 drivers/net/phy/dp83848.c                      | 35 ++++++++++---
 drivers/net/tap.c                              |  5 +-
 drivers/net/tun.c                              |  3 +-
 drivers/net/usb/cdc_ncm.c                      |  4 +-
 drivers/net/virtio_net.c                       |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c | 49 ++++++++++++++++---
 drivers/nvme/host/pci.c                        | 11 ++++-
 drivers/vhost/vhost.c                          |  3 ++
 drivers/w1/masters/mxc_w1.c                    | 20 +++++---
 fs/binfmt_misc.c                               | 12 +++--
 fs/btrfs/inode.c                               |  4 +-
 fs/btrfs/ioctl.c                               | 18 ++++---
 fs/btrfs/scrub.c                               |  2 +-
 fs/cifs/cifsacl.h                              | 14 ++++++
 fs/cifs/smb2ops.c                              | 68 ++++++++++++++++++--------
 fs/cifs/smb2pdu.c                              |  4 +-
 fs/ext4/indirect.c                             | 14 ++++--
 fs/ext4/inline.c                               |  6 +++
 fs/ext4/inode.c                                | 46 +++++++++--------
 fs/ext4/resize.c                               |  2 +-
 fs/ext4/xattr.c                                |  2 +-
 fs/orangefs/inode.c                            |  7 +++
 fs/orangefs/namei.c                            |  7 +++
 include/linux/irq.h                            |  7 ++-
 include/linux/virtio_net.h                     | 11 ++---
 include/net/transp_v6.h                        | 11 ++++-
 include/net/udp.h                              |  5 ++
 kernel/irq/manage.c                            | 37 +++++++++++++-
 kernel/irq/migration.c                         | 31 +++++++-----
 mm/backing-dev.c                               | 18 ++++++-
 mm/page_alloc.c                                |  1 -
 net/dsa/tag_trailer.c                          |  3 +-
 net/ipv4/tcp_ipv4.c                            |  4 ++
 net/ipv4/udp.c                                 |  2 +-
 net/ipv4/udp_diag.c                            |  2 +-
 net/ipv6/datagram.c                            |  6 +--
 net/ipv6/route.c                               |  3 --
 net/ipv6/tcp_ipv6.c                            |  4 ++
 net/ipv6/udp.c                                 |  3 +-
 net/packet/af_packet.c                         |  4 +-
 net/sched/act_simple.c                         | 15 +++---
 net/socket.c                                   | 18 +++++--
 net/tls/tls_sw.c                               | 26 +++++-----
 sound/pci/hda/hda_controller.c                 |  4 +-
 sound/pci/hda/patch_conexant.c                 |  3 ++
 sound/pci/hda/patch_realtek.c                  |  6 ++-
 sound/usb/quirks-table.h                       |  5 ++
 71 files changed, 498 insertions(+), 210 deletions(-)


