Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-999392-1525279178-2-3431913220739574138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525279178; b=ZoQutKEP/UUSSFEzXdniERxL7mqDFTgr3alVCeGsVnR2+bo4ZK
    D03AePUZMNPzt+T0f5FpveqClZuPXfQkBDD03UXpq58HEVUSVQiKIwD2bAQ9kzo0
    gdYCbHaTbOUoB3+104oMQpgVD2rIUc1suPOX+aLbT7/uHyKArYDByAHwS8tAEtto
    /wVP/TGPyO3ds+bNR8MYovKQWRgN+qkVodM6qtv2iR4L+xDIixge7EmLHuerJsIQ
    O4RVEBuX5MdgtthWFVSovnAFDgVKEJp8cANEw6YgUYzFOcCeM8nFZvZaIVsX3co5
    Tu7F5E1o+qw61QfY36gR6ANt6o7z8exA0Qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525279178;
    bh=F5CCGzTcxVFx5Nu7thWQgUCEGBM6KE4JsVdShiUYlEs=; b=a1qeduh87OFb
    nMwx0nvFe74PXFSjD6IE8+o2AwOePUNq5ou2wbnGi0BplZbg5fCRYd/MPKNgpRdW
    DztwvJBlKQzokRgrqa4cyq2mZCEscppkZGXRQwl7v7c8+whvECwxCfmaoxZ2ucCk
    Z3fyRjqQrjKivCe1lwSIlxubSlcNupgYrdK48t7PxKkjJvLIxVXoHbEwmjyyXMVr
    +Io1LsbYWuFJGSpg7ocv5NMuadYFDadxBt0Aph8z9So4sTLI7aFIhaIXamjqEXBb
    6j7nP4ct6d3lTY6aezMOqIOOOQcCe9hcQTLMH9GijuMeaEiMqaGy46LSoCqOekLX
    5otL4s/XVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=YH02LrNs x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=YH02LrNs x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGFh5/GK3s+LM1Ft496jF/ePJG6gCocxdLhcAS0OaUjXYSJ5SplnH9y5b7jvn2HiCSSeHbpW+EndG9yJUhGitA2jTNHBTzYyaySod+89iasoLzDgoK/Y
    r+vPBiAT2E6H57u0YU2II1ZUdwkh+9FLB3zaZEuMRmtzOhL2RGhfrIj9I6dQwSDapVjwqLA5BwQf4O5ADNCKc1rrtTDh6Xb7KUItIh6CUgEXPKGZUjHXo5rs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=ZjG1CphWhkunCjRxdK8A:9 a=Z8T8Zr4NGug4k0cY:21 a=_hNQ5QHd2mslyr3D:21
    a=wPNLvfGTeEIA:10 a=ShTGE1AX7epT_fx9QzoA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEBQjW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 12:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751537AbeEBQjR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 12:39:17 -0400
Date: Wed, 2 May 2018 09:39:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.98
Message-ID: <20180502163906.GA20753@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.98 kernel.

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

 Makefile                                  |    2=20
 arch/powerpc/kernel/eeh_driver.c          |   61 +++++++++++++--------
 arch/powerpc/platforms/powernv/opal-rtc.c |    8 +-
 arch/x86/include/uapi/asm/msgbuf.h        |   31 ++++++++++
 arch/x86/include/uapi/asm/shmbuf.h        |   42 ++++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c     |    2=20
 arch/x86/kernel/smpboot.c                 |    2=20
 crypto/drbg.c                             |    2=20
 drivers/amba/bus.c                        |   17 +++---
 drivers/char/random.c                     |   85 ++++++++++++++++++++++---=
