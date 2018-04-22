Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524407384-2-11400326649276828740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524407383; b=UqUONnB5AzC/cGQximaeHvqL80F/BDHH83vcodMaTgWGrMnqbU
    X1RWVmSH+pEAq7d5r6q2X9Yvmh9DbJ7T3CTbJQfLLJQdLjWK0SSMaTs9ZwEQ4I9W
    DyYbXm/00LR0yoz/t2dH4Tc0XmfkhoTYq0akvOGsKSSikNXJ1s7J0a54Z4iMzbw3
    7bBrW86ZHp9JQkfcXdWEN8FYByz3g+kjTGtey8yQd8DrEDs+1Wp69+/Hsfa+x3dh
    0LPu8BWdgfSiyuNa+YcQHkF7bANB1VAfrfOprkLBo1YCShjLa1JF5LSocHNnYDJ5
    F5tweuBuQnZ5/7x9iF3TurmLSlNcf6Q4iZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524407383; bh=s9q8JTAtXT4DRf9uP7zKA2u76yrBsF
    Pf6ela2xHaAE8=; b=ff/PWg/KV86erMFQQDlWR9gRxrv4e0V5ubl4pob1lAP9V+
    AtrsuVTwfvp7CfNod6WQvZjhxe6cEW7YjB05rWNf46+QrbfSisTA6qgK5H1EkViV
    sQz4L4iWJlYDBPKY0FKTFFSR3i7OBqsSJFwbq85syLffznCLHEV+JV+/k8n2mGS+
    I+EOmJ7InSQ7WF5QzgKAiQuvISsR76ggTxxfzh00i87P5GS4khIlcQyKjKYxcm7M
    mesJYKgd9vSBUwGi9bNEIXRbum3c1S6MF0yR8Yk+FWERYHM7mSvSodR5blgcEmdu
    yepiwJbrVOWw9rZUNGosa3/dWdNXv1ifkIqwY2mQ==
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
X-CM-Envelope: MS4wfL0vPIZ5ECNw49MJXW9Zi//UUomk/642YbFkkRPS5rLx6O1S9Kksa0/FL2uefy6HmKya6RbSgV5+541FjTeD8WxUfdlL5RGBd2cBb/DRY2D3AM91aQZY
    DMIipCbPm9OdsOfM+XJhBwSeJ+tUIJRg5hjO25fyZJBFW//5FKLJA/1r1IPljnP1UajalctMUCvlQ+O5uPwp0GAuEPqHYsbfz7KXJlFtALd2lfQnNo83v+bW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=XatMZvNwr2AA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8 a=jUFqNg-nAAAA:8
    a=drOt6m5kAAAA:8 a=gPJu0pBYAAAA:8 a=CjxXgO3LAAAA:8 a=D_SbEOMbAAAA:8
    a=tCkLEFQzAAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=DfNHnWVPAAAA:8
    a=jIQo8A4GAAAA:8 a=XYAwZIGsAAAA:8 a=Z4Rwk6OoAAAA:8 a=LpQP-O61AAAA:8
    a=VnNF1IyMAAAA:8 a=vQBBkBfzAAAA:8 a=p2E804XgBooI3LNnv9AA:9
    a=LEvYoN_76jvUELfm:21 a=Co04o2QMfcnhslOd:21 a=RdtxUbJDZeoA:10
    a=dH3AY38zAK4A:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=-tElvS_Zar9K8zhlwiSp:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=AlIIF0cMT2hfDT4axODj:22
    a=Pp_2e9zuwDcBULsfUjaf:22 a=bfrCAK1mvQf1AxxUnQma:22 a=t8nPyN_e6usw4ciXM-Pk:22
    a=rjTVMONInIDnV1a_A2c_:22 a=Lf5xNeLK5dgiOs8hzIjU:22 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=pioyyrs4ZptJ924tMmac:22 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757479AbeDVOUv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:20:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754722AbeDVOUs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:20:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/52] 3.18.106-stable review
