Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022357-2-5584737725794321681
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
    1523022356; b=gt2zqj3ZIkfm/fSOYqB4ExDHWXcvTMplsnjeOXykTRI1h8YBYu
    iKAAQfQDiIuOb7+5PYYOaacWH08N4hvQwCOXguNTrQzxAdDQsN05rIS591gCgd1R
    wSWDqTKLywKdnESMeSqFmOWG7lG1SVfV049koOBMmKUcLNxE0kGFRqtIk6ZAPDSu
    Vj0GZGMVVEBcX3VRiL4StZUdq1bfWmdTlJSY3PE0TJKuyTQyHGrQElhxup/6+bH6
    yO7LT/hZ0n+Q8TNWx2vPr9Oz1CvBdMNRlJUG5w9kWdCHACD5N0tvpO4Ei/20yrZ3
    01V/HJXqPVdgouf2M6hTSm36O1rdTaoFucYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523022356; bh=Wf/YdSloDpHq7X25c9sDvlQgbktSzP
    yNRIvloN90bFk=; b=v2qAqqH0jPac03tStCFB+oUEE0OfGMuc1pvhh9ystEkGOS
    UkGb4uzJe43Zn7J80iL8PKo5HJrTfadIL9Z2Gt9QVuHs4d0ks0qCEH9r9hhcBggH
    NRXwoLLJcSX+Zikxn3Se7ceccOM3sv9Dgu/A4CvfcK/eTcIUFJQrIPvp0zjIrcsI
    sVsYIaHpDpd8aApygbHe5o4yxFXGq/mZahGFnWMsGuFxZAyK4WvTbbXlzH7IwAnM
    xIv8nU4jrp79b5WdrghcyvcmVeYOzNSeNFc+HjhS6QbOUTaAwcCuraBY3YI3/mpM
    E+6Ev5iEEyC4ywNWttV+Rx0z+zgpiKUBAcQg5EhQ==
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
X-CM-Envelope: MS4wfBM9GHDpmwQnuUcLVPfxc4NDsrdhPe+Pp5z2UlnxY/YnAFOIwPFRSGcYeg6ExAC50FUBkhhwL8nVFlA9RQb28/WCiRi69nFM+8Plvn78GbzbJcjZ1hh0
    pRvETLmmAbYaVBScn4s4W8KInbhq7+E7pomcauhsUARDTFx0zje3+lIzcPppHxHyZE7a9rLvkR9AV2/nFJX/xgF5pR+NmCO5H/cNR4oSK+yw4QlFLE2L58G0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wslChEY2J8gA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=PtDNVHqPAAAA:8 a=20KFwNOVAAAA:8
    a=cm27Pg_UAAAA:8 a=AgaioDkCAAAA:8 a=7ZN4cI0QAAAA:8 a=CEwII1yZAAAA:8
    a=yC-0_ovQAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
    a=8AirrxEcAAAA:8 a=KKAkSRfTAAAA:8 a=FNyBlpCuAAAA:8 a=QyXUC8HyAAAA:8
    a=P-IC7800AAAA:8 a=zd2uoN0lAAAA:8 a=ttLlOQO2AAAA:8 a=iox4zFpeAAAA:8
    a=DfNHnWVPAAAA:8 a=xLcVsCfpAAAA:8 a=FOH2dFAWAAAA:8 a=vrzYbc16d37QTyYcqsQA:9
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=BpimnaHY1jUKGyF_4-AF:22
    a=xmb-EsYY8bH0VWELuYED:22 a=eNS--96rZ24oWIaEtn_1:22 a=Dl0WHwQvj8hGZljrFLtM:22
    a=4LuAaoAPjBjBTe8K2uIj:22 a=QsnFDINu91a9xkgZirup:22 a=ST-jHhOKWsTCqRlWije3:22
    a=cvBusfyB2V15izCimMoJ:22 a=RlW-AWeGUCXs_Nkyno-6:22 a=d3PnA9EDa4IxuAV0gXij:22
    a=1BJeXTq6bvZE9X1NrNaC:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753985AbeDFNpk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbeDFNpk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/31] 4.16.1-stable review
Date: Fri,  6 Apr 2018 15:24:25 +0200
Message-Id: <20180406084340.999820380@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.1-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.1-rc1
X-KernelTest-Deadline: 2018-04-08T08:43+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.1 release.
There are 31 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr  8 08:43:15 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.1-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.1-rc1

Eric W. Biederman <ebiederm@xmission.com>
    signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k

Mikulas Patocka <mpatocka@redhat.com>
    Fix slab name "biovec-(1<<(21-12))"

Mike Frysinger <vapier@chromium.org>
    vt: change SGR 21 to follow the standards

Ondrej Zary <linux@rainbow-software.org>
    Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    Input: i8042 - add Lenovo ThinkPad L460 to i8042 reset list

Masaki Ota <masaki.ota@jp.alps.com>
    Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude 7370

