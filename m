Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx49FlkyswX/Bpulzp3BK9B+1RYWm9JWnMG8OcjFGmYBIyKSczEGq9hZrxCoRvKZEk68vSdrh
ARC-Seal: i=1; a=rsa-sha256; t=1522912096; cv=none;
        d=google.com; s=arc-20160816;
        b=H6msYbd5mNyfMw/tnL2czqaQllTI5XKrpfFxYvQvBAV9FhN0IFY1nWxcLOeaaEaTR2
         y1E3oi4sj5u/MjmDyt+GYGSTjtL5axtjdQgnjJpCOH80+Pddl6SjyaPSaax47dghPO+K
         wmNIiOIDBBBWw26vcMZG5pLy+bYne91pFoTV6GuLSUttnImwWB10hD1+IsDV0r4uK5GM
         2hb7koFUqeS4Bw1uAGpjZu4w0L95k611/ODjQG9VppMjSJ0vvmINk+yZChFN8OXWFZiu
         aWgUXaxWzNMoV9orXPVLccCO2NOUZOaih8xkUy3CV9kSSQuvTtz1/bofPXsZ67KXa1Bv
         gqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=eB8kObZ6IKFNVkosm8wjxsNXeBizGTu+2YROxTLe6Pw=;
        b=jpPuHeSMBVXq0eZbbaRqnesdeENhx/e5suQ2bY0oiRlrJ+I0+AgGyETrBY0dRY8aJn
         OcJhyMkqleesvou5MsfcQhiiYory5KOv2kVW5mg001q9c0jjDtVBYQFAKV3gOk2mkMB2
         yMGp6/fIaUXscAFKz5BaxJQ4cg+pnwlAXlu4souCk4VnW6kSKsBufeCOvoBLbcoNAOaT
         M3/aRcAxPMv7iRM7kIRfPWDjAHH1SpFo22n7Hj5OZkDw29wAF405F9Is/bKpRI25IvXq
         5tCjhOb05CGPDG4v/BOv8Ch7BegAelziE/G60PIWci1jHxzua0jNEDExAl4+E+c28F74
         ANgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WhvofEhX;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=WhvofEhX;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 5 Apr 2018 09:08:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: James Y Knight <jyknight@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	gregkh@linuxfoundation.org,
	Nick Desaulniers <ndesaulniers@google.com>, mka@chromium.org,
	Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	tglx@linutronix.de, Andrew Morton <akpm@linux-foundation.org>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Kees Cook <keescook@google.com>,
	groeck@chromium.org, Greg Hackmann <ghackmann@google.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180405070810.GM4043@hirez.programming.kicks-ass.net>
References: <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
 <20180403180658.GE87376@google.com>
 <CAKwvOdkaBNTyNjackJcWYkdfwyR2wjAruMFqN8LuYqC8V0ii_A@mail.gmail.com>
 <20180404093823.GC25996@kroah.com>
 <CAKwvOdmk-e5NCkyMT_LX2i5F1X+xGP+ZxAjaJasjgE6FaXKi6w@mail.gmail.com>
 <20180404165914.GA9034@kroah.com>
 <CAA2zVHoteRJeGM=kmsZmaKP97K0LJhVF872KhpWE192A-=B4SA@mail.gmail.com>
 <CA+55aFysRcOu7F-kZKNWp_fY1DViQoz7OmXUBeD0xhXROvPYqA@mail.gmail.com>
 <CAA2zVHqMS7HQggLnhQc9qjUhnD5MQXcyXkVnCQ0BoKqC8i3vgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA2zVHqMS7HQggLnhQc9qjUhnD5MQXcyXkVnCQ0BoKqC8i3vgw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596889074029491113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 10:21:05PM +0000, James Y Knight wrote:
> But allowing random pointer arithmetic, and pointer arithmetic wraparound,
> is still different than asserting that an object _field access_ can
> overflow. Clang does not believe that can happen -- it assumes that an
> object will still be contiguous. And that's why the llist stuff used to be
> broken, before it was corrected to do simply do math on a uintptr_t (which
> is a nice and simple and sane fix!).

That 'fix' wasn't anything simple, I recently ran into that
member_address_is_nonnull() trainwreck and had to think real hard wtf it
was about.
