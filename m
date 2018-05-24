Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162292-2-7572355774036599747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162290; b=eHYzh2XK01jCvKx17utH5PtO9knztyhF5O6KM+Ar612TEuPbG9
    Lm3pEt4zgud6dsAgkCFZDdRAsMoF8I1ZKFY2v2jsuqUfLjJtoV0DHSdeiJn1pGiE
    WhtP5TRKChf2tZJ/p7LuAJN0pM+rql6kAjwILdYFFChNSEaYIZf5P1lr/K4vdwds
    z2s2mO++224ansGvZKh8Veh3Zy2pgwc2ceW1JmO/H/nIwJ/CfFGa4HrXnPpCrJOI
    m4w1QtnOYIcF6HQxfYSmLMCZ9s4vbxdfOgTXBYGd0eKeo3DEc+rFnkXTJ4NKD+bH
    OgCMkTVvfCceFZafRhew1dom7CSzcLQ4TFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527162290; bh=ZuTS+JnHXBRowct0zMQH2aaXWnkFyn
    pEc3rtatvRHp4=; b=IjaYYNqgbrUnPhM3Ig0Bp40NvnGwXDwCR84hj2Mpfgh5oT
    VdYqmcaTUJHwlOzuy4RDGK2LxEmSjlOXD1QCDQzwZGEV3OnOxZFSqLbnMRGwosvR
    0MDD3KGURu8Na1NcyIHU3QTZ46xTtRzDfM6KtebQGrezNWHOkL7e832Ed7X3c0/o
    CEBs04CfM3cpgEzj4X7pReMf1H0YlX+y6pvDZHp857+NBWvEfi1mMKhRkuvjHg7l
    FYe3iXh2oFo7zWqDNBMAxNxgBsBko5yoRGmqWgmDFTrmMBy3yGM70JDk+eP9BcjI
    nBDuFI9tnifeFUy4TGblzDDhJzjIllxJJyfumfhA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jp4su1zj x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jp4su1zj x-bits=1024 x-keytype=rsa
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLoFHMy/ywU5l6bKY7Eg3AXyjVCo7/Xlap15niK8DsR0VYz0WjvyKI1+Sbl0z5bVMnop7VoVOf2JIao9FWJkdc0q2fgSl/qeihdJNsUUxJ5rxE2XxESS
    yHGm7WVMKrxvwtpC8edqqK+3BaePaqj6RZhK2w53Aip33B0XS+d+3KeB+nXXXGgaZsUSYQawKGqnwFCowevyCCOJJ7cJ4S7V2BULw+RjvI4xWkxTA0VeNOAa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kKttcQBkNscA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=DfNHnWVPAAAA:8 a=P-IC7800AAAA:8
    a=sozttTNsAAAA:8 a=hD80L64hAAAA:8 a=s8YR1HE3AAAA:8 a=j-NXPswCAAAA:8
    a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=uBuKx8GwAAAA:8
    a=3uY1OGifAAAA:8 a=zAyngx5bAAAA:8 a=yMhMjlubAAAA:8 a=JF9118EUAAAA:8
    a=LpQP-O61AAAA:8 a=iox4zFpeAAAA:8 a=yQdBAQUQAAAA:8 a=LDBv8-xUAAAA:8
    a=jIQo8A4GAAAA:8 a=7ZN4cI0QAAAA:8 a=J7S8MM_AAAAA:8 a=cm27Pg_UAAAA:8
    a=PPvH6gBIAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=i0EeH86SAAAA:8
    a=drOt6m5kAAAA:8 a=eh1Yez-EAAAA:8 a=vNx-OR5oPJqaUKoPNC4A:9 a=N8N-558xWu8A:10
    a=ySAF077MUekA:10 a=E2q1x9kB5HEA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=rjTVMONInIDnV1a_A2c_:22 a=d3PnA9EDa4IxuAV0gXij:22
    a=aeg5Gbbo78KNqacMgKqU:22 a=jGH_LyMDp9YhSvY-UuyI:22 a=UdV-L189IiqUQIgB40x4:22
    a=wZgZ3yaTFkxMEWn-yT5t:22 a=d_xNPB-V-J0lr6ltNwaW:22 a=4LA4qAFo6bo561LpWNDU:22
    a=xVlTc564ipvMDusKsbsT:22 a=pioyyrs4ZptJ924tMmac:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=SzazLyfi1tnkUD6oumHU:22 a=DZeXCJrVpAJBw65Qk4Ds:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967173AbeEXJsJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967147AbeEXJsF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/96] 4.9.103-stable review
Date: Thu, 24 May 2018 11:37:43 +0200
Message-Id: <20180524093605.602125311@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.103-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.103-rc1
X-KernelTest-Deadline: 2018-05-26T09:36+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.103 release.
There are 96 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat May 26 09:35:42 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.103-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.103-rc1

