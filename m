Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9842C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9167321878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9167321878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbeHROnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:43:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:43:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBZOMm1286903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:35:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBZOog1286900;
        Sat, 18 Aug 2018 04:35:24 -0700
Date:   Sat, 18 Aug 2018 04:35:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-88c211907720f9eb23308401305aefa25392417f@git.kernel.org>
Cc:     tglx@linutronix.de, dsahern@gmail.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
          namhyung@kernel.org, peterz@infradead.org, eranian@google.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, dsahern@gmail.com, tglx@linutronix.de
In-Reply-To: <20180804130521.11408-20-jolsa@kernel.org>
References: <20180804130521.11408-20-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add --percent-type option
Git-Commit-ID: 88c211907720f9eb23308401305aefa25392417f
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

Commit-ID:  88c211907720f9eb23308401305aefa25392417f
Gitweb:     https://git.kernel.org/tip/88c211907720f9eb23308401305aefa25392417f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:53 -0300

perf annotate: Add --percent-type option

Add --percent-type option to set annotation percent type from following
choices:

  global-period, local-period, global-hits, local-hits

Examples:

  $ perf annotate --percent-type period-local --stdio | head -1
   Percent         |      Source code ... es, percent: local period)
  $ perf annotate --percent-type hits-local --stdio | head -1
   Percent         |      Source code ... es, percent: local hits)
  $ perf annotate --percent-type hits-global --stdio | head -1
   Percent         |      Source code ... es, percent: global hits)
  $ perf annotate --percent-type period-global --stdio | head -1
   Percent         |      Source code ... es, percent: global period)

The local/global keywords set if the percentage is computed in the scope
of the function (local) or the whole data (global).

The period/hits keywords set the base the percentage is computed on -
the samples period or the number of samples (hits).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-20-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  9 ++++++
 tools/perf/builtin-annotate.c              |  4 +++
 tools/perf/util/annotate.c                 | 52 ++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h                 |  2 ++
 4 files changed, 67 insertions(+)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 749cc6055dac..e8c972f89357 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -118,6 +118,15 @@ OPTIONS
 --group::
 	Show event group information together
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1]
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8180319285af..830481b8db26 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -542,6 +542,10 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_CALLBACK_DEFAULT(0, "stdio-color", NULL, "mode",
 			     "'always' (default), 'never' or 'auto' only applicable to --stdio mode",
 			     stdio__config_color, "always"),
+	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
+
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6316fa96d984..e4268b948e0e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2799,3 +2799,55 @@ void annotation_config__init(void)
 	annotation__default_options.show_total_period = symbol_conf.show_total_period;
 	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
+
+static unsigned int parse_percent_type(char *str1, char *str2)
+{
+	unsigned int type = (unsigned int) -1;
+
+	if (!strcmp("period", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_PERIOD_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_PERIOD_GLOBAL;
+	}
+
+	if (!strcmp("hits", str1)) {
+		if (!strcmp("local", str2))
+			type = PERCENT_HITS_LOCAL;
+		else if (!strcmp("global", str2))
+			type = PERCENT_HITS_GLOBAL;
+	}
+
+	return type;
+}
+
+int annotate_parse_percent_type(const struct option *opt, const char *_str,
+				int unset __maybe_unused)
+{
+	struct annotation_options *opts = opt->value;
+	unsigned int type;
+	char *str1, *str2;
+	int err = -1;
+
+	str1 = strdup(_str);
+	if (!str1)
+		return -ENOMEM;
+
+	str2 = strchr(str1, '-');
+	if (!str2)
+		goto out;
+
+	*str2++ = 0;
+
+	type = parse_percent_type(str1, str2);
+	if (type == (unsigned int) -1)
+		type = parse_percent_type(str2, str1);
+	if (type != (unsigned int) -1) {
+		opts->percent_type = type;
+		err = 0;
+	}
+
+out:
+	free(str1);
+	return err;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 760a6678edff..005a5fe8a8c6 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -397,4 +397,6 @@ static inline int symbol__tui_annotate(struct symbol *sym __maybe_unused,
 
 void annotation_config__init(void);
 
+int annotate_parse_percent_type(const struct option *opt, const char *_str,
+				int unset);
 #endif	/* __PERF_ANNOTATE_H */
