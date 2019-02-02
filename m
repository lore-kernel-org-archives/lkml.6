Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64FC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0152173B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p46WqfO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBBNPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:15:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43803 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfBBNPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:15:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so4655631pfk.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DtMA/MfhKJlOvXTe+Q3HwtDmCBZ+wASObT1nMUJKG50=;
        b=p46WqfO26194jNP31Ebve0+gEYmwvY9mYKttjG3PCeG9sX1JU7M/Yax8DWBSr0KgfV
         vSV2BDaTzJGJy9djL8dt/G0gbZBGSh8EpRa2nRuB9YjCzXd+jVm91MHnxbLDG26VP/17
         5gryZk/r6XA0IF31UxcD4ksKKK1t+76Sk238ufYHWekzE2Enxc7tvxh8fdcOrPDVzp7J
         ms8aYRHtvo361X1v3cJvsMR3chjLntv2GtdgFLjK7hHa+eauLmvkwcxJl4jej3jZ7WK0
         KbmRMejwUH1RGY8rwdpjjIvFDnWT+fKzj31elJ0irwiE8yIJOx2p+jYO3DWP3igM42ci
         krhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DtMA/MfhKJlOvXTe+Q3HwtDmCBZ+wASObT1nMUJKG50=;
        b=WNByIgeFsL/sHUhY2dWEJEBnbXWCPmfEn2pWZilS6hkgNYN22ig0TsFG3VmQvRN6MJ
         NusShCIbKOSgNrNIL2/AX0zGesCb+drQeRdUbm8P/da6y+CnML/IQcORCKC1ShQ7xI0/
         y1utcp6YiE+nDrRhNUfRMrBrufFSJgbUh3i0iJSRL1Cm9jxvRpZf22cKhnrPSkZY+Kji
         u828zcsi88cytDcSWj+bsAUz8/zdNsQKPJzE9nwgCz+AJ8YOolJzY7SpukYjK3SDA3WS
         51F5i9SbcEu8BCmQvYLqmbElbwO9b8DSpUR4P0nnbo3SqG+pXV7PecB2gVs5uEpkIuXs
         1UEA==
X-Gm-Message-State: AJcUukclHikm30Qr3mI4DTk2K9DvY32nIvWAivnlfMOomU5UfDvQTEW7
        R3D84LNsrheAL1vjlIcMOck=
X-Google-Smtp-Source: ALg8bN7mfibZSRhaie2+jqwDhaxt/uLAiyvt7/sFI5iQ5H5ErqsvkJL+M8tQZnt/e+IGCYovjseZWQ==
X-Received: by 2002:a63:2905:: with SMTP id p5mr39922123pgp.178.1549113300117;
        Sat, 02 Feb 2019 05:15:00 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id g28sm15148045pfd.100.2019.02.02.05.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Feb 2019 05:14:59 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, akpm@linux-foundation.org,
        arnd@arndb.de, bp@alien8.de, davem@davemloft.net,
        devel@linuxdriverproject.org, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, hpa@zytor.com,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        kys@microsoft.com, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, mingo@redhat.com,
        nicolas.ferre@microchip.com, sashal@kernel.org,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com
Subject: [PATCH V2 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date:   Sat,  2 Feb 2019 21:14:44 +0800
Message-Id: <1549113287-5606-1-git-send-email-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

On the bare metal, enabling X2APIC mode requires interrupt remapping
function which helps to deliver irq to cpu with 32-bit APIC ID.
Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
MSI protocol already supports to deliver interrupt to the CPU whose
virtual processor index is more than 255. IO-APIC interrupt still has
8-bit APIC ID limitation.

This patchset is to add Hyper-V stub IOMMU driver in order to enable
X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
interrupt remapping capability when X2APIC mode is available. X2APIC
destination mode is set to physical by PATCH 1 when X2APIC is available.
Hyper-V IOMMU driver will scan cpu 0~255 and set cpu into IO-APIC MAX cpu
affinity cpumask if its APIC ID is 8-bit. Driver creates a Hyper-V irq domain
to limit IO-APIC interrupts' affinity and make sure cpus assigned with IO-APIC
interrupt are in the scope of IO-APIC MAX cpu affinity.

Lan Tianyu (3):
  x86/Hyper-V: Set x2apic destination mode to physical when x2apic is   
     available
  HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
  MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
    scope

 MAINTAINERS                    |   1 +
 arch/x86/kernel/cpu/mshyperv.c |  10 +++
 drivers/iommu/Kconfig          |   8 ++
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/hyperv-iommu.c   | 193 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 217 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4

