Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885CEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6CB2080A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ult3+/09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6CB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLBHem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:55822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBHem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:34:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C33C2080A;
        Sun,  2 Dec 2018 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543736079;
        bh=OsZzsiD66u9RiNj7CEzK43og+z6FngA2qUJqomPO/U8=;
        h=Date:From:To:Cc:Subject:From;
        b=Ult3+/094fdFDl9ky98x/liQgyXaKR7Y2druEk2KKb2n1javyCfuKD1+Y/AOSsq7m
         StdrHpbvkqigLGy9/hfhoI7QtTFGvCcZQb84q2gzhuKcpeNPPFcDzVnW4FdIjmDwDc
         ONyxA7rfFiN5ZQetLXtlYlUDJDWF8CWvFFSTEsNM=
Date:   Sun, 2 Dec 2018 08:34:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.128
Message-ID: <20181202073436.GA32143@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.128 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                          |    2=20
 arch/arm64/Makefile               |    2=20
 arch/powerpc/mm/numa.c            |    2=20
 drivers/cpufreq/imx6q-cpufreq.c   |    7=20
 drivers/gpu/drm/ast/ast_drv.c     |   21=20
 drivers/gpu/drm/ast/ast_mode.c    |    3=20
 drivers/input/gameport/gameport.c |    4=20
 drivers/input/joystick/xpad.c     | 1422 ++++++++++++++++++++++++++++-----=
-----
 drivers/input/misc/ims-pcu.c      |    4=20
 drivers/input/serio/serio.c       |    4=20
 drivers/input/serio/serio_raw.c   |    4=20
 drivers/net/can/dev.c             |   48 -
 drivers/net/wireless/cw1200/wsm.c |   16=20
 drivers/scsi/qla2xxx/qla_os.c     |    5=20
 drivers/scsi/ufs/ufs.h            |    3=20
 drivers/scsi/ufs/ufshcd.c         |   72 +
 drivers/tty/n_tty.c               |   19=20
 drivers/tty/tty_buffer.c          |    2=20
 drivers/usb/core/hub.c            |    4=20
 fs/9p/vfs_dir.c                   |   11=20
 fs/bfs/inode.c                    |    9=20
 fs/gfs2/ops_fstype.c              |    2=20
 include/linux/can/dev.h           |    1=20
 kernel/debug/kdb/kdb_io.c         |   15=20
 kernel/debug/kdb/kdb_private.h    |    2=20
 kernel/debug/kdb/kdb_support.c    |   10=20
 mm/shmem.c                        |    4=20
 net/llc/af_llc.c                  |   11=20
 net/sctp/associola.c              |   10=20
 net/sunrpc/auth_generic.c         |    8=20
 net/unix/af_unix.c                |   27=20
 31 files changed, 1289 insertions(+), 465 deletions(-)

Andrew Price (1):
      gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Aniroop Mathur (1):
      Input: initialize device counter variables with -1

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

Cameron Gutman (12):
      Input: xpad - prevent spurious input from wired Xbox 360 controllers
      Input: xpad - fix rumble on Xbox One controllers with 2015 firmware
      Input: xpad - fix oops when attaching an unknown Xbox One gamepad
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

Dario Scarpa (1):
      Input: xpad - fix Razer Atrox Arcade Stick button mapping

Dennis Wassenberg (1):
      usb: core: Fix hub port connection events lost

Dmitry Torokhov (1):
      Input: xpad - use LED API when identifying wireless controllers

Dominique Martinet (1):
      v9fs_dir_readdir: fix double-free on p9stat_read error

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Eric Dumazet (1):
      llc: do not use sk_eat_skb()

Erik Lundgren (1):
      Input: xpad - add Covert Forces edition of the Xbox One controller

Ethan Lee (1):
      Input: xpad - add GPD Win 2 Controller USB IDs

Francis Therien (1):
      Input: xpad - add PDP device id 0x02a4

Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Greg Kroah-Hartman (2):
      tty: wipe buffer if not echoing data
      Linux 3.18.128

Johannes Thumshirn (1):
      cw1200: Don't leak memory if krealloc failes

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

Mauricio Faria de Oliveira (1):
      scsi: qla2xxx: do not queue commands when unloading

