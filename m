Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE73C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B582075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B582075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeIESyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:54:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIESyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:54:15 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 115D3115F;
        Wed,  5 Sep 2018 14:23:19 +0000 (UTC)
Date:   Wed, 5 Sep 2018 16:23:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.154
Message-ID: <20180905142317.GA8974@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.154 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                  |    2=20
 arch/arc/include/asm/delay.h                              |    3=20
 arch/arc/mm/cache.c                                       |    7 -
 arch/arm/kvm/mmu.c                                        |   42 +++++--
 arch/arm64/mm/init.c                                      |    6 -
 arch/mips/bcm47xx/setup.c                                 |    6 -
 arch/mips/include/asm/mipsregs.h                          |    3=20
 arch/mips/include/asm/processor.h                         |    2=20
 arch/mips/kernel/ptrace.c                                 |    2=20
 arch/mips/kernel/ptrace32.c                               |    2=20
 arch/mips/lib/multi3.c                                    |    6 -
 arch/s390/include/asm/qdio.h                              |    1=20
 arch/s390/mm/fault.c                                      |    2=20
 arch/s390/net/bpf_jit_comp.c                              |    2=20
 arch/s390/pci/pci.c                                       |    2=20
 arch/x86/include/asm/irqflags.h                           |    3=20
 arch/x86/include/asm/processor.h                          |    4=20
 arch/x86/kernel/cpu/bugs.c                                |    4=20
 arch/x86/kernel/cpu/intel.c                               |    3=20
 arch/x86/kernel/process_64.c                              |    1=20
 arch/x86/mm/init.c                                        |    4=20
 arch/x86/mm/mmap.c                                        |    2=20
 drivers/cdrom/cdrom.c                                     |    2=20
 drivers/gpu/drm/i2c/adv7511.c                             |   12 ++
 drivers/gpu/drm/imx/imx-ldb.c                             |    9 +
 drivers/gpu/drm/udl/udl_fb.c                              |    2=20
 drivers/gpu/drm/udl/udl_main.c                            |   35 +++---
 drivers/i2c/busses/i2c-davinci.c                          |    8 +
 drivers/net/can/mscan/mpc5xxx_can.c                       |    5=20
 drivers/net/ethernet/3com/Kconfig                         |    2=20
 drivers/net/ethernet/amd/Kconfig                          |    4=20
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c           |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c       |   13 +-
 drivers/net/ethernet/cirrus/Kconfig                       |    1=20
 drivers/net/ethernet/cisco/enic/enic_main.c               |   78 ++++-----=
-----
 drivers/net/ethernet/qlogic/qed/qed_mcp.c                 |    1=20
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c         |    1=20
 drivers/net/wan/lmc/lmc_main.c                            |    2=20
 drivers/pinctrl/freescale/pinctrl-imx1-core.c             |    2=20
 drivers/s390/cio/qdio_main.c                              |    5=20
 drivers/scsi/fcoe/fcoe_ctlr.c                             |    4=20
 drivers/scsi/libiscsi.c                                   |   12 +-
 drivers/scsi/scsi_sysfs.c                                 |   20 +++
 drivers/scsi/vmw_pvscsi.c                                 |   11 +
 drivers/staging/media/omap4iss/iss_video.c                |    3=20
 drivers/target/iscsi/iscsi_target_login.c                 |   35 +++---
 drivers/usb/gadget/function/f_uac2.c                      |   20 +--
 drivers/usb/gadget/udc/r8a66597-udc.c                     |    6 -
 drivers/usb/phy/phy-fsl-usb.c                             |    4=20
 fs/btrfs/extent-tree.c                                    |    2=20
 fs/cachefiles/namei.c                                     |    1=20
 fs/cachefiles/rdwr.c                                      |   17 ++-
 fs/cifs/cifs_debug.c                                      |   30 ++++-
 fs/cifs/inode.c                                           |    2=20
 fs/cifs/link.c                                            |    4=20
 fs/cifs/sess.c                                            |    6 +
 fs/cifs/smb2inode.c                                       |    2=20
 fs/ext4/namei.c                                           |    1=20
 fs/ext4/sysfs.c                                           |   13 +-
 fs/ext4/xattr.c                                           |    2=20
 fs/fscache/operation.c                                    |    6 -
 fs/fuse/dev.c                                             |   39 +++++--
 fs/fuse/file.c                                            |    1=20
 fs/fuse/fuse_i.h                                          |    1=20
 fs/fuse/inode.c                                           |   23 +---
 fs/sysfs/file.c                                           |   44 +++++++
 include/linux/sysfs.h                                     |   14 ++
 kernel/kprobes.c                                          |    4=20
 kernel/sysctl.c                                           |    3=20
 mm/memory.c                                               |    3=20
 mm/zswap.c                                                |    9 +
 net/caif/caif_dev.c                                       |    4=20
 net/ipv4/cipso_ipv4.c                                     |   12 +-
 net/ipv6/ip6_vti.c                                        |   11 +
 net/mac80211/util.c                                       |    3=20
 net/wireless/nl80211.c                                    |    1=20
 net/xfrm/xfrm_policy.c                                    |    3=20
 net/xfrm/xfrm_user.c                                      |   10 +
 sound/soc/sirf/sirf-usp.c                                 |    7 -
 sound/soc/soc-pcm.c                                       |    8 +
 tools/power/x86/turbostat/turbostat.c                     |    8 -
 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc |   28 +++++
 tools/usb/ffs-test.c                                      |   19 ++-
 83 files changed, 513 insertions(+), 235 deletions(-)

