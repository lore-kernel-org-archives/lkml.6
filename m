Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451319-1523200039-2-12298019258629075532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523200038; b=acEMpMfYzTWgwgLcukSaYU84O1D8bcoCJE0IuU8BUQrfPBqKfN
    dJdmgXi6vdVzlbJCr02QG+lDyAFp6SutdGsoPMIRep+pV8E/fcjswzD9WSXd6OyJ
    owmAiS8UV7wrMgyIjX1ktbbOYeoosm8wnrLikyTeMfB1Lq/cLElzGtzbpeCgQGyM
    D0z8NMjmfx+2SQfpHCd8KwuqtW4ulGtHDcoSo7rz1sAV2KlQTkwB7cu1oMJI5Tps
    EL6ISgDtbyeoGtyPHNypEWgoLlCo6vOQoZvnozPOFlsBksNYXRs5b4hEV1TF9rx7
    DiQE8YceUQXGfJM235tFrGunGeodJYI/NV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523200038;
    bh=BUVoZqq8PAg6Tz2bmxmDwCVPPfgW4jgH2zArPNCPQZQ=; b=aLVTjeAQpTUB
    V269n+3RkRsITwKW2gjK4tFqMm3QOVOSa5ZeUN3GIg6jslVY7MrDzy30s3XyfHQQ
    pXOIjYH9xDLjaVItGPr5kjtNhT5bU2HaQASdsadP6EripgvDE4lhSwKA4DmuZOcn
    e1fjkg91y2UY2BsE0L7LiSmsoVI0DQRIbL2+iq+7yR5Dpfdoe21pi8bOeCY8f/ch
    xqYmmEcVVPi2r0oq8l82ZyZXc18Rku7LZZWZz4cUKx3sdDDMmFdRLEmlMB0Vlgvn
    +M6kOUxI3bVxXOe2CXte/JFgU0ZXSubaElMOUWqxXCmva8lMPbRlSKPUzZaSYAai
    5XiG216Mdw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBPlNxw6K1MqxtTKNN1BK3uHcDjSErKjz0qAtHI70OuUdBXuXy59DFBuAYScJRNoraezuxbqA+zCXJkWricXpuaLvDiHEe1UOpmXgyIzNyjC+yABCSWo
    mEmD5gFRUEmg5NnPA+kniPDVq1XJIp3RljW9A3GeqA0z64QHZ+qcW9sU8Ayu9JqZ3y2rGjH98645I5VPrTqCC66bA3EqfSolwqnCcAjVvC/vAksH+5tEGVGH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=xGHKQzQ9vTqmjHLhYlMA:9 a=-pbtvG5cNJLG_XbY:21 a=aJmnnRNRUfpEBIM8:21
    a=CjuIK1q_8ugA:10 a=4xJyXCPDaj8ql-uvam8A:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbeDHPHP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 11:07:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeDHPHO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 8 Apr 2018 11:07:14 -0400
Date: Sun, 8 Apr 2018 17:07:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.103
Message-ID: <20180408150708.GA15675@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.103 kernel.

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

 Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt |    9=20
 Documentation/filesystems/proc.txt                           |   31=20
 Makefile                                                     |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                          |    2=20
 arch/arm/boot/dts/dra7-evm.dts                               |    2=20
 arch/arm/boot/dts/omap3-n900.dts                             |    4=20
 arch/x86/crypto/cast5_avx_glue.c                             |    3=20
 arch/x86/include/asm/vmx.h                                   |    1=20
 arch/x86/kernel/kprobes/core.c                               |    9=20
 arch/x86/kvm/vmx.c                                           |    9=20
 block/partitions/msdos.c                                     |    4=20
 crypto/ahash.c                                               |    7=20
 drivers/ata/libata-core.c                                    |   26=20
 drivers/ata/libata-scsi.c                                    |    4=20
 drivers/gpu/drm/udl/udl_fb.c                                 |    9=20
 drivers/input/serio/i8042-x86ia64io.h                        |   24=20
 drivers/leds/led-core.c                                      |    2=20
 drivers/md/raid10.c                                          |    1=20
 drivers/media/usb/usbtv/usbtv-core.c                         |    2=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c                | 1020 ++++++=
