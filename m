Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97937C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514AC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514AC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbeGYV5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:57:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbeGYV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:57:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKi3Sr499198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:44:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKi33C499064;
        Wed, 25 Jul 2018 13:44:03 -0700
Date:   Wed, 25 Jul 2018 13:44:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-8a95c8994509c55abf1e38c0cc037b1205725e21@git.kernel.org>
Cc:     heiko.carstens@de.ibm.com, tglx@linutronix.de,
        borntraeger@de.ibm.com, mingo@kernel.org, acme@redhat.com,
        schwidefsky@de.ibm.com, brueckner@linux.ibm.com,
        tmricht@linux.ibm.com, raspl@linux.ibm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, borntraeger@de.ibm.com,
          heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com,
          brueckner@linux.ibm.com, mingo@kernel.org, acme@redhat.com,
          tmricht@linux.ibm.com, raspl@linux.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20180712070936.67547-1-tmricht@linux.ibm.com>
References: <20180712070936.67547-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kvm: Fix subcommands on s390
Git-Commit-ID: 8a95c8994509c55abf1e38c0cc037b1205725e21
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

Commit-ID:  8a95c8994509c55abf1e38c0cc037b1205725e21
Gitweb:     https://git.kernel.org/tip/8a95c8994509c55abf1e38c0cc037b1205725e21
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 12 Jul 2018 09:09:36 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:49:49 -0300

perf kvm: Fix subcommands on s390

With commit eca0fa28cd0d ("perf record: Provide detailed information on
s390 CPU") s390 platform provides detailed type/model/capacity
information in the CPU identifier string instead of just "IBM/S390".

This breaks 'perf kvm' support which uses hard coded string IBM/S390 to
compare with the CPU identifier string. Fix this by changing the
comparison.

Reported-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Stefan Raspl <raspl@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: stable@vger.kernel.org
Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
Link: http://lkml.kernel.org/r/20180712070936.67547-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
index d233e2eb9592..aaabab5e2830 100644
--- a/tools/perf/arch/s390/util/kvm-stat.c
+++ b/tools/perf/arch/s390/util/kvm-stat.c
@@ -102,7 +102,7 @@ const char * const kvm_skip_events[] = {
 
 int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
 {
-	if (strstr(cpuid, "IBM/S390")) {
+	if (strstr(cpuid, "IBM")) {
 		kvm->exit_reasons = sie_exit_reasons;
 		kvm->exit_reasons_isa = "SIE";
 	} else
