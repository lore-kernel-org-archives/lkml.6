Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161192-2-7415401961949138271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161190; b=TCurto2GPnBPyQ/7m7usDEYgRuxc7mymllKSM1wURjFDt9aTSr
    iVmQcaRS+nSr8CsOUsV3pawVDmk28UBgyurjZKBCuaTcJB0XUrfrqumP5SfU8eZj
    qDIvdqppAsLLTHDzEfSldMSkirN4/LVToHZ176bRXw57ny02jM0TXZXKDwlkLvXq
    r4MzboHxpd6Yw7NUlP2vkts/DJ+I2YruV+xnQ2I/REB3Xo243YA4HaCFxRgdhfK9
    Q8Nm8VbS2Txzfwt70+GQaDbiBG1zLkr2bA8RhoxLBMhJoWI0AtLRb59e5YhCeLyX
    SKAc7pgU/ZPB/BsVPMb5/yYhE7i5OHnU4QCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527161190; bh=GhtW5ZHUTVcQlxr/MnuaXZbCzM1udb
    ztzUftckl9h3M=; b=WrWXJBap0NHS8jz5/gnuRvOY3As8Zp3zzxik+qujWnWnb8
    dE2Gg/pzidAzpn6l4lGEzpbOcV3GXSAt/YWURJ1yhFjMSN9PeZMyPMgfozHjuybR
    gNWPTfjX3MFpkDTWXKVV60vFYCNiwn/zRQqtmTDQ0D+0l0f4tpT7c0RXa06//Lkp
    vTA6iAXd2zeKYUrGZJ6WVNZvmjSAlBCS2cZLoB++OYptEj78Wd5vkj7RcGY/lvTo
    vrdBBToOy8B2DVEt5RjUyoXYp0SzhbfPDgSgMM4JyfJROKtEhG9nN4PO5lHrlo1U
    ELYMla2MUu5ZLiUsfpoeIeYqdKRFCIhAkE8Irh2w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=r0DvYrk3 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=r0DvYrk3 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPgVkekm5VjAcJ6lSLnVK5uSMpmZcgC79XjjqkLKMhRGTUu39Epb2JmlGWPFgpKvuybDIaslZZxst9x7KUAAQpkCY1OUoxHvBvWHK+/OFXnART4lEhcv
    dUkgtEA4wv2zkE3PolSLA5sB27jFmjgEtkSXbXEvAsIDHN6gIkOSc5phvFk1zdA15r8PIXv2ZupB/2rhCimpnfo5aGhFdwiZ1kHLxtnARPRn0r+A50+XmZWy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=6xLPOHPkGDIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=P-IC7800AAAA:8
    a=DfNHnWVPAAAA:8 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8
    a=hD80L64hAAAA:8 a=s8YR1HE3AAAA:8 a=j-NXPswCAAAA:8 a=QyXUC8HyAAAA:8
    a=gvl4HP8tAAAA:8 a=NCkSHYsgAAAA:8 a=uBuKx8GwAAAA:8 a=yPCof4ZbAAAA:8
    a=3uY1OGifAAAA:8 a=zAyngx5bAAAA:8 a=yMhMjlubAAAA:8 a=JF9118EUAAAA:8
    a=LpQP-O61AAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=Feg6x53VAAAA:8
    a=8AirrxEcAAAA:8 a=yQdBAQUQAAAA:8 a=LDBv8-xUAAAA:8 a=8T59DR07AAAA:8
    a=jIQo8A4GAAAA:8 a=7ZN4cI0QAAAA:8 a=J7S8MM_AAAAA:8 a=yC-0_ovQAAAA:8
    a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=PPvH6gBIAAAA:8 a=FOH2dFAWAAAA:8
    a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=drOt6m5kAAAA:8 a=jZVsG21pAAAA:8
    a=eh1Yez-EAAAA:8 a=cXK2LVYE7IlDW5CuEzEA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=48Jz6D1wMh0zeABd:21 a=IYa0SEX5PGH9BisO:21 a=QEXdDO2ut3YA:10
    a=aGWD9O9wy84A:10 a=Wd1YyITNqDoA:10 a=ySAF077MUekA:10 a=ZBlwqkAFxgcA:10
    a=E2q1x9kB5HEA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=rjTVMONInIDnV1a_A2c_:22 a=aeg5Gbbo78KNqacMgKqU:22
    a=D0XLA9XvdZm18NrgonBM:22 a=jGH_LyMDp9YhSvY-UuyI:22 a=UdV-L189IiqUQIgB40x4:22
    a=tRkgsvjveJ3YVe9fnr1q:22 a=AnMw66Xr5OuzjdxB04dI:22 a=wZgZ3yaTFkxMEWn-yT5t:22
    a=d_xNPB-V-J0lr6ltNwaW:22 a=4LA4qAFo6bo561LpWNDU:22 a=xVlTc564ipvMDusKsbsT:22
    a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967466AbeEXL02 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:26:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967724AbeEXJvf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/165] 4.14.44-stable review
