Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413692-2-9962223862875700436
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
    t=1519413692; b=R+DkB6RC1leLENuWj921iryKNEsrCD9c9bLhuaSy/MVlYLC
    P7zbdoH3YuPjjepLbDqvwSb7+4SlA/P5guObewXZxk651f4rSuR2JpXhJxf1ZQkW
    XxD7dKq4XFPBKrem8UmJiZob+JU6doVkVtGUZk1LwC28V9blhWmC+jpHodqSoW7z
    aZYVww1H6sRH/chemVclOnN/WYrtmv69nR9kEUU/7hmk5XMgHufr3Uti7cHG/ifU
    z+Cmdnx0v3q2i1nXIe/djDOgY4C0a6oraO+quqIiJOERgPZ24j+d3cxDfRHW5Llz
    sIXyeVvZlMYbZ7fgLFKqScSm8g2pC+4rfwr7+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413692; bh=I5tSw2jXqWlVwknUGGZ0TtWZck
    Id/U1kCYXpS6zJeZc=; b=EO6GRghziSio3pFAhD2W348SAn7ZadCFG2jYy07PRg
    Bhez8546fx/SRNax1xIp37BwWBY9aqNQn/e5W3zOJ0LsDyniCRzJ5vD/CQHa2ltV
    5r5maKftdXWu0dXwQ/vpDehFlizf1W0zXaf/YQqWzas18Rgk3yblKl3l7HgLKWcg
    5nPuYNl1/nclruPnVRYzDwNNPVaItEU/x0FFAPlo0orrOf2Psn9pTiSydu97jJC2
    FjjGC4G7N9KxdHr6boYeYlxXSFQjrJnYSRuImEwLOe3TV5lw3cVCWr9/JAk4lBGe
    Dfq+xUNZ7EmjU5L0BIYAF8c+xD748uiz7UPMrNp8n6gw==
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
        id S964848AbeBWSx4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47552 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964828AbeBWSxz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:55 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 075/159] perf test: Fix test 21 for s390x
Date: Fri, 23 Feb 2018 19:26:23 +0100
Message-Id: <20180223170752.679626816@linuxfoundation.org>
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

From: Thomas Richter <tmricht@linux.vnet.ibm.com>


[ Upstream commit 996548499df61babae5306544c7daf5fd39db31c ]

Test case 21 (Number of exit events of a simple workload) fails on
s390x. The reason is the invalid sample frequency supplied for this
test. On s390x the minimum sample frequency is much higher (see output
of /proc/service_levels).

Supply a save sample frequency value for s390x to fix this.  The value
will be adjusted by the s390x CPUMF frequency convertion function to a
value well below the sysctl kernel.perf_event_max_sample_rate value.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
LPU-Reference: 20171123114611.93397-1-tmricht@linux.vnet.ibm.com
Link: https://lkml.kernel.org/n/tip-1ynblyhi1n81idpido59nt1y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/task-exit.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -84,7 +84,11 @@ int test__task_exit(struct test *test __
 
 	evsel = perf_evlist__first(evlist);
 	evsel->attr.task = 1;
+#ifdef __s390x__
+	evsel->attr.sample_freq = 1000000;
+#else
 	evsel->attr.sample_freq = 1;
+#endif
 	evsel->attr.inherit = 0;
 	evsel->attr.watermark = 0;
 	evsel->attr.wakeup_events = 1;
