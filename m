Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161203AbeBPQri (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:47:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56120 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161071AbeBPQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:47:35 -0500
Date: Fri, 16 Feb 2018 17:47:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Progyan Bhattacharya <bprogyan@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] objtool/x86: Replace Non-standard Range Expression in
 Case
Message-ID: <20180216164722.GF25201@hirez.programming.kicks-ass.net>
References: <20180216141947.9324-1-progyanb@acm.org>
 <20180216142513.9520-1-progyanb@acm.org>
 <20180216143511.fo4emxz6webqk7qn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216143511.fo4emxz6webqk7qn@treble>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 08:35:11AM -0600, Josh Poimboeuf wrote:
> On Fri, Feb 16, 2018 at 07:55:13PM +0530, Progyan Bhattacharya wrote:
> > Replace range expressions with seperate individual cases, i.e. convert case 1...3: to case 1: case 2: case 3
> > Range expression within case statements are non-standard C code and can create issues over compiler and platform variety.
> > 
> > While compiling with gcc 4.8 (RHEL) I encountered this error on range expression in case statements:
> > error: range expressions in switch statements are non-standard [-Werror=pedantic]
> > 
> > Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>
> 
> Hi Progyan,
> 
> Thank you for the patch.
> 
> I think this makes the code unnecessarily verbose and less readable.  We
> rely on many such GCC extensions, and we don't aim to comply with
> standard C.  And AFAIK, we don't use -Werror=pedantic in the kernel.

Agreed, it makes the code actively worse. Just don't use error=pedantic.
