Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeBRDhA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 22:37:00 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42769 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbeBRDg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 22:36:59 -0500
X-Google-Smtp-Source: AH8x224Xtajk7ocsF5jmZD/kouMManQIOHj1LjFqXEYSwhPH1miydmruslwwuKdLCp22s7aTlSoqJA==
Message-ID: <1518925012.5730.0.camel@gmail.com>
Subject: Re: [PATCH] objtool/x86: Replace Non-standard Range Expression in
 Case
From: Progyan Bhattacharya <bprogyan@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Date: Sun, 18 Feb 2018 09:06:52 +0530
In-Reply-To: <20180216164722.GF25201@hirez.programming.kicks-ass.net>
References: <20180216141947.9324-1-progyanb@acm.org>
         <20180216142513.9520-1-progyanb@acm.org>
         <20180216143511.fo4emxz6webqk7qn@treble>
         <20180216164722.GF25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-16 at 17:47 +0100, Peter Zijlstra wrote:
> On Fri, Feb 16, 2018 at 08:35:11AM -0600, Josh Poimboeuf wrote:
> > On Fri, Feb 16, 2018 at 07:55:13PM +0530, Progyan Bhattacharya
> > wrote:
> > > Replace range expressions with seperate individual cases, i.e.
> > > convert case 1...3: to case 1: case 2: case 3
> > > Range expression within case statements are non-standard C code
> > > and can create issues over compiler and platform variety.
> > > 
> > > While compiling with gcc 4.8 (RHEL) I encountered this error on
> > > range expression in case statements:
> > > error: range expressions in switch statements are non-standard [-
> > > Werror=pedantic]
> > > 
> > > Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
> > 
> > Hi Progyan,
> > 
> > Thank you for the patch.
> > 
> > I think this makes the code unnecessarily verbose and less
> > readable.  We
> > rely on many such GCC extensions, and we don't aim to comply with
> > standard C.  And AFAIK, we don't use -Werror=pedantic in the
> > kernel.
> 
> Agreed, it makes the code actively worse. Just don't use
> error=pedantic.

But I cannot figure it out how Werror=pedantic flag is being set. :(
 
-- 
Regards,
Progyan Bhattacharya
(http://codeprogyan.me)