Colin Ian King <colin.king@canonical.com>
    rtc: tx4939: avoid unintended sign extension on a 24 bit shift

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: hctosys: Ensure system time doesn't overflow time_t

Bryan O'Donoghue <pure.logic@nexus-software.ie>
    rtc: snvs: Fix usage of snvs_rtc_enable

Vignesh R <vigneshr@ti.com>
    serial: 8250: Don't service RX FIFO if interrupts are disabled

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: arc_uart: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: fsl_lpuart: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: imx: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: mxs-auart: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: samsung: Fix out-of-bounds access through serial port index

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: xuartps: Fix out-of-bounds access through DT alias

Colin Ian King <colin.king@canonical.com>
    media: cx25821: prevent out-of-bounds read on array card

Hans Verkuil <hverkuil@xs4all.nl>
    media: vivid: fix incorrect capabilities for radio

Masami Hiramatsu <mhiramat@kernel.org>
    media: vb2: Fix videobuf2 to map correct area

Arnd Bergmann <arnd@arndb.de>
    media: s3c-camif: fix out-of-bounds array access

Brad Love <brad@nextdimension.cc>
    media: cx23885: Override 888 ImpactVCBe crystal frequency

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: dmxdev: fix error code for invalid ioctls

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos3250: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5250: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5433: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos5260: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: exynos7: Fix PLL rates

Andrzej Hajda <a.hajda@samsung.com>
    clk: samsung: s3c2410: Fix PLL rates

Shawn Lin <shawn.lin@rock-chips.com>
    clk: rockchip: Prevent calculating mmc phase if clock rate is zero

Brad Love <brad@nextdimension.cc>
    media: cx23885: Set subdev host data to clk_freq pointer

Marcel Ziswiler <marcel@ziswiler.com>
    clk: tegra: Fix pll_u rate configuration

Shawn Lin <shawn.lin@rock-chips.com>
    clk: Don't show the incorrect clock phase

Shawn Lin <shawn.lin@rock-chips.com>
    clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: topology: create TLV data for dapm widgets

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix frequency of Release WQE CQEs

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix issue_lip if link is disabled

Wilfried Weissmann <wilfried.weissmann@gmx.at>
    scsi: mvsas: fix wrong endianness of sgpio api

Dave Carroll <david.carroll@microsemi.com>
    scsi: aacraid: Insure command thread is not recursively stopped

Jeremy Cline <jeremy@jcline.org>
    scsi: sd: Keep disk read-only when re-reading partition

Hannes Reinecke <hare@suse.de>
    scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM

Manish Rangankar <manish.rangankar@cavium.com>
    scsi: qla4xxx: skip error recovery in case of register disconnect.

Meelis Roos <mroos@linux.ee>
    scsi: aacraid: fix shutdown crash when init fails

Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
    scsi: storvsc: Increase cmd_per_lun for higher speed devices

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: qla2xxx: Avoid triggering undefined behavior in qla2x00_mbx_completion()

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: sym53c8xx_2: iterator underflow in sym_getsync()

Chad Dupuis <chad.dupuis@cavium.com>
    scsi: bnx2fc: Fix check in SCSI completion handler for timed out request

Sujit Reddy Thumma <sthumma@codeaurora.org>
    scsi: ufs: Enable quirk to ignore sending WRITE_SAME command

Arnd Bergmann <arnd@arndb.de>
    scsi: fas216: fix sense buffer initialization

Peter Robinson <pbrobinson@gmail.com>
    crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

NeilBrown <neilb@suse.com>
    staging: lustre: lmv: correctly iput lmo_root

Colin Ian King <colin.king@canonical.com>
    staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr

NeilBrown <neilb@suse.com>
    staging: lustre: fix bug in osc_enter_cache_try

Larry Finger <Larry.Finger@lwfinger.net>
    Bluetooth: btusb: Add device ID for RTL8822BE

Brad Love <brad@nextdimension.cc>
    media: em28xx: USB bulk packet size fix

Chris Dickens <christopher.a.dickens@gmail.com>
    usb: gadget: composite: fix incorrect handling of OS desc requests

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: gadget: udc: change comparison to bitshift when dealing with a mask

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS

Minas Harutyunyan <hminas@synopsys.com>
    usb: dwc2: host: Fix transaction errors in host mode

Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
    usb: dwc2: Fix interval type issue

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: zero usb device slot_id member when disabling and freeing a xhci slot

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Add SoftReset PHY synchonization delay

Nobutaka Okabe <nob77413@gmail.com>
    ALSA: usb-audio: Add native DSD support for Luxman DA-06

Vicente Bergas <vicencb@gmail.com>
    Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB

Giuseppe Lippolis <giu.lippolis@gmail.com>
    net-usb: add qmi_wwan if on lte modem wistron neweb d18q1

Torsten Hilbrich <torsten.hilbrich@secunet.com>
    net/usb/qmi_wwan.c: Add USB id for lt4120 modem

Fredrik Noring <noring@nocrew.org>
    USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM

Dominik Bozek <dominikx.bozek@intel.com>
    usb: cdc_acm: prevent race at write to acm while system resumes

Vardan Mikayelyan <mvardan@synopsys.com>
    usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()

Stefan Agner <stefan@agner.ch>
    usb: gadget: fsl_udc_core: fix ep valid checks

Manu Gautam <mgautam@codeaurora.org>
    usb: gadget: core: Fix use-after-free of usb_request

Roger Quadros <rogerq@ti.com>
    usb: dwc3: omap: don't miss events during suspend/resume

Brian Norris <briannorris@chromium.org>
    usb: dwc3: Undo PHY init if soft reset fails

John Keeping <john@metanate.com>
    usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    hfsplus: stop workqueue when fill_super() failed

Johannes Berg <johannes.berg@intel.com>
    cfg80211: limit wiphy names to 128 bytes

Jens Remus <jremus@linux.ibm.com>
    scsi: zfcp: fix infinite iteration on ERP ready list

Alexander Potapenko <glider@google.com>
    scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: defer ata device eh commands to libata

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: use expoline thunks in the BPF JIT

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: extend expoline to BC instructions

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move spectre sysfs attribute code

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/kernel: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/ftrace: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/lib: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/crc32-vx: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move expoline assembler macros to a header

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add assembler macros for CPU alternatives

Al Viro <viro@zeniv.linux.org.uk>
    ext2: fix a block leak

hpreg@vmware.com <hpreg@vmware.com>
    vmxnet3: use DMA memory barriers where required

hpreg@vmware.com <hpreg@vmware.com>
    vmxnet3: set the DMA mask before the first DMA map operation

Eric Dumazet <edumazet@google.com>
    tcp: purge write queue in tcp_connect_init()

Eric Dumazet <edumazet@google.com>
    sock_diag: fix use-after-free read in __sk_free

Willem de Bruijn <willemb@google.com>
    packet: in packet_snd start writing at link layer allocation

Willem de Bruijn <willemb@google.com>
    net: test tailroom before appending to linear skb

Tarick Bedeir <tarick@google.com>
    net/mlx4_core: Fix error handling in mlx4_init_port_info.


-------------