Alexander Sverdlin (1):
      i2c: davinci: Avoid zero value of CLKH

Andi Kleen (1):
      x86/spectre: Add missing family 6 check to microcode check

Andrey Ryabinin (1):
      fuse: Don't access pipe->buffers without pipe_lock()

Arnd Bergmann (1):
      ext4: sysfs: print ext4_super_block fields as little-endian

Bart Van Assche (2):
      scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
      scsi: core: Avoid that SCSI device removal through sysfs triggers a d=
eadlock

Bernd Edlinger (1):
      nl80211: Add a missing break in parse_station_flags

Calvin Walton (1):
      tools/power turbostat: Read extended processor family from CPUID

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom

Colin Ian King (1):
      drivers: net: lmc: fix case value for target abort error

Dan Carpenter (1):
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()

Eric Sandeen (1):
      ext4: reset error code in ext4_find_entry in fallback

Ethan Zhao (1):
      sched/sysctl: Check user input value of sysctl_sched_time_avg

Eugeniu Rosca (1):
      usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Eyal Birger (1):
      vti6: fix PMTU caching and reporting on xmit

Florian Westphal (2):
      xfrm: free skb if nlsk pointer is NULL
      atl1c: reserve min skb headroom

Govindarajulu Varadarajan (1):
      enic: handle mtu change for vf properly

Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Greg Kroah-Hartman (1):
      Linux 4.4.154

Guenter Roeck (1):
      media: staging: omap4iss: Include asm/cacheflush.h after generic incl=
udes

Gustavo A. R. Silva (1):
      ASoC: sirf: Fix potential NULL pointer dereference

Jerome Brunet (1):
      ASoC: dpcm: don't merge format from invalid codec dai

Jia-Ju Bai (2):
      usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs =
in init_controller()
      usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in=
 r8a66597_queue()

Jim Gill (1):
      scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMIN=
ATED

Johannes Thumshirn (1):
      scsi: fcoe: drop frames in ELS LOGO error path

Josef Bacik (1):
      btrfs: don't leak ret from do_chunk_alloc

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags

Kiran Kumar Modukuri (3):
      fscache: Allow cancelled operations to be enqueued
      cachefiles: Fix refcounting bug in backing-file read monitoring
      cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

Kirill Tkhai (1):
      fuse: Add missed unlock_page() to fuse_readpages_fill()

Len Brown (1):
      tools/power turbostat: fix -S on UP systems

Li Wang (1):
      zswap: re-check zswap_is_full() after do zswap_shrink()

Lucas Stach (2):
      drm/imx: imx-ldb: disable LDB on driver bind
      drm/imx: imx-ldb: check if channel is enabled before printing warning

Maciej W. Rozycki (1):
      MIPS: Correct the 64-bit DSP accumulator register size

Martin Schwidefsky (1):
      s390: fix br_r1_trampoline for machines without exrl

Masami Hiramatsu (2):
      selftests/ftrace: Add snapshot and tracing_on test case
      kprobes: Make list and blacklist root user read only

Mike Christie (1):
      iscsi target: fix session creation failure handling

Miklos Szeredi (4):
      fuse: fix double request_end()
      fuse: fix unlocked access to processing queue
      fuse: umount should wait for all requests
      fuse: Fix oops at process_init_reply()

