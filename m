Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90A7C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBF1206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttgSUUkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBF1206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbeLBHfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbeLBHfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:35:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C469206B7;
        Sun,  2 Dec 2018 07:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543736127;
        bh=GAlnD4WvXAOhG0L21BEyL3l8LaVJJl81iYS3GZFElKg=;
        h=Date:From:To:Cc:Subject:From;
        b=ttgSUUkfnEycyS3LaXYN09pj0HolHNCsuX35JsrlKmBg15B+/2VOpUNjJowSIP7sA
         X/Ev7o3UeTVy3yMF1LdDoNmhRPLw4Rjt1UEJbf6DqQvQUj6EhdPbOp6ucqPzONgvbl
         YBGfU5DCJ7ZYwuChxLPNlJ5oYbEusXkgjFpcx0zc=
Date:   Sun, 2 Dec 2018 08:35:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.142
Message-ID: <20181202073523.GA32299@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.142 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/sysctl/fs.txt                                 |   36=20
 MAINTAINERS                                                 |    1=20
 Makefile                                                    |    2=20
 arch/arm64/Makefile                                         |    2=20
 arch/powerpc/include/asm/io.h                               |   20=20
 arch/powerpc/kvm/trace.h                                    |    8=20
 arch/powerpc/kvm/trace_booke.h                              |    9=20
 arch/powerpc/kvm/trace_hv.h                                 |    9=20
 arch/powerpc/kvm/trace_pr.h                                 |    9=20
 arch/powerpc/mm/numa.c                                      |    2=20
 arch/s390/mm/gmap.c                                         |    2=20
 arch/x86/events/intel/uncore_snb.c                          |  115 ++
 drivers/block/floppy.c                                      |    3=20
 drivers/cpufreq/imx6q-cpufreq.c                             |    7=20
 drivers/firmware/efi/arm-init.c                             |    4=20
 drivers/firmware/efi/arm-runtime.c                          |    2=20
 drivers/firmware/efi/memmap.c                               |    3=20
 drivers/gpio/gpiolib.c                                      |    5=20
 drivers/gpu/drm/ast/ast_drv.c                               |   21=20
 drivers/gpu/drm/ast/ast_mode.c                              |    3=20
 drivers/infiniband/core/verbs.c                             |    4=20
 drivers/infiniband/hw/hfi1/user_sdma.c                      |  106 +-
 drivers/input/joystick/xpad.c                               |  471 +++++++=
++---
 drivers/net/can/dev.c                                       |   48 -
 drivers/net/ethernet/broadcom/genet/bcmmii.c                |    2=20
 drivers/net/usb/lan78xx.c                                   |   42 -
 drivers/net/wireless/ath/ath10k/mac.c                       |    6=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    3=20
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c           |   12=20
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c                |    5=20
 drivers/net/wireless/marvell/mwifiex/cfg80211.c             |   10=20
 drivers/net/wireless/marvell/mwifiex/pcie.c                 |   19=20
 drivers/net/wireless/marvell/mwifiex/wmm.c                  |   12=20
 drivers/net/wireless/st/cw1200/wsm.c                        |   16=20
 drivers/nfc/nfcmrvl/uart.c                                  |    5=20
 drivers/of/base.c                                           |   25=20
 drivers/pinctrl/meson/pinctrl-meson.c                       |    2=20
 drivers/rtc/rtc-pcf2127.c                                   |    3=20
 drivers/scsi/ufs/ufs.h                                      |    3=20
 drivers/scsi/ufs/ufshcd-pci.c                               |    2=20
 drivers/scsi/ufs/ufshcd-pltfrm.c                            |    5=20
 drivers/scsi/ufs/ufshcd.c                                   |   75 +
 drivers/tty/n_tty.c                                         |   20=20
 drivers/tty/tty_buffer.c                                    |    2=20
 drivers/usb/core/hub.c                                      |    4=20
 drivers/usb/dwc3/core.c                                     |    1=20
 drivers/usb/host/xhci-hub.c                                 |   66 +
 drivers/usb/host/xhci-ring.c                                |    2=20
 drivers/usb/host/xhci.h                                     |    2=20
 fs/9p/vfs_dir.c                                             |   11=20
 fs/bfs/inode.c                                              |    9=20
 fs/gfs2/ops_fstype.c                                        |    2=20
 fs/namei.c                                                  |   53 +
 include/linux/can/dev.h                                     |    1=20
 include/linux/fs.h                                          |    2=20
 include/linux/integrity.h                                   |    1=20
 include/linux/of.h                                          |    8=20
 include/linux/pfn_t.h                                       |    2=20
 kernel/debug/kdb/kdb_io.c                                   |   15=20
 kernel/debug/kdb/kdb_private.h                              |    2=20
 kernel/debug/kdb/kdb_support.c                              |   10=20
 kernel/sched/core.c                                         |    4=20
 kernel/sysctl.c                                             |   18=20
 mm/shmem.c                                                  |    4=20
 mm/slab.c                                                   |    4=20
 mm/slab_common.c                                            |   12=20
 net/ieee802154/6lowpan/6lowpan_i.h                          |    4=20
 net/ieee802154/6lowpan/reassembly.c                         |   14=20
 net/llc/af_llc.c                                            |   11=20
 net/sctp/associola.c                                        |   10=20
 net/sunrpc/auth_generic.c                                   |    8=20
 security/integrity/evm/evm.h                                |    2=20
 security/integrity/evm/evm_crypto.c                         |   87 +-
 security/integrity/evm/evm_main.c                           |   29=20
 security/integrity/iint.c                                   |    3=20
 security/integrity/ima/ima_api.c                            |   67 +
 security/integrity/ima/ima_appraise.c                       |   31=20
 security/integrity/ima/ima_crypto.c                         |   10=20
 security/integrity/ima/ima_main.c                           |   77 +
 security/integrity/integrity.h                              |   18=20
 security/selinux/ss/policydb.c                              |    2=20
 tools/power/cpupower/bench/Makefile                         |    2=20
 tools/power/cpupower/lib/cpufreq.c                          |    2=20
 tools/power/cpupower/lib/cpuidle.c                          |    2=20
 tools/power/cpupower/lib/cpupower.c                         |    4=20
 tools/power/cpupower/lib/cpupower_intern.h                  |    2=20
 86 files changed, 1317 insertions(+), 462 deletions(-)

