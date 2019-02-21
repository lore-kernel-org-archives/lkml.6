Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DBD20842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfBUPdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:33:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfBUPdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:33:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0DF2075A;
        Thu, 21 Feb 2019 15:33:04 +0000 (UTC)
Date:   Thu, 21 Feb 2019 10:33:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf/core: use strndup_user() instead of buggy
 open-coded version
Message-ID: <20190221103303.5a83229e@gandalf.local.home>
In-Reply-To: <7F433C6B-451A-4C3B-9B7E-0CB2CE4821DD@fb.com>
References: <20190220165443.152385-1-jannh@google.com>
        <20190221092057.8c56fa4db9eb39b7b14cd0fe@kernel.org>
        <7F433C6B-451A-4C3B-9B7E-0CB2CE4821DD@fb.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 07:12:10 +0000
Song Liu <songliubraving@fb.com> wrote:

> > On Feb 20, 2019, at 4:20 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > Hi Jann,
> > 
> > On Wed, 20 Feb 2019 17:54:43 +0100
> > Jann Horn <jannh@google.com> wrote:
> >   
> >> The first version of this method was missing the check for
> >> `ret == PATH_MAX`; then such a check was added, but it didn't call kfree()
> >> on error, so there was still a small memory leak in the error case.
> >> Fix it by using strndup_user() instead of open-coding it.
> >>   
> > 
> > This looks good to me.
> > 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > BTW, for stable, this is good. For the long term, I think we should
> > fix strndup_user() to return -E2BUG when the user string is longer
> > than max.

OK, I'll add a stable tag (but it wont go until the merge window).

It also shouldn't be called "perf/core" as its in the tracing
directory, and thus "tracing/perf" would be more appropriate. But I see
that's what the patch it fixes calls it too :-/

I'll pull it in.

Thanks everyone!

-- Steve


> > 
> > Thank you,
> >   
> >> Fixes: 0eadcc7a7bc0 ("perf/core: Fix perf_uprobe_init()")
> >> Signed-off-by: Jann Horn <jannh@google.com>  
> 
> Thanks for the fix!
> 
> Acked-by: Song Liu <songliubraving@fb.com>