-----
 drivers/media/v4l2-core/v4l2-ctrls.c                         |   96 -
 drivers/media/v4l2-core/v4l2-ioctl.c                         |    5=20
 drivers/media/v4l2-core/videobuf2-core.c                     |    5=20
 drivers/misc/mei/main.c                                      |    1=20
 drivers/mtd/chips/jedec_probe.c                              |    2=20
 drivers/net/can/cc770/cc770.c                                |  100 -
 drivers/net/can/cc770/cc770.h                                |    2=20
 drivers/net/ethernet/arc/emac_rockchip.c                     |    6=20
 drivers/net/ethernet/freescale/fec_main.c                    |    2=20
 drivers/net/team/team.c                                      |    4=20
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c                |   24=20
 drivers/parport/parport_pc.c                                 |    4=20
 drivers/pci/pci-driver.c                                     |    2=20
 drivers/s390/net/qeth_core_main.c                            |   21=20
 drivers/s390/net/qeth_l2_main.c                              |    2=20
 drivers/s390/net/qeth_l3_main.c                              |    2=20
 drivers/scsi/sg.c                                            |    5=20
 drivers/scsi/virtio_scsi.c                                   |    1=20
 drivers/tty/vt/vt.c                                          |   14=20
 drivers/usb/gadget/function/f_hid.c                          |   24=20
 drivers/usb/gadget/function/f_midi.c                         |    6=20
 drivers/usb/gadget/function/f_sourcesink.c                   |    6=20
 drivers/usb/gadget/function/g_zero.h                         |    1=20
 drivers/usb/gadget/u_f.c                                     |    6=20
 drivers/usb/gadget/u_f.h                                     |   26=20
 drivers/usb/host/xhci-mem.c                                  |    3=20
 drivers/usb/serial/cp210x.c                                  |    1=20
 drivers/usb/serial/ftdi_sio.c                                |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                            |    9=20
 fs/ncpfs/ncplib_kernel.c                                     |    4=20
 fs/proc/task_mmu.c                                           |   63=20
 fs/proc/task_nommu.c                                         |   43=20
 include/linux/mm.h                                           |    3=20
 include/linux/netfilter/x_tables.h                           |    2=20
 include/linux/usb/gadget.h                                   |   17=20
 include/uapi/linux/usb/audio.h                               |    4=20
 kernel/events/hw_breakpoint.c                                |   30=20
 kernel/irq/manage.c                                          |    4=20
 kernel/kprobes.c                                             |    2=20
 kernel/trace/trace_kprobe.c                                  |    4=20
 kernel/trace/trace_probe.c                                   |    8=20
 kernel/trace/trace_probe.h                                   |    2=20
 mm/util.c                                                    |   27=20
 net/bluetooth/smp.c                                          |    8=20
 net/bridge/netfilter/ebt_among.c                             |   34=20
 net/core/skbuff.c                                            |    2=20
 net/dccp/proto.c                                             |    5=20
 net/ipv4/ip_sockglue.c                                       |    6=20
 net/ipv6/ndisc.c                                             |    3=20
 net/iucv/af_iucv.c                                           |    4=20
 net/l2tp/l2tp_core.c                                         |    8=20
 net/netfilter/x_tables.c                                     |   30=20
 net/netfilter/xt_hashlimit.c                                 |    5=20
 net/netfilter/xt_recent.c                                    |    6=20
 net/netlink/genetlink.c                                      |    2=20
 net/xfrm/xfrm_ipcomp.c                                       |    2=20
 net/xfrm/xfrm_state.c                                        |    5=20
 net/xfrm/xfrm_user.c                                         |   21=20
 sound/core/oss/pcm_oss.c                                     |    4=20
 sound/core/pcm_native.c                                      |    2=20
 sound/drivers/aloop.c                                        |   17=20
 81 files changed, 1175 insertions(+), 755 deletions(-)

