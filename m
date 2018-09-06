Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08500C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90A920844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90A920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeIFRmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:42:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeIFRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:42:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D6gKm303472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:06:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D6gDT303469;
        Thu, 6 Sep 2018 06:06:42 -0700
Date:   Thu, 6 Sep 2018 06:06:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-fa694160cca6dbba17c57dc7efec5f93feaf8795@git.kernel.org>
Cc:     acme@redhat.com, jolsa@redhat.com, ravi.bangoria@linux.ibm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, kamalesh@linux.vnet.ibm.com,
        sandipan@linux.ibm.com, hpa@zytor.com
Reply-To: kamalesh@linux.vnet.ibm.com, sandipan@linux.ibm.com,
          hpa@zytor.com, ravi.bangoria@linux.ibm.com, acme@redhat.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org,
          naveen.n.rao@linux.vnet.ibm.com
In-Reply-To: <20180828090848.1914-1-sandipan@linux.ibm.com>
References: <20180828090848.1914-1-sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf probe powerpc: Ignore SyS symbols irrespective
 of endianness
Git-Commit-ID: fa694160cca6dbba17c57dc7efec5f93feaf8795
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

Commit-ID:  fa694160cca6dbba17c57dc7efec5f93feaf8795
Gitweb:     https://git.kernel.org/tip/fa694160cca6dbba17c57dc7efec5f93feaf8795
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Tue, 28 Aug 2018 14:38:48 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:15:11 -0300

perf probe powerpc: Ignore SyS symbols irrespective of endianness

This makes sure that the SyS symbols are ignored for any powerpc system,
not just the big endian ones.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Fixes: fb6d59423115 ("perf probe ppc: Use the right prefix when ignoring SyS symbols on ppc")
Link: http://lkml.kernel.org/r/20180828090848.1914-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 20e7d74d86cd..10a44e946f77 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -22,15 +22,16 @@ bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 
 #endif
 
-#if !defined(_CALL_ELF) || _CALL_ELF != 2
 int arch__choose_best_symbol(struct symbol *syma,
 			     struct symbol *symb __maybe_unused)
 {
 	char *sym = syma->name;
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 	/* Skip over any initial dot */
 	if (*sym == '.')
 		sym++;
+#endif
 
 	/* Avoid "SyS" kernel syscall aliases */
 	if (strlen(sym) >= 3 && !strncmp(sym, "SyS", 3))
@@ -41,6 +42,7 @@ int arch__choose_best_symbol(struct symbol *syma,
 	return SYMBOL_A;
 }
 
+#if !defined(_CALL_ELF) || _CALL_ELF != 2
 /* Allow matching against dot variants */
 int arch__compare_symbol_names(const char *namea, const char *nameb)
 {