Date: Thu, 24 May 2018 11:36:46 +0200
Message-Id: <20180524093621.979359379@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.44-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.44-rc1
X-KernelTest-Deadline: 2018-05-26T09:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.44 release.
There are 165 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat May 26 09:35:46 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.44-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.44-rc1

James Hogan <jhogan@kernel.org>
    rtc: goldfish: Add missing MODULE_LICENSE

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: rp5c01: fix possible race condition

Colin Ian King <colin.king@canonical.com>
    rtc: tx4939: avoid unintended sign extension on a 24 bit shift

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: m41t80: fix race conditions

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: rk808: fix possible race condition

Alexandre Belloni <alexandre.belloni@bootlin.com>
    rtc: hctosys: Ensure system time doesn't overflow time_t

Bryan O'Donoghue <pure.logic@nexus-software.ie>
    rtc: snvs: Fix usage of snvs_rtc_enable

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: altera: ensure port->regshift is honored consistently

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
    serial: sh-sci: Fix out-of-bounds access through DT alias

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: xuartps: Fix out-of-bounds access through DT alias

Colin Ian King <colin.king@canonical.com>
    media: cx25821: prevent out-of-bounds read on array card

Hans Verkuil <hverkuil@xs4all.nl>
    media: vivid: fix incorrect capabilities for radio

Masami Hiramatsu <mhiramat@kernel.org>
    media: vb2: Fix videobuf2 to map correct area

Kieran Bingham <kieran.bingham@ideasonboard.com>
    media: i2c: adv748x: fix HDMI field heights

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    media: v4l: vsp1: Fix display stalls when requesting too many inputs

Brad Love <brad@nextdimension.cc>
    media: em28xx: Add Hauppauge SoloHD/DualHD bulk models

Brad Love <brad@nextdimension.cc>
    media: lgdt3306a: Fix a double kfree on i2c device remove

Arnd Bergmann <arnd@arndb.de>
    media: s3c-camif: fix out-of-bounds array access

Brad Love <brad@nextdimension.cc>
    media: cx23885: Set subdev host data to clk_freq pointer

Brad Love <brad@nextdimension.cc>
    media: cx23885: Override 888 ImpactVCBe crystal frequency

Akinobu Mita <akinobu.mita@gmail.com>
    media: ov5645: add missing of_node_put() in error path

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: Don't let tvp5150_get_vbi() go out of vbi_ram_default array

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

Marcel Ziswiler <marcel@ziswiler.com>
    clk: tegra: Fix pll_u rate configuration

Arnd Bergmann <arnd@arndb.de>
    clk: hisilicon: mark wdt_mux_p[] as const

Shawn Lin <shawn.lin@rock-chips.com>
    clk: Don't show the incorrect clock phase

Shawn Lin <shawn.lin@rock-chips.com>
    clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: i2s: Ensure the RCLK rate is properly determined

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: topology: create TLV data for dapm widgets

Sylwester Nawrocki <s.nawrocki@samsung.com>
    ASoC: samsung: odroid: Fix 32000 sample rate handling

Ezequiel Garcia <ezequiel@collabora.co.uk>
    ASoC: rockchip: rk3288-hdmi-analog: Select needed codecs

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: hdmi-codec: Fix module unloading caused kernel crash

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix frequency of Release WQE CQEs

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix soft lockup in lpfc worker thread during LIP testing

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Fix issue_lip if link is disabled

