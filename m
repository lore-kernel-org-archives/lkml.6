Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D17C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CC92173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 14:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZ8QqXHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfAGOlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 09:41:11 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:42609 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfAGOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 09:41:10 -0500
Received: by mail-lj1-f173.google.com with SMTP id l15-v6so502585lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IbLN2doMAR8KMosiPtN7WYSlacXtXDxVSnm51ANm69I=;
        b=JZ8QqXHJ1sNnVL2x4Y9sWUG7ojQ17dnsHixKP5Z5LhRmSDQcF+bOBCOj8xKfmk0UHN
         LOf5PlWpsArF3FRfaadDVOYyA/ZWLphUyilxC29HabdaIK+c8OrmuhAUMqDTNjBygkhC
         kxdxeC8Co/dc+ess/vEQitjstQ4Zw9C4WRZjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IbLN2doMAR8KMosiPtN7WYSlacXtXDxVSnm51ANm69I=;
        b=h+nGcu3Oy7URkzlJepkPceunhGHkuWzmz69XlukLfq/Y9tS2Kbgus25crSHj7mnxft
         qGIOA4i+n0MshISAZNPel115hBq2QXdEFIvTlcoOqXrRbLnIj3tSS+jvytS+aNGTTs9n
         SpMJ9l6bEjidzmZbB6YM72GhFSNoUyczbYV+8EM4vLBwuSOezn++RdHwvFVFDz9abA6J
         sk0z+FncUO6BFfQlWWfFf+oVwY45f3GqKIFMLN3oy2u3pLh0e8KmQMTlgpcLp1uYZFoj
         xpCwf4oWb9JglMrTFl/ca4TLv2hwTy2kv3wMkTR29g/I3fJPTjq5UUO2mJ5RNBFkjXY5
         Snkw==
X-Gm-Message-State: AJcUukcA7bEAzZOP3SnoyyZWPsG/USQqY0KwupVSDPevQ7YbSkMH3cVi
        iGwj/WP+0ZaY9njpsNydx0dHhpPZ0dZJnGzEtg1wWg==
X-Google-Smtp-Source: ALg8bN4ORLAIEppK2+trB+MYlkLC/uciW+wW47N8mEqDPz7EKh/Xcxua5hFLGpBbRkHcx/XinoYXVvuHDc8NDQp7BUM=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr34245582ljc.66.1546872067211;
 Mon, 07 Jan 2019 06:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.280153213@linuxfoundation.org>
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 7 Jan 2019 08:40:56 -0600
Message-ID: <CAEUSe7-ymDukTDvA6rPTsJrxxs31ChAtHo54+Uti_eG2m1_F9A@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/71] 4.9.149-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 7 Jan 2019 at 07:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.9.149 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

With 4.9, we get this build error:
| /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4=
/inode.c:
In function 'ext4_write_inode':
| /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4=
/inode.c:5018:6:
error: implicit declaration of function 'sb_rdonly'
[-Werror=3Dimplicit-function-declaration]
|       sb_rdonly(inode->i_sb))
|       ^~~~~~~~~
|   CC      drivers/char/virtio_console.o
| In file included from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/l=
inux/linkage.h:4:0,
|                  from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include/l=
inux/fs.h:4,
|                  from
/srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4/i=
node.c:21:
| /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/fs/ext4=
/inode.c:5021:15:
error: implicit declaration of function 'ext4_forced_shutdown'; did
you mean 'ext4_force_commit'? [-Werror=3Dimplicit-function-declaration]
|   if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
|                ^
| /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/include=
/linux/compiler.h:168:42:
note: in definition of macro 'unlikely'
|  # define unlikely(x) __builtin_expect(!!(x), 0)
|                                           ^

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org



> Responses should be made by Wed Jan  9 10:53:04 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.149-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.9.149-rc1
>
> Tomas Winkler <tomas.winkler@intel.com>
>     tpm: tpm_i2c_nuvoton: use correct command duration for TPM 2.x
>
> Maciej W. Rozycki <macro@linux-mips.org>
>     rtc: m41t80: Correct alarm month range with RTC reads
>
> Will Deacon <will.deacon@arm.com>
>     arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1
>
> Vitaly Kuznetsov <vkuznets@redhat.com>
>     x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when=
 running nested
