Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16D525F95
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFHA8y64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16D525F95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965091AbeFYRmE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965075AbeFYRmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:42:01 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D0425F81;
        Mon, 25 Jun 2018 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948521;
        bh=6+HElIfRQMUbUL7YINGlIH+QMCCl7NYmKUu39D/Vnsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFHA8y64rnqFODOyB3aDfijVslOCuwyGR736V01Lb26NREGgWoYWEPJNLaDCKnb11
         +3yuGfqC1iIupeXNeUepQieV4MNLLRZXBnOd4nfBBClbOTAwSSonsuP+DlEk+rG/Xt
         4ZYNjqlWlKuR+uoOS4rFek467i302KutVrp2MPl0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/19] perf script: Add missing output fields in a hint
Date:   Mon, 25 Jun 2018 14:40:43 -0300
Message-Id: <20180625174045.25765-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

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
-- 
2.14.3

