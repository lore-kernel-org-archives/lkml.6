Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25520C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BD520873
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547373334;
	bh=+J+fQhIp6hl20HM/NBG+AqbifKwYmIWLKEllNMAvhOU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CEUT2N38yTqPh47cJLrprYpZSsoFPyLPx8YMO0r14wWic5lUvzgWlliI9LYTcqa4Q
	 C8HrOrJGMJlxHREsjr2ESTLskjFvpvZVBi8M1Br1UkEbxhl26ZyiqiVesJngqA3HQX
	 dnFihdwx6TIuNsnvyJ8tmCNeuPyvyyztriR9IMEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfAMJzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfAMJzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:55:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804BC20873;
        Sun, 13 Jan 2019 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547373331;
        bh=+J+fQhIp6hl20HM/NBG+AqbifKwYmIWLKEllNMAvhOU=;
        h=Date:From:To:Cc:Subject:From;
        b=GcYf6bzoHoATlag4qM0xWEa8GUIMzIH+LsfmL1xdDLOiqmnpszBS7FbZNCq6PoOe9
         eo369guF3xUrqhZsOtGo+QujKr2U8w+CKQUoRLvvSkpeA82gUJ74mFsEjBuj3ZzA2Z
         8ftl9wt+KsqtMnTMgQqryR0iP7zCtWa+iNk93yik=
Date:   Sun, 13 Jan 2019 10:55:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.93
Message-ID: <20190113095528.GA21729@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.93 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                             |   29 -
 arch/arm/boot/dts/imx7d-nitrogen7.dts                |    9=20
 arch/arm/mach-imx/cpuidle-imx6sx.c                   |    2=20
 arch/arm64/Makefile                                  |    2=20
 arch/arm64/kernel/image.h                            |   44 -
 arch/arm64/kernel/vmlinux.lds.S                      |    9=20
 arch/powerpc/Makefile                                |    7=20
 arch/powerpc/boot/Makefile                           |    5=20
 arch/powerpc/boot/crt0.S                             |    4=20
 arch/powerpc/kernel/Makefile                         |    3=20
 arch/powerpc/kernel/signal_32.c                      |   20=20
 arch/powerpc/kernel/signal_64.c                      |   44 +
 arch/powerpc/mm/dump_linuxpagetables.c               |    1=20
 arch/powerpc/xmon/Makefile                           |    5=20
 arch/x86/include/asm/pgtable_64_types.h              |    5=20
 arch/x86/mm/dump_pagetables.c                        |   15=20
 arch/x86/xen/mmu_pv.c                                |   11=20
 drivers/block/zram/zram_drv.c                        |    4=20
 drivers/gpio/gpio-mvebu.c                            |    6=20
 drivers/gpu/drm/vc4/vc4_plane.c                      |    1=20
 drivers/hid/hid-ids.h                                |    3=20
 drivers/hid/hid-ite.c                                |    1=20
 drivers/hv/Kconfig                                   |    2=20
 drivers/hwtracing/intel_th/msu.c                     |    3=20
 drivers/infiniband/sw/rxe/rxe_resp.c                 |   13=20
 drivers/input/keyboard/omap4-keypad.c                |   16=20
 drivers/input/mouse/synaptics.c                      |    2=20
 drivers/iommu/intel-iommu.c                          |    4=20
 drivers/md/dm-verity-target.c                        |   24=20
 drivers/md/dm-zoned-target.c                         |  122 +---
 drivers/md/raid10.c                                  |   15=20
 drivers/misc/genwqe/card_utils.c                     |    2=20
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c     |    3=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h          |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |   54 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h       |    4=20
 drivers/net/ethernet/cadence/macb_main.c             |   14=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c    |    3=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c   |   14=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c    |   15=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c   |  503 ++++++++++++--=
