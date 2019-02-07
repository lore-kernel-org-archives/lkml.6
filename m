Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162C1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ED620863
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUWhvCa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfBGPeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:34:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38920 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBGPeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:34:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so88332pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 07:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gnaetUAFn+5YXDNTxlF6/4akDTHRvmy2o7ahSflKzbc=;
        b=YUWhvCa+IWWIHj7ZG+JdsNmBjc1dorQgVphuozqicDGxg1HZ7MyK02kF7Qty9d/Bny
         oGMz7Rt+SeYzncC8bn1p5y4od2fS6n0GOwnHkNB7tE6C/PBhHcpwwqcv/3v5IanEfi9Q
         1N78CDg3Pe3KpU+E+VMQF7NcUnoSCuEUwqrIS1OwT6/EdpyvTqC7aEcDRwd0blSTAy8O
         /CuljMqw6aGrSHZEfNdUu6Vu0Wal0PJkjP2wHaHuA8e3cjTo/Qm2B0HWomMgMe4pPzIV
         CnJgJiOSdYejy8/yKQxBfb4FKH511YC2f1/PsG5vU4+osgVvUXIRf3AxMwhqa/hmHs8C
         ibQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gnaetUAFn+5YXDNTxlF6/4akDTHRvmy2o7ahSflKzbc=;
        b=Rw7fiu9b1EnP6ru7QZ+LiKYUPAPiAPBe0jQ6NnaOQMicJvviWFVwcX74EBV8ap7PFh
         I5uOSlZZ9k2g/ldtLtmH14t6gDa+q4qp0iej3/BBYNS1o9LGLhqZkNY78oUD82Vb4GdF
         zhfq1R02m/8iP3pyOJhEF6cuZAxdvqDZflH+fhOjULhAWD8atTBsjFGz/8poOTgps8Dv
         eJ9/FtXyXsREp5TfmhioMznMOgsYGSdIBYu00/Yb16T+6NTZN+h8yqlH23Ra4ciqSMon
         m+OrYX9UXLF1V/rsXU0MafaC9xvlP6PatXu/Llgc/80hR8Fz6nCGlA5gWop0rniN2RvC
         eWeg==
X-Gm-Message-State: AHQUAuaetZy1SC4QVvIftxZ0ZeJWB1AaIUyDJvROl3HYJk2LfYTdebIa
        gxbmhsK9j3OGASIUaVTYL9c=
X-Google-Smtp-Source: AHgI3Ibz4ZRgrSC+5RFbbderYFs1cc9anmCoZ5dAzMhtBPxnrmdFwXXiGQcA6dz20/8+BnYB2akR5w==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr16647718pls.68.1549553646532;
        Thu, 07 Feb 2019 07:34:06 -0800 (PST)
Received: from tianyukernel.corp.microsoft.com ([167.220.255.93])
        by smtp.googlemail.com with ESMTPSA id j6sm16493945pfg.126.2019.02.07.07.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Feb 2019 07:34:05 -0800 (PST)
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
Subject: [PATCH V3 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date:   Thu,  7 Feb 2019 23:33:46 +0800
Message-Id: <1549553629-8414-1-git-send-email-Tianyu.Lan@microsoft.com>
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
 drivers/iommu/hyperv-iommu.c   | 194 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 218 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4

