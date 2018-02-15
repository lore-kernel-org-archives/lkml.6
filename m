Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518681808; cv=none;
        d=google.com; s=arc-20160816;
        b=CCFfG9zPIbLmW+khuaEfejhPHXOTnNQPUcjc4sI+OfkxOhF3V45gxj7BCf8Ep87G+4
         L6Q72jM53xdbartAEEkxXy21XNzDuF42uHjbDy89BXC3NInCUZWoK6PFaub40xRTc2QW
         /dS9YgyHL9p1SC86cLSbWrvcl1FAqkhgC1hWTda+2raP6+gR/c3hUpSzKFLAsQvwr8M8
         +cpcunBtyduwmr2//OpDy4lzcJpH8+GdzgteRYqKl5neeneKtePjhoV8re9bWAdBjwOJ
         OGpjFm2EryDrKKy0nl9fBzY+C6Mr9b9wEgKINbLun2OvJoR70h+eYFSGg0mQsYu1NGwu
         TaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=HdGgGQHAtnzFafKowqZV6wENU37mDkX8xSK3Hf+DIrs=;
        b=PF0kL8FrH9+byDx3LRHoAazH/xHy1YSMaHBwZF9NVFEtIngihOVfPKT4+en8hzmMoi
         VAsHkzxlG5JtqQ8/QlSSfY830rBkXiwKJVFbBubR/gZLWclA/zFLWReQvQsYRfswtACJ
         ZmGkz9e82B+vMmUmnjanf7G7qzMNsgwG5NImGF8QfdmQxB6ZptJu8Z85dGEvv8gFRyks
         DX0jQhprvVa6/NW1SyNd+ZImqHovwNYr5dkDIfA+EeIwxc1iUWDdyj0p45Z4aIKMgtWH
         gMAJad2iTPjrKclgtEbleVqmi6+w661GfV6IeOmN60/LhY79oUr1ODc3h6GoqO5u0nVb
         zETg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SFjHIzC/;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=SFjHIzC/;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AH8x227YszYneHT6/IL52QMFPeWsstlD1BiMZOOCXQNmcHnqRsQgOhsfone8tIq8Z5xnOp1E0uibaw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 15 Feb 2018 09:03:24 +0100
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
Message-ID: <20180215080324.3reffabx76w7ujyy@gmail.com>
References: <20180215003832.pzi7zbze5vlovp6l@gmail.com>
 <CA+55aFy-TRt++ujpxdq3U5mmXaKLW+jXuB=eD=KWY_Lsz+ox5w@mail.gmail.com>
 <20180215054836.GA9861@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215054836.GA9861@kroah.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592425307928838978?=
X-GMAIL-MSGID: =?utf-8?q?1592453295634389962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 14, 2018 at 05:17:25PM -0800, Linus Torvalds wrote:
> > On Wed, Feb 14, 2018 at 4:38 PM, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >    This tree generates two relatively simple conflicts with your tree:
> > 
> > So what annoys me about these conflicts is that I'm not convinced that
> > the stable tree actually *uses* your fancy x86/pti branch?
> > 
> > I think stable ends up working like a patch-queue anyway due to how
> > Greg works and all his helper scripts, so the whole "let's keep a
> > branch for pti" ends up being of dubious advantage when it results in
> > conflicts on merging, and it's not the same commits in the end anyway.
> 
> I do use it, I take the commits from there and then queue them up as
> individual patches for the stable releases.

Also note that these two conflicts came in recently - and today I eliminated them 
by switching x86/pti over to a clean v4.16 base (d4667ca14261). I'd have done this 
v4.16 backmerge earlier, had I realised that it's a problem to Linus!

Also:

> And if it wasn't there, the conflict resolution would have to be on my
> side, making them "not the same commits in the end", so either I have to
> do that, or you do :)

If tip:x86/pti wasn't there, I do claim that your -stable conflict resolution and 
stabilization work would have been a _LOT_ harder:

> > This is not a complaint so much as a "is it worth it?" question..
> 
> So far, I think this is the first conflict it's generated in a long
> time, so previously it was worth it from my point of view.  As long as
> it doesn't cause more work for the TIP maintainers, or for you, I
> appreciate it.  But if it does cause more work, don't worry about it, I
> can handle backporting things as needed.

Note that the role of x86/pti is not just to identify backporting commits for 
-stable, but to allow us on the x86 tree side to see how current upstream work 
interacts, and proactively allow us to group commits in a low-friction fashion.

So even if you didn't follow the x86/pti branch at all, -stable would _still_ 
benefit from the tip:x86/pti approach and the inherent backportability of all the 
PTI and Spectre commits.

There is no way we could have done this via the classic -stable tagging approach 
alone: the sheer scale of this effort (over 300 backported non-driver commits to 
core code) is almost two magnitudes higher than the Cc: stable commit tagging 
approach is usually applied to!

Also note that while x86/pti was v4.15 based yesterday and is pure v4.16+ based 
today, it's still fundamentally two (mostly) linear sets of commits:

   # v4.14 base
   v4.14..e5d77a73f364          # 71 commits: The original 'cherry-picked/merged' PTI base

   e5d77a73f364..64e16720ea08   # 167 linear commits: PTI and Spectre v4.15 work

   7e86548e2cc8                 # merge v4.15-final into x86/pti

   7e86548e2cc8..e48657573481   # 78 linear commits + 1 limited KVM merge of related changes

   d4667ca14261                 # today I switched x86/pti to this v4.16-rc1 
                                # upstream commit that includes all of x86/pti

   d4667ca14261..x86/pti        # third backporting range starts today, empty now

The "backporting value-add" here is that this short description compactly and 
unambiguously identifies a set of _316_ commits to very fragile pieces of low 
level x86 code (75% of which are must-have 'fixes' in the PTI/Spectre sense) that 
need to be applied to get v4.14 to the latest PTI and Spectre code,

Had we done this the usual way I do claim that it would have generated about a 
dozen nasty conflicts in v4.14 already by today, due to the sheer number and scope 
of PTI and Spectre commits, and the fragility and complexity of the underlying x86 
code.

Note that via the x86/pti approach the relevant v4.14.y x86 arch code is still 
almost 100% shared with Linus's latest tree, where testing results flow both 
downstream and upstream, even though it's cherry-picked and technically not the 
same tree in the Git space.

We'll see how this evolves in the v4.17 development window: PTI has already calmed 
down and things are calming down now for Spectre as well, so maybe we can switch 
back to the -stable tagging method and rely on -stable side conflict resolution.

OTOH exactly because things are calming down we can still keep x86/pti and 
robustly group, test and document the list of commits to backport. But we won't 
overdo it.

Thanks,

	Ingo