Aaron Ma (2):
      usb: xhci: fix timeout for transition from RExit to U0
      usb: xhci: fix uninitialized completion when USB3 port got wrong stat=
us

Alex Estrin (1):
      IB/core: Fix for core panic

Alexander Aring (1):
      net: ieee802154: 6lowpan: fix frag reassembly

Amitkumar Karwar (3):
      mwifiex: prevent register accesses after host is sleeping
      mwifiex: report error to PCIe for suspend failure
      mwifiex: Fix NULL pointer dereference in skb_dequeue()

Andrew Price (1):
      gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Andy Shevchenko (1):
      usb: dwc3: core: Clean up ULPI device

Anson Huang (1):
      cpufreq: imx6q: add return value check for voltage scale

Ard Biesheuvel (1):
      efi/arm: Revert deferred unmap of early memmap mapping

Arvind Yadav (1):
      Input: xpad - constify usb_device_id

Benjamin Valentin (5):
      Input: xpad - sort supported devices by USB ID
      Input: xpad - sync supported devices with xboxdrv
      Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer Sabertooth
      Input: xpad - sync supported devices with 360Controller
      Input: xpad - sync supported devices with XBCD

Cameron Gutman (8):
      Input: xpad - add product ID for Xbox One S pad
      Input: xpad - fix Xbox One rumble stopping after 2.5 secs
      Input: xpad - don't depend on endpoint order
      Input: xpad - fix stuck mode button on Xbox One S pad
      Input: xpad - restore LED state after device resume
      Input: xpad - support some quirky Xbox One pads
      Input: xpad - fix PowerA init quirk for some gamepad models
      Input: xpad - validate USB endpoint type during probe

Daniel Tobias (2):
      Input: xpad - correctly sort vendor id's
      Input: xpad - move reporting xbox one home button to common function

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Dmitry Kasatkin (1):
      ima: re-introduce own integrity cache lock

Dmitry Vyukov (1):
      mm: don't warn about large allocations for slab

Dominique Martinet (1):
      v9fs_dir_readdir: fix double-free on p9stat_read error

Emmanuel Grumbach (2):
      iwlwifi: mvm: support sta_statistics() even on older firmware
      iwlwifi: mvm: fix regulatory domain update when the firmware starts

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Eric Dumazet (1):
      llc: do not use sk_eat_skb()

Eric W. Biederman (1):
      Revert "evm: Translate user/group ids relative to s_user_ns when comp=
uting HMAC"

Ethan Lee (1):
      Input: xpad - add GPD Win 2 Controller USB IDs

Francis Therien (1):
      Input: xpad - add PDP device id 0x02a4

Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Greg Kroah-Hartman (3):
      MAINTAINERS: Add Sasha as a stable branch maintainer
      tty: wipe buffer if not echoing data
      Linux 4.9.142

Janosch Frank (1):
      s390/mm: Check for valid vma before zapping in gmap_discard

Jens Axboe (1):
      floppy: fix race condition in __floppy_read_block_0()

Jerome Brunet (1):
      pinctrl: meson: fix pinconf bias disable

Johan Hovold (3):
      of: add helper to lookup compatible child node
      NFC: nfcmrvl_uart: fix OF child-node lookup
      net: bcmgenet: fix OF child-node lookup

Johannes Thumshirn (1):
      cw1200: Don't leak memory if krealloc failes

