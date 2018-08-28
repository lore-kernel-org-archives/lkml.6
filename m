Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EDBC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505EA2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505EA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeH1S53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:57:29 -0400
Received: from foss.arm.com ([217.140.101.70]:40000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1S53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:57:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47ED418A;
        Tue, 28 Aug 2018 08:05:24 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC45A3F557;
        Tue, 28 Aug 2018 08:05:23 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     bhelgaas@google.com
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        will.deacon@arm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com
Subject: [PATCH 0/2] Drop node-local allocation during host controller initialisation
Date:   Tue, 28 Aug 2018 16:05:11 +0100
Message-Id: <20180828150513.32458-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

As discussed before[0], here are a couple of patches to drop
node-local allocations during host contoller initialisation. This set
covers both arm64 and x86.

I'm posting early to give the patches time on the list as well in next
in case there are issues we've missed.

The patches are based on v4.19-rc1 and has been boot tested on arm64
and compile tested on x86.

Thanks,
Punit

[0] https://www.spinics.net/lists/arm-kernel/msg669746.html

Punit Agrawal (2):
  arm64: PCI: Remove node-local allocations when initialising host
    controller
  x86/PCI: Remove node-local allocation when initialising host
    controller

 arch/arm64/kernel/pci.c | 5 ++---
 arch/x86/pci/acpi.c     | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.18.0

