Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4CCC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F014D20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F014D20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJZQGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:06:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52825 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:06:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7UfaJ136645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:30:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7Uf0p136642;
        Fri, 26 Oct 2018 00:30:41 -0700
Date:   Fri, 26 Oct 2018 00:30:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-glaj3pwespxfj2fdjs9a20b6@git.kernel.org>
Cc:     hpa@zytor.com, wangnan0@huawei.com, ak@linux.intel.com,
        tglx@linutronix.de, adrian.hunter@intel.com, namhyung@kernel.org,
        dsahern@gmail.com, kim.phillips@arm.com, mingo@kernel.org,
        acme@redhat.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, wangnan0@huawei.com, tglx@linutronix.de,
          ak@linux.intel.com, adrian.hunter@intel.com, namhyung@kernel.org,
          dsahern@gmail.com, kim.phillips@arm.com, mingo@kernel.org,
          acme@redhat.com, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib subcmd: Introduce OPTION_ULONG
Git-Commit-ID: 4ba8b3ebf4f8f583c2c01da20e4d110a5881ffdd
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

Commit-ID:  4ba8b3ebf4f8f583c2c01da20e4d110a5881ffdd
Gitweb:     https://git.kernel.org/tip/4ba8b3ebf4f8f583c2c01da20e4d110a5881ffdd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 18 Oct 2018 15:24:07 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 19 Oct 2018 11:56:58 -0300

tools lib subcmd: Introduce OPTION_ULONG

For completeness, will be used in 'perf trace --max-events'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-glaj3pwespxfj2fdjs9a20b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 19 +++++++++++++++++++
 tools/lib/subcmd/parse-options.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index cb7154eccbdc..dbb9efbf718a 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -116,6 +116,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		case OPTION_INTEGER:
 		case OPTION_UINTEGER:
 		case OPTION_LONG:
+		case OPTION_ULONG:
 		case OPTION_U64:
 		default:
 			break;
@@ -166,6 +167,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		case OPTION_INTEGER:
 		case OPTION_UINTEGER:
 		case OPTION_LONG:
+		case OPTION_ULONG:
 		case OPTION_U64:
 		default:
 			break;
@@ -295,6 +297,22 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
 
+	case OPTION_ULONG:
+		if (unset) {
+			*(unsigned long *)opt->value = 0;
+			return 0;
+		}
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			*(unsigned long *)opt->value = opt->defval;
+			return 0;
+		}
+		if (get_arg(p, opt, flags, &arg))
+			return -1;
+		*(unsigned long *)opt->value = strtoul(arg, (char **)&s, 10);
+		if (*s)
+			return opterror(opt, "expects a numerical value", flags);
+		return 0;
+
 	case OPTION_U64:
 		if (unset) {
 			*(u64 *)opt->value = 0;
@@ -703,6 +721,7 @@ static void print_option_help(const struct option *opts, int full)
 	case OPTION_ARGUMENT:
 		break;
 	case OPTION_LONG:
+	case OPTION_ULONG:
 	case OPTION_U64:
 	case OPTION_INTEGER:
 	case OPTION_UINTEGER:
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 92fdbe1519f6..6ca2a8bfe716 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -25,6 +25,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_LONG,
+	OPTION_ULONG,
 	OPTION_CALLBACK,
 	OPTION_U64,
 	OPTION_UINTEGER,
@@ -133,6 +134,7 @@ struct option {
 #define OPT_INTEGER(s, l, v, h)     { .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, int *), .help = (h) }
 #define OPT_UINTEGER(s, l, v, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h) }
 #define OPT_LONG(s, l, v, h)        { .type = OPTION_LONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, long *), .help = (h) }
+#define OPT_ULONG(s, l, v, h)        { .type = OPTION_ULONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned long *), .help = (h) }
 #define OPT_U64(s, l, v, h)         { .type = OPTION_U64, .short_name = (s), .long_name = (l), .value = check_vtype(v, u64 *), .help = (h) }
 #define OPT_STRING(s, l, v, a, h)   { .type = OPTION_STRING,  .short_name = (s), .long_name = (l), .value = check_vtype(v, const char **), .argh = (a), .help = (h) }
 #define OPT_STRING_OPTARG(s, l, v, a, h, d) \
