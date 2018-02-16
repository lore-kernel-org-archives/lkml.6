Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034436AbeBPOfN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:35:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033770AbeBPOfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:35:12 -0500
Date: Fri, 16 Feb 2018 08:35:11 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Progyan Bhattacharya <bprogyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] objtool/x86: Replace Non-standard Range Expression in
 Case
Message-ID: <20180216143511.fo4emxz6webqk7qn@treble>
References: <20180216141947.9324-1-progyanb@acm.org>
 <20180216142513.9520-1-progyanb@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216142513.9520-1-progyanb@acm.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 07:55:13PM +0530, Progyan Bhattacharya wrote:
> Replace range expressions with seperate individual cases, i.e. convert case 1...3: to case 1: case 2: case 3
> Range expression within case statements are non-standard C code and can create issues over compiler and platform variety.
> 
> While compiling with gcc 4.8 (RHEL) I encountered this error on range expression in case statements:
> error: range expressions in switch statements are non-standard [-Werror=pedantic]
> 
> Signed-off-by: Progyan Bhattacharya <progyanb@acm.org>

Hi Progyan,

Thank you for the patch.

I think this makes the code unnecessarily verbose and less readable.  We
rely on many such GCC extensions, and we don't aim to comply with
standard C.  And AFAIK, we don't use -Werror=pedantic in the kernel.

-- 
Josh
