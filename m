Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392DECE565
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A262151D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="qo9M+gfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A262151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeISSFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:05:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52155 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbeISSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:05:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id y2-v6so6078318wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kbL84+d+DsOFg/OzD+cbvvrEUxbtGzVBcNRtKIBsmDo=;
        b=qo9M+gfq8iBtoVnQZJqCYe+TGBWs53KX7QMXHu1f4qjKfh2jj1aboCcBtK+DBQIZt2
         4XbV8CKZ4JFA3ARhlecrh17/Dm5PZZs3UetDDl26UkvGIej6gzqfmkumTFMuPhhDjY3Z
         XdX4zTIVdgjUV7Q/y3bimEgv87xhhNs7ZO31rxrU+NJUe+daGFcwETdoUsn2/FihtiG4
         bTZ4ogUEZIq8700cAhDivIzaoC6BfZerrDpoHuBn4gFegANOP9a+wdMAcOlxaJNk/5JV
         ss+2mlD1THuzUze4Ysg6NWF8i3aCbLP+SuqQ9l+aWuXkeCBTN9u1859pY6BW7rmDHqtw
         zcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kbL84+d+DsOFg/OzD+cbvvrEUxbtGzVBcNRtKIBsmDo=;
        b=BjfpsLIVM8cDuf26ZL8v3zIRMkrXhIboIZw+97sdEzclDsI0Wg9lC8KDOxOYSokbAJ
         1klGnVfbZK5+Qbtb3YPWRTOXg5DQITM7+KXNMX0SQmg0FmN7lN1NJcdyuEyduEX7ZH9K
         JRS2XVRyLwGcupOoPjgkR1xo6Kd5VV1FkSNL0oGjGaiGru1Ukhu68+7yjI7fijyQeBMo
         OAww/6LKAbcKov/U3uR8PsUu78MIkFDg2TnyFFqhLBJzKskKcJkQ2pgda4nv0cF5OHS5
         NqOoesWZRMnCgvWGMsRqw8b6UbAcRSdNaDQ5CvlDWYFYtsDgAX739RFIb04uSKwd9BEN
         GRjQ==
X-Gm-Message-State: APzg51D9RUBqQz1IZQ6BBPvkfbN8Cgp8jWlTal7rLfHtdUVpE3CYB+2I
        wsSawjD6JXXTOCa6fG/YW2/msSA2bSk=
X-Google-Smtp-Source: ANB0Vda8ChrF1fO+MTxvYu7mBNmTgYHkqraO/Ab4wDMjh/j5S4Oyfc8vinqS6RnOI3yZKmOJgZ1/VQ==
X-Received: by 2002:a1c:d785:: with SMTP id o127-v6mr18961194wmg.67.1537360083646;
        Wed, 19 Sep 2018 05:28:03 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id l18-v6sm19412403wru.75.2018.09.19.05.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 05:28:03 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        x86@kernel.org
Subject: [RFC 5/5] tools/perf: Add support for per-PMU access control
Date:   Wed, 19 Sep 2018 13:27:51 +0100
Message-Id: <20180919122751.12439-6-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Now that the perf core supports per-PMU paranoid settings we need to
extend the tool to support that.

We handle the per-PMU setting in the platform support code where
applicable and also notify the user of the new facility on failures to
open the event.

Thanks to Jiri Olsa for contributing most of the "meat" for this patch and
suggestion to improve the error banner as well.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 tools/perf/arch/arm/util/cs-etm.c    |  2 +-
 tools/perf/arch/arm64/util/arm-spe.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c |  2 +-
 tools/perf/arch/x86/util/intel-pt.c  |  2 +-
 tools/perf/util/evsel.c              | 41 ++++++++++++++++++++++++++--
 tools/perf/util/pmu.c                | 17 ++++++++++++
 tools/perf/util/pmu.h                |  1 +
 7 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2f595cd73da6..a5437f100ab9 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -69,7 +69,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct perf_evsel *evsel, *cs_etm_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
