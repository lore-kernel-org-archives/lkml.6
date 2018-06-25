Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0806C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E76825B39
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E76825B39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934332AbeFYOQM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934184AbeFYOQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:16:10 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3B225B35;
        Mon, 25 Jun 2018 14:16:09 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:16:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Thelen <gthelen@google.com>, Andi Kleen <andi@firstfloor.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] trace: fix SKIP_STACK_VALIDATION=1 build
Message-ID: <20180625101607.08db48ff@gandalf.local.home>
In-Reply-To: <CAK7LNARngmBXa5w3XFfuA7pEv39vWjJVNJ+3XVLPYd9QLH+f-A@mail.gmail.com>
References: <20180608214746.136554-1-gthelen@google.com>
        <CAK7LNARngmBXa5w3XFfuA7pEv39vWjJVNJ+3XVLPYd9QLH+f-A@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2018 02:42:26 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-06-09 6:47 GMT+09:00 Greg Thelen <gthelen@google.com>:
> > Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
> > SKIP_STACK_VALIDATION=1 fail.
> > Example output:
> >   /bin/sh: init/.tmp_main.o: Permission denied
> >
> > commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
> > added a mismatched endif.  This causes cmd_objtool to get mistakenly
> > set.
> >
> > Relocate endif to balance the newly added -record-mcount check.
> >
> > Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
> > Signed-off-by: Greg Thelen <gthelen@google.com>
> > ---  
> 
> Applied to linux-kbuild/fixes. Thanks!
> 
> 

I already pushed this to Linus. As I was the one to mess it up in the
first place ;-) (I think I applied it with some fuzz)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ed7d40bc67b8353c677b38c6cdddcdc310c0f452

-- Steve
