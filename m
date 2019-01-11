Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0AFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1B421841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216210;
	bh=1wjLchIxWJ/S93ydw2SBJtSzrxnXeFzkid29tqkat/8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dRr9TblrVbZivJNFBS3jwnScHlFhsvwOrxa2DNRGoDNnxxcpkdodkn0zoPYjQXQF/
	 jbDqQGkiKXGKjnpLl8eJ5/VrEaWanH5cCehIl7eaS1R8frVVX3O75BKWZDCB2vwQ2q
	 SmXZMa9AJ74362dUg4j1GxNqysX+IHEmCWIU9SGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfAKOQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387724AbfAKOQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:16:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AC5214D8;
        Fri, 11 Jan 2019 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216205;
        bh=1wjLchIxWJ/S93ydw2SBJtSzrxnXeFzkid29tqkat/8=;
        h=From:To:Cc:Subject:Date:From;
        b=qwQiCrqvvGwTCOn9aPSunlsk4drySvD5bYefTuolx/V7T/NYmBR0DrWDZMku8VRsm
         yyq5aQALsVHJgQHzZ5IpQj/L15A5Xu5HWILoBIh1ZBmDNmXMpq+JaMFzbj5okH8OsC
         DWLhnNjvP4ejTTH9UlY6IFRGRXEdxAqStN64fRUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/88] 4.4.170-stable review
Date:   Fri, 11 Jan 2019 15:07:29 +0100
Message-Id: <20190111131045.137499039@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.170-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.170-rc1
X-KernelTest-Deadline: 2019-01-13T13:11+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.170 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jan 13 13:09:58 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.170-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.170-rc1

Lubomir Rintel <lkundrak@v3.sk>
    power: supply: olpc_battery: correct the temperature units

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: msu: Fix an off-by-one in attribute store

Christian Borntraeger <borntraeger@de.ibm.com>
    genwqe: Fix size check

Yan, Zheng <zyan@redhat.com>
    ceph: don't update importing cap's mseq when handing cap export

Sohil Mehta <sohil.mehta@intel.com>
    iommu/vt-d: Handle domain agaw being less than iommu agaw

Dominique Martinet <dominique.martinet@cea.fr>
    9p/net: put a lower bound on msize

Larry Finger <Larry.Finger@lwfinger.net>
    b43: Fix error in cordic routine

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix loop in gfs2_rbm_find

Vasily Averin <vvs@virtuozzo.com>
    dlm: memory leaks on error path in dlm_user_request()

Vasily Averin <vvs@virtuozzo.com>
    dlm: lost put_lkb on error path in receive_convert() and receive_unlock()

Vasily Averin <vvs@virtuozzo.com>
    dlm: possible memory leak on error path in create_lkb()

Vasily Averin <vvs@virtuozzo.com>
    dlm: fixed memory leaks after failed ls_remove_names allocation

Hui Peng <benquike@163.com>
    ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: cs46xx: Potential NULL dereference in probe

Ming Lei <ming.lei@redhat.com>
    block: don't deal with discard limit in blkdev_issue_discard()

Jens Axboe <axboe@kernel.dk>
    block: break discard submissions into the user defined size

Eric Biggers <ebiggers@google.com>
    crypto: x86/chacha20 - avoid sleeping with preemption disabled

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use SVC_NET() in svcauth_gss_* functions

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: fix cache_head leak due to queued request

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: kill mapping "System RAM" support

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL

Michal Hocko <mhocko@suse.com>
    hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

David Herrmann <dh.herrmann@gmail.com>
    fork: record start_time late

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix idle configuration to not block SoC idle states

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: bnx2fc: Fix NULL dereference in error handling

Benjamin Poirier <bpoirier@suse.com>
    xfrm: Fix bucket count reported to userspace

Qian Cai <cai@lca.pw>
    checkstack.pl: fix for aarch64

Peter Hutterer <peter.hutterer@who-t.net>
    Input: restore EV_ABS ABS_RESERVED

Anson Huang <anson.huang@nxp.com>
    ARM: imx: update the cpu power up timing setting on i.mx6sx

Paul Mackerras <paulus@ozlabs.org>
    powerpc: Fix COFF zImage booting on old powermacs

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Unbreak the build of esoteric configs

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when running nested

Georgy A Bystrenin <gkot@altlinux.org>
    CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock problem

Huacai Chen <chenhc@lemote.com>
    MIPS: Align kernel load address to 64KB

