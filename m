Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1258495-1525291281-2-25439600877512927
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0007-tracepoint-Do-not-warn-on-ENOMEM.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525291280; b=HVmTCriESWA71SFHMj78JNPxFR8Pggh2n3ShD9QtDWAUSvnjWS
    i8j4HRQVPfWBmgeZtrIFnjuU0LZhVC7HrnJz2nRvPZzRuKJrTaP1RTBQ7ng9tVcl
    aZQFC+IIkoNI42wANiIRXAJiS0Q9pPrkmLOKGVc2L9K+9fzxXVl053yUYa1G4xFT
    sELkFyeRodumoKAigE5SBQrKn/O8jk1CE9eocZexCkOYfk74evE7vjQnq9aAh8E6
    S4cqIXGJaJRcdyjA5ktAaze2LzF29Rjrf9FT4PJjn38uQSsDwLemLxykwP/N4m1C
    osJaMMhRmBwWE2l4F7/o6X63JZX3HfEGHomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1525291280; bh=Mey1Jg4Jtml3RXTtCSIGa/mF/Sol9qR1mrUCV+diMbg=; b=S
    vlHQy7wYJUiAwUSYrenkCd0yd8grjXc4NdhbaVVJLSkPvkIKqK6AoD00y9G9zPe/
    CRCVrohw3Z9Xl4d6XmHSln1LU94WebB0Wu3l9MjkLB02dQ7CXYl99Y2xomeutf9t
    LbHvSwGvvLNPProf2LGjOCGOOnyoNqcgnpPg+x0A1DNqWPW2G9IU59on0IsHxDHP
    WjDrLfvl9qAkSLEG7n3saVzLY8q61P1uq5q+aFlO0FY73IP20/ru/3fEs3MYT4YB
    vajrJAvAIz0mVrzb3Bx9PXpQSV2w1oCiaxR3KyXumo9YRsp9QGy/tCbTCsQn2K43
    AtDsVjNJHGa2owWSROHCg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNaPI8IZzhZZ3796EURxxcQGKhbjAV6EalSeYYQYFZNZjAV5nNaafiMe7fysTk5zNFGS1ja3LqKgjvHx86RYpXRXKo0nJ93X+sHa8Zlu7BVl5xqs3bRF
    dVtngAWKjrBreaBQTGYOtlamwxuAitW8vz4pE3OvSWwNcD95nOAQghbP0/ldUZ487O4Xilzc7zHj1QgO9ljNYnFitigrIQXqhTj5TNYqS9vVUW+8O6rmoYXB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=VUJBJC2UJ8kA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=JfrnYn6hAAAA:8
    a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=hSkVLCK3AAAA:8 a=meVymXHHAAAA:8
    a=vnCGsA8dlzYzCeloyUUA:9 a=PUjeQqilurYA:10 a=jhqOcbufqs7Y1TYCrUUU:22
    a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cQPPKAXgyycSBL8etih5:22
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeEBUBT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 16:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeEBUAn (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 2 May 2018 16:00:43 -0400
Message-Id: <20180502200042.232743479@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 02 May 2018 16:00:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, stable@vger.kernel.org,
        syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com,
        syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 7/7] tracepoint: Do not warn on ENOMEM
References: <20180502200003.592877274@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0007-tracepoint-Do-not-warn-on-ENOMEM.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Tracepoint should only warn when a kernel API user does not respect the
required preconditions (e.g. same tracepoint enabled twice, or called
to remove a tracepoint that does not exist).

Silence warning in out-of-memory conditions, given that the error is
returned to the caller.

This ensures that out-of-memory error-injection testing does not trigger
warnings in tracepoint.c, which were seen by syzbot.

Link: https://lkml.kernel.org/r/001a114465e241a8720567419a72@google.com
Link: https://lkml.kernel.org/r/001a1140e0de15fc910567464190@google.com
Link: http://lkml.kernel.org/r/20180315124424.32319-1-mathieu.desnoyers@efficios.com

CC: Peter Zijlstra <peterz@infradead.org>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: stable@vger.kernel.org
Fixes: de7b2973903c6 ("tracepoint: Use struct pointer instead of name hash for reg/unreg tracepoints")
Reported-by: syzbot+9c0d616860575a73166a@syzkaller.appspotmail.com
Reported-by: syzbot+4e9ae7fa46233396f64d@syzkaller.appspotmail.com
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 671b13457387..1e37da2e0c25 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -207,7 +207,7 @@ static int tracepoint_add_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_add(&tp_funcs, func, prio);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
@@ -239,7 +239,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 			lockdep_is_held(&tracepoints_mutex));
 	old = func_remove(&tp_funcs, func);
 	if (IS_ERR(old)) {
-		WARN_ON_ONCE(1);
+		WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
 		return PTR_ERR(old);
 	}
 
-- 
2.17.0
