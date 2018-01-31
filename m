Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeAaGRh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:17:37 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32922 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeAaGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:17:35 -0500
X-Google-Smtp-Source: AH8x2258nD7lfYtgttGN/7etY5NVbRLWD2D0ZZOmYUILhyQriPt0eeZU2onHdX5AXDtuyqSocN4vqQ==
Date: Wed, 31 Jan 2018 07:17:31 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/4] objtool: Don't print '.tmp_' prefix for .o files
Message-ID: <20180131061731.nqs4wyhgvovql44h@gmail.com>
References: <cover.1517284349.git.jpoimboe@redhat.com>
 <3788b5aec1c279184b78cdbd8b520903c0fb8a80.1517284349.git.jpoimboe@redhat.com>
 <20180130095831.GJ2228@hirez.programming.kicks-ass.net>
 <20180130155357.gq3kuutxoz7suxju@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130155357.gq3kuutxoz7suxju@treble>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Tue, Jan 30, 2018 at 10:58:31AM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 29, 2018 at 10:00:42PM -0600, Josh Poimboeuf wrote:
> > > With the following commit:
> > > 
> > >   2a0098d70640 ("objtool: Fix seg fault with gold linker")
> > > 
> > > ... objtool warnings started showing the modversions '.tmp_' prefix in
> > > the .o file name, like:
> > > 
> > >   arch/x86/mm/.tmp_mem_encrypt_boot.o: warning: objtool: sme_encrypt_execute()+0x48: indirect call found in RETPOLINE build
> > > 
> > > The prefix is confusing.  Remove it from the printed 'objname' variable.
> > 
> > This patch actually tripped me up today. Turns out I have both:
> > 
> >  build/kernel/sched/core.o
> >  build/kernel/sched/.tmp_core.o
> > 
> > and ended up staring at the wrong file and going WTF because the offsets
> > didn't match.
> > 
> > I much prefer the actual real filename printed. Yes the .tmp_ crud is
> > weird, but at least its the real file.
> 
> Good point, sorry for tripping you up there.  I see it's been removed
> from -tip now.  [...]

Yeah, and we had to rebase to a later kernel anyway so it was easy to remove it 
for now.

Thanks,

	Ingo
