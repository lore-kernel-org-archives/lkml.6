Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D976420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D976420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gliwa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXLFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:05:10 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:37946 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbeGXLFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:05:10 -0400
Received: by mail.gliwa.com (Postfix, from userid 992)
        id A7BC2344492; Tue, 24 Jul 2018 11:59:28 +0200 (CEST)
X-Virus-Checker-Version: ClamAV 0.100.0/24777/Tue Jul 24 02:41:32 2018
X-Virus-Status: OK
Received: from [192.168.0.50] (x5ce308b8.dyn.telefonica.de [92.227.8.184])
        by mail.gliwa.com (Postfix) with ESMTPSA id 7C95F344488;
        Tue, 24 Jul 2018 11:59:28 +0200 (CEST)
From:   Claudio <claudio.fontana@gliwa.com>
Subject: ftrace global trace_pipe_raw
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
 <20180709113257.79152dd0@gandalf.local.home>
Message-ID: <39d1df95-a695-1041-38a6-b94d1eee9eb2@gliwa.com>
Date:   Tue, 24 Jul 2018 11:59:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180709113257.79152dd0@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

I am doing correlation of linux sched events, following all tasks between cpus,
and one thing that would be really convenient would be to have a global
trace_pipe_raw, in addition to the per-cpu ones, with already sorted events.

I would imagine the core functionality is already available, since trace_pipe
in the tracing directory already shows all events regardless of CPU, and so
it would be a matter of doing the same for trace_pipe_raw.

But is there a good reason why trace_pipe_raw is available only per-cpu?

Would work in the direction of adding a global trace_pipe_raw be considered
for inclusion?

Thank you,

Claudio
