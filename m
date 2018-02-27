Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeB0Vi2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:38:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751139AbeB0Vi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:38:27 -0500
Date: Tue, 27 Feb 2018 15:38:25 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Robin Jarry <robin.jarry@6wind.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 0/3] kbuild: fix host progs build with libs in non
 standard locations
Message-ID: <20180227213825.ht7a2ggjjxgnleys@treble>
References: <cover.1519393674.git.robin.jarry@6wind.com>
 <cover.1519668832.git.robin.jarry@6wind.com>
 <20180227174518.qzw6eqmuyggcvjl6@treble>
 <20180227205231.t2wmh4e2ky2ganyo@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227205231.t2wmh4e2ky2ganyo@6wind.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 09:52:31PM +0100, Robin Jarry wrote:
> 2018-02-27, Josh Poimboeuf:
> > In Documentation/kbuild/kbuild.txt, we have the following environment
> > variables:
> > 
> >   KCFLAGS
> >   --------------------------------------------------
> >   Additional options to the C compiler (for built-in and modules).
> >   
> >   CFLAGS_KERNEL
> >   --------------------------------------------------
> >   Additional options for $(CC) when used to compile
> >   code that is compiled as built-in.
> >   
> >   CFLAGS_MODULE
> >   --------------------------------------------------
> >   Additional module specific options to use for $(CC).
> >   
> >   LDFLAGS_MODULE
> >   --------------------------------------------------
> >   Additional options used for $(LD) when linking modules.
> >   
> >   LDFLAGS_vmlinux
> >   --------------------------------------------------
> >   Additional options passed to final link of vmlinux.
> > 
> > So instead of
> > 
> >   HOST_CFLAGS
> >   HOST_LDFLAGS
> > 
> > maybe it would be more consistent to call them
> > 
> >   CFLAGS_HOST
> >   LDFLAGS_HOST
> > 
> > ?
> 
> I had missed this file. Indeed {C,LD}FLAGS_HOST are much less confusing!
> 
> > Also, the new environment variables should be documented in the above
> > file.
> 
> Sure, I'll do that. However, I feel like I should also leave the
> paragraph in Documentation/admin-guide/README.txt.
> 
> What do you think?

[ Adding Jon Corbet to CC in case he has an opinion. ]

I think that paragraph in the admin guide seems a bit out of place,
because that file only seems to cover the most common cases.

No other env variables are described in that file (and some of the
previously existing env variables are much more likely to be used than
these new ones anyway).

It might be a good idea to instead just add a reference to kbuild.txt,
suggesting the user refer to that file if they want to learn more about
what env variables can be used to customize the build.

-- 
Josh