Diffstat:

 Makefile                                         |   4 +-
 arch/s390/crypto/crc32be-vx.S                    |   5 +-
 arch/s390/crypto/crc32le-vx.S                    |   4 +-
 arch/s390/include/asm/alternative-asm.h          | 108 +++++++++++++
 arch/s390/include/asm/nospec-insn.h              | 195 +++++++++++++++++++++++
 arch/s390/kernel/Makefile                        |   1 +
 arch/s390/kernel/asm-offsets.c                   |   1 +
 arch/s390/kernel/base.S                          |  24 +--
 arch/s390/kernel/entry.S                         | 105 +++---------
 arch/s390/kernel/mcount.S                        |  14 +-
 arch/s390/kernel/nospec-branch.c                 |  43 +++--
 arch/s390/kernel/nospec-sysfs.c                  |  21 +++
 arch/s390/kernel/reipl.S                         |   7 +-
 arch/s390/kernel/swsusp.S                        |   9 +-
 arch/s390/lib/mem.S                              |   9 +-
 arch/s390/net/bpf_jit.S                          |  16 +-
 arch/s390/net/bpf_jit_comp.c                     |  63 +++++++-
 arch/x86/kernel/machine_kexec_32.c               |   6 +-
 arch/x86/kernel/machine_kexec_64.c               |   4 +-
 drivers/bluetooth/btusb.c                        |   6 +
 drivers/clk/clk.c                                |   3 +
 drivers/clk/rockchip/clk-mmc-phase.c             |  23 +++
 drivers/clk/rockchip/clk-rk3228.c                |   2 +-
 drivers/clk/samsung/clk-exynos3250.c             |   4 +-
 drivers/clk/samsung/clk-exynos5250.c             |   8 +-
 drivers/clk/samsung/clk-exynos5260.c             |   2 +-
 drivers/clk/samsung/clk-exynos5433.c             |  12 +-
 drivers/clk/samsung/clk-exynos7.c                |   2 +-
 drivers/clk/samsung/clk-s3c2410.c                |  16 +-
 drivers/clk/tegra/clk-pll.c                      |   2 +
 drivers/crypto/sunxi-ss/sun4i-ss-core.c          |   1 +
 drivers/media/dvb-core/dmxdev.c                  |   2 +-
 drivers/media/pci/cx23885/cx23885-cards.c        |   4 +
 drivers/media/pci/cx23885/cx23885-core.c         |  10 ++
 drivers/media/pci/cx25821/cx25821-core.c         |   7 +-
 drivers/media/platform/s3c-camif/camif-capture.c |   7 +-
 drivers/media/platform/vivid/vivid-ctrls.c       |   2 +
 drivers/media/usb/em28xx/em28xx.h                |   2 +-
 drivers/media/v4l2-core/videobuf2-vmalloc.c      |   2 +-
 drivers/message/fusion/mptctl.c                  |   2 +
 drivers/net/ethernet/mellanox/mlx4/main.c        |   4 +-
 drivers/net/usb/qmi_wwan.c                       |   4 +
 drivers/net/vmxnet3/vmxnet3_drv.c                |  72 ++++++---
 drivers/rtc/hctosys.c                            |   5 +
 drivers/rtc/rtc-snvs.c                           |  15 +-
 drivers/rtc/rtc-tx4939.c                         |   6 +-
 drivers/s390/scsi/zfcp_dbf.c                     |  23 ++-
 drivers/s390/scsi/zfcp_ext.h                     |   5 +-
 drivers/s390/scsi/zfcp_scsi.c                    |  14 +-
 drivers/scsi/aacraid/commsup.c                   |   4 +-
 drivers/scsi/aacraid/linit.c                     |   5 +-
 drivers/scsi/arm/fas216.c                        |   2 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                  |   1 +
 drivers/scsi/libsas/sas_scsi_host.c              |  33 ++--
 drivers/scsi/lpfc/lpfc_attr.c                    |   5 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                 |   5 +-
 drivers/scsi/lpfc/lpfc_sli.c                     |   2 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c             |   2 +-
 drivers/scsi/mvsas/mv_94xx.c                     |  23 +--
 drivers/scsi/qla2xxx/qla_isr.c                   |   6 +-
 drivers/scsi/qla4xxx/ql4_def.h                   |   2 +
 drivers/scsi/qla4xxx/ql4_os.c                    |  46 ++++++
 drivers/scsi/sd.c                                |   3 +-
 drivers/scsi/sg.c                                |   2 +-
 drivers/scsi/storvsc_drv.c                       |   2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c              |   2 +-
 drivers/scsi/ufs/ufshcd.c                        |   2 +
 drivers/staging/lustre/lustre/include/obd.h      |   2 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c      |   2 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c    |   2 +-
 drivers/staging/rtl8192u/r8192U_core.c           |   2 +
 drivers/tty/serial/8250/8250_port.c              |   3 +-
 drivers/tty/serial/arc_uart.c                    |   5 +
 drivers/tty/serial/fsl_lpuart.c                  |   4 +
 drivers/tty/serial/imx.c                         |   6 +
 drivers/tty/serial/mxs-auart.c                   |   4 +
 drivers/tty/serial/samsung.c                     |   4 +
 drivers/tty/serial/xilinx_uartps.c               |   2 +-
 drivers/usb/class/cdc-acm.c                      |   9 +-
 drivers/usb/dwc2/core.h                          |   2 +-
 drivers/usb/dwc2/gadget.c                        |  12 +-
 drivers/usb/dwc2/hcd.c                           |  14 +-
 drivers/usb/dwc3/core.c                          |  16 +-
 drivers/usb/dwc3/core.h                          |   2 +
 drivers/usb/dwc3/dwc3-omap.c                     |  16 ++
 drivers/usb/gadget/composite.c                   |  40 +++--
 drivers/usb/gadget/function/f_fs.c               |   6 +-
 drivers/usb/gadget/function/f_uac2.c             |   2 +
 drivers/usb/gadget/udc/core.c                    |   2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c            |   4 +-
 drivers/usb/gadget/udc/goku_udc.h                |   2 +-
 drivers/usb/host/ohci-hcd.c                      |   3 +-
 drivers/usb/host/xhci-mem.c                      |   2 +
 fs/ext2/inode.c                                  |  10 --
 fs/hfsplus/super.c                               |   1 +
 include/linux/usb/composite.h                    |   3 +
 include/uapi/linux/nl80211.h                     |   2 +
 net/core/sock.c                                  |   2 +-
 net/ipv4/ip_output.c                             |   3 +-
 net/ipv4/tcp_output.c                            |   7 +-
 net/ipv6/ip6_output.c                            |   3 +-
 net/packet/af_packet.c                           |   4 +-
 net/wireless/core.c                              |   3 +
 sound/soc/au1x/ac97c.c                           |   6 +-
 sound/soc/samsung/i2s.c                          |  13 +-
 sound/soc/soc-topology.c                         |   3 +
 sound/usb/quirks.c                               |  29 ++--
 107 files changed, 975 insertions(+), 335 deletions(-)
