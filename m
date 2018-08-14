Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF675C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5170E2173D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5170E2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeHNIP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:15:28 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:12179 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1728521AbeHNIP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:15:28 -0400
X-Greylist: delayed 762 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Aug 2018 04:15:17 EDT
X-ASG-Debug-ID: 1534223814-0e410858b66e7e0001-xx1T2L
Received: from BJEXCAS001.didichuxing.com ([172.20.1.41]) by bsf02.didichuxing.com with ESMTP id c4FS1Aui9x3oiFNs (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Aug 2018 13:16:54 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didichuxing.com
Received: from bogon.didichuxing.com (172.22.50.20) by
 BJSGEXMBX03.didichuxing.com (172.20.15.133) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Tue, 14 Aug 2018 13:16:54 +0800
Date:   Tue, 14 Aug 2018 13:16:49 +0800
From:   Weiping Zhang <zhangweiping@didichuxing.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] Documentation/scheduler/sched-stats.txt: correct jiffies
 to ns
Message-ID: <20180814051644.GA20560@bogon.didichuxing.com>
X-ASG-Orig-Subj: [PATCH RFC] Documentation/scheduler/sched-stats.txt: correct jiffies
 to ns
Mail-Followup-To: mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS004.didichuxing.com (172.20.1.44) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: UNKNOWN[172.20.1.41]
X-Barracuda-Start-Time: 1534223814
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1061
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.55625
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit of run_daly and rq_cpu_time is ns instead of jiffies.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
---
 Documentation/scheduler/sched-stats.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.txt b/Documentation/scheduler/sched-stats.txt
index 8259b34a66ae..e7d1f614a1f1 100644
--- a/Documentation/scheduler/sched-stats.txt
+++ b/Documentation/scheduler/sched-stats.txt
@@ -48,9 +48,8 @@ Next two are try_to_wake_up() statistics:
      6) # of times try_to_wake_up() was called to wake up the local cpu
 
 Next three are statistics describing scheduling latency:
-     7) sum of all time spent running by tasks on this processor (in jiffies)
-     8) sum of all time spent waiting to run by tasks on this processor (in
-        jiffies)
+     7) sum of all time spent running by tasks on this processor (in ns)
+     8) sum of all time spent waiting to run by tasks on this processor (in ns)
      9) # of timeslices run on this cpu
 
 
-- 
2.14.1

