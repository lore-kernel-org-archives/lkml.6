Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524652987-2-821982873503612286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652987; b=fX681FKKvEAl0VU2RCevMSpCKhbWxEReZM6Lj1P7N/kYDu6irP
    zMzmfAXWeWVxZAT8VwgwoFyOZJLOVCW1T1pVK0ZAfOveovAt1SKb4wgfcTUXOy9d
    fWPamd1hL7A6Ty3XlCTuSuanE4VLEFw3WJcIGkt7DMs+xOI9l5M+oHDSvbVv6B5a
    SRZqJXJeI1GQ1C+TsVGxtkO2TixhmIFRVPN3u8v+k0Osvg5eh97v7av0Nrhz3Qn0
    V6gohw9VAiLodinq8KJM3IaRDzrZe+igIO0yKtkzAo+djfNCXz+ED3YsQyI0I7L/
    NI/Wit3Gj+ABHiMkPLhXZhQKjHMK76JJixyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652987; bh=E020mQXrGTJxeVCx1GtdyUHacVAWaM
    vQszNKWYtEq0k=; b=bOx/zt8aRpT28JUBN3LHZIdrkfFNYiI9Ny6xzJ/50WI22J
    dHh6fzTBSMPdI4mlcODiqGwW4ftR76peorVA7pSw0zNojOiPdI9t/WjJ3yrybZEb
    7lcE2Rq2/QIZxSxDLkVfcBLJ7rgtRW3+b8+2EN7nuAQcg9l4U/FbFxhAjcvt5tjS
    ng8k2QDro1anePRpwXLKUIo7tAE3+cT+mGI2m7uV1Syw4FP8GFAtUQORJJQeIFU0
    LSIkAlkT8mQBUM+GQcGQ9WlUW60TZ/H6j9+cUDU7VObDSSVfcsYEXUosMMuPdhYS
    mK9tbfeDD1ofoSmSqhbZHD/MRWpGuZTvtkjjFPXA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMHs5Ccc0tlZfaWhuHC+//KjEr3yC4vZmmFEqD+q1M8RDxZtgmDoHMHYsFsp/HnqKk4eU75qFijchVKW0wcNScxlHKa4Dhh2hIjF6274CYViW+QxPApY
    LfF0Q6KDUTZj9BMFG7ezKrjgDhLUJ/vOrOdKuPhkB29UYjc755l6HHRXIUK/3x+xoZyg7USk5dGvO/YJhx3Sv7UwVuJCzEPlFJdI2tJQvybGjO1YAKbqFD8G
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=i0Q5mps0RjkFupXZ8FgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeDYKm7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:42:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754139AbeDYKmw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:42:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 136/183] perf record: Fix period option handling
Date: Wed, 25 Apr 2018 12:35:56 +0200
Message-Id: <20180425103247.883389928@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit f290aa1ffa45ed7e37599840878b4dae68269ee1 ]

Stephan reported we don't unset PERIOD sample type when --no-period is
specified. Adding the unset check and reset PERIOD if --no-period is
specified.

Committer notes:

Check the sample_type, it shouldn't have PERF_SAMPLE_PERIOD there when
--no-period is used.

Before:

  # perf record --no-period sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (7 samples) ]
  # perf evlist -v
  cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|PERIOD, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
  #

After:

[root@jouet ~]# perf record --no-period sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB perf.data (17 samples) ]
[root@jouet ~]# perf evlist -v
cycles:ppp: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1
[root@jouet ~]#

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-record.c |    3 ++-
 tools/perf/perf.h           |    1 +
 tools/perf/util/evsel.c     |   11 ++++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1611,7 +1611,8 @@ static struct option __record_options[]
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
 			"Record the sample timestamps"),
-	OPT_BOOLEAN('P', "period", &record.opts.period, "Record the sample period"),
+	OPT_BOOLEAN_SET('P', "period", &record.opts.period, &record.opts.period_set,
+			"Record the sample period"),
 	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
 		    "don't sample"),
 	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -50,6 +50,7 @@ struct record_opts {
 	bool	     sample_time_set;
 	bool	     sample_cpu;
 	bool	     period;
+	bool	     period_set;
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -943,9 +943,6 @@ void perf_evsel__config(struct perf_evse
 	if (target__has_cpu(&opts->target) || opts->sample_cpu)
 		perf_evsel__set_sample_bit(evsel, CPU);
 
-	if (opts->period)
-		perf_evsel__set_sample_bit(evsel, PERIOD);
-
 	/*
 	 * When the user explicitly disabled time don't force it here.
 	 */
@@ -1047,6 +1044,14 @@ void perf_evsel__config(struct perf_evse
 	apply_config_terms(evsel, opts);
 
 	evsel->ignore_missing_thread = opts->ignore_missing_thread;
+
+	/* The --period option takes the precedence. */
+	if (opts->period_set) {
+		if (opts->period)
+			perf_evsel__set_sample_bit(evsel, PERIOD);
+		else
+			perf_evsel__reset_sample_bit(evsel, PERIOD);
+	}
 }
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
