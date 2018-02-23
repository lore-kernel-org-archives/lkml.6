Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519418968-2-1868841201940647504
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
    t=1519418968; b=s1SqARLRH9yFhAYdpL6bZTboM03pH4AOpuKLIDWlh7PAjOh
    1VLCeP9apNi6+ScvUVWD39MBPV8cB/QHLngNdc6vSw8VhABkjiIvoKHQwOxSQ1Oh
    QKTfyXqf8/31ptezCSoCfisfdQNg223Mfv4MFLkGWufj4ft1dVQpMMLrq+sWkxAu
    8XiRiVnqFIUOsp28yaOcvf50jZ3BlUj0B0+L2czF3ffodF/VdBh50ZS4fi+tFUwV
    +pbhKtuiPSG39sLWx6HsJw1PatPCknfU5YOlo0QfByoUlvQiR7D7Fdu+mHhIGS22
    i0HKuu5vrYKUK68dYVE0dvi5mK+NMYcqgfwVmXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418968; bh=WpQe0k8gHuztFA+vY3pp5ZS3zW
    9D/38/palgs274qVE=; b=Ipveb0SIdBlF440Fz4Ef5zV3IOZb5csOvH19DSXuMo
    uBXBTvHHZXGA7Yv+N3VkNCmHFTfithBlkT3TOCUvdch/WeGhbOPeTfTNlhLuFkzC
    WMQFEm6jNzvobR/ZeSvtT3cesZWzGEGxcZvbyqYMAEu4b5xPSRmJXHLVXaNHdZdC
    0V861fPBBAMb+FeXGnnafqxkyyS7vUs6BD3AOE6xV0ahbqyKPX4zgEOtVNgKIh1y
    KnbCATGs31fXl4jdhVsm4Ox+0Zf6YUQEXbMFtmAeVgo14YSUdUa1xsPeDDb/SOFk
    f+HtlGfYXOxoKJuOOFzcmRfWD/CaFlS5Dj88zEin4s4A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeBWSbb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:31:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752516AbeBWSb3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:29 -0500
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
Subject: [PATCH 3.18 38/58] perf top: Fix window dimensions change handling
Date: Fri, 23 Feb 2018 19:26:37 +0100
Message-Id: <20180223170212.762320156@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -70,6 +70,7 @@
 #include <linux/types.h>
 
 static volatile int done;
+static volatile int resize;
 
 #define HEADER_LINE_NR  5
 
@@ -79,10 +80,13 @@ static void perf_top__update_print_entri
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
@@ -461,7 +465,7 @@ static bool perf_top__handle_keypress(st
 					.sa_sigaction = perf_top__sig_winch,
 					.sa_flags     = SA_SIGINFO,
 				};
-				perf_top__sig_winch(SIGWINCH, NULL, top);
+				perf_top__resize(top);
 				sigaction(SIGWINCH, &act, NULL);
 			} else {
 				signal(SIGWINCH, SIG_DFL);
@@ -997,6 +1001,11 @@ static int __cmd_top(struct perf_top *to
 
 		if (hits == top->samples)
 			ret = perf_evlist__poll(top->evlist, 100);
+
+		if (resize) {
+			perf_top__resize(top);
+			resize = 0;
+		}
 	}
 
 	ret = 0;
