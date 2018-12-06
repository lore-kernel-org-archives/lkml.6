Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A999C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2015208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2015208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLFSVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:21:16 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeLFSVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:21:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E45180D;
        Thu,  6 Dec 2018 10:21:15 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D4B33F5AF;
        Thu,  6 Dec 2018 10:21:15 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6AEE51AE0BDD; Thu,  6 Dec 2018 18:21:36 +0000 (GMT)
From:   Will Deacon <will.deacon@arm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, sean.j.christopherson@intel.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH v4 0/5] Clean up huge vmap and ioremap code
Date:   Thu,  6 Dec 2018 18:21:30 +0000
Message-Id: <1544120495-17438-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a resend of version four of the patches I previously posted here:

  v1: http://lkml.kernel.org/r/1536747974-25875-1-git-send-email-will.deacon@arm.com
  v2: http://lkml.kernel.org/r/1538478363-16255-1-git-send-email-will.deacon@arm.com
  v3: http://lkml.kernel.org/r/1539188584-15819-1-git-send-email-will.deacon@arm.com
  v4: http://lkml.kernel.org/r/1543252067-30831-1-git-send-email-will.deacon@arm.com

The only difference from v4 is that I have added Sean's Reviewed-by to the
core change.

Andrew, please can you take this via your tree for 4.21?

Thanks,

Will

--->8

Will Deacon (5):
  ioremap: Rework pXd_free_pYd_page() API
  arm64: mmu: Drop pXd_present() checks from pXd_free_pYd_table()
  x86/pgtable: Drop pXd_none() checks from pXd_free_pYd_table()
  lib/ioremap: Ensure phys_addr actually corresponds to a physical
    address
  lib/ioremap: Ensure break-before-make is used for huge p4d mappings

 arch/arm64/mm/mmu.c           |  13 +++---
 arch/x86/mm/pgtable.c         |  14 +++---
 include/asm-generic/pgtable.h |   5 ++
 lib/ioremap.c                 | 103 +++++++++++++++++++++++++++++-------------
 4 files changed, 91 insertions(+), 44 deletions(-)

-- 
2.1.4