-----
 drivers/char/virtio_console.c             |   49 ++++++++---------
 drivers/cpufreq/powernv-cpufreq.c         |   14 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c     |    7 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c       |    4 -
 drivers/mtd/chips/cfi_cmdset_0001.c       |   33 +++++++++--
 drivers/mtd/chips/cfi_cmdset_0002.c       |    9 ++-
 drivers/of/fdt.c                          |    7 +-
 drivers/pci/host/pci-aardvark.c           |   12 ++--
 drivers/rtc/rtc-opal.c                    |   37 ++++++++-----
 drivers/scsi/sd.c                         |    2=20
 drivers/tty/n_gsm.c                       |   23 +++++++-
 drivers/tty/serial/earlycon.c             |    6 +-
 drivers/tty/tty_io.c                      |    5 +
 drivers/tty/tty_ldisc.c                   |   16 ++---
 drivers/usb/core/hcd.c                    |    1=20
 drivers/usb/core/hub.c                    |   10 +++
 drivers/usb/core/quirks.c                 |    3 +
 drivers/usb/serial/Kconfig                |    1=20
 drivers/usb/serial/cp210x.c               |    1=20
 drivers/usb/serial/ftdi_sio.c             |    3 -
 drivers/usb/serial/usb-serial-simple.c    |    7 ++
 drivers/usb/usbip/stub_main.c             |    5 +
 drivers/usb/usbip/usbip_common.h          |    2=20
 drivers/usb/usbip/usbip_event.c           |    4 -
 fs/ext4/balloc.c                          |   17 +++++-
 fs/ext4/extents.c                         |   16 +++--
 fs/ext4/ialloc.c                          |    7 ++
 fs/jbd2/transaction.c                     |    1=20
 include/asm-generic/vmlinux.lds.h         |    2=20
 include/linux/mtd/flashchip.h             |    1=20
 include/linux/serial_core.h               |   21 ++++---
 include/linux/tty.h                       |    2=20
 include/linux/virtio.h                    |    3 +
 include/sound/control.h                   |    7 +-
 lib/kobject.c                             |   12 +---
 net/ceph/messenger.c                      |    7 ++
 net/ceph/mon_client.c                     |   14 +++-
 sound/core/pcm_native.c                   |    1=20
 sound/core/seq/oss/seq_oss_event.c        |   15 +++--
 sound/core/seq/oss/seq_oss_midi.c         |    2=20
 sound/core/seq/oss/seq_oss_synth.c        |   85 +++++++++++++++++--------=
-----
 sound/core/seq/oss/seq_oss_synth.h        |    3 -
 sound/drivers/opl3/opl3_synth.c           |    7 +-
 sound/firewire/dice/dice-stream.c         |    2=20
 sound/firewire/dice/dice.c                |    2=20
 sound/pci/asihpi/hpimsginit.c             |   13 +++-
 sound/pci/asihpi/hpioctl.c                |    4 +
 sound/pci/hda/hda_hwdep.c                 |   12 +++-
 sound/pci/hda/patch_realtek.c             |    2=20
 sound/pci/rme9652/hdspm.c                 |   24 ++++----
 sound/pci/rme9652/rme9652.c               |    6 +-
 sound/soc/fsl/fsl_esai.c                  |    7 ++
 sound/usb/mixer_maps.c                    |    3 +
 tools/lib/str_error_r.c                   |    2=20
 tools/lib/subcmd/pager.c                  |    5 +
 65 files changed, 586 insertions(+), 232 deletions(-)

Arnd Bergmann (1):
      x86/ipc: Fix x32 version of shmid64_ds and msqid64_ds

Borislav Petkov (1):
      x86/microcode/intel: Save microcode patch unconditionally

Collin May (1):
      USB: serial: simple: add libtransistor console

Daniel Kurtz (1):
      earlycon: Use a pointer table to fix __earlycon_table stride

David Henningsson (1):
      ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr

Dmitry Vyukov (1):
      kobject: don't use WARN for registration failures

Eric Biggers (1):
      ext4: prevent right-shifting extents beyond EXT_MAX_BLOCKS

Evan Wang (1):
      PCI: aardvark: Fix PCIe Max Read Request Size setting

Geert Uytterhoeven (3):
      ARM: amba: Make driver_override output consistent with other buses
      ARM: amba: Fix race condition with driver_override
      ARM: amba: Don't read past the end of sysfs "driver_override" buffer

Gerd Hoffmann (1):
      drm/virtio: fix vq wait_event condition

Greg Kroah-Hartman (1):
      Linux 4.9.98

Ilya Dryomov (3):
      libceph: un-backoff on tick when we have a authenticated session
      libceph: reschedule a tick in finish_hunting()
      libceph: validate con->state at the top of try_write()

Joakim Tjernlund (3):
      mtd: cfi: cmdset_0001: Do not allow read/write to suspend erase block.
      mtd: cfi: cmdset_0001: Workaround Micron Erase suspend bug.
      mtd: cfi: cmdset_0002: Do not allow read/write to suspend erase block.

Josh Poimboeuf (1):
      objtool, perf: Fix GCC 8 -Wrestrict error

Kailang Yang (1):
      ALSA: hda/realtek - Add some fixes for ALC233

Kamil Lulko (1):
      usb: core: Add quirk for HP v222w 16GB Mini

Kyle Roeschley (1):
      USB: serial: cp210x: add ID for NI USB serial console

Lukas Czerner (1):
      ext4: fix bitmap position validation

Mahesh Rajashekhara (1):
      scsi: sd: Defer spinning up drive while SANITIZE is in progress

