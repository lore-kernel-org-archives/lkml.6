Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A909FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557AC208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbEF5wnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557AC208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965547AbeFNOJ7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965515AbeFNOJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:09:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8321208CB;
        Thu, 14 Jun 2018 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985394;
        bh=6LFlfVIki4/4zjY60BtjMH3R4F8bkAEHqblMNBnUbvY=;
        h=From:To:Cc:Subject:Date:From;
        b=KbEF5wnP1i1Hlsjg8kEwoGBHrRKz3Yn2TamPMztx4Ig250JdDNMqMx7J1M8Sxmf//
         tQ29H7Z4xIcoakG/lqi6TzR3hJxz3ycXIYjkn+VFqmSOkr062tgSSBut4ijDI5Z0bE
         U4rKzTPyJZn4owbw92+ozsi/rvL3SKqk/wxYFfQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/36] 4.14.50-stable review
Date:   Thu, 14 Jun 2018 16:04:23 +0200
Message-Id: <20180614132157.333004166@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.50-rc1
X-KernelTest-Deadline: 2018-06-16T13:21+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.50 release.
There are 36 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jun 16 13:21:44 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.50-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.50-rc1

Bin Liu <b-liu@ti.com>
    crypto: omap-sham - fix memleak

Michael Ellerman <mpe@ellerman.id.au>
    crypto: vmx - Remove overly verbose printk from AES XTS init

Michael Ellerman <mpe@ellerman.id.au>
    crypto: vmx - Remove overly verbose printk from AES init routines

Jan Glauber <jglauber@cavium.com>
    crypto: cavium - Limit result reading attempts

Jan Glauber <jglauber@cavium.com>
    crypto: cavium - Fix fallout from CONFIG_VMAP_STACK

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix size of RSA prime factor q

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam/qi - fix IV DMA mapping and updating

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix IV DMA mapping and updating

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix DMA mapping dir for generated IV

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - strip input zeros from RSA input buffer

Johannes Wienke <languitar@semipol.de>
    Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID

Ethan Lee <flibitijibibo@gmail.com>
    Input: goodix - add new ACPI id for GPD Win 2 touch screen

Paolo Bonzini <pbonzini@redhat.com>
    kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor access

Dave Martin <Dave.Martin@arm.com>
    tty: pl011: Avoid spuriously stuck-off interrupts

Gil Kupfer <gilkup@gmail.com>
    vmw_balloon: fixing double free when batching mode is off

Tony Lindgren <tony@atomide.com>
    serial: 8250: omap: Fix idling of clocks for unused uarts

Marek Szyprowski <m.szyprowski@samsung.com>
    serial: samsung: fix maxburst parameter for DMA transactions

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    tty/serial: atmel: use port->name as name in request_irq()

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Stop using printk format %pCr

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: udc: renesas_usb3: disable the controller's irqs for reconnecting

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    usb: gadget: function: printer: avoid wrong list handling in printer_write()

Manu Gautam <mgautam@codeaurora.org>
    phy: qcom-qusb2: Fix crash if nvmem cell not specified

Ethan Lee <flibitijibibo@gmail.com>
    Input: xpad - add GPD Win 2 Controller USB IDs

Alexander Kappner <agk@godking.net>
    usb-storage: Add compatibility quirk flags for G-Technologies G-Drive

Alexander Kappner <agk@godking.net>
    usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usbip: vhci_sysfs: fix potential Spectre v1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    NFC: pn533: don't send USB data off of the stack

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_virt_system

Felix Wilhelm <fwilhelm@google.com>
    kvm: nVMX: Enforce cpl=0 for VMX instructions

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: introduce linear_{read,write}_system

Wanpeng Li <wanpengli@tencent.com>
    KVM: X86: Fix reserved bits check for MOV to CR3

Linus Walleij <linus.walleij@linaro.org>
    gpio: No NULL owner

Kevin Easton <kevin@guarana.org>
    af_key: Always verify length of provided sadb_key

Bart Van Assche <bart.vanassche@wdc.com>
    blkdev_report_zones_ioctl(): Use vmalloc() to allocate large buffers

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: fix NULL pointer dereference on nft_ct_helper_obj_dump()


-------------

Diffstat:

 Makefile                                |   4 +-
 arch/x86/include/asm/kvm_emulate.h      |   6 +-
 arch/x86/kvm/emulate.c                  |  76 ++++++-----
 arch/x86/kvm/vmx.c                      |  38 +++---
 arch/x86/kvm/x86.c                      |  53 +++++---
 arch/x86/kvm/x86.h                      |   4 +-
 block/blk-zoned.c                       |   8 +-
 drivers/crypto/caam/caamalg.c           | 231 ++++++++++++++------------------
 drivers/crypto/caam/caamalg_qi.c        | 227 ++++++++++++++++---------------
 drivers/crypto/caam/caampkc.c           |  62 ++++++++-
 drivers/crypto/caam/caampkc.h           |   8 ++
 drivers/crypto/cavium/zip/common.h      |  21 +++
 drivers/crypto/cavium/zip/zip_crypto.c  |  22 +--
 drivers/crypto/cavium/zip/zip_deflate.c |   4 +-
 drivers/crypto/cavium/zip/zip_inflate.c |   4 +-
 drivers/crypto/omap-sham.c              |   2 +-
 drivers/crypto/vmx/aes.c                |   2 -
 drivers/crypto/vmx/aes_cbc.c            |   3 -
 drivers/crypto/vmx/aes_ctr.c            |   2 -
 drivers/crypto/vmx/aes_xts.c            |   2 -
 drivers/crypto/vmx/ghash.c              |   2 -
 drivers/gpio/gpiolib.c                  |   9 +-
 drivers/input/joystick/xpad.c           |   2 +
 drivers/input/mouse/elan_i2c_core.c     |   1 +
 drivers/input/touchscreen/goodix.c      |   1 +
 drivers/misc/vmw_balloon.c              |  23 +---
 drivers/nfc/pn533/usb.c                 |  42 ++++--
 drivers/phy/qualcomm/phy-qcom-qusb2.c   |   4 +
 drivers/staging/android/ion/ion.c       |   5 +-
 drivers/tty/serial/8250/8250_omap.c     |  16 ++-
 drivers/tty/serial/amba-pl011.c         |  16 +++
 drivers/tty/serial/atmel_serial.c       |   5 +-
 drivers/tty/serial/samsung.c            |   7 +-
 drivers/tty/serial/sh-sci.c             |   4 +-
 drivers/usb/gadget/function/f_printer.c |   6 +-
 drivers/usb/gadget/udc/renesas_usb3.c   |   7 +
 drivers/usb/storage/uas.c               |   6 +
 drivers/usb/storage/unusual_devs.h      |   9 ++
 drivers/usb/storage/unusual_uas.h       |   9 ++
 drivers/usb/usbip/vhci_sysfs.c          |  24 ++--
 net/key/af_key.c                        |  45 +++++--
 net/netfilter/nft_ct.c                  |  20 +--
 42 files changed, 629 insertions(+), 413 deletions(-)


