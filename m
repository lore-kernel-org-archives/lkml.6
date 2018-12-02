Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F35C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3765520834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDBQc/KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3765520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbeLBHfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:35:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBHfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:35:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604672080A;
        Sun,  2 Dec 2018 07:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543736100;
        bh=5+OoKq+9mOeJRJ5nuORTHaNcaNsI0KR5G81RtukL0xg=;
        h=Date:From:To:Cc:Subject:From;
        b=CDBQc/KK/+tIJ/USGtTtchCt7ij9zHdFSihE7Pctweh5JnDNy0mRy6TMad0jtGv4Z
         SJ61SN67+2seU0Bf7guudg7iO1z26e+h1+6sBWWK2SMVFmt0+i1A1t/q5q7qyAqGlG
         VQhsmqOyQVNgV1dw2IiRvNRcKRN7LZ3JGPGkZC5M=
Date:   Sun, 2 Dec 2018 08:34:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.166
Message-ID: <20181202073457.GA32226@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.166 kernel.

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

 Documentation/sysctl/fs.txt                  |   36 +
 MAINTAINERS                                  |    1=20
 Makefile                                     |    2=20
 arch/arm64/Makefile                          |    2=20
 arch/powerpc/kvm/trace.h                     |    8=20
 arch/powerpc/kvm/trace_booke.h               |    9=20
 arch/powerpc/kvm/trace_hv.h                  |    9=20
 arch/powerpc/kvm/trace_pr.h                  |    9=20
 arch/powerpc/mm/numa.c                       |    2=20
 arch/s390/mm/pgtable.c                       |    2=20
 arch/x86/entry/entry_64.S                    |   20=20
 drivers/cpufreq/imx6q-cpufreq.c              |    7=20
 drivers/gpu/drm/ast/ast_drv.c                |   21=20
 drivers/gpu/drm/ast/ast_mode.c               |    3=20
 drivers/input/joystick/xpad.c                |  810 +++++++++++++++++++++-=
-----
 drivers/net/can/dev.c                        |   48 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c |    2=20
 drivers/net/wireless/ath/ath10k/mac.c        |    6=20
 drivers/net/wireless/cw1200/wsm.c            |   16=20
 drivers/net/wireless/iwlwifi/mvm/mac80211.c  |   12=20
 drivers/net/wireless/iwlwifi/mvm/nvm.c       |    5=20
 drivers/net/wireless/mwifiex/cfg80211.c      |   10=20
 drivers/net/wireless/mwifiex/wmm.c           |   12=20
 drivers/nfc/nfcmrvl/uart.c                   |    5=20
 drivers/of/base.c                            |   25=20
 drivers/scsi/qla2xxx/qla_os.c                |    5=20
 drivers/scsi/ufs/ufs.h                       |    3=20
 drivers/scsi/ufs/ufshcd-pci.c                |    2=20
 drivers/scsi/ufs/ufshcd-pltfrm.c             |    5=20
 drivers/scsi/ufs/ufshcd.c                    |   75 ++
 drivers/tty/n_tty.c                          |   19=20
 drivers/tty/tty_buffer.c                     |    2=20
 drivers/usb/core/hub.c                       |    4=20
 drivers/usb/host/xhci-hub.c                  |   66 +-
 drivers/usb/host/xhci-ring.c                 |    2=20
 drivers/usb/host/xhci.h                      |    2=20
 fs/9p/vfs_dir.c                              |   11=20
 fs/bfs/inode.c                               |    9=20
 fs/btrfs/extent-tree.c                       |   10=20
 fs/btrfs/ioctl.c                             |   11=20
 fs/gfs2/ops_fstype.c                         |    2=20
 fs/namei.c                                   |   53 +
 include/linux/can/dev.h                      |    1=20
 include/linux/fs.h                           |    2=20
 include/linux/of.h                           |    8=20
 kernel/debug/kdb/kdb_io.c                    |   15=20
 kernel/debug/kdb/kdb_private.h               |    2=20
 kernel/debug/kdb/kdb_support.c               |   10=20
 kernel/sched/core.c                          |    4=20
 kernel/sysctl.c                              |   18=20
 mm/shmem.c                                   |    4=20
 net/llc/af_llc.c                             |   11=20
 net/netfilter/nf_tables_api.c                |    1=20
 net/sctp/associola.c                         |   10=20
 net/sunrpc/auth_generic.c                    |    8=20
 55 files changed, 1118 insertions(+), 339 deletions(-)

Aaron Ma (2):
      usb: xhci: fix timeout for transition from RExit to U0
      usb: xhci: fix uninitialized completion when USB3 port got wrong stat=
us

Amitkumar Karwar (1):
      mwifiex: Fix NULL pointer dereference in skb_dequeue()

Andrew Price (1):
      gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit

Anson Huang (1):
      cpufreq: imx6q: add return value check for voltage scale

Arnd Bergmann (1):
      Input: xpad - remove unused function

Arvind Yadav (1):
      Input: xpad - constify usb_device_id

Benjamin Valentin (5):
      Input: xpad - sort supported devices by USB ID
      Input: xpad - sync supported devices with xboxdrv
      Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer Sabertooth
      Input: xpad - sync supported devices with 360Controller
      Input: xpad - sync supported devices with XBCD

Cameron Gutman (11):
      Input: xpad - prevent spurious input from wired Xbox 360 controllers
      Input: xpad - fix rumble on Xbox One controllers with 2015 firmware
      Input: xpad - power off wireless 360 controllers on suspend
      Input: xpad - add product ID for Xbox One S pad
      Input: xpad - fix Xbox One rumble stopping after 2.5 secs
      Input: xpad - don't depend on endpoint order
      Input: xpad - fix stuck mode button on Xbox One S pad
      Input: xpad - restore LED state after device resume
      Input: xpad - support some quirky Xbox One pads
      Input: xpad - fix PowerA init quirk for some gamepad models
      Input: xpad - validate USB endpoint type during probe

