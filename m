Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479B12245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj1u08DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479B12245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbeKMPsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732651AbeKMPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:48:38 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B9F422510;
        Tue, 13 Nov 2018 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088331;
        bh=y/jvvh22UBG107mYnk0CtynT/RNDjnwlLQaNjwABcl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jj1u08DRzamAFh3wAwtexR3HIK1fFaYkVT/Axgn2BZu8bKi2F4iyT6A4+UqcoTeke
         Ng9mn2/EyYirzNCs8g8ibnn9Ho/86KVc30fVzxMMws6agPloge4hmLsYuke7YlUIqw
         GycqhteBU6XY025QPSxZoSx8sH220b4457JES2Bk=
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
Subject: [PATCH AUTOSEL 4.14 16/26] perf symbols: Set PLT entry/header sizes properly on Sparc
Date:   Tue, 13 Nov 2018 00:51:40 -0500
Message-Id: <20181113055150.78773-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055150.78773-1-sashal@kernel.org>
References: <20181113055150.78773-1-sashal@kernel.org>
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
index 2de770511e70..8ad4296de98b 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -338,7 +338,17 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss, struct map *
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

