Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6461CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2963E21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eie1m18x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2963E21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbeKZVyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:36294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbeKZVyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:54:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9467A2146F;
        Mon, 26 Nov 2018 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230031;
        bh=AuEH9jgbSHviJll6nfowz/VV4SG9qTHrvgMP4YPjGIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eie1m18xyL+yfk3fshaQkUedU9M2gtxyjh5tFL2hvCX0hwF4JW/6a4A1k00vq+x2F
         aoIsuSBc4/sKShlNzn7LsPJlBcDM+nZBrzNNnaFmWPnLArPEpnFeAf6TAKNNcWenOT
         rUiZ7jZhw/WwAzhHZwcej/d/v0x56g+0abpm8Dkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 45/62] perf machine: Add nr_cpus_avail()
Date:   Mon, 26 Nov 2018 11:51:26 +0100
Message-Id: <20181126105054.194629176@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 9cecca325ea879c84fcd31a5e609a514c1a1dbd1 upstream.

Add a function to return the number of the machine's available CPUs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-5-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/env.c     | 13 +++++++++++++
 tools/perf/util/env.h     |  1 +
 tools/perf/util/machine.c |  5 +++++
 tools/perf/util/machine.h |  1 +
 4 files changed, 20 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 49f58921a968..b492cb974aa0 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -101,11 +101,24 @@ static int perf_env__read_arch(struct perf_env *env)
 	return env->arch ? 0 : -ENOMEM;
 }
 
+static int perf_env__read_nr_cpus_avail(struct perf_env *env)
+{
+	if (env->nr_cpus_avail == 0)
+		env->nr_cpus_avail = cpu__max_present_cpu();
+
+	return env->nr_cpus_avail ? 0 : -ENOENT;
+}
+
 const char *perf_env__raw_arch(struct perf_env *env)
 {
 	return env && !perf_env__read_arch(env) ? env->arch : "unknown";
 }
 
+int perf_env__nr_cpus_avail(struct perf_env *env)
+{
+	return env && !perf_env__read_nr_cpus_avail(env) ? env->nr_cpus_avail : 0;
+}
+
 void cpu_cache_level__free(struct cpu_cache_level *cache)
 {
 	free(cache->type);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index bd3869913907..9aace8452751 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -67,5 +67,6 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__raw_arch(struct perf_env *env);
+int perf_env__nr_cpus_avail(struct perf_env *env);
 
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index af18c3d55642..78aa1c5f19ca 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2247,6 +2247,11 @@ bool machine__is(struct machine *machine, const char *arch)
 	return machine && !strcmp(perf_env__raw_arch(machine->env), arch);
 }
 
+int machine__nr_cpus_avail(struct machine *machine)
+{
+	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
+}
+
 int machine__get_kernel_start(struct machine *machine)
 {
 	struct map *map = machine__kernel_map(machine);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index fbc5133fb27c..245743d9ce63 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -170,6 +170,7 @@ static inline bool machine__is_host(struct machine *machine)
 }
 
 bool machine__is(struct machine *machine, const char *arch);
+int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
-- 
2.17.1