Date: Sun, 22 Apr 2018 15:53:33 +0200
Message-Id: <20180422135315.254787616@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.106-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.106-rc1
X-KernelTest-Deadline: 2018-04-24T13:53+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.106 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Apr 24 13:53:02 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.106-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.106-rc1

Amir Goldstein <amir73il@gmail.com>
    fanotify: fix logic of events on child

Ian Kent <raven@themaw.net>
    autofs: mount point create should honour passed in mode

Al Viro <viro@zeniv.linux.org.uk>
    Don't leak MNT_INTERNAL away from internal mounts

Al Viro <viro@zeniv.linux.org.uk>
    rpc_pipefs: fix double-dput()

Al Viro <viro@zeniv.linux.org.uk>
    hypfs_kill_super(): deal with failed allocations

Al Viro <viro@zeniv.linux.org.uk>
    jffs2_kill_sb(): deal with failed allocations

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/lib: Fix off-by-one in alternate feature patching

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix clobber of v1 in last_fixup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: memset.S: EVA & fault support for small_memset

Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
    HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Takashi Iwai <tiwai@suse.de>
    ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Paul Parsons <lost.distance@yahoo.com>
    drm/radeon: Fix PCIe lane width calculation

Theodore Ts'o <tytso@mit.edu>
    ext4: don't allow r/w mounts if metadata blocks overlap the superblock

Theodore Ts'o <tytso@mit.edu>
    ext4: fail ext4_iget for root directory if unallocated

Theodore Ts'o <tytso@mit.edu>
    ext4: add validity checks for bitmap block numbers

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix endless loop for XRUN recovery in OSS emulation

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix mutex unbalance in OSS emulation ioctls

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Return -EBUSY for OSS ioctls changing busy streams

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Avoid potential races between OSS ioctls and read/write

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Use ERESTARTSYS instead of EINTR in OSS emulation

Nicholas Mc Guire <hofrat@osadl.org>
    ALSA: oss: consolidate kmalloc/memset 0 call to kzalloc

Igor Pylypiv <igor.pylypiv@gmail.com>
    watchdog: f71808e_wdt: Fix WD_EN register read

Mikhail Lappo <mikhail.lappo@esrlabs.com>
    thermal: imx: Fix race condition in imx_thermal_probe()

Richard Genoud <richard.genoud@gmail.com>
    clk: mvebu: armada-38x: add support for missing clocks

Ralph Sennhauser <ralph.sennhauser@gmail.com>
    clk: mvebu: armada-38x: add support for 1866MHz variants

Alex Smith <alex.smith@imgtec.com>
    mmc: jz4740: Fix race condition in IRQ mask update

Theodore Ts'o <tytso@mit.edu>
    jbd2: if the journal is aborted then don't allow update of the log tail

Theodore Ts'o <tytso@mit.edu>
    random: use a tighter cap in credit_entropy_bits_safe()

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Resume control channel after hibernation image is created

James Kelly <jamespeterkelly@gmail.com>
    ASoC: ssm2602: Replace reg_default_raw with reg_default

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Fix smp_wmb barrier definition use use lwsync consistently

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()

Aaron Ma <aaron.ma@canonical.com>
    HID: i2c-hid: fix size check and type usage

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: pci: Properly cleanup resource

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    USB:fix USB3 devices behind USB3 hubs not resuming at hibernate thaw

Mika Westerberg <mika.westerberg@linux.intel.com>
    ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()

Jason Andryuk <jandryuk@gmail.com>
    xen-netfront: Fix hang on device removal

Nicolas Ferre <nicolas.ferre@microchip.com>
    ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property

Heinrich Schuchardt <xypron.glpk@gmx.de>
    usb: musb: gadget: misplaced out of bounds check

Takashi Iwai <tiwai@suse.de>
    resource: fix integer overflow at reallocation