Clement Calmels (1):
      Input: xpad - remove spurious events of wireless xpad 360 controller

Daniel Tobias (2):
      Input: xpad - correctly sort vendor id's
      Input: xpad - move reporting xbox one home button to common function

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Dmitry Torokhov (1):
      Input: xpad - use LED API when identifying wireless controllers

Dominique Martinet (1):
      v9fs_dir_readdir: fix double-free on p9stat_read error

Emmanuel Grumbach (2):
      iwlwifi: mvm: support sta_statistics() even on older firmware
      iwlwifi: mvm: fix regulatory domain update when the firmware starts

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Eric Dumazet (1):
      llc: do not use sk_eat_skb()

Ethan Lee (1):
      Input: xpad - add GPD Win 2 Controller USB IDs

Francis Therien (1):
      Input: xpad - add PDP device id 0x02a4

Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Greg Kroah-Hartman (3):
      MAINTAINERS: Add Sasha as a stable branch maintainer
      tty: wipe buffer if not echoing data
      Linux 4.4.166

Janosch Frank (1):
      s390/mm: Check for valid vma before zapping in gmap_discard

Johan Hovold (3):
      of: add helper to lookup compatible child node
      NFC: nfcmrvl_uart: fix OF child-node lookup
      net: bcmgenet: fix OF child-node lookup

Johannes Thumshirn (1):
      cw1200: Don't leak memory if krealloc failes

Karthik D A (1):
      mwifiex: fix p2p device doesn't find in scan problem

Leo Sperling (1):
      Input: xpad - fix some coding style issues

Linus Torvalds (1):
      tty: wipe buffer.

Liping Zhang (1):
      netfilter: nf_tables: fix oops when inserting an element into a verdi=
ct map

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

Mauricio Faria de Oliveira (1):
      scsi: qla2xxx: do not queue commands when unloading

Nicolas Iooss (1):
      x86/entry: spell EBX register correctly in documentation

Pavel Rojtberg (5):
      Input: xpad - workaround dead irq_out after suspend/ resume
      Input: xpad - correct xbox one pad device name
      Input: xpad - add more third-party controllers
      Input: xpad - xbox one elite controller support
      Input: xpad - simplify error condition in init_output

Pierre-Loup A. Griffais (2):
      Input: xpad - handle "present" and "gone" correctly
      Input: xpad - update Xbox One Force Feedback Support

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

Qu Wenruo (1):
      btrfs: Ensure btrfs_trim_fs can trim the whole filesystem

Ramses Ram=EDrez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Salvatore Mesoraca (1):
      namei: allow restricted O_CREAT of FIFOs and regular files

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Scott Wood (1):
      KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Silvan Jegen (1):
      Input: xpad - add Mad Catz FightStick TE 2 VID/PID

Steven Rostedt (VMware) (1):
      sched/core: Allow __sched_setscheduler() in interrupts when PI is not=
 used

Subhash Jadavani (2):
      scsi: ufs: fix race between clock gating and devfreq scaling work
      scsi: ufshcd: release resources if probe fails

Tetsuo Handa (1):
      bfs: add sanity check at bfs_fill_super()

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Trond Myklebust (1):
      SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Vasanthakumar Thiagarajan (1):
      ath10k: fix kernel panic due to race in accessing arvif list

Venkat Gopalakrishnan (1):
      scsi: ufshcd: Fix race between clk scaling and ungate work

Xin Long (1):
      sctp: clear the transport of some out_chunk_list chunks in sctp_assoc=
_rm_peer

Y.C. Chen (2):
      drm/ast: change resolution may cause screen blurred
      drm/ast: fixed cursor may disappear sometimes

Yaniv Gardi (1):
      scsi: ufs: fix bugs related to null pointer access and array size

Yufen Yu (1):
      tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative of=
fset


--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwDiyAACgkQONu9yGCS
aT6jFxAAtB2uF0KCCR+C/Q/9yEHrB392LbRvLcSOSYRMRFsqrjBEfXPvpigk/h36
aTin6kt0evkQas5p0/8YmY7sIawTV80K/brwfnXzNm7GYEQ7P9vEjfJdaNjRVr8F
inTuA1dR9PphijvE9YJNLsV/ebHmb3p5qYCyGRUrTnrABrxAdq/lyBjpfiDFeZsJ
jYQZ0Y6WGmIOKMsH5Xk2i2m5DS2cXIHfu628F9ParWIIIgCuYGqHhltaXbnTqKXX
E7sinEQV6JRK5fnPi+S3wklFp93UmSLGA51C4uwt7LaPqMn5FqMIuX7NP4bUocfd
1sAtBVhwJzJqMY/0PbkBOQxEzHGW/Ni2z2MTy3psASb+lO2RtWE27JL7XeZV2Sw1
Q03M3TGyenhn2ptHIDO+DMaxmTeclZ1X62xKhwgMiufcQV8p6c7o4/GSgM1xy3qy
mU4W8u4Vj38N1cYDEot07HdOyqfmq5d8giaEc3B2RysqeeYOn9GTFFbrd0Zpznfg
3nuCGnEuMXWblpdVgluWEEYdQ8I1lk/vjACRYnDIqxdi/0G35qjkuwpWqyaCentJ
6KEz1Y2/0Nq9dCrXTOU1Qb/o3ae2UtLUgv14KsM5vXB131Lel8gb2SbjEKVLk131
Mejp2+7Rlvxy/J2XpErk4nShgXeXfHt28tFctk4R4q23DKYiNhI=
=YhTK
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
