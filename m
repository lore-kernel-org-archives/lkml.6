Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC865C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786F22133F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9aqBbYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786F22133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeK0AaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:30:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32820 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeK0AaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:30:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id 79so16598483wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hrRG+8DGJB5KYXK6fX7hN0b+wV3eWhvpfn5aeYmR0gQ=;
        b=r9aqBbYGd+cJTgvi4jeeWZsEw1WwT3Sn3MPsAT94yQ3mQE01vll/OWLkQwmph12Ngd
         gT02P2rna+8lffvQOjBh/9g6/OmZ/XwPO41la0ucmEg7MJ+eI9FGoE/wXx3S8GkN5vmK
         V8aV9WM+o1aptsJ4/72Co52zV4Id0gN0V7Yg/wWiwtyzIwLSdrC7TVX9CXXwwwZyZoGX
         Yl+8rWJQ4kna+XxoM/1aPFs83dp4mrjOoWM7a3+EHv8ixmed4R4abaq1KvkiVeA1G8bI
         0hISGgC7T74xYdJzbfU1RV7ejZ5hW6PdlTHYJqzwnwjdtfhP5bM+Uu8Pd0tqiv3wgSdW
         7vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hrRG+8DGJB5KYXK6fX7hN0b+wV3eWhvpfn5aeYmR0gQ=;
        b=ewH8UsjQ1PQCv/ceu6jFPsNMOw/3txhC8E86gez66xIN9IDJHe/AKMGpTyOlTV5YaS
         GgTMlvgiQgSWmlIATp4j3GTvdtuyDljyUZA+8KYjxm9PUtziRboL+XxZCssJxlTetA96
         1DBlVIGrZ3pZvsc4LMoanjOB0+5D+WqFtweba00Q8gXUOCn4CzQrus+++aK9wNqSH5WI
         O9k7jTKEfEQFWAfsTgXmuVMecMFbQbcNxtyapUKIq6QRt7ZoAqxfR3F0I4bdjTaF40l7
         ymUCD2eOgaNSKhzFpR4/2o58oN7z6ES5Bu5K53K5TksCXIYwpDoH61dHCeI+iSuDgmIe
         9JtA==
X-Gm-Message-State: AGRZ1gLwzO9EAUFmDvJZH+p2Q+gzpg2AoYM/6ax4EmrHR+98xNm5WUag
        R7yEKQF63ElrU/xxqpYFCbA=
X-Google-Smtp-Source: AFSGD/Vq//hY4/SrTZ/oZt2INB9Hce7fmEL3srr/OQ7GvyuGr28KNkXQ4yW9Ll4mPxm4XocqmDjVtA==
X-Received: by 2002:a1c:128c:: with SMTP id 134-v6mr25214156wms.72.1543239374129;
        Mon, 26 Nov 2018 05:36:14 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o8sm480073wrx.15.2018.11.26.05.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 05:36:13 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:36:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 21/28] x86/speculation: Prepare for conditional IBPB
 in switch_mm()
Message-ID: <20181126133610.GB108014@gmail.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185005.466447057@linutronix.de>
 <20181125205330.GO13936@tassilo.jf.intel.com>
 <alpine.DEB.2.21.1811252316560.1684@nanos.tec.linutronix.de>
 <92833780-41BE-446E-A676-925BA1EC93D9@amacapital.net>
 <alpine.DEB.2.21.1811260751030.1684@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1811260751030.1684@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 25 Nov 2018, Andy Lutomirski wrote:
> > > On Nov 25, 2018, at 2:20 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Sun, 25 Nov 2018, Andi Kleen wrote:
> > > 
> > >>> The current check whether two tasks belong to the same context is using the
> > >>> tasks context id. While correct, it's simpler to use the mm pointer because
> > >>> it allows to mangle the TIF_SPEC_IB bit into it. The context id based
> > >>> mechanism requires extra storage, which creates worse code.
> > >> 
> > >> [We tried similar in some really early versions, but it was replaced
> > >> with the context id later.]
> > >> 
> > >> One issue with using the pointer is that the pointer can be reused
> > >> when the original mm_struct is freed, and then gets reallocated
> > >> immediately to an attacker. Then the attacker may avoid the IBPB.
> > >> 
> > >> Given it's probably hard to generate any reasonable leak bandwidth with
> > >> such a complex scenario, but it still seemed better to close the hole.
> > > 
> > > Sorry, but that's really a purely academic exercise. 
> > 
> > I would guess that it’s actually very easy to force mm_struct* reuse.
> > Don’t the various allocators try to allocate hot memory?  There’s nothing
> > hotter than a just-freed allocation of the same size.
> 
> Sure, but this is about a indirect branch predictor attack against
> something which reuses the mm.
> 
> So you'd need to pull off:
> 
>    P1 poisons branch predictor
>    P1 exit
> 
>    P2 starts and resuses mm(P1) and uses the poisoned branch predictor
> 
> the only thing between P1 and P2 is either idle or some other kernel
> thread, but no other user task. If that happens then the code would not
> issue IBPB as it assumes to switch back to the same process.
> 
> Even if you can pull that off the speculation would hit the startup code of
> P2, which is truly a source of secret information. Creating a valuable
> attack based on mm reuse is really less proabable than a lottery jackpot.
> 
> So using mm is really good enough and results in better assembly code which
> is surely more valuable than addressing some hypothetical hole.

OTOH we could probably close even this with very little cost if we added 
an IBPB to non-threaded fork() and vfork()+exec() paths? Those are really 
slow paths compared to all the context switch paths we are trying to 
optimize here.

Alternatively we could IBPB on the post-exit() final task struct freeing, 
which too is a relative slow path compared to the context switch paths.

But no strong opinion.

Thanks,

	Ingo
