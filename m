Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1600C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882C722408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882C722408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeHJPaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeHJPaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:30:03 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874AB22402;
        Fri, 10 Aug 2018 13:00:12 +0000 (UTC)
Date:   Fri, 10 Aug 2018 09:00:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH 00/24] tools lib traceevent: Rename pevent to tep
 for preparation for library
Message-ID: <20180810090010.4537e14a@gandalf.local.home>
In-Reply-To: <20180810092137.GB14485@krava>
References: <20180808155548.510187543@goodmis.org>
        <20180810092137.GB14485@krava>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 11:21:37 +0200
Jiri Olsa <jolsa@redhat.com> wrote:


> > This is not complete. It is only one of many preparations to make
> > libtraceevent into a legitimate library. There's other naming conventions
> > that will be made. But for now, I would like to hear thoughts about
> > this change before we proceed further.  
> 
> right, I can see more things that needs rename, like in print_arg*,
> trace_* stuff and others

We are working on renaming the other data structures. As for the
"trace_" it is really "trace_seq_*" That's not going to get renamed. We
may move it to another header file. It matches the trace_seq_* code in
the kernel, and I would like to keep that the same.

> 
> I'm also getting weird make error when compiling in libtraceevent dir:
> 
>   [jolsa@krava traceevent]$ make
>     GEN      libtraceevent-dynamic-list
>   Either missing one of [ plugin_jbd2.so plugin_hrtimer.so plugin_kmem.so plugin_kvm.so plugin_mac80211.so plugin_sched_switch.so plugin_function.so plugin_xen.so plugin_scsi.so plugin_cfg80211.so] or bad version of nm
> 
> but that seems to be there even without your patchset,
> so probably something we should look into

Hmm, OK, I'll try to look into that later.

> 
> other than that it looks ok to me

Great!

> 
> once this is done, we can move forward to put this
> to kernel-tools-libs-devel rpm

For this patch series, do you want to take the patch set, or just pull
from my branch?

-- Steve