Huacai Chen <chenhc@lemote.com>
    MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: vivid: free bitmap_cap when updating std/timings/etc.

Macpaul Lin <macpaul.lin@mediatek.com>
    cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Fix book-keeping of DMA termination

Lukas Wunner <lukas@wunner.de>
    spi: bcm2835: Fix race on DMA termination

Theodore Ts'o <tytso@mit.edu>
    ext4: force inode writes when nfsd calls commit_metadata()

ruippan (潘睿) <ruippan@tencent.com>
    ext4: fix EXT4_IOC_GROUP_ADD ioctl

Maurizio Lombardi <mlombard@redhat.com>
    ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Pan Bian <bianpan2016@163.com>
    ext4: fix possible use after free in ext4_quota_enable

Ben Hutchings <ben@decadent.org.uk>
    perf pmu: Suppress potential format-truncation warning

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Patrick Dreyer <Patrick@Dreyer.name>
    Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66597_endpoint_disable()

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Fibocom NL678 series

Scott Chen <scott@labau.com.tw>
    USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sameer Pujar <spujar@nvidia.com>
    ALSA: hda/tegra: clear pending irq handlers

Mantas Mikulėnas <grawity@gmail.com>
    ALSA: hda: add mute LED support for HP EliteBook 840 G4

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: emux: Fix potential Spectre v1 vulnerabilities

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: pcm: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ALSA: rme9652: Fix potential Spectre v1 vulnerability

Deepa Dinamani <deepa.kernel@gmail.com>
    sock: Make sock->sk_stamp thread-safe

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    gro_cell: add napi_disable in gro_cells_destroy

Juergen Gross <jgross@suse.com>
    xen/netfront: tolerate frags with no data

Jorgen Hansen <jhansen@vmware.com>
    VSOCK: Send reset control packet when socket is partially bound

Jason Wang <jasowang@redhat.com>
    vhost: make sure used idx is seen before log in vhost_add_used_n()

Xin Long <lucien.xin@gmail.com>
    sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Willem de Bruijn <willemb@google.com>
    packet: validate address length if non-zero

Willem de Bruijn <willemb@google.com>
    packet: validate address length

Cong Wang <xiyou.wangcong@gmail.com>
    netrom: fix locking in nr_find_socket()

Eric Dumazet <edumazet@google.com>
    isdn: fix kernel-infoleak in capi_unlocked_ioctl

Cong Wang <xiyou.wangcong@gmail.com>
    ipv6: explicitly initialize udp6_addr in udp_sock_create6()

Willem de Bruijn <willemb@google.com>
    ieee802154: lowpan_header_create check must check daddr

Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
    ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Cong Wang <xiyou.wangcong@gmail.com>
    ax25: fix a use-after-free in ax25_fillin_cb()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ipv4: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ip6mr: Fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/ioctl: Fix Spectre v1 vulnerabilities

Colin Ian King <colin.king@canonical.com>
    x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels

Christophe Leroy <christophe.leroy@c-s.fr>
    gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Russell King <rmk+kernel@armlinux.org.uk>
    mmc: omap_hsmmc: fix DMA API warning

Ulf Hansson <ulf.hansson@linaro.org>
    mmc: core: Reset HPI enabled state during re-init and in case of errors

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Telit LN940 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Fibocom NL668 series

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)

Tore Anderson <tore@fud.no>
    USB: serial: option: add HP lt4132

Jörgen Storvist <jorgen.storvist@gmail.com>
    USB: serial: option: add GosunCn ZTE WeLink ME3630

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Don't prevent USB2 bus suspend in state check intended for USB3 only

