Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54215C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC34225635
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC34225635
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754728AbeFYIvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:51:01 -0400
Received: from exmail.andestech.com ([59.124.169.137]:49495 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754449AbeFYIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:50:58 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5P8qSH7009370;
        Mon, 25 Jun 2018 16:52:28 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 25 Jun 2018
 16:49:45 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <hch@infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zongbox@gmail.com>
CC:     Zong Li <zong@andestech.com>, <greentime@andestech.com>
Subject: [PATCH v2 0/4] Building for 32-bit RISC-V kernel
Date:   Mon, 25 Jun 2018 16:49:36 +0800
Message-ID: <cover.1529915117.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5P8qSH7009370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches for building 32-bit RISC-V kernel.
 - Fix the compile errors and warnings on RV32I.
 - Fix some incompatible problem on RV32I.
 - Add format.h for compatible of print format.

The fixed width integer types format for Elf_Addr will move to
generic header by another patch. For now, there are some warning
about unexpected argument of type on RV32I.

Change in v1:
 - Fix some error in v1
 - Remove implementation of fixed width integer types format for Elf_Addr.

Zong Li (4):
  RISC-V: Add conditional macro for zone of DMA32
  RISC-V: Select GENERIC_UCMPDI2 on RV32I
  RISC-V: Add definiion of extract symbol's index and type for 32-bit
  RISC-V: Change variable type for 32-bit compatible

 arch/riscv/Kconfig                |  1 +
 arch/riscv/include/uapi/asm/elf.h |  9 +++++++--
 arch/riscv/kernel/module.c        | 22 +++++++++++-----------
 arch/riscv/mm/init.c              |  2 ++
 4 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.16.1

