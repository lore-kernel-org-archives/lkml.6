Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeA3Px7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:53:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbeA3Px6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:53:58 -0500
Date: Tue, 30 Jan 2018 09:53:57 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/4] objtool: Don't print '.tmp_' prefix for .o files
Message-ID: <20180130155357.gq3kuutxoz7suxju@treble>
References: <cover.1517284349.git.jpoimboe@redhat.com>
 <3788b5aec1c279184b78cdbd8b520903c0fb8a80.1517284349.git.jpoimboe@redhat.com>
 <20180130095831.GJ2228@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180130095831.GJ2228@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 10:58:31AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 29, 2018 at 10:00:42PM -0600, Josh Poimboeuf wrote:
> > With the following commit:
> > 
> >   2a0098d70640 ("objtool: Fix seg fault with gold linker")
> > 
> > ... objtool warnings started showing the modversions '.tmp_' prefix in
> > the .o file name, like:
> > 
> >   arch/x86/mm/.tmp_mem_encrypt_boot.o: warning: objtool: sme_encrypt_execute()+0x48: indirect call found in RETPOLINE build
> > 
> > The prefix is confusing.  Remove it from the printed 'objname' variable.
> 
> This patch actually tripped me up today. Turns out I have both:
> 
>  build/kernel/sched/core.o
>  build/kernel/sched/.tmp_core.o
> 
> and ended up staring at the wrong file and going WTF because the offsets
> didn't match.
> 
> I much prefer the actual real filename printed. Yes the .tmp_ crud is
> weird, but at least its the real file.

Good point, sorry for tripping you up there.  I see it's been removed
from -tip now.  We should look at changing how the modversions stuff
does its renaming so this will be less confusing.

-- 
Josh