+	bool privileged = (geteuid() == 0 || cs_etm_pmu->paranoid < 0);
 
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 5ccfce87e693..e7e8154757fa 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -65,7 +65,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 	struct perf_evsel *evsel, *arm_spe_evsel = NULL;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = geteuid() == 0 || arm_spe_pmu->paranoid < 0;
 	struct perf_evsel *tracking_evsel;
 	int err;
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 781df40b2966..c97e6556c8e7 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -116,7 +116,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
 	struct perf_evsel *evsel, *intel_bts_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = geteuid() == 0 || intel_bts_pmu->paranoid < 0;
 
 	btsr->evlist = evlist;
 	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index db0ba8caf5a2..ffbe5f7f1c57 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -555,7 +555,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	bool have_timing_info, need_immediate = false;
 	struct perf_evsel *evsel, *intel_pt_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = geteuid() == 0 || intel_pt_pmu->paranoid < 0;
 	u64 tsc_bit;
 	int err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a61628a1c12..fbebce0593f4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -9,6 +9,7 @@
 
 #include <byteswap.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <linux/bitops.h>
 #include <api/fs/fs.h>
@@ -20,6 +21,7 @@
 #include <linux/err.h>
 #include <sys/ioctl.h>
 #include <sys/resource.h>
+#include <sys/stat.h>
 #include <sys/types.h>
 #include <dirent.h>
 #include "asm/bug.h"
@@ -2843,10 +2845,37 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
+static int __pmu_paranoid_value(const char *name, char *buf, int bufsz)
+{
+	char path[PATH_MAX];
+	int fd, ret;
+
+	ret = snprintf(path, sizeof(path),
+		       "%s/bus/event_source/devices/%s/perf_event_paranoid",
+			sysfs__mountpoint(), name);
+	if (ret < 0 || ret == sizeof(path))
+		return -1;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	ret = read(fd, buf, bufsz - 1);
+	if (ret <= 0)
+		return -1;
+
+	if (buf[ret - 1] == '\n')
+		buf[ret - 1] = 0;
+	else
+		buf[ret] = 0;
+
+	return 0;
+}
+
 int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size)
 {
-	char sbuf[STRERR_BUFSIZE];
+	char sbuf[STRERR_BUFSIZE], buf[4];
 	int printed = 0;
 
 	switch (err) {
@@ -2870,9 +2899,15 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 		 ">= 1: Disallow CPU event access by users without CAP_SYS_ADMIN\n"
 		 ">= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN\n\n"
 		 "To make this setting permanent, edit /etc/sysctl.conf too, e.g.:\n\n"
-		 "	kernel.perf_event_paranoid = -1\n" ,
+		 "	kernel.perf_event_paranoid = -1\n\n"
+		 "Alternatively an identical per PMU setting can be found and adjusted at\n"
+		 "/sys/bus/event_source/devices/%s/perf_event_paranoid for fine-grained\n"
+		 "access control. The current value is '%s'.\n",
 				 target->system_wide ? "system-wide " : "",
-				 perf_event_paranoid());
+				 perf_event_paranoid(),
+				 evsel->pmu_name,
+				 __pmu_paranoid_value(evsel->pmu_name, buf,
+						      sizeof(buf)) ? "-" : buf);
 	case ENOENT:
 		return scnprintf(msg, size, "The %s event is not supported.",
 				 perf_evsel__name(evsel));
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index afd68524ffa9..5ecead4969af 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -545,6 +545,22 @@ static int pmu_type(const char *name, __u32 *type)
 	return ret;
 }
 
+static int pmu_paranoid(const char *name)
+{
+	char path[PATH_MAX];
+	int ret, paranoid;
+
+	ret = snprintf(path, sizeof(path),
+		       EVENT_SOURCE_DEVICE_PATH "%s/perf_event_paranoid",
+		       name);
+
+	if (ret > 0 && ret < (int)sizeof(path) &&
+	    !sysfs__read_int(path, &paranoid))
+		return paranoid;
+
+	return perf_event_paranoid();
+}
+
 /* Add all pmus in sysfs to pmu list: */
 static void pmu_read_sysfs(void)
 {
@@ -825,6 +841,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
 	pmu->name = strdup(name);
 	pmu->type = type;
 	pmu->is_uncore = pmu_is_uncore(name);
+	pmu->paranoid = pmu_paranoid(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 
 	INIT_LIST_HEAD(&pmu->format);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 76fecec7b3f9..1f00c8bbdb90 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -30,6 +30,7 @@ struct perf_pmu {
 	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
 	struct list_head list;    /* ELEM */
 	int (*set_drv_config)	(struct perf_evsel_config_term *term);
+	int paranoid;
 };
 
 struct perf_pmu_info {
-- 
2.17.1

