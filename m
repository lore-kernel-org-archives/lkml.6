Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DDC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF19250F2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF19250F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934177AbeFXPvQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:51:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:51:14 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CF1E52C;
        Sun, 24 Jun 2018 15:51:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/39] 4.9.110-stable review
Date:   Sun, 24 Jun 2018 23:23:47 +0800
Message-Id: <20180624152352.038950449@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.110-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.110-rc1
X-KernelTest-Deadline: 2018-06-26T15:23+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.110 release.
There are 39 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Jun 26 15:23:25 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.110-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.110-rc1

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    fs/binfmt_misc.c: do not allow offset overflow

Michael S. Tsirkin <mst@redhat.com>
    vhost: fix info leak due to uninitialized memory

Even Xu <even.xu@intel.com>
    HID: intel_ish-hid: ipc: register more pm callbacks to support hibernation

Martin Brandenburg <martin@omnibond.com>
    orangefs: set i_size on new symlink

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Hans de Goede <hdegoede@redhat.com>
    libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Dan Carpenter <dan.carpenter@oracle.com>
    libata: zpodd: small read overflow in eject_tray()

Colin Ian King <colin.king@canonical.com>
    libata: zpodd: make arrays cdb static, reduces object code size

Tao Wang <kevin.wangtao@hisilicon.com>
    cpufreq: Fix new policy initialization during limits updates via sysfs

Steve French <stfrench@microsoft.com>
    smb3: on reconnect set PreviousSessionId field

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G4

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 830 G5

Bo Chen <chenbo@pdx.edu>
    ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: Don't use inode pages for device replace

Omar Sandoval <osandov@fb.com>
    Btrfs: fix memory and mount leak in btrfs_ioctl_rm_dev_v2()

Omar Sandoval <osandov@fb.com>
    Btrfs: fix clone vs chattr NODATASUM race

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    driver core: Don't ignore class_dir_create_and_add() failure.

Jan Kara <jack@suse.cz>
    ext4: fix fencepost error in check for inode count overflow during resize

Lukas Czerner <lczerner@redhat.com>
    ext4: update mtime in ext4_punch_hole even if no blocks are released

Jan Kara <jack@suse.cz>
    ext4: fix hole length detection in ext4_ind_map_blocks()

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - New codec support for ALC257

Frank van der Linden <fllinden@amazon.com>
    tcp: verify the checksum of the first data segment in a new connection

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_simple: fix parsing of TCA_DEF_DATA

Julian Anastasov <ja@ssi.bg>
    ipv6: allow PMTU exceptions to local routes

Xiangning Yu <yuxiangning@gmail.com>
    bonding: re-evaluate force_primary when the primary slave name changes

Daniel Glöckner <dg@emlix.com>
    usb: musb: fix remote wakeup racing with suspend

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: make raid6 rebuild retry more

Eric Dumazet <edumazet@google.com>
    tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Sasha Levin <Alexander.Levin@microsoft.com>
    Revert "Btrfs: fix scrub to repair raid6 corruption"

Damien Thébault <damien.thebault@vitec.com>
    net: dsa: b53: Add BCM5389 support

Finn Thain <fthain@telegraphics.com.au>
    net/sonic: Use dma_mapping_error()

João Paulo Rechi Vita <jprvita@gmail.com>
    platform/x86: asus-wmi: Fix NULL pointer dereference

Josh Hill <josh@joshuajhill.com>
    net: qmi_wwan: Add Netgear Aircard 779S

Ivan Bornyakov <brnkv.i1@gmail.com>
    atm: zatm: fix memcmp casting

Hao Wei Tee <angelsl@in04.sg>
    iwlwifi: pcie: compare with number of IRQs requested for, not number of CPUs

Julian Anastasov <ja@ssi.bg>
    ipvs: fix buffer overflow with sync daemon and service

Paolo Abeni <pabeni@redhat.com>
    netfilter: ebtables: handle string from userspace with care

Eric Dumazet <edumazet@google.com>
    xfrm6: avoid potential infinite loop in _decode_session6()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    objtool: update .gitignore file


-------------

Diffstat:

 Documentation/devicetree/bindings/net/dsa/b53.txt |  1 +
 Makefile                                          |  4 +--
 drivers/ata/libata-core.c                         |  3 --
 drivers/ata/libata-zpodd.c                        |  4 +--
 drivers/atm/zatm.c                                |  4 +--
 drivers/base/core.c                               | 14 +++++++--
 drivers/cpufreq/cpufreq.c                         |  2 ++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           | 22 +++++---------
 drivers/net/bonding/bond_options.c                |  1 +
 drivers/net/dsa/b53/b53_common.c                  | 13 ++++++++
 drivers/net/dsa/b53/b53_mdio.c                    |  5 +++-
 drivers/net/dsa/b53/b53_priv.h                    |  1 +
 drivers/net/ethernet/natsemi/sonic.c              |  2 +-
 drivers/net/usb/qmi_wwan.c                        |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   | 10 +++----
 drivers/platform/x86/asus-wmi.c                   | 23 ++++++++-------
 drivers/usb/musb/musb_host.c                      |  5 +++-
 drivers/usb/musb/musb_host.h                      |  7 +++--
 drivers/usb/musb/musb_virthub.c                   | 25 +++++++++-------
 drivers/vhost/vhost.c                             |  3 ++
 drivers/w1/masters/mxc_w1.c                       | 20 ++++++++-----
 fs/binfmt_misc.c                                  | 12 ++++++--
 fs/btrfs/ioctl.c                                  | 18 +++++++-----
 fs/btrfs/scrub.c                                  |  2 +-
 fs/cifs/smb2pdu.c                                 |  1 +
 fs/ext4/indirect.c                                | 14 ++++++---
 fs/ext4/inode.c                                   | 36 +++++++++++------------
 fs/ext4/resize.c                                  |  2 +-
 fs/orangefs/namei.c                               |  7 +++++
 net/bridge/netfilter/ebtables.c                   |  3 +-
 net/ipv4/tcp_input.c                              |  2 +-
 net/ipv4/tcp_ipv4.c                               |  4 +++
 net/ipv6/route.c                                  |  3 --
 net/ipv6/tcp_ipv6.c                               |  4 +++
 net/ipv6/xfrm6_policy.c                           |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c                    | 21 +++++++++----
 net/sched/act_simple.c                            | 15 ++++------
 sound/pci/hda/hda_controller.c                    |  4 ++-
 sound/pci/hda/patch_conexant.c                    |  2 ++
 sound/pci/hda/patch_realtek.c                     |  8 +++++
 tools/objtool/.gitignore                          |  2 +-
 41 files changed, 212 insertions(+), 120 deletions(-)


