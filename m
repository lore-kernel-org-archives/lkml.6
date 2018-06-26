Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39029C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF36265A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF36265A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeFZHAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:00:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbeFZHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:00:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6xq2w1591972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:59:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6xqfD1591969;
        Mon, 25 Jun 2018 23:59:52 -0700
Date:   Mon, 25 Jun 2018 23:59:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ravi Bangoria <tipbot@zytor.com>
Message-ID: <tip-10e9cec905f96fdf47f398be70726e2931b376cd@git.kernel.org>
Cc:     ravi.bangoria@linux.ibm.com, hpa@zytor.com, namhyung@kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        yao.jin@linux.intel.com, tglx@linutronix.de, ak@linux.intel.com,
        jolsa@redhat.com, acme@redhat.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, davidcc@google.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, ak@linux.intel.com,
          acme@redhat.com, dsahern@gmail.com, linux-kernel@vger.kernel.org,
          davidcc@google.com, ravi.bangoria@linux.ibm.com, hpa@zytor.com,
          namhyung@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com
In-Reply-To: <20180625124220.6434-2-ravi.bangoria@linux.ibm.com>
References: <20180625124220.6434-2-ravi.bangoria@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Add missing output fields in a hint
Git-Commit-ID: 10e9cec905f96fdf47f398be70726e2931b376cd
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

Commit-ID:  10e9cec905f96fdf47f398be70726e2931b376cd
Gitweb:     https://git.kernel.org/tip/10e9cec905f96fdf47f398be70726e2931b376cd
Author:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate: Mon, 25 Jun 2018 18:12:18 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:37 -0300

perf script: Add missing output fields in a hint

A few fields are missing in a perf script -F hint. Add them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20180625124220.6434-2-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a31d7082188e..f3fefbcc4503 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3125,8 +3125,9 @@ int cmd_script(int argc, const char **argv)
 		     "+field to add and -field to remove."
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
-		     "addr,symoff,period,iregs,uregs,brstack,brstacksym,flags,"
-		     "bpf-output,callindent,insn,insnlen,brstackinsn,synth,phys_addr",
+		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
+		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
+		     "callindent,insn,insnlen,synth,phys_addr,metric,misc",
 		     parse_output_fields),
 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
 		    "system-wide collection from all CPUs"),