>
> Georgy A Bystrenin <gkot@altlinux.org>
>     CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem
>
> Aaro Koskinen <aaro.koskinen@iki.fi>
>     MIPS: OCTEON: mark RGMII interface disabled on OCTEON III
>
> Huacai Chen <chenhc@lemote.com>
>     MIPS: Align kernel load address to 64KB
>
> Huacai Chen <chenhc@lemote.com>
>     MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
>
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: v4l2-tpg: array index could become negative
>
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: vivid: free bitmap_cap when updating std/timings/etc.
>
> Nava kishore Manne <nava.manne@xilinx.com>
>     serial: uartps: Fix interrupt mask issue to handle the RX interrupts =
properly
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     f2fs: fix validation of the block count in sanity_check_raw_super
>
> Breno Leitao <leitao@debian.org>
>     powerpc/tm: Set MSR[TS] just prior to recheckpoint
>
> Josef Bacik <jbacik@fb.com>
>     btrfs: run delayed items before dropping the snapshot
>
> Filipe Manana <fdmanana@suse.com>
>     Btrfs: fix fsync of files with multiple hard links in new directories
>
> Macpaul Lin <macpaul.lin@mediatek.com>
>     cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.
>
> Johan Jonker <jbx9999@hotmail.com>
>     clk: rockchip: fix typo in rk3188 spdif_frac parent
>
> Lukas Wunner <lukas@wunner.de>
>     spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
>
> Lukas Wunner <lukas@wunner.de>
>     spi: bcm2835: Fix book-keeping of DMA termination
>
> Lukas Wunner <lukas@wunner.de>
>     spi: bcm2835: Fix race on DMA termination
>
> Theodore Ts'o <tytso@mit.edu>
>     ext4: check for shutdown and r/o file system in ext4_write_inode()
>
> Theodore Ts'o <tytso@mit.edu>
>     ext4: force inode writes when nfsd calls commit_metadata()
>
> Theodore Ts'o <tytso@mit.edu>
>     ext4: include terminating u32 in size of xattr entries when expanding=
 inodes