Andrew Morton <akpm@linux-foundation.org>
    fs/reiserfs/journal.c: add missing resierfs_warning() arg

Richard Weinberger <richard@nod.at>
    ubi: Reject MLC NAND

Romain Izard <romain.izard.pro@gmail.com>
    ubi: Fix error for write access

Richard Weinberger <richard@nod.at>
    ubifs: Check ubifs_wbuf_sync() return code

Tejaswi Tanikella <tejaswit@codeaurora.org>
    slip: Check if rstate is initialized before uncompressing

Vasily Gorbik <gor@linux.ibm.com>
    s390/ipl: ensure loadparm valid flag is set

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't merge ERROR output buffers

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't retry EQBS after CCQ 96

Helge Deller <deller@gmx.de>
    parisc: Fix out of array access in match_pci_device()

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: v4l2-compat-ioctl32: don't oops on overlay


-------------

Diffstat:

 Makefile                                      |   4 +-
 arch/arm/boot/dts/at91sam9g25.dtsi            |   2 +-
 arch/mips/lib/memset.S                        |  11 +-
 arch/parisc/kernel/drivers.c                  |   4 +
 arch/powerpc/include/asm/barrier.h            |   3 +-
 arch/powerpc/include/asm/synch.h              |   4 -
 arch/powerpc/lib/feature-fixups.c             |   2 +-
 arch/powerpc/platforms/powernv/opal-nvram.c   |  11 +-
 arch/s390/hypfs/inode.c                       |   2 +-
 arch/s390/kernel/ipl.c                        |   1 +
 drivers/char/random.c                         |   2 +-
 drivers/clk/mvebu/armada-38x.c                |  15 +-
 drivers/gpu/drm/radeon/si_dpm.c               |   4 +-
 drivers/hid/hidraw.c                          |   5 +
 drivers/hid/i2c-hid/i2c-hid.c                 |  13 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   4 +-
 drivers/mmc/host/jz4740_mmc.c                 |   2 +-
 drivers/mtd/ubi/block.c                       |   2 +-
 drivers/mtd/ubi/build.c                       |  11 ++
 drivers/net/slip/slhc.c                       |   5 +
 drivers/net/xen-netfront.c                    |   7 +-
 drivers/pci/hotplug/acpiphp_glue.c            |  23 +++-
 drivers/s390/cio/qdio_main.c                  |  42 +++---
 drivers/thermal/imx_thermal.c                 |   6 +-
 drivers/thunderbolt/nhi.c                     |   1 +
 drivers/usb/core/generic.c                    |   9 +-
 drivers/usb/dwc3/dwc3-pci.c                   |   2 +-
 drivers/usb/musb/musb_gadget_ep0.c            |  14 +-
 drivers/watchdog/f71808e_wdt.c                |   2 +-
 fs/autofs4/root.c                             |   2 +-
 fs/ext4/balloc.c                              |  16 ++-
 fs/ext4/ialloc.c                              |   8 +-
 fs/ext4/inode.c                               |   6 +
 fs/ext4/super.c                               |   6 +
 fs/jbd2/journal.c                             |   5 +-
 fs/jffs2/super.c                              |   2 +-
 fs/namespace.c                                |   3 +-
 fs/notify/fanotify/fanotify.c                 |  34 ++---
 fs/reiserfs/journal.c                         |   2 +-
 fs/ubifs/super.c                              |  14 +-
 include/net/slhc_vj.h                         |   1 +
 include/sound/pcm_oss.h                       |   1 +
 kernel/resource.c                             |   3 +-
 net/sunrpc/rpc_pipe.c                         |   1 +
 sound/core/oss/pcm_oss.c                      | 189 ++++++++++++++++++++------
 sound/core/rawmidi_compat.c                   |  18 ++-
 sound/soc/codecs/ssm2602.c                    |  19 ++-
 47 files changed, 388 insertions(+), 155 deletions(-)
