Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CBFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A69C20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPwqqOPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A69C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeKGUUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:20:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:20:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so16891978wre.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sEv3uOrcvNCjZbB1HGF/zWr7WB0LAuhTeYz66AM57eQ=;
        b=WPwqqOPteOe4Ny4fxv+Vd6sqyX1NXIzXgunkzdnvywvoI/x3ffgKqpqTxPj0a86vme
         MspQTzgqJNIF9FN+oz3ISh4A1+eUtgePt0Ae3l7iF3AmoTkfLZqnkgqOnk3UBsW5ldLy
         YBFl3zH2EflaQPNS6AKZRvg0972jWONuObF9WbqZNpVL//s+hXH23/zFMcGLq5Vf46o8
         hKcJ1o2PFqD3oxN3vXhJcJ/mUb7jpZrTILIgABWjJylD2hPetLfMIhuVUvbPOE2WVLY7
         n1sxf0HfLftakYjrhOEHOg/9SQcL7WNtJLAoH7pjkXFkCUMX2+MMG3hWpdvJThMaVp6r
         fGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sEv3uOrcvNCjZbB1HGF/zWr7WB0LAuhTeYz66AM57eQ=;
        b=B9l5DMMms37Lk5jBa3+lr3Js/RMMs8nC/CB9yRv5tRa55FBskvGjE82Zt2TsQGHz4a
         UALMTXKnTiwaaWnhcIwdGJVppfKgKYkID2AD+0EyX6T53FfJiw2MdrYF4Px83yLI4AvO
         RVFrdWkh65f/p18wChIVKataONt8X+ofxxyy0eeufpCMWrH39xVdfby46BbKWTVCF8XE
         ACBERpKg2mgfxUPpOnVzKUhaEQpvUaALrCAmNvFF8YZkJItfoc9KD8MSsGui6u6HUfp3
         /IfUX/A1vRP0ZcLyxI0AfMawGlmz6cLnw0faDAx6mZGNCN6Jh61sWG6rGfUOW5A3OdFA
         BoxQ==
X-Gm-Message-State: AGRZ1gLPcz45e4iTekbz53nf6uua8dPywQhqWJ7xvJRPuEX1zpD73p8B
        QS+biW+lG1HUSi6PmJ4AHxi23l/rsIR0Qg==
X-Google-Smtp-Source: AJdET5cVfHWUeSRUGHdoll7lMknInZTHI9ApVczCNpVdicUREc+/xSc+63dkArXRKhy5Hd+VPDZkKA==
X-Received: by 2002:adf:9022:: with SMTP id h31-v6mr1439150wrh.297.1541587847852;
        Wed, 07 Nov 2018 02:50:47 -0800 (PST)
Received: from localhost ([104.132.117.109])
        by smtp.gmail.com with ESMTPSA id x16-v6sm330736wro.28.2018.11.07.02.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 02:50:47 -0800 (PST)
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, peterz@infradead.org, mingo@elte.hu,
        jolsa@redhat.com
Subject: [PATCH] perf stat: fix csv mode column output for non-cgroup events
Date:   Wed,  7 Nov 2018 02:50:45 -0800
Message-Id: <1541587845-9150-1-git-send-email-eranian@google.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the -x option, perf stat prints csv-style output
with one event per line.  For each event, it prints the count,
the unit, the event name, the cgroup, and a bunch of other event
specific fields (such as insn per cycles).

When you use csv-style mode, you expect a normalized output where
each event is printed with the same number of fields regardless of
what it is so it can easily be imported into a spreadsheet or parsed.
For instance, if an event does not have a unit, then print an empty field
for it. Although this approach was implemented for the unit, it was not
for the cgroup.  When mixing cgroup and non-cgroup events, then non-cgroup
events would not show an empty field, instead the next field was printed,
make columns not line up correctly.

This patch fixes the cgroup output issues by forcing an empty field
for non-cgroup events as soon as one event has cgroup.

Before:
<not counted> @ @cycles @foo    @ 0    @100.00@@
2531614       @ @cycles @6420922@100.00@    @

foo cgroup lines up with time_running!

After:
<not counted> @ @cycles @foo @0       @100.00@@
2594834       @ @cycles @    @5287372 @100.00@@

Fields line up.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/stat-display.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e7b4c44ebb62..665ee374fc01 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -59,6 +59,15 @@ static void print_noise(struct perf_stat_config *config,
 	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
 }
 
+static void print_cgroup(struct perf_stat_config *config, struct perf_evsel *evsel)
+{
+	if (nr_cgroups) {
+		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
+		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
+	}
+}
+
+
 static void aggr_printout(struct perf_stat_config *config,
 			  struct perf_evsel *evsel, int id, int nr)
 {
@@ -336,8 +345,7 @@ static void abs_printout(struct perf_stat_config *config,
 
 	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
 
-	if (evsel->cgrp)
-		fprintf(output, "%s%s", config->csv_sep, evsel->cgrp->name);
+	print_cgroup(config, evsel);
 }
 
 static bool is_mixed_hw_group(struct perf_evsel *counter)
@@ -431,9 +439,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			config->csv_output ? 0 : -25,
 			perf_evsel__name(counter));
 
-		if (counter->cgrp)
-			fprintf(config->output, "%s%s",
-				config->csv_sep, counter->cgrp->name);
+		print_cgroup(config, counter);
 
 		if (!config->csv_output)
 			pm(config, &os, NULL, NULL, "", 0);
-- 
2.7.4