-----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h    |   13=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c        |   43 +
 drivers/net/ethernet/ibm/ibmvnic.c                   |    2=20
 drivers/net/ethernet/intel/i40e/i40e_main.c          |   14=20
 drivers/net/ethernet/neterion/vxge/vxge-config.c     |    2=20
 drivers/net/ethernet/nuvoton/w90p910_ether.c         |    2=20
 drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c |    3=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c            |    1=20
 drivers/net/ieee802154/ca8210.c                      |    4=20
 drivers/net/usb/lan78xx.c                            |    4=20
 drivers/net/usb/qmi_wwan.c                           |   15=20
 drivers/net/wireless/broadcom/b43/phy_common.c       |    2=20
 drivers/pinctrl/meson/pinctrl-meson.c                |    3=20
 drivers/power/supply/olpc_battery.c                  |    4=20
 drivers/s390/scsi/zfcp_aux.c                         |    6=20
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                    |    2=20
 drivers/scsi/lpfc/lpfc_sli.c                         |    3=20
 drivers/target/iscsi/cxgbit/cxgbit_cm.c              |    5=20
 drivers/target/iscsi/cxgbit/cxgbit_main.c            |    1=20
 drivers/tty/serial/sunsu.c                           |   31 -
 drivers/vhost/vsock.c                                |    2=20
 fs/ceph/caps.c                                       |    1=20
 fs/dlm/lock.c                                        |   17=20
 fs/dlm/lockspace.c                                   |    2=20
 fs/gfs2/inode.c                                      |   18=20
 fs/gfs2/rgrp.c                                       |    2=20
 fs/lockd/clntproc.c                                  |    2=20
 fs/lockd/xdr.c                                       |    4=20
 fs/lockd/xdr4.c                                      |    4=20
 include/linux/hmm.h                                  |    4=20
 include/uapi/linux/input-event-codes.h               |    9=20
 kernel/fork.c                                        |   13=20
 kernel/irq/affinity.c                                |   15=20
 kernel/memremap.c                                    |   11=20
 kernel/sched/fair.c                                  |   43 -
 lib/raid6/Makefile                                   |   15=20
 lib/test_debug_virtual.c                             |    1=20
 mm/hmm.c                                             |  131 ----
 mm/memory_hotplug.c                                  |   16=20
 mm/swapfile.c                                        |    3=20
 net/9p/client.c                                      |   21=20
 net/mac80211/status.c                                |    5=20
 net/netfilter/ipset/ip_set_list_set.c                |    2=20
 net/netfilter/nf_conntrack_seqadj.c                  |    7=20
 net/netfilter/nf_nat_core.c                          |    3=20
 net/sunrpc/auth_gss/svcauth_gss.c                    |    8=20
 net/sunrpc/cache.c                                   |   10=20
 net/sunrpc/xprtsock.c                                |    4=20
 net/xfrm/xfrm_input.c                                |    7=20
 net/xfrm/xfrm_output.c                               |    1=20
 net/xfrm/xfrm_state.c                                |    2=20
 scripts/Makefile.build                               |    2=20
 scripts/checkstack.pl                                |    4=20
 scripts/kallsyms.c                                   |    1=20
 security/selinux/ss/policydb.c                       |   51 +
 sound/pci/cs46xx/dsp_spos.c                          |    3=20
 sound/usb/mixer.c                                    |   10=20
 sound/usb/quirks-table.h                             |    3=20
 tools/cgroup/Makefile                                |    1=20
 tools/gpio/Makefile                                  |    2=20
 tools/hv/Makefile                                    |    1=20
 tools/iio/Makefile                                   |    2=20
 tools/laptop/freefall/Makefile                       |    1=20
 tools/leds/Makefile                                  |    1=20
 tools/perf/Makefile.perf                             |    6=20
 tools/power/acpi/Makefile.config                     |    4=20
 tools/scripts/Makefile.include                       |   18=20
 tools/spi/Makefile                                   |    2=20
 tools/testing/nvdimm/test/iomap.c                    |    2=20
 tools/usb/Makefile                                   |    1=20
 tools/virtio/linux/kernel.h                          |    4=20
 tools/vm/Makefile                                    |    1=20
 113 files changed, 1042 insertions(+), 665 deletions(-)

Alexander Shishkin (1):
      intel_th: msu: Fix an off-by-one in attribute store

Andreas Gruenbacher (2):
      gfs2: Get rid of potential double-freeing in gfs2_create_inode
      gfs2: Fix loop in gfs2_rbm_find

Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Anssi Hannula (2):
      net: macb: fix random memory corruption on RX with 64-bit DMA
      net: macb: fix dropped RX frames due to a race

Ard Biesheuvel (3):
      scripts/kallsyms: filter arm64's __efistub_ symbols
      arm64: drop linker script hack to hide __efistub_ symbols
      arm64: relocatable: fix inconsistencies in linker script and options

Arnd Bergmann (1):
      w90p910_ether: remove incorrect __init annotation

Benjamin Coddington (1):
      lockd: Show pid of lockd for remote locks

