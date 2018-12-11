Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A4FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76EA32082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EA32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLKLXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:23:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:62986 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeLKLXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:23:52 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43DcyZ5LD8zB09b8;
        Tue, 11 Dec 2018 12:23:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xvU3fgHPPo0v; Tue, 11 Dec 2018 12:23:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43DcyZ4CLxzB09b7;
        Tue, 11 Dec 2018 12:23:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FB6B8B7EB;
        Tue, 11 Dec 2018 12:23:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xbv62bS9UM6C; Tue, 11 Dec 2018 12:23:51 +0100 (CET)
Received: from PO15451.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 64B0D8B7E7;
        Tue, 11 Dec 2018 12:23:51 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id C11BA71702; Tue, 11 Dec 2018 11:23:50 +0000 (UTC)
Message-Id: <cover.1544519035.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 0/3] Enable CONFIG_VMAP_STACK on the 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 11 Dec 2018 11:23:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to enable CONFIG_VMAP_STACK on the 8xx.

I'm sending it now to get early feedback if any.
For the time being, there is no proper handling of stack overflow.

This serie applies on the top of the serie "powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK"

Christophe Leroy (3):
  powerpc/32: prepare for CONFIG_VMAP_STACK
  powerpc/8xx: Use alternative scratch registers in DTLB miss handler
  powerpc/8xx: Enable CONFIG_VMAP_STACK

 arch/powerpc/Kconfig                   |   1 +
 arch/powerpc/include/asm/processor.h   |   5 ++
 arch/powerpc/include/asm/thread_info.h |   5 ++
 arch/powerpc/kernel/asm-offsets.c      |   5 ++
 arch/powerpc/kernel/entry_32.S         |  16 +++++
 arch/powerpc/kernel/head_8xx.S         | 114 ++++++++++++++++++++++++++-------
 arch/powerpc/perf/8xx-pmu.c            |  12 ++--
 7 files changed, 132 insertions(+), 26 deletions(-)

-- 
2.13.3

