Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C421C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535302086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfARLNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:13:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfARLNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:13:44 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C997189AE6;
        Fri, 18 Jan 2019 11:13:43 +0000 (UTC)
Received: from kasong-desktop-nay-redhat-com.nay.redhat.com (unknown [10.66.128.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 649D1101F97A;
        Fri, 18 Jan 2019 11:13:35 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, dyoung@redhat.com, bhe@redhat.com,
        kexec@lists.infradead.org, akpm@linux-foundation.org,
        robert.moore@intel.com, erik.schmauss@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org,
        fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 0/3] make kexec work with efi=noruntime or efi=old_map
Date:   Fri, 18 Jan 2019 19:13:07 +0800
Message-Id: <20190118111310.29589-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 18 Jan 2019 11:13:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fix the kexec panic on efi=noruntime or efi=old_map
pass acpi_rsdp_addr to the second kernel and make it boot up properly.

Update from V2:
 - Store acpi rsdp value, and add an acpi_os_get_root_pointer_late as
   a helper, leveraging existing codes so we don't need to reparse RSDP.

Update from V1:
 - Add a cover letter and fix some type in commit message
 - Previous patches are not sent in a single thread

Kairui Song (3):
  x86, kexec_file_load: Don't setup EFI info if EFI runtime is not
    enabled
  acpi: store acpi_rsdp address for later kexec usage
  x86, kexec_file_load: make it work with efi=noruntime or efi=old_map

 arch/x86/kernel/kexec-bzimage64.c | 13 +++++++++++++
 drivers/acpi/osl.c                | 10 ++++++++++
 include/linux/acpi.h              |  3 +++
 3 files changed, 26 insertions(+)

-- 
2.20.1

