Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214273-2-3179617193397612655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214272; b=O+K4hjcd+DbmKf5ZCoDUkOgOtZkmiLnSdDOWr3kxYwblnk4
    t1HwAnpTZm8iE9k5lJzYfBVLb4Ktad9iCiCT35CPPtkl/nlk1v2d9RWb94Igk9jh
    dT7EjjQpBHW1gPAP2UNXb4cWEd7HVDzIj4CFvd5C7pe7yBNXWbc2NAJGIkK7nN2p
    dOpd3/xZxdsKk5FRnLfgckSbjDWzx2QZ+pR7TV8zrjhaiuTkg9IEspYgOaXyCSwD
    km+12KYOq2qeq2xQ4GKO9mGFgmupv6yuFhYh5fZMbzEFgs4wxwdLZJXDT9yyGbWw
    0PaGRxpX2dnidc54SacInvTrWAkFYjSBoEIj5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214272; bh=NoXh2sbdYVaiVRvutvhZj5SEvO
    IjJw9lXgTNYEBrjvY=; b=UHtn4G/h61dEBGLw2rVEz4bxY3fuj1cZSEOdr8Fkcn
    QFG6uTt4HAziEgD6Cmz7K+61wQJEfGbeoK8OPu69CJx/VC0QlJg9WnJ+dLIczfwr
    9tNqsv6xDDxBiv9a4GzUOuWESryvmgO203IdEK5ul+5tyF0iWJuamtC/uRBC29wF
    9rbfCj+QJ+DNkblsSu0oBy02cBDaNvlnAupLy9EQWHOzpRHPioBCLUw1mg/qDwAO
    4IP86VSMqe2kPBSD21JQ3Xjoodjihy19ydUfQMe8vtJHVHirePk6aKVQx3pG59Sl
    7ieVr2MRW3UNt7AoTbsTSDsjAaoXFvsItFtiDgzFY1bQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeCPPbF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:31:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeCPPbD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:31:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 29/86] perf tools: Fix trigger class trigger_on()
Date: Fri, 16 Mar 2018 16:22:52 +0100
Message-Id: <20180316152319.379252134@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit de19e5c3c51fdb1ff20d0f61d099db902ff7494b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/trigger.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/tools/perf/util/trigger.h
+++ b/tools/perf/util/trigger.h
@@ -11,7 +11,7 @@
  * States and transits:
  *
  *
- *  OFF--(on)--> READY --(hit)--> HIT
+ *  OFF--> ON --> READY --(hit)--> HIT
  *                 ^               |
  *                 |            (ready)
  *                 |               |
@@ -26,8 +26,9 @@ struct trigger {
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
@@ -49,7 +50,7 @@ static inline bool trigger_is_error(stru
 static inline void trigger_on(struct trigger *t)
 {
 	TRIGGER_WARN_ONCE(t, TRIGGER_OFF);
-	t->state = TRIGGER_READY;
+	t->state = TRIGGER_ON;
 }
 
 static inline void trigger_ready(struct trigger *t)
