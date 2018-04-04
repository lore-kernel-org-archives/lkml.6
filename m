Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AIpwx495zEpbiMQUaIgZrXL5XIj541jdWKr7J8x7xyfDivDRHH6g0XoUjt+S5SvBu8PKRXyiP8wL
ARC-Seal: i=1; a=rsa-sha256; t=1522870368; cv=none;
        d=google.com; s=arc-20160816;
        b=OcsPcZogv8lDLcgmsT8yh8yuzU/JFy8cGoyzv1bk5r+v4sfiCS4W52JRhKYD2/dTle
         c6kr+LhceWzkpHBDLj/k3YAms81kzNX49WEzIkZEJmyc23cUPCYAWgvMYSVsd76zapJv
         m6pFKoaOuDPLMBTaftQjp5Ri8/GGIQFsr81VdcMhQt8x6b1tX5icK1xVXUTkpoPGqjhg
         7QCy0BfI2RvgGqOxf71rWN6h7OOkdIFL7r2TiVm4lrLURG2AeBGJ8k/4hNoRnhmA3JoD
         pQ8ddmopjAuMadMUjupW5t9M527knVv5AkughL6Gr8R3n2rYNeiRq5+AR93X3l9mqvQD
         ulFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=NwQiVVI02bDvarG+aUYtvtB8DN2aJB7MazSG5MuybAk=;
        b=IbY0xxM1R4hcXKW6vYqpmRHPtMCZrirg9xQsnGDMD2qN/Rv9BA7brPkSqJsj4rj1R/
         QqPZvWcFI8cFvBtGnNXa2Kzu1aaeIe+BnFn27Ud/vgjH2QlBHbndI04E/AvxNUqktBiY
         VYQ3+P2izb5z9d3M/82UB4srByqcFa05sD9EDovMjHAcIKcFEXIQpCuaRuCvxCSg/Iaj
         aH3la1u1yCyXmUz3kpojIULHJDc55SWhf/z+ORDvRLMpw9vFTxMgJdlwk5Kr8ul+qL78
         Z3UFADpbmrBucjD7XbCpIhx9Ft0RcOvv2J1Xo7YgsAnjlb2oIsuBlYCCuUOh7OjmrwCg
         R+Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 4 Apr 2018 14:32:47 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>,
	groeck@chromium.org, Greg Hackmann <ghackmann@google.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180404193247.lsoxe3xjcidwtlgv@treble>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com>
 <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596845319349905193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 04:53:52PM +0000, Nick Desaulniers wrote:
> (re-sending as plain text)
> 
> On Wed, Apr 4, 2018 at 2:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > There are known-bugs with building a kernel with clang right now (I
> > pointed one out a few days ago about NULL checks being deleted from the
> > clang output for no good reason, which really is scary for obvious
> > reasons).
> 
> Is this the thread you are referring to?
> https://lkml.org/lkml/2018/3/27/1286
> 
> It's definitely something curious that I'll need to sit down and
> investigate more.  If there are other known instances, it would be good to
> let me know.

As Matthias mentioned elsewhere, it sounds like they're planning to
implement -fno-delete-null-pointer-checks, which would presumably fix
the above issue.

Aside from the above-mentioned debugfs NULL checks, there was also
another (seemingly valid) objtool warning:

  arch/x86/mm/pti.o: warning: objtool: pti_init() falls through to next function pti_user_pagetable_walk_pmd()

I don't know if that one was also caused by removed NULL checks, but
it's worth investigating.

More details (and the .o file) here:

  https://lkml.kernel.org/r/20180319232255.GF37438@google.com

-- 
Josh
