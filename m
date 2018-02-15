Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518682609; cv=none;
        d=google.com; s=arc-20160816;
        b=nsLCXvTZC2zcBS8j13WiBGLz9jpI8NpEys6defa/hEM0DTnHs6ZkOzNehCHxfzJROj
         zO/Ozj/MBqkUgfn49y1jTm95TilWn8OKBlnhqCYk5In8mgwDycp+vV1xjYRqQanhNJfU
         RhF7pBLlj1+U9oroEWTfnNkv1F6rRrMuJ1WMTMRhn9foWN6N6AwK2ITbxlfI3d5WnPHI
         7XebN4Vo5Ubq8YDu+Q5HddsUB8xeNEiqMAaqqcoCNb1+oicxlXEonl3DBFPGxZoYzqXn
         l7TWBSLZLZKz22ocjcvOOLudy+Atrz+8XSpH3cTJUrXnZoj6r8mzvTC1BvN00P2IA4Cv
         biHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=eexLhqQGFfGT3CD+t7ZZWoQ/O2DgjcZQti0Jz+2tswA=;
        b=A5vUn73htRoWtkza6lEwyjRqjEbx7eCNcVTCaPdae1wV0Jkutj8sGuLD6emhWwh6ZO
         9BOMSDvINXoR/KvoL+JfgP4jaJJM5I5oNTVZcNrR8At3XeGFawxa6GWl3BDYxzrPA5vl
         V9epH4ClirkJRPEQsABx58rCF/lzWqr+IOQWH7tK8LL96+h+4FLiDBTWqqo5Uvj48KMy
         6ngHWmYoRtRAzszUROtPvlnDoz5McgBt3LdMFSO6lAnJreAdeLzwHXTMJ3gMnUbZuOXo
         71rYUYwF6MGCSZI6wrx5jOEBpJ7H/0J+yKDWqPnLS8uQR1i7H+bJsMKqgAmmtvprXw8F
         SFOQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DEDZJuga;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DEDZJuga;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x225qpFHw3FA8utS2pqWlHAv9uaw0DO4cotwbrVcowCpSPtJR3yutRCUJm8FJ8ZizAcKUQyKLJQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 15 Feb 2018 09:16:46 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [GIT PULL] x86 PTI and Spectre related fixes and updates
Message-ID: <20180215081646.px477klttsj6axgp@gmail.com>
References: <20180215003832.pzi7zbze5vlovp6l@gmail.com>
 <CA+55aFy-TRt++ujpxdq3U5mmXaKLW+jXuB=eD=KWY_Lsz+ox5w@mail.gmail.com>
 <20180215054836.GA9861@kroah.com>
 <20180215080324.3reffabx76w7ujyy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215080324.3reffabx76w7ujyy@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592425307928838978?=
X-GMAIL-MSGID: =?utf-8?q?1592454135857616716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ingo Molnar <mingo@kernel.org> wrote:

> > > This is not a complaint so much as a "is it worth it?" question..
> > 
> > So far, I think this is the first conflict it's generated in a long
> > time, so previously it was worth it from my point of view.  As long as
> > it doesn't cause more work for the TIP maintainers, or for you, I
> > appreciate it.  But if it does cause more work, don't worry about it, I
> > can handle backporting things as needed.
> 
> Note that the role of x86/pti is not just to identify backporting commits for 
> -stable, but to allow us on the x86 tree side to see how current upstream work 
> interacts, and proactively allow us to group commits in a low-friction fashion.
> 
> So even if you didn't follow the x86/pti branch at all, -stable would _still_ 
> benefit from the tip:x86/pti approach and the inherent backportability of all the 
> PTI and Spectre commits.

Put differently: this approach isn't a zero-sum game of 'upstream conflicts versus 
-stable conflicts', where if we don't resolve a conflict upstream then -stable has 
to do it and vice versa.

The tip:x86/pti approach actively avoided literally _dozens_ of nasty conflicts in 
the -stable space, at an (IMHO) much lower cost to upstream. It also IMHO 
successfully avoided the destabilizing effect that otherwise the backporting of 
most of ~300 these commits would have caused on the widely deployed v4.14 and 
v4.15 base kernels ....

Had I done this latest pull request a bit smarter Linus would not have seen these 
two conflicts either, so I still think this is the right approach and the cost to 
upstream is very low.

The x86 tree maintenance overhead was obviously higher due to all this, but right 
now I'm reasonably happy about the backporting aspect/overhead, because the v4.14 
and v4.15 stable kernels are now essentially using and testing our latest upstream 
code, which allows it to stabilize a lot faster.

Thanks,

	Ingo
