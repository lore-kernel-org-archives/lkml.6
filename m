Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6436EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF3C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF3C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeHVSBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbeHVSBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:01:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE4A208DB;
        Wed, 22 Aug 2018 14:36:14 +0000 (UTC)
Date:   Wed, 22 Aug 2018 10:36:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Cc:     y.karadz@gmail.com, acme@redhat.com, tz.stoyanov@gmail.com,
        tglx@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] tools lib traceevent: Rename various pevent
 get/set/is APIs
Message-ID: <20180822103612.2b41102a@gandalf.local.home>
In-Reply-To: <tip-413af01c8d9d5d688df3244401cbddfe98bafe2a@git.kernel.org>
References: <20180808180703.114110715@goodmis.org>
        <tip-413af01c8d9d5d688df3244401cbddfe98bafe2a@git.kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Aug 2018 04:53:45 -0700
"tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com> wrote:

> Commit-ID:  413af01c8d9d5d688df3244401cbddfe98bafe2a
> Gitweb:     https://git.kernel.org/tip/413af01c8d9d5d688df3244401cbddfe98bafe2a
> Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> AuthorDate: Wed, 8 Aug 2018 14:03:06 -0400
> Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
> CommitDate: Mon, 13 Aug 2018 15:35:02 -0300
> 
> tools lib traceevent: Rename various pevent get/set/is APIs
> 
> In order to make libtraceevent into a proper library, variables, data
> structures and functions require a unique prefix to prevent name space
> conflicts. That prefix will be "tep_" and not "pevent_". This changes
> APIs: pevent_pid_is_registered, pevent_get_cpus, pevent_set_cpus,
> pevent_is_file_bigendian, pevent_is_host_bigendian, pevent_is_latency_format,
> pevent_set_latency_format
> 
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
> Cc: linux-trace-devel@vger.kernel.org
> Link: http://lkml.kernel.org/r/20180808180703.114110715@goodmis.org
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Hi Arnaldo,

I'm curious to why the "(VMware)" part of my Signed-off-by was stripped
off on all these patches? It's required that is added to denote that my
work is done on my company time, otherwise I will have to use my vmware
email address which I really don't want to do.

-- Steve


> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/lib/traceevent/event-parse.c |  4 ++--
>  tools/lib/traceevent/event-parse.h | 14 +++++++-------
>  tools/lib/traceevent/plugin_kvm.c  |  4 ++--
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
>