Benjamin Poirier (1):
      xfrm: Fix bucket count reported to userspace

Boris Brezillon (1):
      drm/vc4: Set ->is_yuv to false when num_planes =3D=3D 1

Breno Leitao (1):
      powerpc/tm: Set MSR[TS] just prior to recheckpoint

Christian Borntraeger (1):
      genwqe: Fix size check

Christophe Leroy (1):
      lib: fix build failure in CONFIG_DEBUG_VIRTUAL test

Colin Ian King (1):
      vxge: ensure data0 is initialized in when fetching firmware version i=
nformation

Damien Le Moal (1):
      dm zoned: Fix target BIO completion handling

Dan Carpenter (3):
      scsi: bnx2fc: Fix NULL dereference in error handling
      qed: Fix an error code qed_ll2_start_xmit()
      ALSA: cs46xx: Potential NULL dereference in probe

Dan Williams (4):
      mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL
      mm, devm_memremap_pages: kill mapping "System RAM" support
      mm, hmm: use devm semantics for hmm_devmem_{add, remove}
      mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL

Daniele Palmas (1):
      qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup

David Herrmann (1):
      fork: record start_time late

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Ewan D. Milne (1):
      scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcn=
t is invalid

Fabio Estevam (1):
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Florian Westphal (2):
      netfilter: seqadj: re-load tcp header pointer after possible head rea=
llocation
      netfilter: nat: can't use dst_hold on noref dst

Greg Kroah-Hartman (1):
      Linux 4.14.93

Hans de Goede (1):
      HID: ite: Add USB id match for another ITE based keyboard rfkill key =
quirk

Huang Ying (1):
      mm, swap: fix swapoff with KSM pages

Hui Peng (1):
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Ivan Mironov (1):
      bnx2x: Fix NULL pointer dereference in bnx2x_del_all_vlans() on some =
hw

Jason Martinsen (1):
      lan78xx: Resolve issue with changing MAC address

Jerome Brunet (1):
      pinctrl: meson: fix pull enable register calculation

Jiri Slaby (1):
      tools: power/acpi, revert to LD =3D gcc

Joel Stanley (5):
      powerpc: Disable -Wbuiltin-requires-header when setjmp is used
      ftrace: Build with CPPFLAGS to get -Qunused-arguments
      Makefile: Export clang toolchain variables
      powerpc/boot: Set target when cross-compiling for clang
      raid6/ppc: Fix build for clang

Kangjie Lu (1):
      net: netxen: fix a missing check and an uninitialized use

Kirill A. Shutemov (2):
      x86/mm: Fix guard hole handling
      x86/dump_pagetables: Fix LDT remap address marker

Larry Finger (1):
      b43: Fix error in cordic routine

Linus Torvalds (1):
      sched/fair: Fix infinite loop in update_blocked_averages() by reverti=
ng a9e7f6544b9c

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Mantas Mikul=C4=97nas (1):
      Input: synaptics - enable SMBus for HP EliteBook 840 G4

Martin Kelly (1):
      tools: fix cross-compile var clobbering

Masahiro Yamada (3):
      kbuild: fix false positive warning/error about missing libelf
      kbuild: add -no-integrated-as Clang option unconditionally
      kbuild: consolidate Clang compiler flags

Matthias Kaehlcke (1):
      md: raid10: remove VLAIS

Michael Ellerman (1):
      powerpc/mm: Fix linux page tables build with some configs

Michael S. Tsirkin (1):
      virtio: fix test build after uio.h change

Michal Hocko (1):
      hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

Mikulas Patocka (1):
      dm verity: fix crash on bufio buffer that was allocated with vmalloc

Minchan Kim (1):
      zram: fix double free backing device

Nathan Chancellor (1):
      drivers: net: xgene: Remove unnecessary forward declarations

Nicholas Piggin (1):
      powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer

Ondrej Mosnacek (1):
      selinux: policydb - fix byte order and alignment issues

Pan Bian (1):
      netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel

Paul Mackerras (1):
      powerpc: Fix COFF zImage booting on old powermacs

Peter Hutterer (1):
      Input: restore EV_ABS ABS_RESERVED

Qian Cai (1):
      checkstack.pl: fix for aarch64

Sagi Grimberg (1):
      rxe: fix error completion wr_id and qp_num

Sara Sharon (1):
      mac80211: free skb fraglist before freeing the skb

Sinan Kaya (1):
      x86, hyperv: remove PCI dependency

