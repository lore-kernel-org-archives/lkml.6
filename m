Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A09BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA458204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA458204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeIZPEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:04:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42565 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:04:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8qlmR3772516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:52:47 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8ql1f3772513;
        Wed, 26 Sep 2018 01:52:47 -0700
Date:   Wed, 26 Sep 2018 01:52:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-1affd34f192a516436a2e0cec15a97bc1001678a@git.kernel.org>
Cc:     tglx@linutronix.de, tz.stoyanov@gmail.com, rostedt@goodmis.org,
        hpa@zytor.com, akpm@linux-foundation.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, hpa@zytor.com, rostedt@goodmis.org,
          akpm@linux-foundation.org, namhyung@kernel.org,
          tz.stoyanov@gmail.com, tglx@linutronix.de
In-Reply-To: <20180919185724.751088939@goodmis.org>
References: <20180919185724.751088939@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Rename data2host*() APIs
Git-Commit-ID: 1affd34f192a516436a2e0cec15a97bc1001678a
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

Commit-ID:  1affd34f192a516436a2e0cec15a97bc1001678a
Gitweb:     https://git.kernel.org/tip/1affd34f192a516436a2e0cec15a97bc1001678a
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 19 Sep 2018 14:56:57 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 17:30:06 -0300

tools lib traceevent: Rename data2host*() APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_". This renames data2host*() APIs

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180919185724.751088939@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 10 +++++-----
 tools/lib/traceevent/event-parse.h | 14 +++++++-------
 tools/perf/util/trace-event-read.c |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 055bee7b738a..7980fc6c3bac 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3331,11 +3331,11 @@ unsigned long long tep_read_number(struct tep_handle *pevent,
 	case 1:
 		return *(unsigned char *)ptr;
 	case 2:
-		return data2host2(pevent, ptr);
+		return tep_data2host2(pevent, ptr);
 	case 4:
-		return data2host4(pevent, ptr);
+		return tep_data2host4(pevent, ptr);
 	case 8:
-		return data2host8(pevent, ptr);
+		return tep_data2host8(pevent, ptr);
 	default:
 		/* BUG! */
 		return 0;
@@ -4061,7 +4061,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			f = tep_find_any_field(event, arg->string.string);
 			arg->string.offset = f->offset;
 		}
-		str_offset = data2host4(pevent, data + arg->string.offset);
+		str_offset = tep_data2host4(pevent, data + arg->string.offset);
 		str_offset &= 0xffff;
 		print_str_to_seq(s, format, len_arg, ((char *)data) + str_offset);
 		break;
@@ -4079,7 +4079,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			f = tep_find_any_field(event, arg->bitmask.bitmask);
 			arg->bitmask.offset = f->offset;
 		}
-		bitmask_offset = data2host4(pevent, data + arg->bitmask.offset);
+		bitmask_offset = tep_data2host4(pevent, data + arg->bitmask.offset);
 		bitmask_size = bitmask_offset >> 16;
 		bitmask_offset &= 0xffff;
 		print_bitmask_to_seq(pevent, s, format, len_arg,
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 2a7b0a857f39..830147dc6b21 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -496,7 +496,7 @@ static inline void tep_set_flag(struct tep_handle *pevent, int flag)
 }
 
 static inline unsigned short
-__data2host2(struct tep_handle *pevent, unsigned short data)
+__tep_data2host2(struct tep_handle *pevent, unsigned short data)
 {
 	unsigned short swap;
 
@@ -510,7 +510,7 @@ __data2host2(struct tep_handle *pevent, unsigned short data)
 }
 
 static inline unsigned int
-__data2host4(struct tep_handle *pevent, unsigned int data)
+__tep_data2host4(struct tep_handle *pevent, unsigned int data)
 {
 	unsigned int swap;
 
@@ -526,7 +526,7 @@ __data2host4(struct tep_handle *pevent, unsigned int data)
 }
 
 static inline unsigned long long
-__data2host8(struct tep_handle *pevent, unsigned long long data)
+__tep_data2host8(struct tep_handle *pevent, unsigned long long data)
 {
 	unsigned long long swap;
 
@@ -545,14 +545,14 @@ __data2host8(struct tep_handle *pevent, unsigned long long data)
 	return swap;
 }
 
-#define data2host2(pevent, ptr)		__data2host2(pevent, *(unsigned short *)(ptr))
-#define data2host4(pevent, ptr)		__data2host4(pevent, *(unsigned int *)(ptr))
-#define data2host8(pevent, ptr)					\
+#define tep_data2host2(pevent, ptr)		__tep_data2host2(pevent, *(unsigned short *)(ptr))
+#define tep_data2host4(pevent, ptr)		__tep_data2host4(pevent, *(unsigned int *)(ptr))
+#define tep_data2host8(pevent, ptr)					\
 ({								\
 	unsigned long long __val;				\
 								\
 	memcpy(&__val, (ptr), sizeof(unsigned long long));	\
-	__data2host8(pevent, __val);				\
+	__tep_data2host8(pevent, __val);				\
 })
 
 static inline int tep_host_bigendian(void)
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 3dfc1db6b25b..b98ee2a2eb44 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -102,7 +102,7 @@ static unsigned int read4(struct tep_handle *pevent)
 
 	if (do_read(&data, 4) < 0)
 		return 0;
-	return __data2host4(pevent, data);
+	return __tep_data2host4(pevent, data);
 }
 
 static unsigned long long read8(struct tep_handle *pevent)
@@ -111,7 +111,7 @@ static unsigned long long read8(struct tep_handle *pevent)
 
 	if (do_read(&data, 8) < 0)
 		return 0;
-	return __data2host8(pevent, data);
+	return __tep_data2host8(pevent, data);
 }
 
 static char *read_string(void)
