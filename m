Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC03C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA79208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA79208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbeG0PJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbeG0PJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:09:33 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D234208AF;
        Fri, 27 Jul 2018 13:47:32 +0000 (UTC)
Date:   Fri, 27 Jul 2018 09:47:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jann Horn <jannh@google.com>
Cc:     Golden_Miller83@protonmail.ch,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg KH <greg@kroah.com>, Kees Cook <keescook@google.com>,
        salyzyn@android.com, kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, kernel-team@android.com,
        stable@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH] tracing: do not leak kernel addresses
Message-ID: <20180727094730.3a448629@gandalf.local.home>
In-Reply-To: <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
References: <20180725202238.165314-1-salyzyn@android.com>
        <20180725210717.3b807191@vmware.local.home>
        <11437c3e-5131-7190-c496-7b51eb7fcc2a@android.com>
        <20180726153153.GA8327@kroah.com>
        <CAKwvOdk9s+=kUwcPGQzZNxR7eOGAiiasAyWhZxgKom4_6h+oxA@mail.gmail.com>
        <20180726181558.25a5c3b8@gandalf.local.home>
        <753E9YR1QhdsPhsFoYuXCwfUzfyntDrc_A93hMUkktMi7lbh3KUZMcbfqKVWUfi15zYhuiDFant-ROa4QNV5shx74ff4hGngq2BOJDv-hq4=@protonmail.ch>
        <CAG48ez1U=5nTOrnOqwMuXhdER-7XxJUYLcyYNuczwasQLQ0gXA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 15:40:32 +0200
Jann Horn <jannh@google.com> wrote:

> > > But the code doesn't go to dmesg. It's only available
> > > via /sys/kernel/debug/tracing/printk_formats which is only available
> > > via root. Nobody else has access to that directory.
> > >
> > > -- Steve  
> >
> > I think the point was that when we take capabilities into account the root
> > privileges aren't unequivocal anymore. The 'root' owned process with only
> > 'CAP_SYSLOG' shouldn't have access to /sys/kernel/debug/tracing/printk_formats  
> 
> Then they shouldn't have access to debugfs at all, right?

That's what I'm thinking.

-- Steve
