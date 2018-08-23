Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F98C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077BA208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077BA208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbeHWMkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:40:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbeHWMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:40:35 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3EE9CAC;
        Thu, 23 Aug 2018 09:11:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 00/22] 4.18.5-stable review
Date:   Thu, 23 Aug 2018 09:56:26 +0200
Message-Id: <20180823074759.234685844@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.5-rc1
X-KernelTest-Deadline: 2018-08-25T07:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.5 release.
There are 22 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Aug 25 07:47:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.5-rc1

Jann Horn <jannh@google.com>
    reiserfs: fix broken xattr handling (heap corruption, bad retval)

Esben Haabendal <eha@deif.com>
    i2c: imx: Fix race condition in dma read

Hans de Goede <hdegoede@redhat.com>
    i2c: core: ACPI: Properly set status byte to 0 for multi-byte writes

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix unprotected list iteration in IRQ handler

Lukas Wunner <lukas@wunner.de>
    PCI: pciehp: Fix use-after-free on unplug

Myron Stowe <myron.stowe@redhat.com>
    PCI: Skip MPS logic for Virtual Functions (VFs)

Zachary Zhang <zhangzg@marvell.com>
    PCI: aardvark: Size bridges before resources allocation

Lukas Wunner <lukas@wunner.de>
    PCI: hotplug: Don't leak pci_slot on registration failure

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI / ACPI / PM: Resume all bridges on suspend-to-RAM

Christian König <ckoenig.leichtzumerken@gmail.com>
    PCI: Restore resized BAR state on resume

John David Anglin <dave.anglin@bell.net>
    parisc: Remove ordered stores from syscall.S

John David Anglin <dave.anglin@bell.net>
    parisc: Remove unnecessary barriers from spinlock.h

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/amdgpu/pm: Fix potential Spectre v1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/i915/kvmgt: Fix potential Spectre v1

Jeremy Cline <jcline@redhat.com>
    ext4: fix spectre gadget in ext4_mb_regular_allocator()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm/init: Remove freed kernel image areas from alias mapping

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm/init: Add helper for freeing kernel image pages

Dave Hansen <dave.hansen@linux.intel.com>
    x86/mm/init: Pass unconverted symbol addresses to free_init_pages()

Dave Hansen <dave.hansen@linux.intel.com>
    mm: Allow non-direct-map arguments to free_reserved_area()

Matthijs van Duin <matthijsvanduin@gmail.com>
    pty: fix O_CLOEXEC for TIOCGPTPEER

Takashi Iwai <tiwai@suse.de>
    EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]


-------------

Diffstat:

 Makefile                               |  4 ++--
 arch/parisc/include/asm/spinlock.h     |  8 ++------
 arch/parisc/kernel/syscall.S           | 24 +++++++++++-----------
 arch/powerpc/kernel/security.c         | 27 ++++++++++++++++---------
 arch/x86/include/asm/processor.h       |  1 +
 arch/x86/include/asm/set_memory.h      |  1 +
 arch/x86/mm/init.c                     | 37 +++++++++++++++++++++++++++++++---
 arch/x86/mm/init_64.c                  |  8 ++------
 arch/x86/mm/pageattr.c                 | 13 ++++++++++++
 drivers/edac/edac_mc.c                 |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |  3 ++-
 drivers/gpu/drm/i915/gvt/kvmgt.c       |  9 ++++++++-
 drivers/i2c/busses/i2c-imx.c           |  8 ++++----
 drivers/i2c/i2c-core-acpi.c            | 11 +++++++---
 drivers/pci/controller/pci-aardvark.c  |  1 +
 drivers/pci/hotplug/pci_hotplug_core.c |  9 +++++++++
 drivers/pci/hotplug/pciehp.h           |  1 +
 drivers/pci/hotplug/pciehp_core.c      |  7 +++++++
 drivers/pci/hotplug/pciehp_hpc.c       | 18 +++++------------
 drivers/pci/pci-acpi.c                 |  6 ++----
 drivers/pci/pci.c                      | 28 +++++++++++++++++++++++++
 drivers/pci/probe.c                    |  4 ++++
 drivers/tty/pty.c                      |  2 +-
 fs/ext4/mballoc.c                      |  4 +++-
 fs/reiserfs/xattr.c                    |  4 +++-
 mm/page_alloc.c                        | 16 +++++++++++++--
 26 files changed, 185 insertions(+), 70 deletions(-)


