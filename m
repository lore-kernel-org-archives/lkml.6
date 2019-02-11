Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E96BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0E82073F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slqENg6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfBKOUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:20:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40816 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBKOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:20:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so2513646pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cRSp6tvS/Rco8rcWUsXIYReEFgEXXBMbEv9s2oo6H7Y=;
        b=slqENg6Nslm2S8G35nd06cHQ/nwbfvdW/cuOpHUw1A615nkhoRwfOOntJ5mJL+ZvWT
         H9NpAHlbdlPhLOFFoxSP3cwYjIKz33W0U28Y2b+21n0e052awZmx5UwvLqK8b/X93qX6
         QAlIYoYYZMXnA9wgJTOg5nlGbmZsvWkNJWHKAUXQ/z7tFYjGMfJYy+T941GGph+X1jx2
         wHdVYXGWItLcFv5ZLQzYnb8NTYGtnVIFGDcvNi1vpGR/R3sKbSTxcuUpGxiiBAJ1poCF
         +VLS7sZXielWlMKU4RmdVRVdy1EymgjU0qQPIzUwMnqCEleCpQSGXucRxnxidY4jQKti
         ZH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cRSp6tvS/Rco8rcWUsXIYReEFgEXXBMbEv9s2oo6H7Y=;
        b=qmteC+zDDfwpacgGF294cWMqyThJS/l0bkW+LdRd5CY8zag/hk2Hp5+neCfTOVxsa1
         vR4okpXZW01ycFfIDN2BOgDRsBWXG11zgLdZKXBrRr/upAqhyw5ZoyEfQG2ZVMLzrdTR
         frBWrqv+j89mbdegEmZHC07VFZIQbc1fpNnanbw+359yc3IkXC/0xtMnPty6h8ENWDKL
         PxrLRSuJKz/ExHcxMAUBoamyF4WH5/rBh24B8S+bBZB+kkGI4Z3I/G+ZKfukUWt6Huka
         lZJgG/r64+8my/ToNTTneSgfl8h5fe4k2EJf1l88/EXkFe9k36OLWazWxKQJ704cTBi9
         iQFg==
X-Gm-Message-State: AHQUAuZZVJGUG5m/Cg/WZhmCMzGU36t+74EpCuVr8r41WsYwedOSMKYr
        bTpNUYto3yRO0YHwSvH0SGU=
X-Google-Smtp-Source: AHgI3Iarytl1Q5adPr1u341JpAtNl4DClbU4RZAhUnIDtq+VV6YRpY2QncnBfoaL5y1+kcvOqDLL8A==
X-Received: by 2002:a62:9305:: with SMTP id b5mr36410747pfe.10.1549894845571;
        Mon, 11 Feb 2019 06:20:45 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id e2sm20551664pga.92.2019.02.11.06.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 06:20:44 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de, bp@alien8.de,
        davem@davemloft.net, devel@linuxdriverproject.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com, hpa@zytor.com,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        kys@microsoft.com, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, mingo@redhat.com,
        nicolas.ferre@microchip.com, sashal@kernel.org,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com,
        alex.williamson@redhat.com, dan.carpenter@oracle.com
Subject: [PATCH V4 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date:   Mon, 11 Feb 2019 22:20:21 +0800
Message-Id: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
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
 drivers/iommu/Kconfig          |   9 ++
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/hyperv-iommu.c   | 194 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 219 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4

