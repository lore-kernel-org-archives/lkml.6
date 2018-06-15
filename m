Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C9ADC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F0A208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qp8gcfFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F0A208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965333AbeFOBBe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:01:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35049 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964831AbeFOBBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:01:32 -0400
Received: by mail-pg0-f65.google.com with SMTP id 15-v6so3686077pge.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v1MCs7zLya7novvKNUKv/tMh3SjEXYZm+NOZkX/OYrs=;
        b=qp8gcfFrqVMVV19sK4nBWcaGkYbydLBc4tR8S7duMCxF9gyHXBRuHPrcSo3c32iIpz
         gtIIJ1TTqNE8QhdWftEDhV6xUup7VXMB4qYseWdE3rvGUwFHuV935W7ZVHXPU1gehDAF
         BmqOJ7R44yf8wUfBLEffQhy68CD6UK/QoaL9xAr/l4d1c7V8sAFj0AwXj5h9e6mLGi87
         ihN/FfzCiBJkhqqAEJaTLkgFvfpmeHcaMegz+pqH94IhS4QElZPxkoeyXAAthRpSy9hC
         o6sljR6VoSNbTCr5Gcqoh2YjS4/Xva+sBhNCuZsxKzCINScmj87hIwoSScTdOkMY4ysX
         96aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v1MCs7zLya7novvKNUKv/tMh3SjEXYZm+NOZkX/OYrs=;
        b=VGy43reyj3sjCDkJrC6OERaE6qGv0Dp+ayUEYOHftchOVKYtsE71kmy8hhCeWNxnc9
         T+FaBUykl2fXOiN4Pc/nMxifgELDGT86Fn0LULab9zxYJhPk+Z5sx5WBMKDU7U098/A/
         phpNXmftcJ3zIGxfC0DRNEMVtDjuA3l+DzrLOMykEXE7zToT6+koi6INQEsrCi68QEb3
         kvagU21pGykr4lKTraF2FNDty5E9/YBpszW0gzkkRWnizGa9I0ePlKA3g1Rgq19Z8cq7
         8sekSKjpCEQGPJaZWljjKo5UbX5jyr2xlaRs3WMmFcUcgfXZ2XOyAl93adviHNkqp/HO
         Xalw==
X-Gm-Message-State: APt69E19YdydoUEUqbH0HIXxdFxW63niyBRMmrWLG1/zuzs0Ax2em7eV
        j5IP59LDT/lQRQhokJJX8+DRGTmVtEg=
X-Google-Smtp-Source: ADUXVKIK5s8Pc2X6cJWCjad+OgVlWIWMVBtZ7A8heXjju3hBP1ysxTaLn2I5MyBjrvdgZTfUnIoTOw==
X-Received: by 2002:a62:a8e:: with SMTP id 14-v6mr11748881pfk.57.1529024491617;
        Thu, 14 Jun 2018 18:01:31 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t192-v6sm9717557pgc.74.2018.06.14.18.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 18:01:30 -0700 (PDT)
From:   Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        mhiramat@kernel.org, namhyung@kernel.org,
        mathieu.desnoyers@efficios.com, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>, peterz@infradead.org
Subject: [PATCH RFC] tracing: Call triggers only if event passes filter checks
Date:   Thu, 14 Jun 2018 18:01:13 -0700
Message-Id: <20180615010113.127718-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Currently, trace event triggers are called regardless of if the event
filter checks pass or fail. Thus if one were to enable event triggers
and filters at the same time, then the triggers will always be called
even if the filter checks didn't pass.

This is a problem for a usecase I was experimenting with: measuring the
time preemption is disabled using synthetic events and dump the stack
using the stacktrace trigger if the total preempt off time was greater
than a threshold. Following are the commands for the same:

Create synthetic event:

echo 'preemptdisable u64 lat' >> \
	      /sys/kernel/debug/tracing/synthetic_events

echo 'hist:keys=cpu:ts0=common_timestamp.usecs:scpu=cpu' >> \
	      /sys/kernel/debug/tracing/events/preemptirq/preempt_disable/trigger

echo 'hist:keys=cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
onmatch(preemptirq.preempt_disable).preemptdisable($wakeup_lat)' >> \
	        /sys/kernel/debug/tracing/events/preemptirq/preempt_enable/trigger

Enable synthetic event:

echo stacktrace > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
echo 'lat > 400' > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/filter
echo 1 > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/enable

With the patch, the stacktrace is triggered only if the filter checks
passed. It also seems sensible to call triggers only if filter checks
pass so lets do that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/trace/trace.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 630c5a24b2b2..b0b5df288924 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1296,13 +1296,14 @@ __event_trigger_test_discard(struct trace_event_file *file,
 			     enum event_trigger_type *tt)
 {
 	unsigned long eflags = file->flags;
+	bool filtered = (file->flags & EVENT_FILE_FL_FILTERED) &&
+			 !filter_match_preds(file->filter, entry);
 
-	if (eflags & EVENT_FILE_FL_TRIGGER_COND)
+	if (!filtered && (eflags & EVENT_FILE_FL_TRIGGER_COND))
 		*tt = event_triggers_call(file, entry, event);
 
 	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
-	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
-	     !filter_match_preds(file->filter, entry))) {
+	    filtered) {
 		__trace_event_discard_commit(buffer, event);
 		return true;
 	}
-- 
2.18.0.rc1.244.gcf134e6275-goog

