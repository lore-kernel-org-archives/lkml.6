Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-891914-1520357090-2-3548555276276071716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357089; b=pcf9yTl6KOIsRWGl6OflMfFQi/bJkhhk9owAFDyE8Xb4FBD
    TxiMt3cKWUAEO5PrM42K1BmSYW3ZXVAHC+BzPDCT4l81PBpGD4IwAbCPbSMKU/7i
    qshU5S6E13QQPySLvIopvP/5zRrQNMfzu5CtFPsoJ4jpKN1d6OkuyrDYJHfb2o8Z
    4+lu8MzR4/uBrazgR3ergFHb2CurP1leaqrOsazRLC1hMLpi+7jek504q9hz9Jzm
    DnGhQrfOw9AGQQoUkr3YDUoGMl4aYe05jK0GKC0F6Gv3YPNunrAHqumKkQtjsN30
    i21qFcgkQiK86bxKdmyfLPuYEHkEKCoiSGe0qPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520357089;
    bh=yda0M4JkgVKCTLjjqVel3nfgOoEyrs4ssYfOlclOH6k=; b=bdOLu4X3AaZ5
    +F/Il3v1IeEKU1d4OvcKEDKTzIY/SpBchFOUNgjXXWGQ1ZOoLLsiiP248ZzRRYzL
    QNEtVQkHNa7Foc2oU4kJEM1SqK8vZTPplbDSVDBOQbASLICe8Mj9Oo9/lLFKrNd/
    f8ZJXJNri5LWqfzytJrDMyP6dFaag2pharLOGa1GlkKFnRg68KG+vF0hkN/EHris
    7AGKruq5fCtwW9Pr9cR8leDAf3rR66rgiv1UIhEeTgWU4WSNi+YvIoJbQorZONRB
    1pD8pkMGx+e0GrhLtZJZYngmEg9oARTl+751emZqTDHN6MR++avDDzsLvmjyqK9g
    adjBTrLrJA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeCFRYe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 12:24:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754074AbeCFRYc (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 6 Mar 2018 12:24:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 9/9] perf tools: Fix trigger class trigger_on()
Date: Tue,  6 Mar 2018 14:23:43 -0300
Message-Id: <20180306172343.16546-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180306172343.16546-1-acme@kernel.org>
References: <20180306172343.16546-1-acme@kernel.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

trigger_on() means that the trigger is available but not ready, however
trigger_on() was making it ready. That can segfault if the signal comes
before trigger_ready(). e.g. (USR2 signal delivery not shown)

  $ perf record -e intel_pt//u -S sleep 1
  perf: Segmentation fault
  Obtained 16 stack frames.
  /home/ahunter/bin/perf(sighandler_dump_stack+0x40) [0x4ec550]
  /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
  /home/ahunter/bin/perf(perf_evsel__disable+0x26) [0x4b9dd6]
  /home/ahunter/bin/perf() [0x43a45b]
  /lib/x86_64-linux-gnu/libc.so.6(+0x36caf) [0x7fa76411acaf]
  /lib/x86_64-linux-gnu/libc.so.6(__xstat64+0x15) [0x7fa7641d2cc5]
  /home/ahunter/bin/perf() [0x4ec6c9]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4ec73b]
  /home/ahunter/bin/perf() [0x4eca15]
  /home/ahunter/bin/perf(machine__create_kernel_maps+0x257) [0x4f0b77]
  /home/ahunter/bin/perf(perf_session__new+0xc0) [0x4f86f0]
  /home/ahunter/bin/perf(cmd_record+0x722) [0x43c132]
  /home/ahunter/bin/perf() [0x4a11ae]
  /home/ahunter/bin/perf(main+0x5d4) [0x427fb4]

Note, for testing purposes, this is hard to hit unless you add some sleep()
in builtin-record.c before record__open().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: stable@vger.kernel.org
Fixes: 3dcc4436fa6f ("perf tools: Introduce trigger class")
Link: http://lkml.kernel.org/r/1519807144-30694-1-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trigger.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trigger.h b/tools/perf/util/trigger.h
index 370138e7e35c..88223bc7c82b 100644
--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -12,7 +12,7 @@
  * States and transits:
  *
  *
- *  OFF--(on)--> READY --(hit)--> HIT
+ *  OFF--> ON --> READY --(hit)--> HIT
  *                 ^               |
  *                 |            (ready)
  *                 |               |
@@ -27,8 +27,9 @@ struct trigger {
 	volatile enum {
 		TRIGGER_ERROR		= -2,
 		TRIGGER_OFF		= -1,
-		TRIGGER_READY		= 0,
-		TRIGGER_HIT		= 1,
+		TRIGGER_ON		= 0,
+		TRIGGER_READY		= 1,
+		TRIGGER_HIT		= 2,
 	} state;
 	const char *name;
 };
@@ -50,7 +51,7 @@ static inline bool trigger_is_error(struct trigger *t)
 static inline void trigger_on(struct trigger *t)
 {
 	TRIGGER_WARN_ONCE(t, TRIGGER_OFF);
-	t->state = TRIGGER_READY;
+	t->state = TRIGGER_ON;
 }
 
 static inline void trigger_ready(struct trigger *t)
-- 
2.14.3
