Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeBWQeT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:34:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751430AbeBWQeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:34:18 -0500
Date: Fri, 23 Feb 2018 10:34:17 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] objtool: use host flags to detect if libelf is
 missing
Message-ID: <20180223163417.jdj54q6uy2sefcfh@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <2afbfc7911a0eb0642c33e8c2582f137a4fda2f3.1519393674.git.robin.jarry@6wind.com>
 <20180223153720.glun6fa2a3jde7mi@treble>
 <20180223162255.cakkzdi3jpkh4vmi@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223162255.cakkzdi3jpkh4vmi@6wind.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 05:22:55PM +0100, Robin Jarry wrote:
> 2018-02-23, Josh Poimboeuf:
> > Hi Robin,
> > 
> > Did you test this?  I see some issues:
> > 
> > a) I don't see where the host_cflags variable comes from (and btw, it's
> >    misspelled...)
> 
> Hi Josh,
> 
> Shame on me... Last minute fix. I had tested this first by forcing
> HOSTCC="gcc <CFLAGS> <LDFLAGS>" but I found it rather dirty. As it turns
> out, my patch is not better.
> 
> > b) I don't see where objtool uses HOSTLDFLAGS.
> 
> Indeed, I also missed this (see above).
> 
> It looks like objtool does not use HOSTCFLAGS nor HOSTLDFLAGS (defined
> in top Makefile). Do you see a reason why? Maybe it would be a good idea
> to share these flags (adding some specific ones for objtool, if needed).
> 
> What do you think?

Yeah, I think it would be a good idea for objtool to use HOSTCC,
HOSTCFLAGS, and HOSTLDFLAGS.

-- 
Josh
