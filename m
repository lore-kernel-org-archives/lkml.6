Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A38AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA8E214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT0SA5n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA8E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbeIXVHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732449AbeIXVHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:33 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED00B20C0A;
        Mon, 24 Sep 2018 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801497;
        bh=FhYgl0qqTnmeO/G6u1dQEYfI96sO42ax8nOayWWgveA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NT0SA5n2JtlRARmMIhlISlkBJR8XnAIRbhU75a7Cxcb2uH+Rve4s573EoMt8egwXd
         30E9Guk2wdC/rY4+/WGkkpSrpuNB6qXe5/xCEkFyVp5DeqPQolfRn5B8bIZVo5G8NU
         bE3dVwu9+Q6ro4RfH+GmLRVlBrSe3+qxJOMc2B7s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/27] tools lib traceevent: Rename data2host*() APIs
Date:   Mon, 24 Sep 2018 12:02:34 -0300
Message-Id: <20180924150242.14235-20-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

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
-- 
2.14.4