Ming-ting Yao Wei (1):
      Input: xpad - add rumble support for Xbox One controller

Pavel Rojtberg (16):
      Input: xpad - re-send LED command on present event
      Input: xpad - clarify LED enumeration
      Input: xpad - use ida() for finding the pad_nr
      Input: xpad - remove needless bulk out URB used for LED setup
      Input: xpad - factor out URB submission in xpad_play_effect
      Input: xpad - x360w: report dpad as buttons and axes
      Input: xpad - query wireless controller state at init
      Input: xpad - fix clash of presence handling with LED setting
      Input: xpad - correctly handle concurrent LED and FF requests
      Input: xpad - workaround dead irq_out after suspend/ resume
      Input: xpad - correct xbox one pad device name
      Input: xpad - move pending clear to the correct location
      Input: xpad - add more third-party controllers
      Input: xpad - xbox one elite controller support
      Input: xpad - use correct product id for x360w controllers
      Input: xpad - simplify error condition in init_output

Pierre-Loup A. Griffais (4):
      Input: xpad - set the LEDs properly on XBox Wireless controllers
      Input: xpad - move the input device creation to a new function
      Input: xpad - handle "present" and "gone" correctly
      Input: xpad - update Xbox One Force Feedback Support

Prarit Bhargava (1):
      kdb: Use strscpy with destination buffer size

Ramses Ram=EDrez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Satheesh Rajendran (1):
      powerpc/numa: Suppress "VPHN is not supported" messages

Silvan Jegen (1):
      Input: xpad - add Mad Catz FightStick TE 2 VID/PID

Subhash Jadavani (1):
      scsi: ufs: fix race between clock gating and devfreq scaling work

Tetsuo Handa (1):
      bfs: add sanity check at bfs_fill_super()

Thomas Zimmermann (1):
      drm/ast: Remove existing framebuffers before loading driver

Trond Myklebust (1):
      SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Venkat Gopalakrishnan (1):
      scsi: ufshcd: Fix race between clk scaling and ungate work

WANG Cong (1):
      af_unix: move unix_mknod() out of bindlock

Xin Long (1):
      sctp: clear the transport of some out_chunk_list chunks in sctp_assoc=
_rm_peer

Y.C. Chen (2):
      drm/ast: fixed cursor may disappear sometimes
      drm/ast: change resolution may cause screen blurred

Yaniv Gardi (1):
      scsi: ufs: fix bugs related to null pointer access and array size

Yufen Yu (1):
      tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative of=
fset


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwDiwkACgkQONu9yGCS
aT6RmRAAyn3Z4nDlLi4UMzlZH6V4JZc5hWIsNYQs/lbpQHNo0LzFbYplUUCeSeC1
m8mGUXP5lcktklJNXp9JE4MEPm0sarxhaWl4vkFv5ABhTx/EgP2Yr84PUkAdP+bt
RI/GlVlBmggGgCC7zQSITS+bRvDPU6eQEDTnQD70FmmX5teZTCxrigiy+d9w/5bd
tGxxaLRThOUbWpRoBx37zIGhkenmlPaWzrWZy7eI6CDateGYu8nQBpxKEZH8dcLQ
iD1aCCiTunJfQJMaSFohYLeQM3khKsNEq3oyZvvtJWTM5lgZHn3/iH+FUKtF9yaC
eBp7YgchbEfmuy/FAw95GaEaukHk/vk2KQetmNRSgrk2h/4IQ/qEkLe1sLA1ymL7
SvbQ30AaRv1NAdFL0/D/rRRM6lPu7NMJ+TLofUL6P1jgzjMZFOP2qWKwlHIBKYBF
w5Lt8NS+0Bu6RtkG5IKXgqJAOPomGUaGDIU4aTTaRE5LIVbiUtGC51T9yxL8S7N3
7XJXo17Oa7y3Usz9Hifs7ng0rp2AYSwVWqI4BbmHqrtxUx2h6Exb+SzVNSQB4mP8
Lq1+ZCcGxynqjFLlsQWhR9Wf+YHsbWOaObiB08s+ND+JJXsXLicS5imrMCtDlPdh
UbajaDXI82DEMZ/K5t6jz1iZs0iFs+rURnhBaMcryx+fJLQ/dvs=
=FRd6
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
