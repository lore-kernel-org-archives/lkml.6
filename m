Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908AA20651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfAOJ72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:59:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfAOJ72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:59:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F16578EA;
        Tue, 15 Jan 2019 09:59:27 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4177A18763;
        Tue, 15 Jan 2019 09:59:17 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dyoung@redhat.com, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH 0/2] make kexec work with efi=noruntime or efi=old_map
Date:   Tue, 15 Jan 2019 17:58:32 +0800
Message-Id: <20190115095834.22617-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 15 Jan 2019 09:59:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fix the kexec panic on efi=noruntime or efi=old_map
and leverage acpi_rsdp_addr to make the second kernel boot up properly.

Kairui Song (2):
  x86, kexec_file_load: Don't setup EFI info if EFI runtime is not
    enabled
  x86, kexec_file_load: make it work with efi=noruntime or efi=old_map

Update from V1:
 - Add a cover letter and fix some type in commit message
 - Previous patches are not sent in a single thread

 arch/x86/kernel/kexec-bzimage64.c | 24 ++++++++++++++++++++++++
 drivers/acpi/acpica/tbxfroot.c    |  3 +--
 include/acpi/acpixf.h             |  2 +-
 3 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.20.1

