Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-420442-1526483125-3-3325855271581966661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='ISO-8859-15'
X-Attached: 0011-ftrace-selftest-Have-the-reset_trigger-code-be-a-bit.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526483125; b=HOKmTj//c8RWC5ovYxNg4a3k/Oj9iQMVa3jcUWory6F/fhMXXF
    duZRqAFkUHDaKXQi6laRjhF+t4DLeRTFlnB7pWgF7LclGktWgyQcgQU0aLWANHEv
    ZHVQI+AQQYkK/RRa2xnOP/8zylPb8MxFiGnCD3ipY6UvmoMaikv+4UXSJRgk9jpJ
    hRv24tci6JNr0nyW+Bm5J3wfgW7ocYyHll5W9aM4sLChvjk5pKa5K3qKG5HWNtds
    O4DA189Gbz/8p30sVJey81AZk8Tgo8GohTx597RQlP5n8lrYHvnqO3eLhiKAqnVT
    VBiMqiwNUrxgawcteC0eCiZ+MzlxuxhhYDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:mime-version:content-type:sender:list-id; s=fm2; t=
    1526483125; bh=lmP1p5ClzalYZicMX0Eo/fnRSHUL1/ytKDrNYS0/9ao=; b=k
    icVYnz7x/vTiZ5153lXVwuWrvQGPs4J2xzjmSIuBe5yNtBbfwthBooqG9zND4nNo
    B36kmYcO/9y4fxxlQA5mb9gZEZ4uLUCCXybrHNZdfVt+Z0Bts3Xtaoxdx1CyBXFs
    ahWiaAQCI/v/rRQ5O2ry0LzpiEWdASat224M0ZiIT+M9jSj3EKP14LoTwWcv8cg0
    RQWZMw5s2wev7ResQf/bepeEYKZlKxTkYSeE/6tnZCXTuVTV1zypm80T/YtfEsxw
    HExlI0zHMMFV5wkLrsvjCtM9ZTXcSSz91PsBPVQGdGQ/ttkQus9FURdAlJut+XWP
    x4Er/hrKfnC40/VRlFLtg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfJUa0wjsoMHhJg4+rj2sEXAJHUjhlNHTpoy94EpQmANmklQ5WvdurRgCLtPX9KYkWdCskKMaP9yBYyAf6lgnsr6yE6Xi7gEqtxGXMi2hYwn1FVHFfbI0
    c/zX0Y028JQmdZFPjeHsVkIjm8p2Ha0qbqph4NViBQYs9DQOL6lYlCer7mRW4vS0q+XYTlkRKwNmjHle7sMWdmu784T+t6mHKqxWG53UWbMeEBXHocz7OJkb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Q9fys5e9bTEA:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=LqzWqcw_idgH_oglLg8A:9 a=PUjeQqilurYA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeEPPCk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 11:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbeEPPCC (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 16 May 2018 11:02:02 -0400
Message-Id: <20180516150200.946375138@goodmis.org>
User-Agent: quilt/0.63-1
Date: Wed, 16 May 2018 11:00:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 11/14] ftrace/selftest: Have the reset_trigger code be a bit more careful
References: <20180516150012.135869655@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0011-ftrace-selftest-Have-the-reset_trigger-code-be-a-bit.patch
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The trigger code is picky in how it can be disabled as there may be
dependencies between different events and synthetic events. Change the order
on how triggers are reset.

 1) Reset triggers of all synthetic events first
 2) Remove triggers with actions attached to them
 3) Remove all other triggers

If this order isn't followed, then some triggers will not be reset, and an
error may happen because a trigger is busy.

Cc: stable@vger.kernel.org
Fixes: cfa0963dc474f ("kselftests/ftrace : Add event trigger testcases")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../testing/selftests/ftrace/test.d/functions | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 2a4f16fc9819..8393b1c06027 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -15,14 +15,29 @@ reset_tracer() { # reset the current tracer
     echo nop > current_tracer
 }
 
-reset_trigger() { # reset all current setting triggers
-    grep -v ^# events/*/*/trigger |
+reset_trigger_file() {
+    # remove action triggers first
+    grep -H ':on[^:]*(' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+    grep -Hv ^# $@ |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d" "`
-	echo "!$cmd" > `echo $line | cut -f1 -d:`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" > $file
     done
 }
 
+reset_trigger() { # reset all current setting triggers
+    if [ -d events/synthetic ]; then
+        reset_trigger_file events/synthetic/*/trigger
+    fi
+    reset_trigger_file events/*/*/trigger
+}
+
 reset_events_filter() { # reset all current setting filters
     grep -v ^none events/*/*/filter |
     while read line; do
-- 
2.17.0
