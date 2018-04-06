Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021146-2-18186457469245031141
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021145; b=OB47TeMCqLaTVOYH/BYYV5QJ9vvcQLQUv6ygg/e/yus40pZgyF
    /dgTYluanRI+OSZ4/ZFBE3iVBOw70rEbjybjvuXdMejOoeUCk9vxAcKe1nMwi4Iy
    upkjT153PCbf7Xs+yAqhEzDdK/Pz7ZBQ6u6d/PKxSSEXOlCbbJx9IftFojXRD9iu
    AcbX7tiO/sV3SMK6V1OteuuXeobwAyoZqLp/LKfrR9naMYz88HtpzE6Zlbc+n/dd
    W2hlIZSXWBGvcdgKex0WMSPJSY2RM9pNMVLeznycxE628h+USmakwL68UFPH0ISk
    lKSL5nnvbZwgRKp5Yu5pHCQqMkcbTBsUldgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523021145; bh=ts5vT7o5b5TUZcvihfry7bGDEghLib
    RpQxRLHxPvBgc=; b=i0ifWUssuc0YzZP422k2DqyrnRt4Uxp03SU/tQy3+GiYIU
    Gv1cTosdm2pLuv+q85D1O0H4CgDNxA7ClMu3K8FjmgumK2OSlDJih8kEdPLA2FhD
    jaevDJfTdxmeSNsGAivM/qqxjGcPFEQ6dzPTH8ClyxxceuzhhibZ5nKUwX+Hgv+T
    1doGmf0tbmPGOXZiFqDbF4+aY9MMsCnGKrTNvCt67QRBaRDdX/71mT6/wv0QOSCj
    oanPpaCpplSD3ho2gh9aI6IljQUFikFeZX+ZtU3fytTeALnWfhrsYmk3jZGYLNyI
    EhiKyFE/PgyvMK+n8h81f0BgaxGQ0Tne8xqyKtng==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDL+US09VIp+mjGFHylyQVYshTimbm3xcVFaD5EBUgHFRNnZ0X62AuYujRF1roC0+bMweWJyo+Ac1awU6f5k8g5GE1djP4TtKNZQLRKl3rBCwcKU/BrL
    zRz/JsLWM7W5J1FOimB85zSptQEn4TLwKyq0DpjOQ52+vQONqZMI3XJNO/e079VEm+NLEXlyllQLhTWA9dKLAPFzXTaOaPYFl6cPtFcr5ZncMughxxw/Dj5S
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=RRRRr2VPVCgA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=iox4zFpeAAAA:8 a=sozttTNsAAAA:8
    a=cm27Pg_UAAAA:8 a=AgaioDkCAAAA:8 a=7ZN4cI0QAAAA:8 a=ufHFDILaAAAA:8
    a=1XWaLZrsAAAA:8 a=FNyBlpCuAAAA:8 a=ttLlOQO2AAAA:8 a=DfNHnWVPAAAA:8
    a=pGLkceISAAAA:8 a=xLcVsCfpAAAA:8 a=vQBBkBfzAAAA:8 a=AUd_NHdVAAAA:8
    a=20KFwNOVAAAA:8 a=1EsaE_6oAAAA:8 a=w7XRow0EAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=CbDCq_QkAAAA:8
    a=QyXUC8HyAAAA:8 a=4YC7WVefAAAA:8 a=nTPwkA1SAAAA:8 a=Q-fNiiVtAAAA:8
    a=O7NPPQOqRjlRvzojiA4A:9 a=DVWIchCFlw767sp1:21 a=x2y1fnD_Hf3pl1gY:21
    a=2t5KsnBapy4A:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=aeg5Gbbo78KNqacMgKqU:22 a=xmb-EsYY8bH0VWELuYED:22
    a=eNS--96rZ24oWIaEtn_1:22 a=Dl0WHwQvj8hGZljrFLtM:22 a=ZmIg1sZ3JBWsdXgziEIF:22
    a=RlW-AWeGUCXs_Nkyno-6:22 a=1BJeXTq6bvZE9X1NrNaC:22 a=rjTVMONInIDnV1a_A2c_:22
    a=4-ZGFxpmiTxXQSWJmrgh:22 a=NGXS0kB0m_rannUenejW:22 a=3ZumFrijQQ-2J9H5h8ct:22
    a=wbvQwYS7zXXSDml_C_4i:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeDFNZk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:25:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbeDFNZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:25:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/93] 3.18.103-stable review