Sohil Mehta (1):
      iommu/vt-d: Handle domain agaw being less than iommu agaw

Stefan Assmann (1):
      i40e: fix mac filter delete when setting mac address

Stefan Hajnoczi (1):
      vhost/vsock: fix uninitialized vhost_vsock->guest_cid

Steffen Klassert (1):
      xfrm: Fix NULL pointer dereference in xfrm_input when skb_dst_force c=
lears the dst_entry.

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Sudarsana Reddy Kalluru (3):
      bnx2x: Clear fip MAC when fcoe offload support is disabled
      bnx2x: Remove configured vlans as part of unload sequence.
      bnx2x: Send update-svid ramrod with retry/poll flags enabled

Takashi Iwai (1):
      ALSA: usb-audio: Avoid access before bLength check in build_audio_pro=
cunit()

Thomas Falcon (1):
      ibmvnic: Fix non-atomic memory allocation in IRQ context

Thomas Gleixner (1):
      genirq/affinity: Don't return with empty affinity masks on error

Tony Lindgren (1):
      Input: omap-keypad - fix idle configuration to not block SoC idle sta=
tes

Trond Myklebust (1):
      SUNRPC: Fix a race with XPRT_CONNECTING

Uwe Kleine-K=C3=B6nig (1):
      gpio: mvebu: only fail on missing clk if pwm is actually to be used

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix csk leak
      scsi: target: iscsi: cxgbit: add missing spin_lock_init()

Vasily Averin (6):
      sunrpc: fix cache_head leak due to queued request
      sunrpc: use SVC_NET() in svcauth_gss_* functions
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlo=
ck()
      dlm: memory leaks on error path in dlm_user_request()

Wei Yongjun (1):
      xfrm: Fix error return code in xfrm_output_one()

Yan, Zheng (1):
      ceph: don't update importing cap's mseq when handing cap export

Yangtao Li (1):
      serial/sunsu: fix refcount leak

Yonglong Liu (10):
      net: hns: Incorrect offset address used for some registers.
      net: hns: All ports can not work when insmod hns ko after rmmod.
      net: hns: Some registers use wrong address according to the datasheet.
      net: hns: Fixed bug that netdev was opened twice
      net: hns: Clean rx fbd when ae stopped.
      net: hns: Free irq when exit from abnormal branch
      net: hns: Avoid net reset caused by pause frames storm
      net: hns: Fix ntuple-filters status error.
      net: hns: Add mac pcs config when enable|disable mac
      net: hns: Fix ping failed when use net bridge and send multicast

YueHaibing (1):
      ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done

Yussuf Khalil (1):
      Input: synaptics - enable RMI on ThinkPad T560


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw7CxAACgkQONu9yGCS
aT4qrhAAzdTfFyqFXwlqQGn7mgbc7pGszXfYa3yAvsAisSX3e+E6tRjK1pGUMgEF
Oki5YNgfsu283WC5TFhlZveqx8f/dw/54KgUqSyPoszmOa0VZlmkIZnooOG64VRc
V5TUkW9bs7abu551lBE2oTmd4bb5C1CBoPVWrkbv296sP8tAtdIkZswNdwIhNdgq
2dRLtCTGoUBUGPTHeJ4A8F1ddq6u6RHR6GUYNNj+x7KGFuDGe/bLyH1SliztfMyN
JHISD5ZIUs5cRvVrd3yq92oM85I5fJ3NfSH6gqI35t3mmaTHVw4DD7s1rlHns8cn
ZGwAViDqRPJAJ/E6S+vqFxsI5vokvfI0wdxweDv0UQfOSaZm6Cv3Bdto/eOyO9OO
P+XzZPxTnFmlfOgLRrsA/aA5LCU7DQqgSyN1+SipVERuK2UXmbvx8P1bkgAWr4fq
8GKJ3v1vENb7YrZvpc+p/lWY6jMsIEOT7oUsDFezUe0cIIDjJHqx2YBQRBiMXyMU
oNnMzFGegml/QpjLkBfQ90Sa1LyZb9Ps+2y7ytEAQFI+KeJ0sz3LBhjmJExPJZdG
5K2AAdPXOKzyNBr5l2PHhWEs44akbipEce4KSRLYHRRhWTl/dYgwOaFa1W64Q4n6
csxOWsZ5apf2KVxdsKxOL5xU3DMq7yMzMY6gMHdxroHeoeKDfEQ=
=uJq4
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