Gaku Inami <gaku.inami.xh@renesas.com>
    Revert "base: arch_topology: fix section mismatch build warnings"

Frank Mori Hess <fmh6jj@gmail.com>
    staging: comedi: ni_mio_common: ack ai fifo error interrupts.

Gavin Schenk <g.schenk@eckelmann.de>
    siox: fix possible buffer overflow in device_add_store

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected cow in run_delalloc_nocow

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: hci_bcm: Add 6 new ACPI HIDs

Eric Biggers <ebiggers@google.com>
    crypto: x86/cast5-avx - fix ECB encryption when long sg follows short one

Leonard Crestez <leonard.crestez@nxp.com>
    crypto: arm,arm64 - Fix random regeneration of S_shipped

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    crypto: ccp - return an actual key size from RSA max_size callback

Rui Miguel Silva <rui.silva@linaro.org>
    crypto: caam - Fix null dereference at error path

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: ahash - Fix early termination in hash walk

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix IPsec cipher in length

Conor McLoughlin <conor.mcloughlin@intel.com>
    crypto: testmgr - Fix incorrect values in PKCS#1 test vector

Gregory CLEMENT <gregory.clement@bootlin.com>
    crypto: inside-secure - fix clock management

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - don't persistently map req_ctx->hw_context and req_ctx->buf

Gary R Hook <gary.hook@amd.com>
    crypto: ccp - Fill the result buffer only on digest, finup, and final ops

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: lrw - Free rctx->ext with kzfree

Alexander Gerasiov <gq@redlab-i.ru>
    parport_pc: Add support for WCH CH382L PCI-E single parallel port card.

Oliver Neukum <oneukum@suse.com>
    media: usbtv: prevent double free in error case

Kees Cook <keescook@chromium.org>
    /dev/mem: Avoid overwriting "err" in read_mem()

Colin Ian King <colin.king@canonical.com>
    mei: remove dev_err message on an unsupported ioctl

Joel Stanley <joel@jms.id.au>
    serial: 8250: Add Nuvoton NPCM UART

Johan Hovold <johan@kernel.org>
    USB: serial: cp210x: add ELDAT Easywave RX09 id

Clemens Werther <clemens.werther@gmail.com>
    USB: serial: ftdi_sio: add support for Harman FirmwareHubEmulator

Major Hayden <major@mhtx.net>
    USB: serial: ftdi_sio: add RT Systems VX-8 cable

Omar Sandoval <osandov@fb.com>
    bitmap: fix memset optimization on big-endian systems


-------------

Diffstat:

 Documentation/devicetree/bindings/serial/8250.txt |   1 +
 Makefile                                          |   4 +-
 arch/arm/crypto/Makefile                          |   2 +
 arch/arm64/crypto/Makefile                        |   2 +
 arch/x86/crypto/cast5_avx_glue.c                  |   3 +-
 block/bio.c                                       |   4 +-
 crypto/ahash.c                                    |   7 +-
 crypto/lrw.c                                      |   2 +-
 crypto/testmgr.h                                  |   6 +-
 drivers/base/arch_topology.c                      |  12 +-
 drivers/bluetooth/hci_bcm.c                       |   6 +
 drivers/char/mem.c                                |   6 +-
 drivers/crypto/caam/ctrl.c                        |   3 -
 drivers/crypto/ccp/ccp-crypto-aes-cmac.c          |   2 +-
 drivers/crypto/ccp/ccp-crypto-rsa.c               |   7 +-
 drivers/crypto/ccp/ccp-crypto-sha.c               |   2 +-
 drivers/crypto/inside-secure/safexcel.c           |   2 +-
 drivers/crypto/talitos.c                          | 168 +++++++++-------------
 drivers/input/mouse/alps.c                        |  24 +++-
 drivers/input/serio/i8042-x86ia64io.h             |  24 ++++
 drivers/media/usb/usbtv/usbtv-core.c              |   2 +
 drivers/misc/mei/main.c                           |   1 -
 drivers/parport/parport_pc.c                      |   4 +
 drivers/siox/siox-core.c                          |   2 +-
 drivers/staging/comedi/drivers/ni_mio_common.c    |   2 +
 drivers/tty/serial/8250/8250_of.c                 |   1 +
 drivers/tty/serial/8250/8250_port.c               |  33 +++++
 drivers/tty/vt/vt.c                               |   6 +-
 drivers/usb/serial/cp210x.c                       |   1 +
 drivers/usb/serial/ftdi_sio.c                     |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                 |   9 ++
 fs/btrfs/inode.c                                  |  37 ++++-
 include/linux/bitmap.h                            |  22 ++-
 include/linux/compat.h                            |   6 +-
 include/uapi/asm-generic/siginfo.h                |   7 +-
 include/uapi/linux/serial_core.h                  |   3 +
 36 files changed, 269 insertions(+), 156 deletions(-)
