Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F38C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AFE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171316;
	bh=kN7wFD3C6wt4ETmI7w8uQ6+wgvl1CYxR7j1AFMwlkYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nNFNmk+m0qcecGTOs9L+F136eTCTodW7zOmg6QRBCtTHVe0utxCA+XaN650lzfRgV
	 V0zEHMPfKM784+ON47Rq7555qBrkdfZcFXu91E3m02fSlfiFEZhfP5Md/6M2CYsZIf
	 2BpJht+qj7FKebw5LjLBQt57OZSi5LOhUkyP4vL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeLRWPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727546AbeLRWPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:15:14 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5F16217D9;
        Tue, 18 Dec 2018 22:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171313;
        bh=kN7wFD3C6wt4ETmI7w8uQ6+wgvl1CYxR7j1AFMwlkYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNa38+YlmjVJfv4YQ57yi2W7RKoL3bkwsbPRxI6WVZajrQ9fmoU0KhHy5fRDZE4qL
         5MAYDp+KvAraxiXCsq302yjycGqHp8kaAluOq2Q4NhFhLN5nP/vrApWozKtN1g5V1D
         yYW+/EyTokOe19Lu5WBOKp0Uj2Ybs21U0G1/AS/Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 51/63] tools include arch: Grab a copy of x86's prctl.h
Date:   Tue, 18 Dec 2018 19:07:21 -0300
Message-Id: <20181218220733.15839-52-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need it to generate the tables for the 'code' arch_prctl's syscall
argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vu890pi18fpd4eyz61cazckj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/prctl.h | 17 +++++++++++++++++
 tools/perf/check-headers.sh             |  1 +
 2 files changed, 18 insertions(+)
 create mode 100644 tools/arch/x86/include/uapi/asm/prctl.h

diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
new file mode 100644
index 000000000000..5a6aac9fa41f
--- /dev/null
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _ASM_X86_PRCTL_H
+#define _ASM_X86_PRCTL_H
+
+#define ARCH_SET_GS		0x1001
+#define ARCH_SET_FS		0x1002
+#define ARCH_GET_FS		0x1003
+#define ARCH_GET_GS		0x1004
+
+#define ARCH_GET_CPUID		0x1011
+#define ARCH_SET_CPUID		0x1012
+
+#define ARCH_MAP_VDSO_X32	0x2001
+#define ARCH_MAP_VDSO_32	0x2002
+#define ARCH_MAP_VDSO_64	0x2003
+
+#endif /* _ASM_X86_PRCTL_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 9531f7bd7d9b..10d97dc632da 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -21,6 +21,7 @@ include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
 arch/x86/include/asm/required-features.h
 arch/x86/include/asm/cpufeatures.h
+arch/x86/include/uapi/asm/prctl.h
 arch/arm/include/uapi/asm/perf_regs.h
 arch/arm64/include/uapi/asm/perf_regs.h
 arch/powerpc/include/uapi/asm/perf_regs.h
-- 
2.19.2

