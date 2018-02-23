Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413950-2-1860472048183292252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413949; b=PVBPV/6c1Ro/Emklun7oMj9/Qjs2LwovHC0ptKBzJlmPr9z
    6n9xHoqHvhIHsHT0o+jv6WR5FY17UvfgbZlmUWlEkNn11/p0qrPfja3/yYOIjcVs
    ypIfzxPbNL8LtEESQ0W5pyNw4jmB5VNg46fM2t9nCjHvDiIMxVvv+sjtLM0z9rMN
    V7Uv56dUHw+bnTrymTVcB1HsJgWzm83/Sn02jLnZt5AuRlOVInDS9EnS+ywfz+V3
    dCfgCpJXn/vBkdXGbglJFovq8oom1rZ42D1PzsciWA8fdyOCZLbionqJx41OO3JG
    ggd6rNFaeVY0xSnP8Xm99fTTJ/JNhsHcjw3Nw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413949; bh=QIahH20hYtvJTZvPX/KmzsQovk
    pPJmHO7DqpZrpzswI=; b=BSsUA1LhXBgpRCiPUpzk8vTT70Gzh+yPhV07aVFXuB
    gqKw9FE3L+abRcccJaCtzoYDWZ8Cptqui5jabZm+sbAjxyjE4Tjv9nJ4QipvGnY0
    N4EtJ7xwsWGCtbuHCELaFgRyhBgUNuQ3Y3bAwhX1J4R3yrn2E3qv+ahg0Fsx19+w
    yam/oK0KspKob/cSh9cGTywQJPhvsqQUejUNx/DLAUNz14/4lC7eIa88w0I95rsx
    3pzYu6DFFCxU7Z4Moc3jsg4ghGu7f62pJ37FsjHeVonk3JEHjb3RbQVhipblU6yR
    nC5E8hR4kqllkwmCXjT7PIUW0jqDu/h2nR+Z6fwvcGiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeBWTZc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:25:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935228AbeBWSwv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 073/159] perf top: Fix window dimensions change handling
Date: Fri, 23 Feb 2018 19:26:21 +0100
Message-Id: <20180223170752.443474351@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit 89d0aeab4252adc2a7ea693637dd21c588bfa2d1 ]

The stdio perf top crashes when we change the terminal
window size. The reason is that we assumed we get the
perf_top pointer as a signal handler argument which is
not the case.

Changing the SIGWINCH handler logic to change global
resize variable, which is checked in the main thread
loop.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-ysuzwz77oev1ftgvdscn9bpu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-top.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -77,6 +77,7 @@
 #include "sane_ctype.h"
 
 static volatile int done;
+static volatile int resize;
 
 #define HEADER_LINE_NR  5
 
@@ -86,10 +87,13 @@ static void perf_top__update_print_entri
 }
 
 static void perf_top__sig_winch(int sig __maybe_unused,
-				siginfo_t *info __maybe_unused, void *arg)
+				siginfo_t *info __maybe_unused, void *arg __maybe_unused)
 {
-	struct perf_top *top = arg;
+	resize = 1;
+}
 
+static void perf_top__resize(struct perf_top *top)
+{
 	get_term_dimensions(&top->winsize);
 	perf_top__update_print_entries(top);
 }
@@ -477,7 +481,7 @@ static bool perf_top__handle_keypress(st
 					.sa_sigaction = perf_top__sig_winch,
 					.sa_flags     = SA_SIGINFO,
 				};
-				perf_top__sig_winch(SIGWINCH, NULL, top);
+				perf_top__resize(top);
 				sigaction(SIGWINCH, &act, NULL);
 			} else {
 				signal(SIGWINCH, SIG_DFL);
@@ -1022,6 +1026,11 @@ static int __cmd_top(struct perf_top *to
 
 		if (hits == top->samples)
 			ret = perf_evlist__poll(top->evlist, 100);
+
+		if (resize) {
+			perf_top__resize(top);
+			resize = 0;
+		}
 	}
 
 	ret = 0;
