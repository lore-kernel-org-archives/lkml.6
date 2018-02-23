Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415432-2-5368628120495594684
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
    t=1519415431; b=fICAA0GQ3vPm3ly22ohVc6d6OU42Lxc2S+1rDagk8BUpBWi
    vh4y5TFQj/tXHcrbxhuMDo5K7jjmi0sb9izSKqbCbQ6RV9Vfy3XkO5S8UrhlLWXC
    QVwMTon0tAP3LLJqO7ZM2XyLLv8/XrAXcrn11HxJk3Sa5EerFRKcf8wwnjcO8r7m
    hGkRyGIHXn8FuM1tJ4GA/+swMRu3ZYJi4j2S3MyV+bP0edOLnrnzcSPmiODzGz7U
    Nt6Ui4upg76MYvypSPsglhVrbqGqIcp79RSoURxw7mO1sdgpHx3SRuXjwSQrzBxq
    cFrLnyEj0fKOB8ZNy1nNprO0c4WKJb7K0bAMSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415431; bh=sCJxEbmPWHM8ZyhaZOKvJ9v/Pn
    yMc+HUMnMgu3de3Zg=; b=sKAMo6LCXFTVGOn+JZcdCFT0tyyv0zvYmhViIHWgbS
    RUttmyngYnIhQUU5ecOVd/D4KVDOH1WXD1BDn4lOzezoTb4mkh6AVfHO1Xk72wL4
    Cb7yA3ojqmR7YJRaLEvVmaL+iwtHhYv1FcQqED07LZpwweyuIxCOr77gLt7dWrV4
    p0ikQDgqv9hZNkMPEAHVysHcbJiL3vbaX3JdNmif4/gMdKInba3zaXt6xKriLchu
    ZT4tG8uMIaaFLRQzy5xc7cKWKUH/iKXdJ7802FM0LSGE5xseyh5mYXaroscFj7wz
    SQdr9xJo6Hl7AFqFs56djMsYqd60zQ09gszyyqO/cA7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933954AbeBWSqL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:46:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeBWSqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:46:10 -0500
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
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 050/145] perf top: Fix window dimensions change handling
Date: Fri, 23 Feb 2018 19:25:56 +0100
Message-Id: <20180223170731.334942400@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-top.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -73,6 +73,7 @@
 #include <linux/types.h>
 
 static volatile int done;
+static volatile int resize;
 
 #define HEADER_LINE_NR  5
 
@@ -82,10 +83,13 @@ static void perf_top__update_print_entri
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
@@ -472,7 +476,7 @@ static bool perf_top__handle_keypress(st
 					.sa_sigaction = perf_top__sig_winch,
 					.sa_flags     = SA_SIGINFO,
 				};
-				perf_top__sig_winch(SIGWINCH, NULL, top);
+				perf_top__resize(top);
 				sigaction(SIGWINCH, &act, NULL);
 			} else {
 				signal(SIGWINCH, SIG_DFL);
@@ -1003,6 +1007,11 @@ static int __cmd_top(struct perf_top *to
 
 		if (hits == top->samples)
 			ret = perf_evlist__poll(top->evlist, 100);
+
+		if (resize) {
+			perf_top__resize(top);
+			resize = 0;
+		}
 	}
 
 	ret = 0;