Michael Neuling (1):
      powerpc/eeh: Fix race with driver un/bind

Michael S. Tsirkin (2):
      virtio: add ability to iterate over vqs
      virtio_console: free buffers after reset

Nicholas Piggin (1):
      rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops

Nicolai H=E4hnle (1):
      drm/amdgpu: set COMPUTE_PGM_RSRC1 for SGPR/VGPR clearing shaders

Nicolin Chen (1):
      ASoC: fsl_esai: Fix divisor calculation failure at lower ratio

Ravi Chandra Sadineni (1):
      USB: Increment wakeup count on remote wakeup.

Sergey Senozhatsky (1):
      tools/lib/subcmd/pager.c: do not alias select() params

Shilpasri G Bhat (1):
      cpufreq: powernv: Fix hardlockup due to synchronous smp_call in timer=
 interrupt

Shuah Khan (3):
      usbip: usbip_event: fix to not print kernel pointer address
      usbip: usbip_host: fix to hold parent lock for device_attach() calls
      usbip: vhci_hcd: Fix usb device and sockfd leaks

Stephan Mueller (1):
      crypto: drbg - set freed buffers to NULL

Takashi Iwai (9):
      ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
      ALSA: opl3: Hardening for potential Spectre v1
      ALSA: asihpi: Hardening for potential Spectre v1
      ALSA: hdspm: Hardening for potential Spectre v1
      ALSA: rme9652: Hardening for potential Spectre v1
      ALSA: control: Hardening for potential Spectre v1
      ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
      ALSA: seq: oss: Hardening for potential Spectre v1
      ALSA: hda: Hardening for potential Spectre v1

Takashi Sakamoto (2):
      ALSA: dice: fix OUI for TC group
      ALSA: dice: fix error path to destroy initialized stream data

Tetsuo Handa (2):
      tty: Don't call panic() at tty_ldisc_init()
      tty: Use __GFP_NOFAIL for tty_ldisc_get()

Theodore Ts'o (5):
      ext4: set h_journal if there is a failure starting a reserved handle
      ext4: add validity checks for bitmap block numbers
      random: set up the NUMA crng instances after the CRNG is fully initia=
lized
      random: fix possible sleeping allocation from irq context
      random: rate limit unseeded randomness warnings

Tony Lindgren (2):
      tty: n_gsm: Fix long delays with control frame timeouts in ADM mode
      tty: n_gsm: Fix DLCI handling for ADM mode if debug & 2 is not set

Vasyl Vavrychuk (1):
      USB: serial: ftdi_sio: use jtag quirk for Arrow USB Blaster

Victor Gu (2):
      PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
      PCI: aardvark: Set PIO_ADDR_LS correctly in advk_pcie_rd_conf()

Yazen Ghannam (1):
      x86/smpboot: Don't use mwait_play_dead() on AMD systems


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrp6aoACgkQONu9yGCS
aT7gHQ//bsR9vOd43BGUTjZ8HcvWBO3XtLGV1WwANMbcZ+HFCegy8yMwYm/v5LpE
BdxjVnk07IZu9RqXBmuzLjc7Iy9ESvD4hBKSqNc1kqAEjIJo/p++TDPyPjiUBO0W
rPQQ6f4Bcr0N6NQzKAAKCWHokmQw0Epp1afkCBGfRrBaPuECjoLDM1ihmA5G01rc
BWCktalNNzCwTKgKaaqrbD1IPwMx45B4GKelY4vK62DJNoslsFAUeLl0+lsC6kVz
hsRgdLf2J9gFrlmmtvJADmMwrrZEYZCrHXXCWiPC6LPk/IKvzpueajPd9HvMYEPB
7f1YW/qnJ02NyOguX7FcR8RaACnt2y/kmWh54kvDul3c2WZOZG7aBxXJytZ16GR8
dYViWpzrONqwsOY8lNroB2nwU07N6EqyGWZ7Sf1Kd+0fI36P//oaPjH1SovOgKeX
0CluGLkRtcfqRDOcPrKnIhnUXHTkW239CYpPsmjdOJoQMH6CtrXSineZKk5JP0Gj
lK0wNldzD5ecJJRxc7agQRqScw1CgvPkj+Dgt57TRKZuggvLmvqx7mU2gYV92ofh
2I7WYkOk64KjLRv2oldpkhbysnxIikvK9xWrWCzotNzO941wKAjpGiibVHRdoYun
J9WVvglG+G471Lltd0+BeH1lcVYNrm5/sZGjjLYzDMXJGhdq3QU=
=NtBJ
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
