Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C26C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB45F21557
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ynQNFheH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45F21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeJHWjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbeJHWjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 861392151C;
        Mon,  8 Oct 2018 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012417;
        bh=yHB5ahIa4TX9QioB9aOdBoc+GN7Joxg/E5HNDfee7+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynQNFheH2OKQwpb3LWFngsewjswVPoPMtm2OQ3ps27+YOLqMPYpOTdcCn7ItfmfY0
         ZQ1mlVHEPIs0oC3WGiOjGxVQq7huh2KHfOwqDHMZvK9wEVZkmtvmgRFFj8T0hoAK3+
         By/HEP4749Q6DINAOyK9GPIf7tegiO3Y3Rfp1ME8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     James Cowgill <jcowgill@debian.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/32] RISC-V: include linux/ftrace.h in asm-prototypes.h
Date:   Mon,  8 Oct 2018 11:26:26 -0400
Message-Id: <20181008152629.70812-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152629.70812-1-sashal@kernel.org>
References: <20181008152629.70812-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Cowgill <jcowgill@debian.org>

[ Upstream commit 57a489786de9ec37d6e25ef1305dc337047f0236 ]

Building a riscv kernel with CONFIG_FUNCTION_TRACER and
CONFIG_MODVERSIONS enabled results in these two warnings:

  MODPOST vmlinux.o
WARNING: EXPORT symbol "return_to_handler" [vmlinux] version generation failed, symbol will not be versioned.
WARNING: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.

When exporting symbols from an assembly file, the MODVERSIONS code
requires their prototypes to be defined in asm-prototypes.h (see
scripts/Makefile.build). Since both of these symbols have prototypes
defined in linux/ftrace.h, include this header from RISC-V's
asm-prototypes.h.

Reported-by: Karsten Merker <merker@debian.org>
Signed-off-by: James Cowgill <jcowgill@debian.org>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/riscv/include/asm/asm-prototypes.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/riscv/include/asm/asm-prototypes.h

diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..c9fecd120d18
--- /dev/null
+++ b/arch/riscv/include/asm/asm-prototypes.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_PROTOTYPES_H
+
+#include <linux/ftrace.h>
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_RISCV_PROTOTYPES_H */
-- 
2.17.1