Wilfried Weissmann <wilfried.weissmann@gmx.at>
    scsi: mvsas: fix wrong endianness of sgpio api

Douglas Gilbert <dgilbert@interlog.com>
    scsi: core: Make SCSI Status CONDITION MET equivalent to GOOD

Dave Carroll <david.carroll@microsemi.com>
    scsi: aacraid: Insure command thread is not recursively stopped

Jianchao Wang <jianchao.w.wang@oracle.com>
    scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled

Jeremy Cline <jeremy@jcline.org>
    scsi: sd: Keep disk read-only when re-reading partition

Hannes Reinecke <hare@suse.de>
    scsi: mpt3sas: Do not mark fw_event workqueue as WQ_MEM_RECLAIM

Manish Rangankar <manish.rangankar@cavium.com>
    scsi: qedi: Fix kernel crash during port toggle

Hannes Reinecke <hare@suse.de>
    scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()

Manish Rangankar <manish.rangankar@cavium.com>
    scsi: qla4xxx: skip error recovery in case of register disconnect.

Meelis Roos <mroos@linux.ee>
    scsi: aacraid: fix shutdown crash when init fails

Andrew Vasquez <andrew.vasquez@cavium.com>
    scsi: qedi: Fix truncation of CHAP name and secret

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

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix memory corruption during hba reset test

Tomas Henzl <thenzl@redhat.com>
    scsi: mpt3sas: fix an out of bound write

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - fix the invalidation step during cra_exit

Peter Robinson <pbrobinson@gmail.com>
    crypto: sunxi-ss - Add MODULE_ALIAS to sun4i-ss

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - fix the extra cache computation

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - fix the cache_len computation

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - do not process request if no command was issued

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    crypto: ccp - don't disable interrupts while setting up debugfs

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: atmel-aes - fix the keys zeroing on errors

Antoine Tenart <antoine.tenart@bootlin.com>
    crypto: inside-secure - wait for the request to complete if in the backlog

NeilBrown <neilb@suse.com>
    staging: lustre: lmv: correctly iput lmo_root

Quytelda Kahja <quytelda@tamalin.org>
    staging: ks7010: Use constants from ieee80211_eid instead of literal ints.

Colin Ian King <colin.king@canonical.com>
    staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr

Ioana Radulescu <ruxandra.radulescu@nxp.com>
    staging: fsl-dpaa2/eth: Fix incorrect casts

NeilBrown <neilb@suse.com>
    staging: lustre: fix bug in osc_enter_cache_try

Kirill Marinushkin <k.marinushkin@gmail.com>
    staging: bcm2835-audio: Release resources on module_exit()

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: Show what USB release number the xHC supports from protocol capablity

Larry Finger <Larry.Finger@lwfinger.net>
    Bluetooth: btusb: Add device ID for RTL8822BE

Brad Love <brad@nextdimension.cc>
    media: em28xx: USB bulk packet size fix

Brad Love <brad@nextdimension.cc>
    media: lgdt3306a: Fix module count mismatch on usb unplug

Chris Dickens <christopher.a.dickens@gmail.com>
    usb: gadget: composite: fix incorrect handling of OS desc requests

Wolfram Sang <wsa+renesas@sang-engineering.com>
    usb: gadget: udc: change comparison to bitshift when dealing with a mask

Ben Hutchings <ben@decadent.org.uk>
    usbip: Correct maximum value of CONFIG_USBIP_VHCI_HC_PORTS

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Execute copy_to_user() with USER_DS set

Lars-Peter Clausen <lars@metafoo.de>
    usb: gadget: ffs: Let setup() return USB_GADGET_DELAYED_STATUS

Minas Harutyunyan <hminas@synopsys.com>
    usb: dwc2: host: Fix transaction errors in host mode

Minas Harutyunyan <hminas@synopsys.com>
    usb: dwc2: hcd: Fix host channel halt flow

Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>
    usb: dwc2: Fix interval type issue

