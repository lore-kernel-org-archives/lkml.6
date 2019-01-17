Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE3EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A4120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAQMcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:32:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfAQMcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:32:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0B2F4E93F;
        Thu, 17 Jan 2019 12:32:04 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 56E2460D27;
        Thu, 17 Jan 2019 12:32:03 +0000 (UTC)
Date:   Thu, 17 Jan 2019 13:32:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 check-perf-trace.py
Message-ID: <20190117123202.GC16366@krava>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 12:32:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:15:28PM +0530, Seeteena Thoufeek wrote:
> Support both Python 2 and Python 3 in check-perf-trace.py.
> ``print`` is now a function rather than a statement. This should have
> no functional change.
> 
> Fix indentation issue, replace spaces with tab
> 
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

hum, could you please add some info about testing those changes?
(or even some global into 0/.. patch)

this is working for me on python2:

	[root@krava perf]# perf script rec check-perf-trace
	^C
	[root@krava perf]# perf script   -s scripts/python/check-perf-trace.py
	trace_begin

	unhandled events:


	event                                          count

	----------------------------------------  -----------

	raw_syscalls__sys_enter                      3509879


but fails for python3:

	[root@ibm-x3650m4-01-vm-04 perf]# perf script rec check-perf-trace
	^C[ perf record: Woken up 0 times to write data ]
	Warning:
	1 out of order events recorded.
	[ perf record: Captured and wrote 43.132 MB perf.data (490171 samples) ]

	[root@ibm-x3650m4-01-vm-04 perf]# perf script   -s scripts/python/check-perf-trace.py
	Traceback (most recent call last):
	  File "scripts/python/check-perf-trace.py", line 18, in <module>
	    from perf_trace_context import *
	ModuleNotFoundError: No module named 'perf_trace_context'
	Error running python script scripts/python/check-perf-trace.py

I did not test with rpm, just did 'make install' for perf

thanks,
jirka
