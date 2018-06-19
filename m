Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50467C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F220920693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qy67aIuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F220920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757375AbeFSVYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:24:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41163 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755319AbeFSVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:24:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so476006pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=Pelz5FHy51W8TUqyvihv8FJhBRIfpBQnlS/oVO34FcU=;
        b=qy67aIuQ2SjnjMCJeWy5iCmDiA+LNhM1CmEOX3zN8b421EZvFcpMuT+VOvoXNHm6dU
         v+9aTSYN4lLuX/XMgN9g4ojuLYitVQxbFEawXeu30X2Q05DvCEnMF71sFzYrpXWfEIsf
         zHEMeIqcHs0IfVYVxcLImVJaC5QC2cbiNqmT+kuHjcpjpRvwbsetAk5xjE0H1ds7D3co
         EnCguD5Db+5u70dG9I4t7RdhprYJgQvXtshKQnAj27Vxx+vt2BZK/fWJF8VX3KAdY+Za
         V1tPlTnkREXH53hzbqjFOUe5FyT45hjTtWL7m6XRlYaD39q43Od1/MZmPC7/mSIM273l
         si5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pelz5FHy51W8TUqyvihv8FJhBRIfpBQnlS/oVO34FcU=;
        b=rX8iXmWrCMuukOkRl2UzsExwKpuQqTKjL1U3bz93GRWKskFbzvyMR+EvdeBPVQzVR3
         HCtiRwT07khDbV1dW15nsGC8Ep07A0/8HWk74tN4uIGJe4Tjo9nOcojppeXCS06um1sA
         P8iELzHs+ILwChSup034GVpBk+vBbzHW+wY+fU1B2d3mGovZYZ+CMYv4WiO/OpyQrv5B
         aP21xaWOZ9d3P9g4dV5C67PKP070gHnHdThZd05r1aVQQ6SVoC7mv6wv955eGY0mwte7
         H+tz6VyQ6lJZlw36I4TQEzu/sRVp/i4jWZV6w/5NJwjSiJGKAxhk6w+qCUdKg1msgxdt
         efTA==
X-Gm-Message-State: APt69E0aSeXaqCXkjBc909bZyFrgTr9p6YyRwEUECiMAATo1Ztd95EMb
        u6VndXozcqNQ1GAF3EAaVNI=
X-Google-Smtp-Source: ADUXVKJGrZ1rRFVyOTpd6CuCeBT2GO237G+YfBp5MimD279izjPsfv2UQS4L9wY1upTf09gdj57Grg==
X-Received: by 2002:a63:2c9:: with SMTP id 192-v6mr643447pgc.354.1529443478210;
        Tue, 19 Jun 2018 14:24:38 -0700 (PDT)
Received: from mhkkerneltest.corp.microsoft.com ([131.107.160.79])
        by smtp.gmail.com with ESMTPSA id t23-v6sm846203pfa.86.2018.06.19.14.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 14:24:37 -0700 (PDT)
From:   Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mikelley@microsoft.com>
To:     will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        vkuznets@redhat.com, jasowang@redhat.com,
        leann.ogasawara@canonical.com, marcelo.cerri@canonical.com,
        sthemmin@microsoft.com, kys@microsoft.com
Cc:     mikelley@microsoft.com
Subject: [PATCH 0/5] Enable Linux guests on Hyper-V on ARM64
Date:   Tue, 19 Jun 2018 14:23:10 -0700
Message-Id: <1529443395-20874-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: mikelley@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables Linux guests running on Hyper-V on ARM64
hardware. New ARM64-specific code in arch/arm64/hyperv initializes
Hyper-V, including its synthetic clocks and hypercall mechanism.
Existing architecture independent drivers for Hyper-V's VMbus and
synthetic devices just work when built for ARM64. Hyper-V code is
built and included in the image and modules only if CONFIG_HYPERV
is enabled.

The five patches are organized as follows:
1) Implement slow_virt_to_phys() function for ARM64.  This
function parallels the same function for x86/x64, and is used
by the Hyper-V synthetic network driver.

2) Add include files that define the Hyper-V interface as
described in the Hyper-V Top Level Functional Spec (TLFS), plus
additional definitions specific to Linux running on Hyper-V.

3) Add core Hyper-V support on ARM64, including hypercalls,
synthetic clock initialization, and interrupt handlers.

4) Update the existing VMbus driver to generalize interrupt
management across x86/x64 and ARM64.

5) Make CONFIG_HYPERV selectable on ARM64 in addition to x86/x64.

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

Michael Kelley (5):
  arm64: mm: Add slow_virt_to_phys()
  arm64: hyperv: Add core Hyper-V include files
  arm64: hyperv: Add support for Hyper-V as a hypervisor
  Drivers: hv: vmbus: Add hooks for per-CPU IRQ
  Drivers: hv: Enable CONFIG_HYPERV on ARM64

 MAINTAINERS                          |   3 +
 arch/arm64/Makefile                  |   1 +
 arch/arm64/hyperv/Makefile           |   2 +
 arch/arm64/hyperv/hv_hvc.S           |  54 +++++
 arch/arm64/hyperv/hv_init.c          | 411 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c         | 178 +++++++++++++++
 arch/arm64/include/asm/hyperv-tlfs.h | 353 ++++++++++++++++++++++++++++++
 arch/arm64/include/asm/memory.h      |   6 +
 arch/arm64/include/asm/mshyperv.h    | 291 +++++++++++++++++++++++++
 arch/arm64/mm/pageattr.c             |  37 ++++
 arch/x86/include/asm/mshyperv.h      |   4 +
 drivers/hv/Kconfig                   |   3 +-
 drivers/hv/hv.c                      |   2 +
 13 files changed, 1344 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

-- 
1.8.3.1

