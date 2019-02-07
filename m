Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C63821872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBGOrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:47:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37270 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGOrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:47:09 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1grkx5-0006BS-2t; Thu, 07 Feb 2019 14:46:55 +0000
Date:   Thu, 7 Feb 2019 14:46:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Edwin Zimmerman <edwin@211mainstreet.net>
Cc:     'Denis Efremov' <efremov@ispras.ru>,
        'Casey Schaufler' <casey@schaufler-ca.com>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        'Eric Paris' <eparis@parisplace.org>,
        'Kees Cook' <keescook@chromium.org>,
        'John Johansen' <john.johansen@canonical.com>,
        'James Morris' <jmorris@namei.org>,
        "'Serge E. Hallyn'" <serge@hallyn.com>,
        'Paul Moore' <paul@paul-moore.com>,
        'Kentaro Takeda' <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] security: fix documentation for the path_chmod hook
Message-ID: <20190207144654.GB2217@ZenIV.linux.org.uk>
References: <cover.1549540487.git.efremov@ispras.ru>
 <0275d06334cdb1d2a87384d7971924a70776b3cb.1549540487.git.efremov@ispras.ru>
 <20190207134939.GA2217@ZenIV.linux.org.uk>
 <000001d4beee$caa8eff0$5ffacfd0$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d4beee$caa8eff0$5ffacfd0$@211mainstreet.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:09:49AM -0500, Edwin Zimmerman wrote:
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index cb93972257be..5d6428d0027b 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -304,8 +304,7 @@
> > >   *	Return 0 if permission is granted.
> > >   * @path_chmod:
> > >   *	Check for permission to change DAC's permission of a file or directory.
> > > - *	@dentry contains the dentry structure.
> > > - *	@mnt contains the vfsmnt structure.
> > > + *	@path contains the path structure.
> > 
> > May I politely inquire about the value of these comments?  How much information
> > is provided by refering to an argument as "the dentry structure" or "the path
> > structure", especially when there's nothing immediately above that would introduce
> > either.  "Type of 'dentry' argument is somehow related to struct dentry,
> > try and guess what the value might be - we don't care, we just need every
> > argument commented"?
> > 
> > Who needs that crap in the first place?
> 
> The comments fill a valuable place to folks like me who are new to the linux security modules.
> In my spare time, I'm writing a new LSM specifically geared for parental controls uses, and the
> comments in lsm_hooks.h have helped me out more than once.  Perhaps the comments could
> be inproved by changing them to something like this:
> "@[arg] contains the [type] structure, defined in linux/[?].h"

Um...   The _type_ of argument is visible in declaration already;
it doesn't say a damn thing about the value of that argument.

In this particular case, dentry/mnt pair (whichever way it gets
passed; struct path is exactly such a pair) is actually used to
specify the location of file or directory in question, but
try to guess that by description given in this "documentation"...

As for "defined in"... that's what grep/ctags/etc. are for.
Again, the useful information about an argument is _what_ gets
passed in it, not just which type it is...
