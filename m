Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9F6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC94422510
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tduW5EOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC94422510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbeKMPr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732275AbeKMPr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:56 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3432251D;
        Tue, 13 Nov 2018 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088289;
        bh=AWzVjzeUVJsUK3t04cHGiP0B6CdFb0ryBVaQB2Qfg9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tduW5EOWPrgDOIfV0e8A+oqAVEL4CNrb6Ztp5CI7x1/7+WtP/OdylGzmy+oIsbJ4z
         RinCjpoLR7lMfxXbNswEil8PYbuyVEphucwzfHVX3e1WSqVixtm37aTg8GgKJ9oNmS
         0yeLh2ZIs2JK0nAjUXH5dcS5RvyKqcm+zHcmKKVY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        David Tolnay <dtolnay@gmail.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Hemant Kumar <hemant@linux.vnet.ibm.com>,
        Li Bin <huawei.libin@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>, zhangmengting@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 23/39] perf symbols: Set PLT entry/header sizes properly on Sparc
Date:   Tue, 13 Nov 2018 00:50:37 -0500
Message-Id: <20181113055053.78352-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>

[ Upstream commit d6afa561e1471ccfdaf7191230c0c59a37e45a5b ]

Using the sh_entsize for both values isn't correct.  It happens to be
correct on x86...

For both 32-bit and 64-bit sparc, there are four PLT entries in the PLT
section.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexis Berlemont <alexis.berlemont@gmail.com>
Cc: David Tolnay <dtolnay@gmail.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: zhangmengting@huawei.com
Fixes: b2f7605076d6 ("perf symbols: Fix plt entry calculation for ARM and AARCH64")
Link: http://lkml.kernel.org/r/20181017.120859.2268840244308635255.davem@davemloft.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/symbol-elf.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 29770ea61768..6e70cc00c161 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -324,7 +324,17 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 			plt_entry_size = 16;
 			break;
 
-		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/sparc/xtensa need to be checked */
+		case EM_SPARC:
+			plt_header_size = 48;
+			plt_entry_size = 12;
+			break;
+
+		case EM_SPARCV9:
+			plt_header_size = 128;
+			plt_entry_size = 32;
+			break;
+
+		default: /* FIXME: s390/alpha/mips/parisc/poperpc/sh/xtensa need to be checked */
 			plt_header_size = shdr_plt.sh_entsize;
 			plt_entry_size = shdr_plt.sh_entsize;
 			break;
-- 
2.17.1