Alexander Gerasiov (1):
      parport_pc: Add support for WCH CH382L PCI-E single parallel port car=
d.

Alexey Kodanev (1):
      dccp: check sk for closed state in dccp_sendmsg()

Andri Yngvason (3):
      can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack
      can: cc770: Fix queue stall & dropped RTR reply
      can: cc770: Fix use after free in cc770_tx_interrupt()

Andy Lutomirski (1):
      fs/proc: Stop trying to report thread stacks

Arend Van Spriel (1):
      brcmfmac: fix P2P_DEVICE ethernet address generation

Arkadi Sharshevsky (1):
      team: Fix double free in error path

Arvind Yadav (1):
      net/iucv: Free memory obtained by kzalloc

Ben Hutchings (2):
      Revert "led: core: Fix brightness setting when setting delay_off=3D0"
      xhci: Fix ring leak in failure path of xhci_alloc_virt_device()

Christophe JAILLET (1):
      net: ethernet: arc: Fix a potential memory leak if an optional regula=
tor is deferred

Clemens Werther (1):
      USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Colin Ian King (1):
      mei: remove dev_err message on an unsupported ioctl

Dan Carpenter (2):
      staging: ncpfs: memory corruption in ncp_read_kernel()
      ALSA: pcm: potential uninitialized return values

Daniel Mentz (2):
      media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
      media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

David Ahern (1):
      net: Only honor ifindex in IP_PKTINFO if non-0

Dennis Wassenberg (1):
      Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Eric Biggers (3):
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data
      crypto: x86/cast5-avx - fix ECB encryption when long sg follows short=
 one

Eric Dumazet (1):
      l2tp: do not accept arbitrary sockets

Felipe F. Tonello (4):
      usb: gadget: define free_ep_req as universal function
      usb: gadget: change len to size_t on alloc_ep_req()
      usb: gadget: fix usb_ep_align_maybe endianness and new usb_ep_align
      usb: gadget: align buffer size when allocating for OUT endpoint

Florian Fainelli (1):
      net: fec: Fix unbalanced PM runtime calls

Florian Westphal (3):
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: bridge: ebt_among: add more missing match size checks
      netfilter: x_tables: add and use xt_check_proc_name

Greg Hackmann (1):
      net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Greg Kroah-Hartman (6):
      drm: udl: Properly check framebuffer mmap offsets
      Revert "genirq: Use irqd_get_trigger_type to compare the trigger type=
 for shared IRQs"
      Revert "PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()"
      Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"
      Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"
      Linux 3.18.103

Guoqing Jiang (1):
      md/raid10: reset the 'first' at the end of loop

Hans Verkuil (12):
      media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
      media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
      media: v4l2-compat-ioctl32.c: fix the indentation
      media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4=
l2_format32
      media: v4l2-compat-ioctl32.c: avoid sizeof(type)
      media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
      media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
      media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
      media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
      media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
      media: v4l2-compat-ioctl32.c: don't copy back the result for certain =
errors
      media: v4l2-ctrls: fix sparse warning

Hans de Goede (4):
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware vers=
ions
      libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 versi=
on

Herbert Xu (1):
      crypto: ahash - Fix early termination in hash walk

Johan Hovold (1):
      USB: serial: cp210x: add ELDAT Easywave RX09 id

Johannes Thumshirn (1):
      scsi: sg: don't return bogus Sg_requests

Johannes Weiner (1):
      proc: revert /proc/<pid>/maps [stack:TID] annotation

Ju Hyung Park (1):
      libata: Enable queued TRIM for Samsung SSD 860

