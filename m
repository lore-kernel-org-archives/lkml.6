Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A71218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbeLTSTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:19:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:19:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIJBJ43683430
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:19:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIJAlB3683427;
        Thu, 20 Dec 2018 10:19:10 -0800
Date:   Thu, 20 Dec 2018 10:19:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-z2n63avz6tliqb5gmu4l1dti@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, treeze.taeung@gmail.com, acme@redhat.com,
        adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
        jolsa@kernel.org, lclaudio@redhat.com, wangnan0@huawei.com
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          treeze.taeung@gmail.com, jolsa@kernel.org, hpa@zytor.com,
          lclaudio@redhat.com, wangnan0@huawei.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf config: Show the configuration when no
 arguments are provided
Git-Commit-ID: 41e0d040c475251eea14c8b92ea3a01c5e269856
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

Commit-ID:  41e0d040c475251eea14c8b92ea3a01c5e269856
Gitweb:     https://git.kernel.org/tip/41e0d040c475251eea14c8b92ea3a01c5e269856
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 10:29:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:00 -0300

perf config: Show the configuration when no arguments are provided

More convenient thah having to recall what letter is about
showing/listing/dumping the configuration, i.e. no arguments means
-l/--list:

  # perf config
  llvm.dump-obj=true
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  # perf config -l
  llvm.dump-obj=true
  trace.default_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  trace.show_zeros=yes
  trace.show_duration=no
  # perf config -h

   Usage: perf config [<file-option>] [options] [section.name[=value] ...]

      -l, --list            show current config variables
          --system          use system config file
          --user            use user config file

  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-z2n63avz6tliqb5gmu4l1dti@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-config.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 514f70f95b57..d76f831f94c7 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -196,6 +196,7 @@ int cmd_config(int argc, const char **argv)
 			pr_err("Error: takes no arguments\n");
 			parse_options_usage(config_usage, config_options, "l", 1);
 		} else {
+do_action_list:
 			if (show_config(set) < 0) {
 				pr_err("Nothing configured, "
 				       "please check your %s \n", config_filename);
@@ -204,10 +205,8 @@ int cmd_config(int argc, const char **argv)
 		}
 		break;
 	default:
-		if (!argc) {
-			usage_with_options(config_usage, config_options);
-			break;
-		}
+		if (!argc)
+			goto do_action_list;
 
 		for (i = 0; argv[i]; i++) {
 			char *var, *value;