Date: Fri,  6 Apr 2018 15:22:29 +0200
Message-Id: <20180406084224.918716300@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.103-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.103-rc1
X-KernelTest-Deadline: 2018-04-08T08:42+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.103 release.
There are 93 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr  8 08:42:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.103-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.103-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: omap3-n900: Fix the audio CODEC's reset pin"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()"

Guoqing Jiang <gqjiang@suse.com>
    md/raid10: reset the 'first' at the end of loop

Keerthy <j-keerthy@ti.com>
    ARM: dts: dra7: Add power hold and power controller properties to palmas

Keerthy <j-keerthy@ti.com>
    Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition

Mike Frysinger <vapier@chromium.org>
    vt: change SGR 21 to follow the standards

Ondrej Zary <linux@rainbow-software.org>
    Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Andy Lutomirski <luto@kernel.org>
    fs/proc: Stop trying to report thread stacks

Johannes Weiner <hannes@cmpxchg.org>
    proc: revert /proc/<pid>/maps [stack:TID] annotation

Eric Biggers <ebiggers@google.com>
    crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: ahash - Fix early termination in hash walk

Alexander Gerasiov <gq@redlab-i.ru>
    parport_pc: Add support for WCH CH382L PCI-E single parallel port card.

Oliver Neukum <oneukum@suse.com>
    media: usbtv: prevent double free in error case

Colin Ian King <colin.king@canonical.com>
    mei: remove dev_err message on an unsupported ioctl

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add ELDAT Easywave RX09 id

Clemens Werther <clemens.werther@gmail.com>
    USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Major Hayden <major@mhtx.net>
    USB: serial: ftdi_sio: add RT Systems VX-8 cable

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: v4l2-compat-ioctl32: initialize a reserved field

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: v4l2-compat-ioctl32: use compat_u64 for video standard

Ricardo Ribalda <ricardo.ribalda@gmail.com>
    media: media/v4l2-ctrls: volatiles should not generate CH_VALUE

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-ctrls: fix sparse warning

Daniel Mentz <danielmentz@google.com>
    media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32

Daniel Mentz <danielmentz@google.com>
    media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha

Hans Verkuil <hansverk@cisco.com>
    media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: avoid sizeof(type)

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4l2_format32

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: fix the indentation

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF

Ricardo Ribalda <ricardo.ribalda@gmail.com>
    vb2: V4L2_BUF_FLAG_DONE is set after DQBUF

Hans Verkuil <hans.verkuil@cisco.com>
    media: v4l2-ioctl.c: don't copy back the result for -ENOTTY

Paolo Bonzini <pbonzini@redhat.com>
    scsi: virtio_scsi: always read VPD pages for multiqueue too

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix missing encryption refresh on Security Request

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: add and use xt_check_proc_name

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add more missing match size checks

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems

Greg Hackmann <ghackmann@google.com>
    net: xfrm: use preempt-safe this_cpu_read() in ipcomp_alloc_tfms()

Florian Westphal <fw@strlen.de>
    xfrm_user: uncoditionally validate esn replay attribute struct

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes/x86: Fix to set RWX bits correctly before releasing trampoline

Ben Hutchings <ben.hutchings@codethink.co.uk>
    xhci: Fix ring leak in failure path of xhci_alloc_virt_device()

Ben Hutchings <ben.hutchings@codethink.co.uk>
    Revert "led: core: Fix brightness setting when setting delay_off=0"

Krzysztof Opasiak <kopasiak90@gmail.com>
    usb: gadget: f_hid: fix: Prevent accessing released memory

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: align buffer size when allocating for OUT endpoint

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: fix usb_ep_align_maybe endianness and new usb_ep_align

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: change len to size_t on alloc_ep_req()

Felipe F. Tonello <eu@felipetonello.com>
    usb: gadget: define free_ep_req as universal function

Richard Narron <comet.berkeley@gmail.com>
    partitions/msdos: Unable to mount UFS 44bsd partitions

Linus Torvalds <torvalds@linux-foundation.org>
    perf/hwbp: Simplify the perf-hwbp code, fix documentation

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: pcm: potential uninitialized return values

