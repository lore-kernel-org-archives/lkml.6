Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE6F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbobrowski-org.20150623.gappssmtp.com header.i=@mbobrowski-org.20150623.gappssmtp.com header.b="xYRXxJ6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE6F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mbobrowski.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeLMJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:47:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32817 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeLMJrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:47:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so823798pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4aEx2uXuUdlX3c27Y0gll5OHSNh1td7UGwzbaC++S30=;
        b=xYRXxJ6oRdaIZRcZ4AuLpmrIunJ2pMdNfZRMZjSRygHF9pvAWY9eah2oh43Xy2D6cR
         z4e163m+FzsNg+6VpUOC5wFheqw/nTCoM8X9zrY52bxioP6Zt/PmK+hP+Q8f9qj9pxwC
         brVBqWWZUWpPamlf4PzEnQ7C/qoF5fP4BF+1FGYlYXW04IvRF11Ty64To4P3fUCy2R6j
         1n/36eZD95qz0EPH1fgoVJXtoOWKRcokvQV60oO7hkupjMNu5LYu071FLKZDj2szFAht
         HG9oKxiEpiYSDmVWx9viTtUchY72MUQ0k7rPzmn5M7rJCcpMfOXN2gB2wX3zi7gOhpmp
         yoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4aEx2uXuUdlX3c27Y0gll5OHSNh1td7UGwzbaC++S30=;
        b=bj4UG0OnU7CXv1nzj8/3uMUVYpBHOZDkSFM3PxZSC1dA0lmzgK4BaOeiiPL5bm4KKE
         Yy127Nvo72Wie+8RL1uYlktVzJIvrgMIVlUH6bB2uVbj08i8szlVbNWgsGH9sZut7Czy
         izUuysBPH+r2MfoaKHULqoUWTT95bNVoFsmZ28jf1THJU/1AAevUcDfsK3zuTfw0vS4q
         HFiQKi2SJy1UWWLjDgne6Wcy+SGzINDPE+DJKgVf6Kbf/l4eXqlsAcpVzmXdP9T/i+MX
         dL70i3OWhz7PSOSVmkwwL9cMEvVe2cGaYLiyCdS+aG34q/n0HZe7pzLYoyghD7iH+z7D
         ljxA==
X-Gm-Message-State: AA+aEWazO2EainYEyPcP6v2JqNScc4qmvJx654GQTJZMXl1VzcByIhtZ
        0HtyLeL3DH/1IAbrBba5uKDp
X-Google-Smtp-Source: AFSGD/WMbJehOwf06/UZWSkxrL7D0shfZBwMNGtMHP0ioqH56GlvIGwaNXCUnsUqXQg6ICClw3lQzA==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr23822549pfn.125.1544694437798;
        Thu, 13 Dec 2018 01:47:17 -0800 (PST)
Received: from lithium.mbobrowski.org ([103.230.158.220])
        by smtp.gmail.com with ESMTPSA id k191sm1613621pgd.9.2018.12.13.01.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 01:47:17 -0800 (PST)
Date:   Thu, 13 Dec 2018 20:47:02 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sgrubb@redhat.com
Subject: Re: [RFC PATCH v1 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
Message-ID: <20181213094658.GA996@lithium.mbobrowski.org>
References: <20181212081712.32347-1-mic@digikod.net>
 <20181212081712.32347-2-mic@digikod.net>
 <20181212144306.GA19945@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181212144306.GA19945@quack2.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 03:43:06PM +0100, Jan Kara wrote:
> > When the O_MAYEXEC flag is passed, sys_open() may be subject to
> > additional restrictions depending on a security policy implemented by an
> > LSM through the inode_permission hook.
> > 
> > The underlying idea is to be able to restrict scripts interpretation
> > according to a policy defined by the system administrator.  For this to
> > be possible, script interpreters must use the O_MAYEXEC flag
> > appropriately.  To be fully effective, these interpreters also need to
> > handle the other ways to execute code (for which the kernel can't help):
> > command line parameters (e.g., option -e for Perl), module loading
> > (e.g., option -m for Python), stdin, file sourcing, environment
> > variables, configuration files...  According to the threat model, it may
> > be acceptable to allow some script interpreters (e.g. Bash) to interpret
> > commands from stdin, may it be a TTY or a pipe, because it may not be
> > enough to (directly) perform syscalls.
> > 
> > A simple security policy implementation is available in a following
> > patch for Yama.
> > 
> > This is an updated subset of the patch initially written by Vincent
> > Strubel for CLIP OS:
> > https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> > This patch has been used for more than 10 years with customized script
> > interpreters.  Some examples can be found here:
> > https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> > 
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> > Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
> > Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
> 
> ...
> 
> > diff --git a/fs/open.c b/fs/open.c
> > index 0285ce7dbd51..75479b79a58f 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -974,6 +974,10 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
> >  	if (flags & O_APPEND)
> >  		acc_mode |= MAY_APPEND;
> >  
> > +	/* Check execution permissions on open. */
> > +	if (flags & O_MAYEXEC)
> > +		acc_mode |= MAY_OPENEXEC;
> > +
> >  	op->acc_mode = acc_mode;
> >  
> >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> 
> I don't feel experienced enough in security to tell whether we want this
> functionality or not. But if we do this, shouldn't we also set FMODE_EXEC
> on the resulting struct file? That way also security_file_open() can be
> used to arbitrate such executable opens and in particular
> fanotify permission event FAN_OPEN_EXEC will get properly generated which I
> guess is desirable (support for it is sitting in my tree waiting for the
> merge window) - adding some audit people involved in FAN_OPEN_EXEC to
> CC. Just an idea...

If I'm understanding this patch series correctly, without an enforced LSM
policy there's realistically no added benefit from a security perspective,
right? Also, I'm in agreement with what Jan has mentioned in regards to setting
the __FMODE_EXEC flag when O_MAYEXEC has been specified. This is something that
would work quite nicely in conjunction with some of the new file access
notification events.

Rather than setting it on the resulting struct file, couldn't they simply
incorporate it as part of op->open_flags when flags & O_MAYEXEC? Not entirely
sure whether this is what you actually meant or not though? Pretty much the
same as a call to exec(2)/execat(2) when it builds its open_flags.

-- 
Matthew Bobrowski
