Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0423C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71740218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWJnTQuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbfAaKRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:17:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33133 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAaKRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:17:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so1286761plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RoOAYP00CJcOcCAZPnZiRQwx0NYD5yfmYBG5B5dDX60=;
        b=YWJnTQuCgOMIMlMVLwhtinm7X33G33heYNvLafQLJhMldvljWSQ+kP+a5BO4TGwjOr
         68uF14bKXcGDDAzFZdssOF9I/yQ5Q6efG4g6WGMd3LMMxUiNkNA+PJPRI+NYNxmt9lww
         BVYYtnrYLI2w16OI9Njxh409GcoqJ3I1SlWUM/6nusAM5oh16upKuVyx4g8nDrRrBCZR
         o5k3FtSOhhL7qsKogLHy0E0o998TJLps0NqyRDxMFPUrFllBsu1OFVt3xmOwbglQ9TQ6
         eP90/dV8u/wKv/e5yf95qexo7McyhreiYrs1MV/CSso3G6MO62cVnwxabKU9BYDfDVBk
         McrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RoOAYP00CJcOcCAZPnZiRQwx0NYD5yfmYBG5B5dDX60=;
        b=q7iwAyPD5hoPoZ8a2qE7hlfwUPYCQ46F6mQ3e6Da2XNDWT/HB4fMZZOOoQvCCwiiH9
         1OI0+X5aGpy1a7cZfkGSYZ538qgCcI+mvIn47rD3HrD9cOW8eQbwZXntcKhpfAqE9Pba
         esXzjKNDD3cvnadSZWs0/1zPSI2IC5eIK/RDUNP/JCL50IVYBnJaCC5T/oxD2ifksi3x
         Lx2xiuJbQp6LqFUB2DB4V+oEIxvaQr+Kc5xKwLzdmuQCCFHGt2J/IJtpSksO7LCYVlhE
         CZeYZHLOtSy4Deh+x0yV/1pBPOat4oGNXEt6uaqywcTs0+KzeyN9zX6PJIXqvP/l4YO7
         Yu7Q==
X-Gm-Message-State: AJcUukdlPQ7ClQ1NokxI2Q7+UJmnK88a8AbuTaMgUXNOJTlB2JScW8HL
        qMCe/m3G3BB38c6+tRz+FZQ=
X-Google-Smtp-Source: ALg8bN6UUi7pPJT0RP72mAzIqM2QmOdB091kzRkZ9to47QVEIz970dYs7wSMKU9Msd+jEdAIhGQhOA==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr33598489plb.113.1548929873633;
        Thu, 31 Jan 2019 02:17:53 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id p67sm5944830pfg.44.2019.01.31.02.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 02:17:52 -0800 (PST)
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
        alex.williamson@redhat.com
Subject: [PATCH 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date:   Thu, 31 Jan 2019 18:17:30 +0800
Message-Id: <1548929853-25877-1-git-send-email-Tianyu.Lan@microsoft.com>
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
 arch/x86/kernel/cpu/mshyperv.c |  14 +++
 drivers/iommu/Kconfig          |   7 ++
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/hyperv-iommu.c   | 189 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 216 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4

