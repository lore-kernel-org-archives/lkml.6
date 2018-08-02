Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EDBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623C2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 05:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8623C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeHBH3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 03:29:38 -0400
Received: from exmail.andestech.com ([59.124.169.137]:51074 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeHBH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 03:29:38 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w725di8G008376;
        Thu, 2 Aug 2018 13:39:44 +0800 (GMT-8)
        (envelope-from alankao@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 2 Aug 2018
 13:40:04 +0800
From:   Alan Kao <alankao@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Palmer Dabbelt" <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, Darius Rad <darius@bluespec.com>
CC:     Alan Kao <alankao@andestech.com>
Subject: [PATCH v3 0/4] riscv: Add support to no-FPU systems
Date:   Thu, 2 Aug 2018 13:39:47 +0800
Message-ID: <1533188391-5932-1-git-send-email-alankao@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w725di8G008376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an option, CONFIG_FPU, to enable/disable floating-
point procedures.

Changes in v3:
 - Refactor the whole patch into independent ones.

Changes in v2:
 - Various code cleanups and style fixes.

Alan Kao (4):
  Extract FPU context operations from entry.S
  Refactor FPU codes in signal setup/return procedures
  Cleanup ISA string setting
  Add an option to support no-FPU systems

 arch/riscv/Kconfig                 |   9 +++
 arch/riscv/Makefile                |  19 +++---
 arch/riscv/include/asm/switch_to.h |  12 ++++
 arch/riscv/kernel/Makefile         |   1 +
 arch/riscv/kernel/entry.S          |  87 ------------------------
 arch/riscv/kernel/fpu.S            | 105 +++++++++++++++++++++++++++++
 arch/riscv/kernel/process.c        |   4 +-
 arch/riscv/kernel/signal.c         |  70 +++++++++++--------
 8 files changed, 181 insertions(+), 126 deletions(-)
 create mode 100644 arch/riscv/kernel/fpu.S

-- 
2.18.0

