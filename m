Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45283C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046F8216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/BI0QQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046F8216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbeKLPCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:02:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeKLPCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:02:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id w14-v6so2348529wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 21:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rib+a1LmXHll7Q1LBkgSwoIu3qcWwcpm0bzXN17ejlk=;
        b=o/BI0QQMH8XUUokTo9vzadnYwhrPgCVxBvK7oYRtn8JXJZLNBgTdulNtSCqsWfffTP
         ZZ+alu8WCEXfNr5zlw4t9NUo0YBLTs2jxMmxKp6VDYFvES/4xARAd1ukvBHxbqxJI4bL
         Erh4UwD/LE87+fBxx4+4nQZLr9vOkNhrKBO0PnOLxsc4bIHiWWLM8VRJPwP2blqL+Nob
         mpxB5tmPgyzxTm5y9kzd70PEX5ySRqDU2JdMVtH1+xZ2+VPPZIzKLqTvz1/HhjyuADNW
         dZ3OUYKdZ03n2dKJcln2mqrThg4zBBFd9R5kyipvRe+oVG0wrT6E5HtfkLGVp5WHjMeF
         d2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rib+a1LmXHll7Q1LBkgSwoIu3qcWwcpm0bzXN17ejlk=;
        b=FFYja0DxkEhS4KzBeouPOH82IDsSFZrldQuldO+Uzsc/WGjRKgwL4zLBFln2hd1HDB
         mlorGs2SOQkTHPdTrUPaG8hmU5OBLIqKKHoxUceV3bJUP0d1+quCURywy5Qh5wwqx2lw
         PKuVmMGpCzDVwV8wyHvF5yM4C9eQ+K41EjBgrkTDshSHu5rc1Lvf9TscGl0vsmiKcmHl
         8WE7y15te5GiklkLBCZFSxCGDpwxxTW6zVFZx5UJnY+X5EKXi8NbV2veXQEf3RjwKSpR
         aUU9MzOiCa6q9jbVcuUu6rGSNsn2O3WEsN+0aLWt4GrSBtD5Kt5Cb0IjU8VKnoSvTBIT
         o7Ow==
X-Gm-Message-State: AGRZ1gKxrccXWwXa98wAJQ4uRAhDOM6J/IMAVE/zQ5PiXAG/l/OVLUue
        ZavvwumjMtUEBNvjh5I65cM=
X-Google-Smtp-Source: AJdET5e7zr+AAGusO4lLU/OZ9D9QveGE0tvR0SiDQ0cEYFa/yLhmpTKgdMzT2lt5JtYAWB2X4Sa93Q==
X-Received: by 2002:a5d:4907:: with SMTP id x7-v6mr15848095wrq.272.1541999437437;
        Sun, 11 Nov 2018 21:10:37 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q12sm464929wmf.2.2018.11.11.21.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 21:10:36 -0800 (PST)
Date:   Mon, 12 Nov 2018 06:10:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/12] locking/lockdep: Add a new class of terminal
 locks
Message-ID: <20181112051033.GA123204@gmail.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <20181109080412.GC86700@gmail.com>
 <20181110141045.GD3339@worktop.programming.kicks-ass.net>
 <dfa0a2fa-0094-3ae0-4f27-2930233132a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa0a2fa-0094-3ae0-4f27-2930233132a3@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> On 11/10/2018 09:10 AM, Peter Zijlstra wrote:
> > On Fri, Nov 09, 2018 at 09:04:12AM +0100, Ingo Molnar wrote:
> >> BTW., if you are interested in more radical approaches to optimize 
> >> lockdep, we could also add a static checker via objtool driven call graph 
> >> analysis, and mark those locks terminal that we can prove are terminal.
> >>
> >> This would require the unified call graph of the kernel image and of all 
> >> modules to be examined in a final pass, but that's within the principal 
> >> scope of objtool. (This 'final pass' could also be done during bootup, at 
> >> least in initial versions.)
> >
> > Something like this is needed for objtool LTO support as well. I just
> > dread the build time 'regressions' this will introduce :/
> >
> > The final link pass is already by far the most expensive part (as
> > measured in wall-time) of building a kernel, adding more work there
> > would really suck :/
> 
> I think the idea is to make objtool have the capability to do that. It
> doesn't mean we need to turn it on by default in every build.

Yeah.

Also note that much of the objtool legwork would be on a per file basis 
which is reasonably parallelized already. On x86 it's also already done 
for every ORC build i.e. every distro build and the incremental overhead 
from also extracting locking dependencies should be reasonably small.

The final search of the global graph would be serialized but still 
reasonably fast as these are all 'class' level dependencies which are 
much less numerous than runtime dependencies.

I.e. I think we are talking about tens of thousands of dependencies, not 
tens of millions.

At least in theory. ;-)

Thanks,

	Ingo