Kan Liang (1):
      perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLa=
ke CPUs

Karthik D A (1):
      mwifiex: fix p2p device doesn't find in scan problem

Konstantin Khlebnikov (1):
      tools/power/cpupower: fix compilation with STATIC=3Dtrue

Leo Sperling (1):
      Input: xpad - fix some coding style issues

Linus Torvalds (1):
      tty: wipe buffer.

Marc Kleine-Budde (4):
      can: dev: can_get_echo_skb(): factor out non sending code to __can_ge=
t_echo_skb()
      can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_fra=
me to access frame length
      can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::e=
cho_skb is accessed out of bounds
      can: dev: __can_get_echo_skb(): print error message, if trying to ech=
o non existing skb

Marcus Folkesson (1):
      Input: xpad - avoid using __set_bit() for capabilities

Mark Furneaux (1):
      Input: xpad - add support for PDP Xbox One controllers

Mathias Nyman (1):
      usb: xhci: Prevent bus suspend if a port connect change or polling st=
ate is detected

Matthew Garrett (1):
      EVM: Add support for portable signature format

Michael Ellerman (1):
      powerpc/io: Fix the IO workarounds code to work with Radix

Michael J. Ruhl (1):
      IB/hfi1: Eliminate races in the SDMA send error path

Mimi Zohar (2):
      ima: always measure and audit files in policy
      ima: re-initialize iint->atomic_flags

Pavel Rojtberg (1):
      Input: xpad - simplify error condition in init_output

Phil Elwell (1):
      lan78xx: Read MAC address from DT if present

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmfmac: fix reporting support for 160 MHz channels

Ramses Ram=C3=ADrez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Salvatore Mesoraca (1):
      namei: allow restricted O_CREAT of FIFOs and regular files

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Scott Wood (1):
      KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Sebastien Boisvert (1):
      include/linux/pfn_t.h: force '~' to be parsed as an unary operator

Steven Rostedt (VMware) (1):
      sched/core: Allow __sched_setscheduler() in interrupts when PI is not=
 used

Subhash Jadavani (2):
      scsi: ufs: fix race between clock gating and devfreq scaling work
      scsi: ufshcd: release resources if probe fails

Tetsuo Handa (2):
      selinux: Add __GFP_NOWARN to allocation at str_read()
      bfs: add sanity check at bfs_fill_super()

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Trond Myklebust (1):
      SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Vasanthakumar Thiagarajan (1):
      ath10k: fix kernel panic due to race in accessing arvif list

Venkat Gopalakrishnan (1):
      scsi: ufshcd: Fix race between clk scaling and ungate work

Vladimir Zapolskiy (1):
      gpio: don't free unallocated ida on gpiochip_add_data_with_key() erro=
r path

Xin Long (1):
      sctp: clear the transport of some out_chunk_list chunks in sctp_assoc=
_rm_peer

Xulin Sun (1):
      rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
      drm/ast: fixed cursor may disappear sometimes

Yaniv Gardi (1):
      scsi: ufs: fix bugs related to null pointer access and array size

Yufen Yu (1):
      tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative of=
fset


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwDizsACgkQONu9yGCS
aT6mJhAAwwfL8a63kkKGPLdVc+/fzOPXkTw5DP0dlSbDFARSxJMOUuuonFTMhC2P
EAmbD+/Hxfpvx9zoBR8Dyr/dPninXTfof/Hf76pCH26mHRAxp4noxzYtqpoVubPn
cdKqc3/euDY7l3XZADEkxfdEu3mLN9GQhewyxdrGFe8PnmfiMWCO2xm/HCyyc0cO
0+h4RXCaFdIVHKT8PmzxISeDRfemkvv17UlxPE6xl9YlAHGJSAWgwIko1PEFk2UL
KQkQov4aqxBM+ej0vcA9S2rgDeQn8Dbk8keLDhBNcCrsFZqn8A4Il4mZ/8hl0JWn
V1am1VqBlnGLVk6/GUaFy9HRRMkinIAAtegLBXf5xyQhA12O96eikmV52VbdDIsU
d/7FiNGo0RoMKZ5bUqwqRxIM/BekR4VPaFZEpjmeJa6mWW6FFl7DSaOTAMm4hLpy
sB2wOtsmU90kWZzn5DZezToJalFfbDRhWS/ABQZKNY1dYeS0D17AZHKwhdY9SSZZ
ThOcqjQEjEyI3NdoPgVuS5yTSOnw35UpamXuWXdhYMqTg38W9ZqTrcDg7uB3u19X
kdzPXoQvMHzD3xakDvZ9WPMbftWLEEYTs4Sm8OS/LeaMgtsy9KvQrXVC/Wj9WtEM
yrKSfU4O73CvvespNgdscoyJohQBjdJXTQhjkWolUjzDuGOIaeM=
=M9Bp
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
