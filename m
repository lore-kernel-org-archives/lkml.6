Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06085C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AB621872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfBGOKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:10:00 -0500
Received: from mail.emypeople.net ([216.220.167.73]:34423 "EHLO
        mail.emypeople.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBGOJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:09:59 -0500
Received: from Shop7 ([166.182.241.52])
        by mail.emypeople.net (12.1.1 build 4 DEB9 x64) with ASMTP id 201902070909555932;
        Thu, 07 Feb 2019 09:09:55 -0500
From:   "Edwin Zimmerman" <edwin@211mainstreet.net>
To:     "'Al Viro'" <viro@zeniv.linux.org.uk>,
        "'Denis Efremov'" <efremov@ispras.ru>
Cc:     "'Casey Schaufler'" <casey@schaufler-ca.com>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        "'Eric Paris'" <eparis@parisplace.org>,
        "'Kees Cook'" <keescook@chromium.org>,
        "'John Johansen'" <john.johansen@canonical.com>,
        "'James Morris'" <jmorris@namei.org>,
        "'Serge E. Hallyn'" <serge@hallyn.com>,
        "'Paul Moore'" <paul@paul-moore.com>,
        "'Kentaro Takeda'" <takedakn@nttdata.co.jp>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1549540487.git.efremov@ispras.ru> <0275d06334cdb1d2a87384d7971924a70776b3cb.1549540487.git.efremov@ispras.ru> <20190207134939.GA2217@ZenIV.linux.org.uk>
In-Reply-To: <20190207134939.GA2217@ZenIV.linux.org.uk>
Subject: RE: [PATCH 06/10] security: fix documentation for the path_chmod hook
Date:   Thu, 7 Feb 2019 09:09:49 -0500
Message-ID: <000001d4beee$caa8eff0$5ffacfd0$@211mainstreet.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHt/nb8gz5bVEVBhRHqG/14fbqxbAHJyUheAmdZodmlgFWToA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 07, 2019 8:50 AM Al Viro wrote:
> On Thu, Feb 07, 2019 at 03:44:54PM +0300, Denis Efremov wrote:
> > The path_chmod hook was changed in the commit
> > "switch security_path_chmod() to struct path *" (cdcf116d44e7).
> > The argument @mnt was removed from the hook, @dentry was changed
> > to @path. This patch updates the documentation accordingly.
> >
> > Signed-off-by: Denis Efremov <efremov@ispras.ru>
> > ---
> >  include/linux/lsm_hooks.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index cb93972257be..5d6428d0027b 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -304,8 +304,7 @@
> >   *	Return 0 if permission is granted.
> >   * @path_chmod:
> >   *	Check for permission to change DAC's permission of a file or directory.
> > - *	@dentry contains the dentry structure.
> > - *	@mnt contains the vfsmnt structure.
> > + *	@path contains the path structure.
> 
> May I politely inquire about the value of these comments?  How much information
> is provided by refering to an argument as "the dentry structure" or "the path
> structure", especially when there's nothing immediately above that would introduce
> either.  "Type of 'dentry' argument is somehow related to struct dentry,
> try and guess what the value might be - we don't care, we just need every
> argument commented"?
> 
> Who needs that crap in the first place?

The comments fill a valuable place to folks like me who are new to the linux security modules.
In my spare time, I'm writing a new LSM specifically geared for parental controls uses, and the
comments in lsm_hooks.h have helped me out more than once.  Perhaps the comments could
be inproved by changing them to something like this:
"@[arg] contains the [type] structure, defined in linux/[?].h"

