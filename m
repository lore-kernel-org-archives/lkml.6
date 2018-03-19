Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521483917-2-1545550008412672789
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483917; b=iCyLsD3jBED8Vh3x4qPzSAORIII4XLqLiMI3ZnQqBNTMgOT
    6dgR8wv+wd4RyzJHeP+PTq69db9gAL5xkqrL+K7mZIFPO7LU9OaEaqZxx6S61UCv
    GXbJVxTZIGsuflayMjN1tDeUiBvvQq24VU2DPYsvARyciYo7t6cf8dCbVtGGh536
    JKCYygPxwMkX8ShxU2xhG1CwwOq7BBm5Iz0+wJRvQHUTR8R2NNNUz2eO9Ylwn5+a
    qDxIhY9ogeGcSTx41XXFq9Y6KCAF7L4B+hLKruLQLAEn06nyfqR8Ydl4kZFyrBDE
    T1hiyFjQg3RIBGPyC05UlEykOOukdwoTzEP26VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483917; bh=BhVeHyA160/+ue5KAPW+jp2NGB
    ka90tCx2kClizS46M=; b=K6qa0oYx+GTW1PpFnJaKsahGohhaE5Kl3HtQnXTmyG
    oXbWiukm75NOZEjytiFHTG17We0eb/s14qB4zH9cKyNBFcDZ3deWNEL1lIIyJqjX
    E5rMip3PZlqXKFcxi3o9Hts0kU9nRpRUChZtHgcLrYi4Kra7sHPTHEQkiUCJv/Qp
    lEmJHJSGu41w573gRJRhL+kpUnQgRb1/LhqSr/xnHBcHB3IRmLWRMRkogC0OZ213
    TfDow/rows7YO/nZ+EMMZd3d/GI5qtz9jMsHO0HINL3M5TR7PWLsRaauZR83vKqC
    rDimtqfGptC1tS1Jdkdf9NP4qKbxwDeq+EPqIxE1DV7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheegfedunecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheegfedunecuvehluhhsthgvrhfuihiivgepie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031610AbeCSSZO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:25:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031358AbeCSSZL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:25:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 162/241] perf stat: Fix bug in handling events in error state
Date: Mon, 19 Mar 2018 19:07:07 +0100
Message-Id: <20180319180757.870200065@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Eranian <eranian@google.com>


[ Upstream commit db49a71798a38f3ddf3f3462703328dca39b1ac7 ]

(This is a patch has been sitting in the Intel CQM/CMT driver series for
 a while, despite not depend on it. Sending it now independently since
 the series is being discarded.)

When an event is in error state, read() returns 0 instead of sizeof()
buffer. In certain modes, such as interval printing, ignoring the 0
return value may cause bogus count deltas to be computed and thus
invalid results printed.

This patch fixes this problem by modifying read_counters() to mark the
event as not scaled (scaled = -1) to force the printout routine to show
<NOT COUNTED>.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: David Carrillo-Cisneros <davidcc@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170412182301.44406-1-davidcc@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-stat.c |   12 +++++++++---
 tools/perf/util/evsel.c   |    4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -311,8 +311,12 @@ static int read_counter(struct perf_evse
 			struct perf_counts_values *count;
 
 			count = perf_counts(counter->counts, cpu, thread);
-			if (perf_evsel__read(counter, cpu, thread, count))
+			if (perf_evsel__read(counter, cpu, thread, count)) {
+				counter->counts->scaled = -1;
+				perf_counts(counter->counts, cpu, thread)->ena = 0;
+				perf_counts(counter->counts, cpu, thread)->run = 0;
 				return -1;
+			}
 
 			if (STAT_RECORD) {
 				if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
@@ -337,12 +341,14 @@ static int read_counter(struct perf_evse
 static void read_counters(void)
 {
 	struct perf_evsel *counter;
+	int ret;
 
 	evlist__for_each_entry(evsel_list, counter) {
-		if (read_counter(counter))
+		ret = read_counter(counter);
+		if (ret)
 			pr_debug("failed to read counter %s\n", counter->name);
 
-		if (perf_stat_process_counter(&stat_config, counter))
+		if (ret == 0 && perf_stat_process_counter(&stat_config, counter))
 			pr_warning("failed to process counter %s\n", counter->name);
 	}
 }
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1221,7 +1221,7 @@ int perf_evsel__read(struct perf_evsel *
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;
 
-	if (readn(FD(evsel, cpu, thread), count, sizeof(*count)) < 0)
+	if (readn(FD(evsel, cpu, thread), count, sizeof(*count)) <= 0)
 		return -errno;
 
 	return 0;
@@ -1239,7 +1239,7 @@ int __perf_evsel__read_on_cpu(struct per
 	if (evsel->counts == NULL && perf_evsel__alloc_counts(evsel, cpu + 1, thread + 1) < 0)
 		return -ENOMEM;
 
-	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) < 0)
+	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
 		return -errno;
 
 	perf_evsel__compute_deltas(evsel, cpu, thread, &count);