Stefan Roese <sr@denx.de>
    ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Linus Walleij <linus.walleij@linaro.org>
    mtd: jedec_probe: Fix crash in jedec_read_mfr()

Florian Fainelli <f.fainelli@gmail.com>
    net: fec: Fix unbalanced PM runtime calls

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: on channel error, reject further cmd requests

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: lock read device while queueing next buffer

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: when thread completes, wake up all waiters

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qeth: free netdevice when removing a card

Arkadi Sharshevsky <arkadis@mellanox.com>
    team: Fix double free in error path

Vinicius Costa Gomes <vinicius.gomes@intel.com>
    skbuff: Fix not waking applications when errors are enqueued

David Ahern <dsahern@gmail.com>
    net: Only honor ifindex in IP_PKTINFO if non-0

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    netlink: avoid a double skb free in genlmsg_mcast()

Arvind Yadav <arvind.yadav.cs@gmail.com>
    net/iucv: Free memory obtained by kzalloc

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net: ethernet: arc: Fix a potential memory leak if an optional regulator is deferred

Eric Dumazet <edumazet@google.com>
    l2tp: do not accept arbitrary sockets

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv6: fix access to non-linear packet in ndisc_fill_redirect_hdr_option()

Alexey Kodanev <alexey.kodanev@oracle.com>
    dccp: check sk for closed state in dccp_sendmsg()

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "genirq: Use irqd_get_trigger_type to compare the trigger type for shared IRQs"

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sg: don't return bogus Sg_requests

Linus Torvalds <torvalds@linux-foundation.org>
    kvm/x86: fix icebp instruction handling

Linus Torvalds <torvalds@linux-foundation.org>
    tty: vt: fix up tabstops properly

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix use after free in cc770_tx_interrupt()

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix queue stall & dropped RTR reply

Andri Yngvason <andri.yngvason@marel.com>
    can: cc770: Fix stalls on rt-linux, remove redundant IRQ ack

Dan Carpenter <dan.carpenter@oracle.com>
    staging: ncpfs: memory corruption in ncp_read_kernel()

Masami Hiramatsu <mhiramat@kernel.org>
    tracing: probeevent: Fix to support minus offset from symbol

Arend Van Spriel <arend.vanspriel@broadcom.com>
    brcmfmac: fix P2P_DEVICE ethernet address generation

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    drm: udl: Properly check framebuffer mmap offsets

Hans de Goede <hdegoede@redhat.com>
    libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version

Hans de Goede <hdegoede@redhat.com>
    libata: Make Crucial BX100 500GB LPM quirk apply to all firmware versions

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs

Ju Hyung Park <qkrwngud825@gmail.com>
    libata: Enable queued TRIM for Samsung SSD 860

Kai-Heng Feng <kai.heng.feng@canonical.com>
    libata: disable LPM for Crucial BX100 SSD 500GB drive

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs

Eric Biggers <ebiggers@google.com>
    libata: remove WARN() for DMA or PIO command without data

Eric Biggers <ebiggers@google.com>
    libata: fix length validation of ATAPI-relayed SCSI commands

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Fix access to not-yet-ready substream via cable

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Sync stale timer before release

Kirill Marinushkin <k.marinushkin@gmail.com>
    ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit


-------------

