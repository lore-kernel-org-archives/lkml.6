Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E005C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4673220875
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4673220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeFUBsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:48:13 -0400
Received: from exmail.andestech.com ([59.124.169.137]:63720 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbeFUBsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:48:10 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w5L1fvso038394
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:41:57 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L1faYs038340;
        Thu, 21 Jun 2018 09:41:36 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 09:41:57 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>, <greentime@adnestech.com>
Subject: [PATCH 0/5] Building for 32-bit RISC-V kernel
Date:   Thu, 21 Jun 2018 09:41:40 +0800
Message-ID: <cover.1529506497.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L1faYs038340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are for building 32-bit RISC-V kernel.
 - Fix the compile errors and warnings on RV32I.
 - Fix some incompatible problem on RV32I.
 - Add format.h for compatible of print format.


Zong Li (5):
  RISC-V: Add conditional macro for zone of DMA32
  RISC-V: Select GENERIC_UCMPDI2 on RV32I
  RISC-V: Add definiion of extract symbol's index and type for 32-bit
  RISC-V: Change variable type for 32-bit compatible
  RISC-V: Use fixed width integer types for 32-bit compatible

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/asm/format.h   | 20 ++++++++++++++++++++
 arch/riscv/include/uapi/asm/elf.h |  9 +++++++--
 arch/riscv/kernel/module.c        | 35 ++++++++++++++++++-----------------
 arch/riscv/mm/init.c              |  3 +++
 5 files changed, 49 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/include/asm/format.h

-- 
2.16.1