Mathias Nyman <mathias.nyman@linux.intel.com>
    xhci: zero usb device slot_id member when disabling and freeing a xhci slot

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: dwc3: Makefile: fix link error on randconfig

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

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: host: xhci-plat: revert "usb: host: xhci-plat: enable clk in resume timing"

Leonard Crestez <leonard.crestez@nxp.com>
    ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name

Eric Dumazet <edumazet@google.com>
    net: usbnet: fix potential deadlock on 32bit hosts

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

Omar Sandoval <osandov@fb.com>
    loop: fix LOOP_GET_STATUS lock imbalance

Omar Sandoval <osandov@fb.com>
    loop: don't call into filesystem while holding lo_ctl_mutex

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

Arvind Yadav <arvind.yadav.cs@gmail.com>
    sparc: vio: use put_device() instead of kfree()

Mohammed Gamal <mgamal@redhat.com>
    hv_netvsc: Fix net device attach on older Windows hosts

Mohammed Gamal <mgamal@redhat.com>
    hv_netvsc: Ensure correct teardown message sequence order

Mohammed Gamal <mgamal@redhat.com>
    hv_netvsc: Split netvsc_revoke_buf() and netvsc_teardown_gpadl()

Mohammed Gamal <mgamal@redhat.com>
    hv_netvsc: Use Windows version instead of NVSP version on GPAD teardown

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: common detach logic

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: change GPAD teardown order on older versions

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: use RCU to fix concurrent rx and queue changes

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: disable NAPI before channel close

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: defer queue selection to VF

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix race in napi poll when rescheduling

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: cancel subchannel setup before halting device

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: fix error unwind handling if vmbus_open fails

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: only wake transmit queue if link is up

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: avoid retry on send during shutdown

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Use the num_online_cpus() for channel limit

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: empty current transmit aggregation if flow blocked

Vitaly Kuznetsov <vkuznets@redhat.com>
    hv_netvsc: preserve hw_features on mtu/channels/ringparam changes

Vitaly Kuznetsov <vkuznets@redhat.com>
    hv_netvsc: netvsc_teardown_gpadl() split

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Set tx_table to equal weight after subchannels open

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Add initialization of tx_table in netvsc_device_add()

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Rename tx_send_table to tx_table

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Rename ind_table to rx_table

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix the real number of queues of non-vRSS cases

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

Eric Biggers <ebiggers@google.com>
    net/smc: check for missing nlattrs in SMC_PNETID messages

Paolo Abeni <pabeni@redhat.com>
    net: sched: red: avoid hashing NULL child

Davide Caratti <dcaratti@redhat.com>
    net/sched: fix refcnt leak in the error path of tcf_vlan_init()

Tarick Bedeir <tarick@google.com>
    net/mlx4_core: Fix error handling in mlx4_init_port_info.

