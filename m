Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA71C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F72204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJMNW8vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F72204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeH2Tks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:40:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43784 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbeH2Tks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:40:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so2488009pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=/YDwQsThjmPLdlPjCV+wqui3+DoIsxT3Y8bTH3kVInw=;
        b=IJMNW8vfTpTWe1niz7k0sdsv5AxKbBPozrjYQO8mFWQkuAbulwqThXuijPvRqJdCnv
         aYQM7RuGOPp7YbGITEjSOeRlWcWG1WiQlN0K81iOtxwMbZT8NIAJyIEfBq6BWFr58B8I
         w/ETPpgIUy2+x7xFGvRauffMdHQ4Et/6MQ0zGYdipYQqCoI7lQ5KxwAsJSGp9lFPq1Ay
         HZ78R7i+KtveEdsEUlnmdqn3SF75sblv6F3nFaM20jC7ST55U5euDxb2pSDBP/o3l7Hw
         o4HOyeI0jZpPLY5jtpUNmGifbsb1dCDpZ1nHLFC8fFU/5doZHQra5bqo82H5nBEbd9Oi
         nyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YDwQsThjmPLdlPjCV+wqui3+DoIsxT3Y8bTH3kVInw=;
        b=PevA0p1GTJnNVTWvSxEi+F95h7K637Bvjx6/th0Kq+ZUze6QjCWcnHT5rBf9o5SKYx
         ZU5NhKI6Ocaklpi45Aq/Y+jmv6fw7zfCcrADf/11zTQStsJCVbG/0tL1P5bNrUYV2l2+
         vZ1RUfJMVcVXw/gulrxaee6R+6IQ+jbfhVX4lAcDjcJkG0eq7H7pLXSjG556lynAQUsk
         /35DRTt4YNUE22Pe1uvtQ+J8ngzw4XWMx+797zl1QhgQTwKlw+jsKOPbej3sMRnZA1+f
         j+J7ipakChTTg5a4DcEvtSAsEJNrRwNsAcqjwheNVIB1VEgU3VDYHalNQSaZG/pR4Aw6
         tg7A==
X-Gm-Message-State: APzg51Dm2qTpGKTENRtwdSyDvcF1SX0xBgE0zlwm7CgiEIdPyMKKdeXr
        VNH/qqEPMm1/JjlUIsKHF4o=
X-Google-Smtp-Source: ANB0VdZvq7v9x2P+cx/gCAPoPuolzHNXlYbyDSPF+Lz677Jz45Ynv4q/Vq9hKnI5mmBJpVZ2rkbokA==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr6528506pfb.20.1535557397034;
        Wed, 29 Aug 2018 08:43:17 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id z6-v6sm6178821pgr.41.2018.08.29.08.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:43:16 -0700 (PDT)
From:   mhkelley58@gmail.com
X-Google-Original-From: mikelley@microsoft.com
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        marcelo.cerri@canonical.com, sthemmin@microsoft.com,
        kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 0/4] Enable Linux guests on Hyper-V on ARM64
Date:   Wed, 29 Aug 2018 08:22:24 -0700
Message-Id: <1535556148-10452-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

This series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its synthetic clocks and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The four patches are organized as follows:
1) Add include files that define the Hyper-V interface as
   described in the Hyper-V Top Level Functional Spec (TLFS), plus
   additional definitions specific to Linux running on Hyper-V.

2) Add core Hyper-V support on ARM64, including hypercalls,
   synthetic clock initialization, and interrupt handlers.

3) Update the existing VMbus driver to generalize interrupt
   management across x86/x64 and ARM64.

4) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

Some areas of Linux guests on Hyper-V on ARM64 are a work-
in-progress, primarily due to work still being done in Hyper-V:

* Hyper-V on ARM64 currently runs with a 4 Kbyte page size, and only
  supports guests with a 4 Kbyte page size. Because Hyper-V uses
  shared pages to communicate between the guest and the hypervisor,
  there are open design decisions on the page size to use when
  the guest is using 16K/64K pages.  Once those issues are
  resolved and Hyper-V fully supports 16K/64K guest pages, changes
  may be needed in the Linux drivers for Hyper-V synthetic devices.

* Hyper-V on ARM64 does not currently support mapping PCI devices
  into the guest address space. The Hyper-V PCI driver at
  drivers/pci/host/pci-hyperv.c has x86/x64-specific code and is
  not being built for ARM64.

In a few cases, terminology from the x86/x64 world has been carried
over into the ARM64 code ("MSR", "TSC").  Hyper-V still uses the
x86/x64 terminology and has not replaced it with something more
generic, so the code uses the Hyper-V terminology.  This will be
fixed when Hyper-V updates the usage in the TLFS.

Changes in v2:
* Remove patch to implement slow_virt_to_phys() on ARM64.
  Use of slow_virt_to_phys() in arch independent Hyper-V
  drivers has been eliminated by commit 6ba34171bcbd
  ("Drivers: hv: vmbus: Remove use of slow_virt_to_phys()")
* Minor tweaks to rebase to latest linux-next code

Michael Kelley (4):
  arm64: hyperv: Add core Hyper-V include files
  arm64: hyperv: Add support for Hyper-V as a hypervisor
  Drivers: hv: vmbus: Add hooks for per-CPU IRQ
  Drivers: hv: Enable CONFIG_HYPERV on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Makefile                  |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_hvc.S           |  54 +++++
 arch/arm64/hyperv/hv_init.c          | 437 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 178 ++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h | 338 +++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    | 295 +++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h      |   4 +
 drivers/hv/Kconfig                   |   3 +-
 drivers/hv/hv.c                      |   2 +
 11 files changed, 1316 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

