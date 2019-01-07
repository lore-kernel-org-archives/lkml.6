Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D953C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD4520859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864685;
	bh=mCQsbCqBISjjzkIhEEncSxu5U3cXUtzckFub+sYWxT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQfczOX32kcCaHDNwa2bSpYSEuRyYUHeFL++O1PVv7KviNdkr+zlAuf2wIPC3TS1z
	 NG6DhEX1LBc+vlJqI1faCkGKNR6r6XFMdlZPqIG9J3zBvM6HaEErF3NmQRVunemya2
	 JRGkYn7+lS0I9fYNw9NHy1VJbxO6IUMC7HrfpJBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfAGMiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfAGMiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:38:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF5720859;
        Mon,  7 Jan 2019 12:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864681;
        bh=mCQsbCqBISjjzkIhEEncSxu5U3cXUtzckFub+sYWxT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sl9pcJNpES18Y3QLYGWV3+OKOnQBOERadNREt9vtGYwATHqXOhfUXeaJgyCXeH2nH
         GAb14Dhqi6XhlO4cNVfpdzawZx2/ljeZbw0vGjaiWcLXOffb2uNnK1miW6Hr76GI+7
         WnkyjJdV0AfDcuIHO/nOtODpCUUvaNXzhjPCLInQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.20 067/145] perf script: Use fallbacks for branch stacks
Date:   Mon,  7 Jan 2019 13:31:44 +0100
Message-Id: <20190107104446.050458027@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 692d0e63324d2954a0c63a812a8588e97023a295 upstream.

Branch stacks do not necessarily have the same cpumode as the 'ip'. Use
the fallback functions in those cases.

This patch depends on patch "perf tools: Add fallback functions for cases
where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181106210712.12098-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/builtin-script.c                            |   12 ++++++------
 tools/perf/util/scripting-engines/trace-event-python.c |   16 ++++++++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -728,8 +728,8 @@ static int perf_sample__fprintf_brstack(
 		if (PRINT_FIELD(DSO)) {
 			memset(&alf, 0, sizeof(alf));
 			memset(&alt, 0, sizeof(alt));
-			thread__find_map(thread, sample->cpumode, from, &alf);
-			thread__find_map(thread, sample->cpumode, to, &alt);
+			thread__find_map_fb(thread, sample->cpumode, from, &alf);
+			thread__find_map_fb(thread, sample->cpumode, to, &alt);
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
@@ -775,8 +775,8 @@ static int perf_sample__fprintf_brstacks
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		thread__find_symbol(thread, sample->cpumode, from, &alf);
-		thread__find_symbol(thread, sample->cpumode, to, &alt);
+		thread__find_symbol_fb(thread, sample->cpumode, from, &alf);
+		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
 		if (PRINT_FIELD(DSO)) {
@@ -820,11 +820,11 @@ static int perf_sample__fprintf_brstacko
 		from = br->entries[i].from;
 		to   = br->entries[i].to;
 
-		if (thread__find_map(thread, sample->cpumode, from, &alf) &&
+		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
 		    !alf.map->dso->adjust_symbols)
 			from = map__map_ip(alf.map, from);
 
-		if (thread__find_map(thread, sample->cpumode, to, &alt) &&
+		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
 		    !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -494,14 +494,14 @@ static PyObject *python_process_brstack(
 		pydict_set_item_string_decref(pyelem, "cycles",
 		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));
 
-		thread__find_map(thread, sample->cpumode,
-				 br->entries[i].from, &al);
+		thread__find_map_fb(thread, sample->cpumode,
+				    br->entries[i].from, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "from_dsoname",
 					      _PyUnicode_FromString(dsoname));
 
-		thread__find_map(thread, sample->cpumode,
-				 br->entries[i].to, &al);
+		thread__find_map_fb(thread, sample->cpumode,
+				    br->entries[i].to, &al);
 		dsoname = get_dsoname(al.map);
 		pydict_set_item_string_decref(pyelem, "to_dsoname",
 					      _PyUnicode_FromString(dsoname));
@@ -576,14 +576,14 @@ static PyObject *python_process_brstacks
 		if (!pyelem)
 			Py_FatalError("couldn't create Python dictionary");
 
-		thread__find_symbol(thread, sample->cpumode,
-				    br->entries[i].from, &al);
+		thread__find_symbol_fb(thread, sample->cpumode,
+				       br->entries[i].from, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "from",
 					      _PyUnicode_FromString(bf));
 
-		thread__find_symbol(thread, sample->cpumode,
-				    br->entries[i].to, &al);
+		thread__find_symbol_fb(thread, sample->cpumode,
+				       br->entries[i].to, &al);
 		get_symoff(al.sym, &al, true, bf, sizeof(bf));
 		pydict_set_item_string_decref(pyelem, "to",
 					      _PyUnicode_FromString(bf));