Amritha Nambiar <amritha.nambiar@intel.com>
    net: Fix a bug in removing queues from XPS map


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   2 +-
 arch/s390/crypto/crc32be-vx.S                      |   5 +-
 arch/s390/crypto/crc32le-vx.S                      |   4 +-
 arch/s390/include/asm/alternative-asm.h            | 108 +++++++
 arch/s390/include/asm/nospec-insn.h                | 195 +++++++++++++
 arch/s390/kernel/Makefile                          |   1 +
 arch/s390/kernel/asm-offsets.c                     |   1 +
 arch/s390/kernel/base.S                            |  24 +-
 arch/s390/kernel/entry.S                           | 105 ++-----
 arch/s390/kernel/mcount.S                          |  14 +-
 arch/s390/kernel/nospec-branch.c                   |  43 ++-
 arch/s390/kernel/nospec-sysfs.c                    |  21 ++
 arch/s390/kernel/reipl.S                           |   7 +-
 arch/s390/kernel/swsusp.S                          |  10 +-
 arch/s390/lib/mem.S                                |  13 +-
 arch/s390/net/bpf_jit.S                            |  16 +-
 arch/s390/net/bpf_jit_comp.c                       |  63 ++++-
 arch/sparc/kernel/vio.c                            |   2 +-
 arch/x86/kernel/machine_kexec_32.c                 |   6 +-
 arch/x86/kernel/machine_kexec_64.c                 |   5 +-
 drivers/block/loop.c                               |  71 +++--
 drivers/bluetooth/btusb.c                          |   6 +
 drivers/clk/clk.c                                  |   3 +
 drivers/clk/hisilicon/crg-hi3516cv300.c            |   2 +-
 drivers/clk/rockchip/clk-mmc-phase.c               |  23 ++
 drivers/clk/rockchip/clk-rk3228.c                  |   2 +-
 drivers/clk/samsung/clk-exynos3250.c               |   4 +-
 drivers/clk/samsung/clk-exynos5250.c               |   8 +-
 drivers/clk/samsung/clk-exynos5260.c               |   2 +-
 drivers/clk/samsung/clk-exynos5433.c               |  12 +-
 drivers/clk/samsung/clk-exynos7.c                  |   2 +-
 drivers/clk/samsung/clk-s3c2410.c                  |  16 +-
 drivers/clk/tegra/clk-pll.c                        |   2 +
 drivers/crypto/atmel-aes.c                         |   2 +-
 drivers/crypto/ccp/ccp-debugfs.c                   |   7 +-
 drivers/crypto/inside-secure/safexcel.c            |   9 +
 drivers/crypto/inside-secure/safexcel_cipher.c     |   2 +-
 drivers/crypto/inside-secure/safexcel_hash.c       |   8 +-
 drivers/crypto/sunxi-ss/sun4i-ss-core.c            |   1 +
 drivers/media/dvb-core/dmxdev.c                    |   2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |  10 +-
 drivers/media/i2c/adv748x/adv748x-hdmi.c           |   3 +
 drivers/media/i2c/ov5645.c                         |   5 +-
 drivers/media/i2c/tvp5150.c                        |  88 +++---
 drivers/media/pci/cx23885/cx23885-cards.c          |   4 +
 drivers/media/pci/cx23885/cx23885-core.c           |  10 +
 drivers/media/pci/cx25821/cx25821-core.c           |   7 +-
 drivers/media/platform/s3c-camif/camif-capture.c   |   7 +-
 drivers/media/platform/vivid/vivid-ctrls.c         |   2 +
 drivers/media/platform/vsp1/vsp1_drm.c             |   9 +
 drivers/media/usb/em28xx/em28xx-cards.c            |  22 +-
 drivers/media/usb/em28xx/em28xx.h                  |   2 +-
 drivers/media/v4l2-core/videobuf2-vmalloc.c        |   2 +-
 drivers/message/fusion/mptctl.c                    |   2 +
 drivers/net/ethernet/mellanox/mlx4/main.c          |   4 +-
 drivers/net/hyperv/hyperv_net.h                    |  11 +-
 drivers/net/hyperv/netvsc.c                        | 203 ++++++++------
 drivers/net/hyperv/netvsc_drv.c                    | 310 ++++++++++++---------
 drivers/net/hyperv/rndis_filter.c                  | 210 +++++++-------
 drivers/net/usb/qmi_wwan.c                         |   4 +
 drivers/net/usb/usbnet.c                           |  10 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  72 +++--
 drivers/rtc/hctosys.c                              |   5 +
 drivers/rtc/rtc-goldfish.c                         |   2 +
 drivers/rtc/rtc-m41t80.c                           |  18 +-
 drivers/rtc/rtc-rk808.c                            |  14 +-
 drivers/rtc/rtc-rp5c01.c                           |  12 +-
 drivers/rtc/rtc-snvs.c                             |  15 +-
 drivers/rtc/rtc-tx4939.c                           |   6 +-
 drivers/s390/scsi/zfcp_dbf.c                       |  23 +-
 drivers/s390/scsi/zfcp_ext.h                       |   5 +-
 drivers/s390/scsi/zfcp_scsi.c                      |  14 +-
 drivers/scsi/aacraid/commsup.c                     |   4 +-
 drivers/scsi/aacraid/linit.c                       |   5 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |   1 +
 drivers/scsi/iscsi_tcp.c                           |   8 +
 drivers/scsi/libsas/sas_scsi_host.c                |  33 +--
 drivers/scsi/lpfc/lpfc_attr.c                      |   5 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |   5 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   2 +
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   5 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c               |   2 +-
 drivers/scsi/mvsas/mv_94xx.c                       |  23 +-
 drivers/scsi/qedi/qedi_fw.c                        |   5 +
 drivers/scsi/qedi/qedi_main.c                      |  24 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   6 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +
 drivers/scsi/qla4xxx/ql4_def.h                     |   2 +
 drivers/scsi/qla4xxx/ql4_os.c                      |  46 +++
 drivers/scsi/scsi_lib.c                            |  13 +
 drivers/scsi/sd.c                                  |   3 +-
 drivers/scsi/sg.c                                  |   2 +-
 drivers/scsi/storvsc_drv.c                         |   2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c                |   2 +-
 drivers/scsi/ufs/ufshcd.c                          |   2 +
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |   6 +-
 drivers/staging/ks7010/ks_hostif.c                 |  31 +--
 drivers/staging/ks7010/ks_hostif.h                 |   1 +
 drivers/staging/lustre/lustre/include/obd.h        |   2 +-
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |   2 +-
 drivers/staging/lustre/lustre/osc/osc_cache.c      |   2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   2 +
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |  54 ++--
 drivers/tty/serial/8250/8250_port.c                |   3 +-
 drivers/tty/serial/altera_uart.c                   |  12 +-
 drivers/tty/serial/arc_uart.c                      |   5 +
 drivers/tty/serial/fsl_lpuart.c                    |   4 +
 drivers/tty/serial/imx.c                           |   6 +
 drivers/tty/serial/mxs-auart.c                     |   4 +
 drivers/tty/serial/samsung.c                       |   4 +
 drivers/tty/serial/sh-sci.c                        |   4 +
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 drivers/usb/class/cdc-acm.c                        |   9 +-
 drivers/usb/dwc2/core.h                            |   2 +-
 drivers/usb/dwc2/gadget.c                          |  12 +-
 drivers/usb/dwc2/hcd.c                             |  32 ++-
 drivers/usb/dwc3/Makefile                          |   2 +-
 drivers/usb/dwc3/core.c                            |  16 +-
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/dwc3/dwc3-omap.c                       |  16 ++
 drivers/usb/gadget/composite.c                     |  40 ++-
 drivers/usb/gadget/function/f_fs.c                 |   6 +-
 drivers/usb/gadget/function/f_uac2.c               |   2 +
 drivers/usb/gadget/udc/core.c                      |   2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   4 +-
 drivers/usb/gadget/udc/goku_udc.h                  |   2 +-
 drivers/usb/host/ohci-hcd.c                        |   3 +-
 drivers/usb/host/xhci-mem.c                        |   2 +
 drivers/usb/host/xhci-plat.c                       |  11 +-
 drivers/usb/host/xhci.c                            |  14 +-
 drivers/usb/usbip/Kconfig                          |   2 +-
 fs/ext2/inode.c                                    |  10 -
 fs/hfsplus/super.c                                 |   1 +
 include/linux/u64_stats_sync.h                     |  22 ++
 include/linux/usb/composite.h                      |   3 +
 include/scsi/scsi.h                                |   2 +
 include/uapi/linux/nl80211.h                       |   2 +
 net/core/dev.c                                     |   2 +-
 net/core/sock.c                                    |   2 +-
 net/ipv4/ip_output.c                               |   3 +-
 net/ipv4/tcp_output.c                              |   7 +-
 net/ipv6/ip6_output.c                              |   3 +-
 net/packet/af_packet.c                             |   4 +-
 net/sched/act_vlan.c                               |   2 +
 net/sched/sch_red.c                                |   5 +-
 net/sched/sch_tbf.c                                |   5 +-
 net/smc/smc_pnet.c                                 |  71 ++---
 net/wireless/core.c                                |   3 +
 sound/soc/codecs/hdmi-codec.c                      |   7 +-
 sound/soc/rockchip/Kconfig                         |   3 +
 sound/soc/samsung/i2s.c                            |  13 +-
 sound/soc/samsung/odroid.c                         |  11 +-
 sound/soc/soc-topology.c                           |   3 +
 sound/usb/quirks.c                                 |  29 +-
 155 files changed, 1787 insertions(+), 895 deletions(-)
