Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518376396; cv=none;
        d=google.com; s=arc-20160816;
        b=DNr+MdTgToW/NshnfI0MZ4oSn0VCvViYS7eAPWudMwF/u8+uwc3o4oQ7sFQM/xxlBN
         FqXNR2JYEhtBVNDW8dFcMAYdnt1WCKWyXoxsD5uGJVeks/WrnoPN67UVjAOaStpa1Eke
         /a5eqlZsfSwl+JREkeEnRkDjJV7R+10dhNE5x7o80dXaR52lCwRNVDmzVWi8tvOJxfYq
         /gD7RMU96Qf9CqxsxtpxEdfoMtu2vbTgHa+r+DA5FR8HXz7kAs+CyDKFVJerW8m92Cy+
         Mr+Qz22B9ILQQsTsXmqno/t7i2ifAnmOMjgc37WY4VjfpYkNOsLxVUKVi+H0TXCpFQPs
         u7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=Sb7D/e+myKUPxA0fmAFwq4qF2XlDjLhyP8QV6vk16WM=;
        b=D/bpdDzhp6W7/L52lBEh0ixXmrhBkiW2n9I0D8Cmea7m2AQgh95UDzXKj8pi9Sctym
         Cjev1FRTVzUc9LKygluGjr1v17ltFELjOH1UH8Z10Z3NN08DGXOsLLzTBdPY8hBMEn4k
         VWbbZFYZCd+N5czybUVMnJMKzCPmwyqeEgPY5Z7WFjOFjYChV9LW1Xiur5smpgGqoJyv
         v3aiRvlvHlB0gxUS8vtavsckGhM88ZZ6gPakR86SA1aLOPX+qPgTn3FKu0dO+UZV/pvs
         9UpOD1YCjf6BwKxoTaECp+fH4lJ8ohFSUP97Aoc0CuljUaNNtk8xuJzddKVcGLUzSefX
         jFTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=X+YZdKyL;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=X+YZdKyL;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x226h8BGJdx/8XTLuQwe3M1h/2q5taCVoHe694JHBhAyV7TQpIv8KJnaP+lGgeIf1rsqFYTmfuw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 11 Feb 2018 20:13:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/31 v2] PTI support for x86_32
Message-ID: <20180211191312.54apu5edk3olsfz3@gmail.com>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
 <CALCETrUF61fqjXKG=kwf83JWpw=kgL16UvKowezDVwVA1=YVAw@mail.gmail.com>
 <20180209191112.55zyjf4njum75brd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209191112.55zyjf4njum75brd@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900490843452?=
X-GMAIL-MSGID: =?utf-8?q?1592133048313998878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Joerg Roedel <jroedel@suse.de> wrote:

> Hi Andy,
> 
> On Fri, Feb 09, 2018 at 05:47:43PM +0000, Andy Lutomirski wrote:
> > One thing worth noting is that performance of this whole series is
> > going to be abysmal due to the complete lack of 32-bit PCID.  Maybe
> > any kernel built with this option set that runs on a CPU that has the
> > PCID bit set in CPUID should print a big fat warning like "WARNING:
> > you are using 32-bit PTI on a 64-bit PCID-capable CPU.  Your
> > performance will increase dramatically if you switch to a 64-bit
> > kernel."
> 
> Thanks for your review. I can add this warning, but I just hope that not
> a lot of people will actually see it :)

Could you please measure the PTI kernel vs. vanilla kernel?

Nothing complex, just perf's built-in scheduler and syscall benchmark should be 
enough:

   perf stat --null --sync --repeat 10 perf bench sched messaging -g 20

this should give us a pretty good worst-case overhead figure for process 
workloads.

Add '-t' to test threaded workloads as well:

   perf stat --null --sync --repeat 10 perf bench sched messaging -g 20 -t

The 10 runs used should be enough to reach good stability in practice:

 Performance counter stats for 'perf bench sched messaging -g 20 -t' (10 runs):

       0.380742219 seconds time elapsed                                          ( +-  0.73% )

Maybe do the same on the 64-bit kernel as well, so that we have 4 good data points 
on the same hardware?

Thanks,

	Ingo