Julian Wiedmann (4):
      s390/qeth: free netdevice when removing a card
      s390/qeth: when thread completes, wake up all waiters
      s390/qeth: lock read device while queueing next buffer
      s390/qeth: on channel error, reject further cmd requests

Kai-Heng Feng (1):
      libata: disable LPM for Crucial BX100 SSD 500GB drive

Keerthy (2):
      Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override prop=
erty definition
      ARM: dts: dra7: Add power hold and power controller properties to pal=
mas

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Krzysztof Opasiak (1):
      usb: gadget: f_hid: fix: Prevent accessing released memory

Linus Torvalds (3):
      tty: vt: fix up tabstops properly
      kvm/x86: fix icebp instruction handling
      perf/hwbp: Simplify the perf-hwbp code, fix documentation

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()

Lorenzo Bianconi (1):
      ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_opti=
on()

Major Hayden (1):
      USB: serial: ftdi_sio: add RT Systems VX-8 cable

Masami Hiramatsu (2):
      tracing: probeevent: Fix to support minus offset from symbol
      kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Mauro Carvalho Chehab (2):
      media: v4l2-compat-ioctl32: use compat_u64 for video standard
      media: v4l2-compat-ioctl32: initialize a reserved field

Mike Frysinger (1):
      vt: change SGR 21 to follow the standards

Nicolas Dichtel (1):
      netlink: avoid a double skb free in genlmsg_mcast()

Oliver Neukum (1):
      media: usbtv: prevent double free in error case

Ondrej Zary (1):
      Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Paolo Bonzini (1):
      scsi: virtio_scsi: always read VPD pages for multiqueue too

Ricardo Ribalda (2):
      vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
      media: media/v4l2-ctrls: volatiles should not generate CH_VALUE

Richard Narron (1):
      partitions/msdos: Unable to mount UFS 44bsd partitions

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Steffen Klassert (1):
      xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit sys=
tems

Szymon Janc (1):
      Bluetooth: Fix missing encryption refresh on Security Request

Takashi Iwai (2):
      ALSA: aloop: Sync stale timer before release
      ALSA: aloop: Fix access to not-yet-ready substream via cable

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrKMBkACgkQONu9yGCS
aT4GQQ//Ydh4I+zhRfThCOOlm3+Y5uPHm9c2CD/O896+oYYXFZX+bg5/ADUEwDNa
g5b5ca1dCYsrlKZwuGT9TqXYvqHeVbtthba/9E2L3oqWH3/Uu+a3OWSt4Q6vaLvK
1CjwJajBRNcGRkdtWVj1+bbpl34CgoRCiejnEAR6hiGnOykmQlc0AipB7HjCxh3F
rih2ATtySMTnCtOtTcu/R0TCqor0CfkFjERSvs+4MHRY3uIzrlFcnBeFCTbNUf7W
8kaoCBjVmEjS7J64Cn5klMrdbaLXpvyMhae+v7jM48R8pdQ5uxxrRCB4bUbD37z0
kZNQnFmdUtnH5D2YW67Q+hYe84S6WRQ1xYGcpZJiTfWEdH08pv0NZclOR6hCpxv3
WxJwYOXwNOQjvgzTIj5jwIcZXAvvcDomb7lKN8sbHJSR1i1v3VYSTHDqeMJBSdC6
2JKnN3yw/kJdACcinJfuxbL9QZKET5me6VDhU0A4Hf1vKFVpZnchfqu24cBtg32D
sFiRBNwU/idhV6QufsdsQchInLCwDok6AmqT9mW3mku+SiACc81Mtx3zGl/bNOYq
hM2I6xkX4zjBOwoxoO6RFMtMXJFTixEIm5hWPoghzGsnbDd5t3DTCDjg5tir9cJ5
hjJsbzktF1l+TUOHhKJi9ILTahReVOqfaRCwxUDjwzTSW3ywcKs=
=arNO
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
