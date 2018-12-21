Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403843AbeLUW6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390880AbeLUW6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:58:16 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7769021920;
        Fri, 21 Dec 2018 22:58:15 +0000 (UTC)
Date:   Fri, 21 Dec 2018 17:58:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper
 macro
Message-ID: <20181221175813.0e98743f@gandalf.local.home>
In-Reply-To: <CAHk-=whLFsxr751LsJoxe-E=4LVvh=hB-3MmQTLVRA5mMLHzJA@mail.gmail.com>
References: <20181221175618.968519903@goodmis.org>
        <20181221175659.208858193@goodmis.org>
        <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
        <20181221144054.20bdeb33@gandalf.local.home>
        <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
        <20181221153526.5e6055ca@gandalf.local.home>
        <077eeb8b09baebe78822819b5f15d671b738a2b2.camel@perches.com>
        <20181221155435.38a9a221@gandalf.local.home>
        <871s6ad2br.fsf@igel.home>
        <20181221160826.34c544e6@gandalf.local.home>
        <84199633fd49db573c9ba71f1992936422e907d4.camel@perches.com>
        <CAHk-=whLFsxr751LsJoxe-E=4LVvh=hB-3MmQTLVRA5mMLHzJA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2018 14:29:30 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Dec 21, 2018 at 2:20 PM Joe Perches <joe@perches.com> wrote:
> >
> > Using
> >
> > static inline bool str_has_prefix(const char *str, const char prefix[])
> > {
> >         return !strncmp(str, prefix, strlen(prefix));
> > }
> >
> > eliminates the strlen with gcc 4.8 (oldest I still have)  
> 
> Ok, that looks like the right thing to do.
> 

Agreed, and I posted a new version. I can start running it through my
test suit (I'll update all the instances in the tracing directory to
use it), and then it will be ready for a pull request by next week.

I'll revert the top two patches from my for-next tree now.

-- Steve