>
> ruippan (=E6=BD=98=E7=9D=BF) <ruippan@tencent.com>
>     ext4: fix EXT4_IOC_GROUP_ADD ioctl
>
> Maurizio Lombardi <mlombard@redhat.com>
>     ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()
>
> Pan Bian <bianpan2016@163.com>
>     ext4: fix possible use after free in ext4_quota_enable
>
> Ben Hutchings <ben@decadent.org.uk>
>     perf pmu: Suppress potential format-truncation warning
>
> Miquel Raynal <miquel.raynal@bootlin.com>
>     platform-msi: Free descriptors in platform_msi_domain_free()
>
> Sean Christopherson <sean.j.christopherson@intel.com>
>     KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup
>
> Patrick Dreyer <Patrick@Dreyer.name>
>     Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G
>
> Bj=C3=B8rn Mork <bjorn@mork.no>
>     qmi_wwan: apply SET_DTR quirk to the SIMCOM shared device ID
>
> Colin Ian King <colin.king@canonical.com>
>     staging: wilc1000: fix missing read_write setting when reading data
>
> Jia-Ju Bai <baijiaju1990@gmail.com>
>     usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()
>
> J=C3=B6rgen Storvist <jorgen.storvist@gmail.com>
>     USB: serial: option: add Fibocom NL678 series
>
> Scott Chen <scott@labau.com.tw>
>     USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays
>
> Sameer Pujar <spujar@nvidia.com>
>     ALSA: hda/tegra: clear pending irq handlers
>
> Mantas Mikul=C4=97nas <grawity@gmail.com>
>     ALSA: hda: add mute LED support for HP EliteBook 840 G4
>
> Arnd Bergmann <arnd@arndb.de>
>     mtd: atmel-quadspi: disallow building on ebsa110
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     ALSA: emux: Fix potential Spectre v1 vulnerabilities
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     ALSA: pcm: Fix potential Spectre v1 vulnerability
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     ALSA: emu10k1: Fix potential Spectre v1 vulnerabilities
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     ALSA: rme9652: Fix potential Spectre v1 vulnerability
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     ptr_ring: wrap back ->producer in __ptr_ring_swap_queue()
>
> Deepa Dinamani <deepa.kernel@gmail.com>
>     sock: Make sock->sk_stamp thread-safe
>
> Yuval Avnery <yuvalav@mellanox.com>
>     net/mlx5: Typo fix in del_sw_hw_rule
>
> Alaa Hleihel <alaa@mellanox.com>
>     net/mlx5e: Remove the false indication of software timestamping suppo=
rt
>
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
>     gro_cell: add napi_disable in gro_cells_destroy
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     tipc: compare remote and local protocols in tipc_udp_enable()
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     tipc: use lock_sock() in tipc_sk_reinit()
>
> Juergen Gross <jgross@suse.com>
>     xen/netfront: tolerate frags with no data
>
> Jorgen Hansen <jhansen@vmware.com>
>     VSOCK: Send reset control packet when socket is partially bound
>
> Jason Wang <jasowang@redhat.com>
>     vhost: make sure used idx is seen before log in vhost_add_used_n()
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     tipc: fix a double kfree_skb()
>
> Xin Long <lucien.xin@gmail.com>
>     sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event
>
> Willem de Bruijn <willemb@google.com>
>     packet: validate address length if non-zero
>
> Willem de Bruijn <willemb@google.com>
>     packet: validate address length
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     net/wan: fix a double free in x25_asy_open_tty()
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     netrom: fix locking in nr_find_socket()
>
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>     net: phy: Fix the issue that netif always links up after resuming
>
> Michal Kubecek <mkubecek@suse.cz>
>     net: ipv4: do not handle duplicate fragments as overlapping
>
> Eric Dumazet <edumazet@google.com>
>     isdn: fix kernel-infoleak in capi_unlocked_ioctl
>
> Eric Dumazet <edumazet@google.com>
>     ipv6: tunnels: fix two use-after-free
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     ipv6: explicitly initialize udp6_addr in udp_sock_create6()
>
> Willem de Bruijn <willemb@google.com>
>     ieee802154: lowpan_header_create check must check daddr
>
> Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>     ibmveth: fix DMA unmap error in ibmveth_xmit_start error path
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     ax25: fix a use-after-free in ax25_fillin_cb()
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     phonet: af_phonet: Fix Spectre v1 vulnerability
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     net: core: Fix Spectre v1 vulnerability
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     ipv4: Fix potential Spectre v1 vulnerability
>
> Gustavo A. R. Silva <gustavo@embeddedor.com>
>     ip6mr: Fix potential Spectre v1 vulnerability
>
> Guenter Roeck <linux@roeck-us.net>
>     NFC: nxp-nci: Include unaligned.h instead of access_ok.h
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |  4 +-
>  arch/arm64/include/asm/kvm_arm.h                   |  2 +-
>  arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |  7 ++-
>  arch/mips/cavium-octeon/executive/cvmx-helper.c    |  3 +-
>  arch/mips/include/asm/pgtable-64.h                 |  5 ++
>  arch/powerpc/kernel/signal_32.c                    | 20 ++++++-
>  arch/powerpc/kernel/signal_64.c                    | 44 +++++++++-----
>  arch/x86/include/asm/kvm_host.h                    |  2 +-
>  arch/x86/kvm/vmx.c                                 | 19 +++++-
>  arch/x86/kvm/x86.c                                 |  3 +-
>  drivers/base/platform-msi.c                        |  6 +-
>  drivers/char/tpm/tpm_i2c_nuvoton.c                 | 11 ++--
>  drivers/clk/rockchip/clk-rk3188.c                  |  2 +-
>  drivers/input/mouse/elan_i2c_core.c                |  1 +
>  drivers/isdn/capi/kcapi.c                          |  4 +-
>  drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |  2 +-
>  drivers/media/platform/vivid/vivid-vid-cap.c       |  2 +
>  drivers/mtd/spi-nor/Kconfig                        |  2 +-
>  drivers/net/ethernet/ibm/ibmveth.c                 |  6 +-
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 11 +---
>  drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  2 +-
>  drivers/net/phy/phy_device.c                       |  7 +--
>  drivers/net/usb/qmi_wwan.c                         |  2 +-
>  drivers/net/wan/x25_asy.c                          |  2 +
>  drivers/net/xen-netfront.c                         |  2 +-
>  drivers/nfc/nxp-nci/firmware.c                     |  2 +-
>  drivers/nfc/nxp-nci/i2c.c                          |  2 +-
>  drivers/rtc/rtc-m41t80.c                           |  2 +-
>  drivers/spi/spi-bcm2835.c                          | 14 ++---
>  drivers/staging/wilc1000/wilc_sdio.c               |  1 +
>  drivers/tty/serial/xilinx_uartps.c                 |  4 +-
>  drivers/usb/class/cdc-acm.c                        | 10 ++++
>  drivers/usb/class/cdc-acm.h                        |  1 +
>  drivers/usb/host/r8a66597-hcd.c                    |  5 +-
>  drivers/usb/serial/option.c                        |  4 ++
>  drivers/usb/serial/pl2303.c                        |  5 ++
>  drivers/usb/serial/pl2303.h                        |  5 ++
>  drivers/vhost/vhost.c                              |  2 +
>  fs/btrfs/btrfs_inode.h                             |  6 ++
>  fs/btrfs/extent-tree.c                             |  4 ++
>  fs/btrfs/inode.c                                   | 17 ++++++
>  fs/btrfs/tree-log.c                                | 16 ++++++
>  fs/cifs/smb2maperror.c                             |  4 +-
>  fs/ext4/inline.c                                   |  5 +-
>  fs/ext4/inode.c                                    |  9 ++-
>  fs/ext4/resize.c                                   |  2 +-
>  fs/ext4/super.c                                    | 13 ++++-
>  fs/ext4/xattr.c                                    |  2 +-
>  fs/f2fs/super.c                                    |  6 +-
>  include/linux/msi.h                                |  2 +
>  include/linux/ptr_ring.h                           |  2 +
>  include/net/gro_cells.h                            |  1 +
>  include/net/sock.h                                 | 36 +++++++++++-
>  include/trace/events/ext4.h                        | 20 +++++++
>  net/ax25/af_ax25.c                                 | 11 +++-
>  net/ax25/ax25_dev.c                                |  2 +
>  net/compat.c                                       | 15 +++--
>  net/core/filter.c                                  |  2 +
>  net/core/sock.c                                    |  3 +
>  net/ieee802154/6lowpan/tx.c                        |  3 +
>  net/ipv4/ip_fragment.c                             | 18 ++++--
>  net/ipv4/ipmr.c                                    |  3 +
>  net/ipv6/ip6_tunnel.c                              |  1 +
>  net/ipv6/ip6_udp_tunnel.c                          |  3 +-
>  net/ipv6/ip6_vti.c                                 |  1 +
>  net/ipv6/ip6mr.c                                   |  4 ++
>  net/netrom/af_netrom.c                             | 15 +++--
>  net/packet/af_packet.c                             |  8 ++-
>  net/phonet/af_phonet.c                             |  3 +
>  net/sctp/ipv6.c                                    |  1 +
>  net/sunrpc/svcsock.c                               |  2 +-
>  net/tipc/socket.c                                  |  8 ++-
>  net/tipc/udp_media.c                               |  9 ++-
>  net/vmw_vsock/vmci_transport.c                     | 67 ++++++++++++++++=
------
>  sound/core/pcm.c                                   |  2 +
>  sound/pci/emu10k1/emufx.c                          |  5 ++
>  sound/pci/hda/hda_tegra.c                          |  2 +
>  sound/pci/hda/patch_conexant.c                     |  1 +
>  sound/pci/rme9652/hdsp.c                           | 10 ++--
>  sound/synth/emux/emux_hwdep.c                      |  7 ++-
>  tools/perf/util/pmu.c                              |  8 +--
>  81 files changed, 451 insertions(+), 136 deletions(-)
>
>
