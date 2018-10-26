Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B034FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9DD20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9DD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJZQF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:05:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:05:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7TZtL136145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:29:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7TYov136142;
        Fri, 26 Oct 2018 00:29:34 -0700
Date:   Fri, 26 Oct 2018 00:29:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for David Miller <tipbot@zytor.com>
Message-ID: <tip-d6afa561e1471ccfdaf7191230c0c59a37e45a5b@git.kernel.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, guohanjun@huawei.com, peterz@infradead.org,
        davem@davemloft.net, hemant@linux.vnet.ibm.com, mingo@kernel.org,
        acme@redhat.com, wangnan0@huawei.com,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        dtolnay@gmail.com, namhyung@kernel.org, huawei.libin@huawei.com,
        hpa@zytor.com, milian.wolff@kdab.com
Reply-To: namhyung@kernel.org, dtolnay@gmail.com,
          alexis.berlemont@gmail.com, alexander.shishkin@linux.intel.com,
          milian.wolff@kdab.com, huawei.libin@huawei.com, hpa@zytor.com,
          mingo@kernel.org, hemant@linux.vnet.ibm.com, davem@davemloft.net,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          peterz@infradead.org, guohanjun@huawei.com, mhiramat@kernel.org,
          wangnan0@huawei.com, acme@redhat.com
In-Reply-To: <20181017.120859.2268840244308635255.davem@davemloft.net>
References: <20181017.120859.2268840244308635255.davem@davemloft.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf symbols: Set PLT entry/header sizes properly
 on Sparc
Git-Commit-ID: d6afa561e1471ccfdaf7191230c0c59a37e45a5b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d6afa561e1471ccfdaf7191230c0c59a37e45a5b
Gitweb:     https://git.kernel.org/tip/d6afa561e1471ccfdaf7191230c0c59a37e45a5b
Author:     David Miller <davem@davemloft.net>
AuthorDate: Wed, 17 Oct 2018 12:08:59 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 18 Oct 2018 11:19:44 -0300

perf symbols: Set PLT entry/header sizes properly on Sparc

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
