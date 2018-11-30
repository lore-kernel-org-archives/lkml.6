Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F89C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53320868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA53320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbeLAGr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:47:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLAGr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:47:59 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2287B20834;
        Fri, 30 Nov 2018 19:37:38 +0000 (UTC)
Date:   Fri, 30 Nov 2018 14:37:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: Re: [PATCH 7/9] tools/lib/traceevent: traceevent API cleanup
Message-ID: <20181130143736.7b3fbd5f@gandalf.local.home>
In-Reply-To: <20181130191856.GC19230@kernel.org>
References: <20181130154403.150474900@goodmis.org>
        <20181130154647.891651290@goodmis.org>
        <20181130191856.GC19230@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 16:18:56 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Nov 30, 2018 at 10:44:10AM -0500, Steven Rostedt escreveu:
> > From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> > 
> > In order to make libtraceevent into a proper library, its API
> > should be straightforward. This patch hides few API functions,
> > intended for internal usage only:
> > tep_free_event(), tep_free_format_field(), __tep_data2host2(),
> > __tep_data2host4() and __tep_data2host8().
> > The patch also alignes the libtraceevent summary man page with
> > these API changes.  
> 
> I applied the previous patches, stopped here as it this one fails with
> the error bellow.

Thanks, I'll take a look at it.

What branch are you applying it against? Just to make sure I'm testing
the same thing you are.

-- Steve

> 
> Please resend from this patch onwards.
> 
> BTW, this is what I have right now:
> 
> [acme@quaco perf]$ git log --oneline - 6
> 9db9efe53c72 (HEAD -> perf/core) tools lib traceevent: Rename tep_free_format() to tep_free_event()
> e58c351e8383 tools lib traceevent, perf tools: Rename 'struct tep_event_format' to 'struct tep_event'
> 4237fd0b60d8 tools lib traceevent: Install trace-seq.h API header file
> bb837f2581dc tools lib traceevent: Added support for pkg-config
> a2c167ad70b6 tools lib traceevent: Implement new API tep_get_ref()
> 51d0337d0198 (acme.korg/perf/core) tools lib traceevent: Add sanity check to is_timestamp_in_us()
> 
