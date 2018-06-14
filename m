Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9E59CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB4208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="arDvkTF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BB4208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966128AbeFNOMv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966091AbeFNOMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76569208DD;
        Thu, 14 Jun 2018 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985568;
        bh=Y9XdixBJMhde+KU+yBojbKUuw9hc0oZ79Cs17Kg+qK0=;
        h=From:To:Cc:Subject:Date:From;
        b=arDvkTF2KHAFRimIoOPxYp0hvXoxhxlIgJcm3687IKOZQy/dLnI5YGmzm/uXHRzzK
         6bzWcbDvH2mHNaRwbTii5lnmPei/bB28VCRhp359AUqYq6RjW0z6BXzv9+pTjmfYfu
         FMpiklL7tGz8cgySsXd5P8T0i7Xo8XHjERG9GoY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/30] 4.9.109-stable review
Date:   Thu, 14 Jun 2018 16:04:41 +0200
Message-Id: <20180614132600.255515394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.109-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.109-rc1
X-KernelTest-Deadline: 2018-06-16T13:26+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.109 release.
There are 30 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jun 16 13:25:48 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.109-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.109-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    perf: sync up x86/.../cpufeatures.h

Bin Liu <b-liu@ti.com>
    crypto: omap-sham - fix memleak

Michael Ellerman <mpe@ellerman.id.au>
    crypto: vmx - Remove overly verbose printk from AES init routines

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

Alexander Kappner <agk@godking.net>
    usb-storage: Add compatibility quirk flags for G-Technologies G-Drive

Alexander Kappner <agk@godking.net>
    usb-storage: Add support for FL_ALWAYS_SYNC flag in the UAS driver

Gustavo A. R. Silva <gustavo@embeddedor.com>
    usbip: vhci_sysfs: fix potential Spectre v1

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Switch to pr_warn_once in ion_buffer_destroy

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_virt_system

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: introduce linear_{read,write}_system

Linus Walleij <linus.walleij@linaro.org>
    gpio: No NULL owner

Martin Wilck <mwilck@suse.com>
    nvmet: don't overwrite identify sn/fr with 0-bytes

Martin Wilck <mwilck@suse.com>
    nvmet: don't report 0-bytes in serial number

Johannes Thumshirn <jthumshirn@suse.de>
    nvmet: Move serial number from controller to subsystem

Andy Lutomirski <luto@kernel.org>
    x86/crypto, x86/fpu: Remove X86_FEATURE_EAGER_FPU #ifdef from the crc32c code

Kevin Easton <kevin@guarana.org>
    af_key: Always verify length of provided sadb_key

Keith Busch <keith.busch@intel.com>
    nvme-pci: initialize queue memory before interrupts

Andreas Born <futur.andy@googlemail.com>
    bonding: require speed/duplex only for 802.3ad, alb and tlb

Mahesh Bandewar <maheshb@google.com>
    bonding: fix active-backup transition

Mahesh Bandewar <maheshb@google.com>
    bonding: correctly update link status during mii-commit phase

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Hard-disable lazy FPU mode


-------------

Diffstat:

 Makefile                                 |  4 +-
 arch/x86/crypto/crc32c-intel_glue.c      |  5 --
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/include/asm/fpu/internal.h      |  2 +-
 arch/x86/include/asm/kvm_emulate.h       |  6 ++-
 arch/x86/kernel/fpu/init.c               | 91 ++------------------------------
 arch/x86/kvm/emulate.c                   | 72 ++++++++++++-------------
 arch/x86/kvm/vmx.c                       | 23 ++++----
 arch/x86/kvm/x86.c                       | 51 +++++++++++++-----
 arch/x86/kvm/x86.h                       |  4 +-
 drivers/crypto/omap-sham.c               |  2 +-
 drivers/crypto/vmx/aes.c                 |  2 -
 drivers/crypto/vmx/aes_cbc.c             |  2 -
 drivers/crypto/vmx/aes_ctr.c             |  2 -
 drivers/crypto/vmx/ghash.c               |  2 -
 drivers/gpio/gpiolib.c                   |  9 +++-
 drivers/input/mouse/elan_i2c_core.c      |  1 +
 drivers/input/touchscreen/goodix.c       |  1 +
 drivers/misc/vmw_balloon.c               | 23 +++-----
 drivers/net/bonding/bond_main.c          | 22 ++++----
 drivers/nvme/host/pci.c                  |  4 +-
 drivers/nvme/target/admin-cmd.c          | 22 +++++---
 drivers/nvme/target/core.c               |  5 +-
 drivers/nvme/target/nvmet.h              |  2 +-
 drivers/staging/android/ion/ion.c        |  5 +-
 drivers/tty/serial/8250/8250_omap.c      | 16 +++++-
 drivers/tty/serial/amba-pl011.c          | 16 ++++++
 drivers/tty/serial/atmel_serial.c        |  5 +-
 drivers/tty/serial/samsung.c             |  7 +--
 drivers/tty/serial/sh-sci.c              |  4 +-
 drivers/usb/gadget/udc/renesas_usb3.c    |  7 +++
 drivers/usb/storage/uas.c                |  6 +++
 drivers/usb/storage/unusual_devs.h       |  9 ++++
 drivers/usb/storage/unusual_uas.h        |  9 ++++
 drivers/usb/usbip/vhci_sysfs.c           | 24 ++++++---
 include/net/bonding.h                    |  5 ++
 net/key/af_key.c                         | 45 ++++++++++++----
 tools/arch/x86/include/asm/cpufeatures.h |  2 +-
 38 files changed, 274 insertions(+), 245 deletions(-)