Mikulas Patocka (3):
      udl-kms: change down_interruptible to down
      udl-kms: handle allocation failure
      udl-kms: fix crash due to uninitialized memory

Nicholas Mc Guire (2):
      can: mpc5xxx_can: check of_iomap return before use
      cifs: check kmalloc before use

Nick Desaulniers (1):
      x86/irqflags: Mark native_restore_fl extern inline

Paul Burton (1):
      MIPS: lib: Provide MIPS64r6 __multi3() for GCC < 7

Peter Senna Tschudin (1):
      tools: usb: ffs-test: Fix build on big endian systems

Punit Agrawal (2):
      KVM: arm/arm64: Skip updating PTE entry if no change
      KVM: arm/arm64: Skip updating PMD entry if no change

Rafa=C5=82 Mi=C5=82ecki (1):
      Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

Randy Dunlap (4):
      usb/phy: fix PPC64 build errors in phy-fsl-usb.c
      net: prevent ISA drivers from building on PPC32
      arc: fix build errors in arc/include/asm/delay.h
      arc: fix type warnings in arc/mm/cache.c

Rian Hunter (1):
      x86/process: Re-export start_thread()

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Sean Paul (1):
      drm/bridge: adv7511: Reset registers on hotplug

Sebastian Ott (1):
      s390/pci: fix out of bounds access during irq setup

Shubhrajyoti Datta (1):
      net: axienet: Fix double deregister of mdio

Steve French (3):
      cifs: add missing debug entries for kconfig options
      smb3: Do not send SMB3 SET_INFO if nothing changed
      smb3: don't request leases in symlink creation and query

Sudarsana Reddy Kalluru (2):
      qed: Fix possible race for the link state value.
      bnx2x: Fix invalid memory access in rss hash config path.

Theodore Ts'o (1):
      ext4: check for NUL characters in extended attribute's name

Tommi Rantala (1):
      xfrm: fix missing dst_release() after policy blocking lbcast and mult=
icast

Varun Prakash (1):
      scsi: libiscsi: fix possible NULL pointer dereference in case of TMF

Vlastimil Babka (3):
      x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit
      x86/speculation/l1tf: Fix off-by-one error when warning that system h=
as too much RAM
      x86/speculation/l1tf: Suggest what to do on systems with too much RAM

YueHaibing (1):
      net: caif: Add a missing rcu_read_unlock() in caif_flow_cb

jie@chenjie6@huwei.com (1):
      mm/memory.c: check return value of ioremap_prot

mpubbise@codeaurora.org (1):
      mac80211: add stations tied to AP_VLANs during hw reconfig

yujuan.qi (1):
      Cipso: cipso_v4_optptr enter infinite loop


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluP5tUACgkQONu9yGCS
aT4e4A/+NZnXn8F0hNP6KBD2t9T+4FOZPkt1m05eP+U9nkkSCuAf+g1e+k60QeKP
fmj/fR3gNtXfa6FGdnxrP8O8hBvUNfHy2+fMD9SQouYAwBT8f6W4QeAs85Zyjmas
CLODkriEGIzS3qXBXQ9or+DYM6iuiNZz8nGoppvsRB7Sd9bNFsZPBjDoC2JHGsXQ
Sip2V4P7jZqyLEnZGoZ7lNaQyGILVe1E8wK1+AjgkQAU1kKTzX9jGrQGOJvuexKB
/0Teyt+kj+xPkc0dUuho9meDPsFjz8i5l+dlJL+OoDBEvJ4bnj4BX+dvyXzUFAyC
VvgArSMhlNyJ7OySfA0sVjGT+NJAPR9OVZczow31WmMWstOeE+aCZ2FueBBACh+F
2ie+DYbO5G/k897ca+fWQlJjTow2v4knSejf1WAucWO1A/47rfrLUll+k1IhX5nh
SLEn33nmx3BvfRJpr6+Fgo/U7smxiQqz1Wd3AXiDu9dCFxmPqQBPnUjpt4CpC8ys
I4Jy9oovmtRl0QxiseICBuwSLnevc4S2Xb9gjc8dIaHE2ZiGmVrd+WCYf5McW66M
Cam1THb2+RbL++JId06LZTD4UAWHWwkfeALMpqR/sfEyT6Idhp2jSwlB0fkd2T6K
h8X4aTlFj8NLqXOXGonI7D1oHMR7OOPXmISv4+h9+yf+sb0Gfss=
=9vSj
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
