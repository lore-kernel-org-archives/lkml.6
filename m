Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A2C21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL/YiuRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A2C21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbeKLQWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:22:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbeKLQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:22:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so7918566wrx.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H5TmepNa4XL9dVVhtjOAgDyktnhKTu0RBWuI53/PQuw=;
        b=QL/YiuRUL9dCyu2QRoQ/mG6Sawxu1+QOii2LVALiUdC8TPrP85j09zL/ihhCHr/Y2C
         EULs8rJkwGjc4d1Fi8lQWF56d2fMl7kfeKmyo/g2UmtEWCuGIOisPzm2pacJSM5E6I4S
         7ney97BTmnteuXp/c7FZlpKdoj9OiyzFhReAT3lIdR1+1msocNaDQ+iZ+Va0PygQBm2w
         wDbku5ZD6xb4XiCV1k3d5/5ZZ20CnX7Bufk1g6Gdeqk4cZ4PtadVktAQ/dmwa4ZcasZ8
         28haslBYPUUj5Ok6VUlp+7WgEgyvRWdQRPBwQ8D8oxAFJuUGPeQwYcE1fA34dFCvpWWZ
         hMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H5TmepNa4XL9dVVhtjOAgDyktnhKTu0RBWuI53/PQuw=;
        b=OWVDDD2AAQLSAHPJa1lWIA3gNELgry1z7B5II4hC/G9of2Iy3pGQV8MpgzFCYTBY2a
         q3FTT3hzzyulPBu2u8b18//T1p/ZDYW+KYOe6rR1euxfbsOcQx+Qq9HpDTmUqMSC3QnT
         Vz6Z7zQ2XZWxP0jZ3bd06PHRNrojGd958Sn55PjBM5L+0K8mL6OkUNPL1Hay6hq2ZDHr
         2bGnpJJx5ehM4YMGuvl4mslJ7J4xliRnAS6XHJfk5tqxr4FQbJDEsdar7lr8xDYnE3Fk
         IoF1ay3WrOEto9SNjQ4HeaRvgetl1V7tBRrAQZtqMBd2Nmb4+RoPlszDkPCWbInU6V6U
         embQ==
X-Gm-Message-State: AGRZ1gLXNJ3e8V941kD/B7KHLZiRg6s114SZMBQhKxMrtVoEBqY4Si0a
        Afk4yXcUhydasIyMKQMFl3c=
X-Google-Smtp-Source: AJdET5eyznImnyGZxSJCmIEazVJE/iDIKnf47LcmXEYzvJ/i3KNn3ShvmVEFGahtoTAf+pBTHSAAew==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr16231053wrx.171.1542004253471;
        Sun, 11 Nov 2018 22:30:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w18-v6sm37639365wrn.66.2018.11.11.22.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 22:30:52 -0800 (PST)
Date:   Mon, 12 Nov 2018 07:30:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20181112063050.GB61749@gmail.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <20181109080412.GC86700@gmail.com>
 <20181110141045.GD3339@worktop.programming.kicks-ass.net>
 <dfa0a2fa-0094-3ae0-4f27-2930233132a3@redhat.com>
 <20181112051033.GA123204@gmail.com>
 <20181112055324.f7div2ahx5emkbbe@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112055324.f7div2ahx5emkbbe@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Nov 12, 2018 at 06:10:33AM +0100, Ingo Molnar wrote:
> > 
> > * Waiman Long <longman@redhat.com> wrote:
> > 
> > > On 11/10/2018 09:10 AM, Peter Zijlstra wrote:
> > > > On Fri, Nov 09, 2018 at 09:04:12AM +0100, Ingo Molnar wrote:
> > > >> BTW., if you are interested in more radical approaches to optimize 
> > > >> lockdep, we could also add a static checker via objtool driven call graph 
> > > >> analysis, and mark those locks terminal that we can prove are terminal.
> > > >>
> > > >> This would require the unified call graph of the kernel image and of all 
> > > >> modules to be examined in a final pass, but that's within the principal 
> > > >> scope of objtool. (This 'final pass' could also be done during bootup, at 
> > > >> least in initial versions.)
> > > >
> > > > Something like this is needed for objtool LTO support as well. I just
> > > > dread the build time 'regressions' this will introduce :/
> > > >
> > > > The final link pass is already by far the most expensive part (as
> > > > measured in wall-time) of building a kernel, adding more work there
> > > > would really suck :/
> > > 
> > > I think the idea is to make objtool have the capability to do that. It
> > > doesn't mean we need to turn it on by default in every build.
> > 
> > Yeah.
> > 
> > Also note that much of the objtool legwork would be on a per file basis 
> > which is reasonably parallelized already. On x86 it's also already done 
> > for every ORC build i.e. every distro build and the incremental overhead 
> > from also extracting locking dependencies should be reasonably small.
> > 
> > The final search of the global graph would be serialized but still 
> > reasonably fast as these are all 'class' level dependencies which are 
> > much less numerous than runtime dependencies.
> > 
> > I.e. I think we are talking about tens of thousands of dependencies, not 
> > tens of millions.
> > 
> > At least in theory. ;-)
> 
> Generating a unified call graph sounds very expensive (and very far
> beyond what objtool can do today).

Well, objtool already goes through the instruction stream and recognizes 
function calls - so it can in effect generate a stream of "function x 
called by function y" data, correct?

>  Also, what about function pointers?

So maybe it's possible to enumerate all potential values for function 
pointers with a reasonably simple compiler plugin and work from there?

One complication would be function pointers encoded as opaque data 
types...

> BTW there's another kernel static analysis tool which attempts to 
> create such a call graph already: smatch.

It's not included in the kernel tree though and I'd expect tight coupling 
(or at least lock-step improvements) between tooling and lockdep here.

Thanks,

	Ingo
