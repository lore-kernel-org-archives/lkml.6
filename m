Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521197226; cv=none;
        d=google.com; s=arc-20160816;
        b=gNUoVxt4Ig9nRyhUa+mKjAi+X3oy/ztyuzvvGZT2VlUgPAtNs+aPY/bMhx2LIecWG5
         jKpC8xiU89iskKZkC+nedE5aJdve4jV+LLy4HaanWdSa6AtSGGOK0yfcby7SSptIXwVh
         dmaBorKrG39t2JZAulC8sTAKMTGqa5CXHZKqfFaAFBZes+UN6FN1Yx/MjUJBVJjOBZzC
         gkoQLfg+Bt/a3aQU32wdqLk8vMyxmbsjHlOVpXOGuSHoD/Z2Y/BB+nicSqDLVHbpjRd9
         HuTYoiEBanNIi4K6Z/Lyqj+0PJKEaIlQoRDQYilHQ1m0dkzfPOjd1j1RQOXTUrA0Qtqk
         1r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=8ghE8scXNG2/dd7skHSeWsqCt3RYcflaZVfDfqQgixs=;
        b=uO/c9+bUkrwBvekS5atbC9PjlmhgiC679og1KBIyfDr4YyWKxVzaijRYqAVRlOtALA
         IsoVqxOo2y7sPs5/V1Z4sQikDPI4sZ6GgsRj96emXYBvekS8gu4mmTuksb7sDaUrttdc
         dsxGsJPrIxkyXCZswLAtjPbhLYk3gyLClWKNAYh7EwL9KGYAeY+5snTUNd4MOOIGd4mE
         RqzrGDaWyRRKDMEdCRwxUDGQrCTc5B95jwV20Atw2Uugnp81jw9ERlFh0BiEzqOQgjng
         curFrVfXwfPquw7MAE4r4uDaAhl5NNxx3N8j98N8KMjC7Yj6vrlJhZgu1Dq9ZPJ1Wd+N
         m3EA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SrHu3Kcx;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SrHu3Kcx;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsivD+/xedU15kMNxrBEv72AOx9gI+M1AVHLDiiUKv5TUhB/ol4GRrCwbHJMi2/l5XxuDwPAQ==
Date: Fri, 16 Mar 2018 20:46:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>, "Bryant G. Ly"
 <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sergey
 Senozhatsky <sergey.senozhatsky@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "Tobin C.
 Harding" <me@tobin.cc>, Anton Blanchard <anton@ozlabs.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in
 syscall entry
Message-ID: <20180316204647.68417bc5@roar.ozlabs.ibm.com>
In-Reply-To: <20180316101549.31238bdf@naga.suse.cz>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
	<cover.1521141122.git.msuchanek@suse.de>
	<b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
	<20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
	<20180316101549.31238bdf@naga.suse.cz>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347539334628?=
X-GMAIL-MSGID: =?utf-8?q?1595090902459040277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Mar 2018 10:15:49 +0100
Michal Suchánek <msuchanek@suse.de> wrote:

> Hello,
> 
> On Fri, 16 Mar 2018 15:18:23 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > On Thu, 15 Mar 2018 20:15:52 +0100
> > Michal Suchanek <msuchanek@suse.de> wrote:
> >   
> > > On powerpc syscall entry is done in assembly so patch in an explicit
> > > barrier_nospec.    
> > 
> > Same comment as Linus for this -- the barriers are before the branch
> > here, so is it possible the branch instruction can be speculative
> > while the index is used to load the syscall table?  
> 
> As far as I understand barriers they separate code before the barrier
> and code after the barrier.
> 
> So inserting barrier_nospec after cmpldi means that the result of the
> cmpldi has to be known before any instruction following barrier_nospec
> that depends on the result can be executed. 
> 
> In many cases it is useful to put the barrier after a branch. It allows
> the compiler to speculate on the computed value at compile time and if
> it is constrained optimize out the branch. It may also result in the
> need to include many barriers and less readable code.
> 
> However, you have probably knowledge of the powerpc implementation of
> the barrier so if the semantic is actually different then please
> enlighten me.

I actually don't. I'm assuming we should be able to say that no previous
instruction is speculative when a subsequent one is executed.

But the branch instruction itself that is speculated, not the compare.

Usually even if all sources are ready, the pipeline may take in some
cycles after a branch, before that branch can finish executing and
squash speculation if it was wrong. Perhaps there is only a couple of
cycles of instructions that get a chance to reach execution units and
disturb any caches, but still there could be some window and I don't
think we would have architectural gurantees on that.

I'll try to ask around and see if there's any documentation we can
give you yet.

Thanks,
Nick
