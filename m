Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELsRNkfGoW7l7+HZOIj2PH5BCpuFyNNWT6istwYUU+mt8FOftWPEU1QDOzncsQM1nnZ4Kimx
ARC-Seal: i=1; a=rsa-sha256; t=1521191757; cv=none;
        d=google.com; s=arc-20160816;
        b=0Mgd5ZCObUCo8Be7nqtTVqg+ezoEsAx4htDSFz4cz5WvSNtgmKigqTcnCEie+DsGhI
         13fmEs9yvqNXeLLD6Cvo5+3HBEwbxG30N48jghbf0YiQhccEbNmnQ+Sc0yEOvTst9Gu9
         P9SdOxweUZTzOy8xkxuhoU6A0vybr5i+DJxx2hrHCqNN71pC5uB4DddSrXS03zy3XtNj
         Rc95KwkCRhMTg4zt0D7OBzADkBGIKp3g2IjMgm1pS6TgDhru2eC75DZ1K7s5VTaSUZyr
         0fTNqmJQQwd3hGxksPNaTuvYYB/KynnpEKcM3Ipvf5b8hJ84h6lHm2JTuJC8w0X8MdUx
         60Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=vsklQ237/bSLHGTm3EcYkz251WlBna9MO8G7vzLV6w0=;
        b=p2AetMW8yUJkTuOe0umLr+DmAQqhuZsDWrY8rBvr7NCZhDLR+Ahh2IZhBoStjpZVhw
         VHvzxqqsP5+tPV/1utx7UcRA1/85FjA3lGukEa0/2d7yid8LeNBDwaiH+IrJbrQH6UZm
         LxxIliwVk/r5H2tXfT9BtALr2gzsO2cAmMzVq8yFE00uZL2E6+iQO40EGiu4DKDVJwDi
         Kzthi1AKSZuJJUlGlHTdCpihZWBdxG7JaI8VxrBLctScp8Gx39mrG09VnTVsgr4Uv+63
         qTENgb8PLN6mILgatztiaOrrYd9+jMlLYl4CwIGoTtJq02cn3PDyYIw7Po9m2ABnG4DZ
         ofew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Date: Fri, 16 Mar 2018 10:15:49 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
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
 Harding" <me@tobin.cc>
Subject: Re: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in
 syscall entry
Message-ID: <20180316101549.31238bdf@naga.suse.cz>
In-Reply-To: <20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
	<cover.1521141122.git.msuchanek@suse.de>
	<b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
	<20180316151823.2f28d5ea@roar.ozlabs.ibm.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347539334628?=
X-GMAIL-MSGID: =?utf-8?q?1595085168941981635?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

On Fri, 16 Mar 2018 15:18:23 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu, 15 Mar 2018 20:15:52 +0100
> Michal Suchanek <msuchanek@suse.de> wrote:
> 
> > On powerpc syscall entry is done in assembly so patch in an explicit
> > barrier_nospec.  
> 
> Same comment as Linus for this -- the barriers are before the branch
> here, so is it possible the branch instruction can be speculative
> while the index is used to load the syscall table?

As far as I understand barriers they separate code before the barrier
and code after the barrier.

So inserting barrier_nospec after cmpldi means that the result of the
cmpldi has to be known before any instruction following barrier_nospec
that depends on the result can be executed. 

In many cases it is useful to put the barrier after a branch. It allows
the compiler to speculate on the computed value at compile time and if
it is constrained optimize out the branch. It may also result in the
need to include many barriers and less readable code.

However, you have probably knowledge of the powerpc implementation of
the barrier so if the semantic is actually different then please
enlighten me.

Thanks

Michal