Diffstat:

 .../devicetree/bindings/pinctrl/pinctrl-palmas.txt |    9 +
 Documentation/filesystems/proc.txt                 |   31 +-
 Makefile                                           |    4 +-
 arch/arm/boot/dts/am335x-pepper.dts                |    2 +-
 arch/arm/boot/dts/dra7-evm.dts                     |    2 +
 arch/arm/boot/dts/omap3-n900.dts                   |    4 +-
 arch/x86/crypto/cast5_avx_glue.c                   |    3 +-
 arch/x86/include/asm/vmx.h                         |    1 +
 arch/x86/kernel/kprobes/core.c                     |    9 +
 arch/x86/kvm/vmx.c                                 |    9 +-
 block/partitions/msdos.c                           |    4 +-
 crypto/ahash.c                                     |    7 +-
 drivers/ata/libata-core.c                          |   26 +-
 drivers/ata/libata-scsi.c                          |    4 +-
 drivers/gpu/drm/udl/udl_fb.c                       |    9 +-
 drivers/input/serio/i8042-x86ia64io.h              |   24 +
 drivers/leds/led-core.c                            |    2 +-
 drivers/md/raid10.c                                |    1 +
 drivers/media/usb/usbtv/usbtv-core.c               |    2 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      | 1020 ++++++++++++--------
 drivers/media/v4l2-core/v4l2-ctrls.c               |   96 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    5 +-
 drivers/media/v4l2-core/videobuf2-core.c           |    5 +
 drivers/misc/mei/main.c                            |    1 -
 drivers/mtd/chips/jedec_probe.c                    |    2 +
 drivers/net/can/cc770/cc770.c                      |  100 +-
 drivers/net/can/cc770/cc770.h                      |    2 +
 drivers/net/ethernet/arc/emac_rockchip.c           |    6 +-
 drivers/net/ethernet/freescale/fec_main.c          |    2 +
 drivers/net/team/team.c                            |    4 +-
 drivers/net/wireless/brcm80211/brcmfmac/p2p.c      |   24 +-
 drivers/parport/parport_pc.c                       |    4 +
 drivers/pci/pci-driver.c                           |    2 +
 drivers/s390/net/qeth_core_main.c                  |   21 +-
 drivers/s390/net/qeth_l2_main.c                    |    2 +-
 drivers/s390/net/qeth_l3_main.c                    |    2 +-
 drivers/scsi/sg.c                                  |    5 +-
 drivers/scsi/virtio_scsi.c                         |    1 +
 drivers/tty/vt/vt.c                                |   14 +-
 drivers/usb/gadget/function/f_hid.c                |   24 +-
 drivers/usb/gadget/function/f_midi.c               |    6 -
 drivers/usb/gadget/function/f_sourcesink.c         |    6 -
 drivers/usb/gadget/function/g_zero.h               |    1 -
 drivers/usb/gadget/u_f.c                           |    6 +-
 drivers/usb/gadget/u_f.h                           |   26 +-
 drivers/usb/host/xhci-mem.c                        |    3 +-
 drivers/usb/serial/cp210x.c                        |    1 +
 drivers/usb/serial/ftdi_sio.c                      |    2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |    9 +
 fs/ncpfs/ncplib_kernel.c                           |    4 +
 fs/proc/task_mmu.c                                 |   63 +-
 fs/proc/task_nommu.c                               |   43 +-
 include/linux/mm.h                                 |    3 +-
 include/linux/netfilter/x_tables.h                 |    2 +
 include/linux/usb/gadget.h                         |   17 +-
 include/uapi/linux/usb/audio.h                     |    4 +-
 kernel/events/hw_breakpoint.c                      |   30 +-
 kernel/irq/manage.c                                |    4 +-
 kernel/kprobes.c                                   |    2 +-
 kernel/trace/trace_kprobe.c                        |    4 +-
 kernel/trace/trace_probe.c                         |    8 +-
 kernel/trace/trace_probe.h                         |    2 +-
 mm/util.c                                          |   27 +-
 net/bluetooth/smp.c                                |    8 +-
 net/bridge/netfilter/ebt_among.c                   |   34 +
 net/core/skbuff.c                                  |    2 +-
 net/dccp/proto.c                                   |    5 +
 net/ipv4/ip_sockglue.c                             |    6 +-
 net/ipv6/ndisc.c                                   |    3 +-
 net/iucv/af_iucv.c                                 |    4 +-
 net/l2tp/l2tp_core.c                               |    8 +-
 net/netfilter/x_tables.c                           |   30 +
 net/netfilter/xt_hashlimit.c                       |    5 +-
 net/netfilter/xt_recent.c                          |    6 +-
 net/netlink/genetlink.c                            |    2 +-
 net/xfrm/xfrm_ipcomp.c                             |    2 +-
 net/xfrm/xfrm_state.c                              |    5 +
 net/xfrm/xfrm_user.c                               |   21 +-
 sound/core/oss/pcm_oss.c                           |    4 +-
 sound/core/pcm_native.c                            |    2 +-
 sound/drivers/aloop.c                              |   17 +-
 81 files changed, 1176 insertions(+), 756 deletions(-)
