Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F5C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AFE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AFE208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbeJEW6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJEW6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:58:04 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97D22084D;
        Fri,  5 Oct 2018 15:58:44 +0000 (UTC)
Date:   Fri, 5 Oct 2018 11:58:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH v3] tools/lib/traceevent: Replace str_error_r() with an
 open coded implementation
Message-ID: <20181005115843.46155df8@gandalf.local.home>
In-Reply-To: <20181005154740.GD20250@kernel.org>
References: <20181002175539.2ac894c7@gandalf.local.home>
        <20181005113056.55b23c31@gandalf.local.home>
        <20181005153731.GC20250@kernel.org>
        <20181005114516.68f47767@gandalf.local.home>
        <20181005154740.GD20250@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 12:47:40 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Oct 05, 2018 at 11:45:16AM -0400, Steven Rostedt escreveu:
> > On Fri, 5 Oct 2018 12:37:31 -0300
> > Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   
> > > Em Fri, Oct 05, 2018 at 11:30:56AM -0400, Steven Rostedt escreveu:  
> > > > Bah, I now get warnings that sys_nerr and sys_errlist are deprecated.
> > > > 
> > > > OK, so going back to just using the racy strerror() should be good
> > > > enough, as this incompatibility with strerror_r() is a disaster!    
> > > 
> > > I've been there, done that... ;-) Check:
> > > 
> > > tools/lib/str_error_r.c
> > > tools/lib/bpf/str_error.c
> > > 
> > > The trick: have this function in a separate file, so that _GNU_SOURCE
> > > doesn't get in the way...
> > >   
> > 
> > Yep, I've been looking at these. I'll need to add yet another version,
> > so that we can have it for the external libtraceevent. I'll be sending
> > out a patch shortly.  
> 
> Unfortunately, yes, due to licensing and because we don't have a
> liblinux with the things in tools/lib/*.c, we need to relicense that as
> at least LGPL 2.1 :-\
> 
> Lets start here, whoever reads this message, would you have a problem
> with relicensing what is in tools/lib/*.c and tools/lib/api/ as LGPL
> 2.1?
> 

All of the libtraceeevent code was already licensed as LGPL 2.1 to
begin with. It was taken from trace-cmd which had that as LGPL as well.

  :-)

-- Steve
