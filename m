Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB65C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE72075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEE72075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeKTRxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:53:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:44214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbeKTRxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:53:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7ABEAF07;
        Tue, 20 Nov 2018 07:25:31 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        daniel.kiper@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/2] Move RSDP address out of setup_header
Date:   Tue, 20 Nov 2018 08:25:27 +0100
Message-Id: <20181120072529.5489-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend with Daniel's mailo address corrected

Instead of passing the RSDP address for Xen PVH guests from grub2 to
the kernel in setup_header move it into the non-legacy part of the
boot_params structure.

This patch series should be applied rather sooner than later in order
to avoid shipping linux 4.20 with a corky boot protocol.

Juergen Gross (2):
  x86/boot: revert commit ae7e1238e68f2a (Add ACPI RSDP address to
    setup_header)
  x86/acpi, x86/boot: Take RSDP address from boot params if available

 Documentation/x86/boot.txt            | 32 +-------------------------------
 arch/x86/boot/header.S                |  6 +-----
 arch/x86/include/asm/x86_init.h       |  2 --
 arch/x86/include/uapi/asm/bootparam.h |  7 ++-----
 arch/x86/kernel/acpi/boot.c           |  2 +-
 arch/x86/kernel/head32.c              |  1 -
 arch/x86/kernel/head64.c              |  2 --
 arch/x86/kernel/setup.c               | 17 -----------------
 8 files changed, 5 insertions(+), 64 deletions(-)

-- 
2.16.4