Hui Peng <benquike@gmail.com>
    USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |  2 +-
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |  7 ++-
 arch/mips/include/asm/pgtable-64.h                 |  5 ++
 arch/powerpc/boot/crt0.S                           |  4 +-
 arch/x86/crypto/chacha20_glue.c                    |  1 +
 arch/x86/include/asm/kvm_host.h                    |  2 +-
 arch/x86/kernel/cpu/mtrr/if.c                      |  2 +
 arch/x86/kvm/vmx.c                                 | 19 +++++-
 arch/x86/kvm/x86.c                                 |  3 +-
 block/blk-lib.c                                    | 26 ++-------
 drivers/gpio/gpio-max7301.c                        | 12 +---
 drivers/gpu/drm/drm_ioctl.c                        | 10 +++-
 drivers/hv/vmbus_drv.c                             | 20 +++++++
 drivers/hwtracing/intel_th/msu.c                   |  3 +-
 drivers/input/keyboard/omap4-keypad.c              | 16 ++----
 drivers/input/mouse/elan_i2c_core.c                |  1 +
 drivers/iommu/intel-iommu.c                        |  4 +-
 drivers/isdn/capi/kcapi.c                          |  4 +-
 drivers/media/platform/vivid/vivid-vid-cap.c       |  2 +
 drivers/misc/genwqe/card_utils.c                   |  2 +-
 drivers/mmc/core/mmc.c                             |  4 +-
 drivers/mmc/host/omap_hsmmc.c                      | 12 +++-
 drivers/net/ethernet/ibm/ibmveth.c                 |  6 +-
 drivers/net/usb/hso.c                              | 18 +++++-
 drivers/net/wireless/b43/phy_common.c              |  2 +-
 drivers/net/xen-netfront.c                         |  2 +-
 drivers/power/olpc_battery.c                       |  4 +-
 drivers/s390/scsi/zfcp_aux.c                       |  6 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |  2 +-
 drivers/spi/spi-bcm2835.c                          | 16 +++---
 drivers/usb/class/cdc-acm.c                        | 10 ++++
 drivers/usb/class/cdc-acm.h                        |  1 +
 drivers/usb/host/r8a66597-hcd.c                    |  5 +-
 drivers/usb/host/xhci-hub.c                        |  3 +-
 drivers/usb/serial/option.c                        | 20 ++++++-
 drivers/usb/serial/pl2303.c                        |  5 ++
 drivers/usb/serial/pl2303.h                        |  5 ++
 drivers/vhost/vhost.c                              |  2 +
 fs/ceph/caps.c                                     |  1 -
 fs/cifs/smb2maperror.c                             |  4 +-
 fs/dlm/lock.c                                      | 17 +++---
 fs/dlm/lockspace.c                                 |  2 +-
 fs/ext4/inline.c                                   |  5 +-
 fs/ext4/resize.c                                   |  2 +-
 fs/ext4/super.c                                    | 13 ++++-
 fs/gfs2/rgrp.c                                     |  2 +-
 include/net/gro_cells.h                            |  1 +
 include/net/sock.h                                 | 36 +++++++++++-
 include/trace/events/ext4.h                        | 20 +++++++
 include/uapi/linux/input-event-codes.h             |  9 +++
 kernel/fork.c                                      | 13 ++++-
 kernel/memremap.c                                  | 11 ++--
 mm/memory_hotplug.c                                | 16 ++++++
 net/9p/client.c                                    | 21 +++++++
 net/ax25/af_ax25.c                                 | 11 +++-
 net/ax25/ax25_dev.c                                |  2 +
 net/compat.c                                       | 15 +++--
 net/core/sock.c                                    |  3 +
 net/ieee802154/6lowpan/tx.c                        |  3 +
 net/ipv4/ipmr.c                                    |  2 +
 net/ipv6/ip6_udp_tunnel.c                          |  3 +-
 net/ipv6/ip6mr.c                                   |  4 ++
 net/netrom/af_netrom.c                             | 15 +++--
 net/packet/af_packet.c                             |  8 ++-
 net/sctp/ipv6.c                                    |  1 +
 net/sunrpc/auth_gss/svcauth_gss.c                  |  8 +--
 net/sunrpc/cache.c                                 | 10 +++-
 net/sunrpc/svcsock.c                               |  2 +-
 net/vmw_vsock/vmci_transport.c                     | 67 ++++++++++++++++------
 net/xfrm/xfrm_state.c                              |  2 +-
 scripts/checkstack.pl                              |  4 +-
 sound/core/pcm.c                                   |  2 +
 sound/pci/cs46xx/dsp_spos.c                        |  3 +
 sound/pci/emu10k1/emufx.c                          |  5 ++
 sound/pci/hda/hda_tegra.c                          |  2 +
 sound/pci/hda/patch_conexant.c                     |  1 +
 sound/pci/rme9652/hdsp.c                           | 10 ++--
 sound/synth/emux/emux_hwdep.c                      |  7 ++-
 sound/usb/mixer.c                                  | 10 +++-
 sound/usb/quirks-table.h                           |  3 +
 tools/perf/util/pmu.c                              |  8 +--
 82 files changed, 489 insertions(+), 167 deletions(-)


