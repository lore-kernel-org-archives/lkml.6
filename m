Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B441C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010FE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKmcbgNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010FE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeK0E2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:28:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46267 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0E2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:28:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so14190548ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9pjwjXP7gvg+7JJOvzIRlHPm5IEKmfEvrU8I//CXbtY=;
        b=iKmcbgNnKva0eY4Pssuc4kK5tbm+mJbmgC7aPyZVlTivngdXFX2ugLK0jIlTg09NP9
         02aApICivzO37wHePXPmyZdbVTBc00DidC63UIwrs+xkjhMUvgRpBrGoVlXXsJcTWjzN
         VjZeMgo7f/XRp5pqC3wGRjAtylxr/ljvayLiA2ilUhfF55u4v62WabYP8TqIUC2a9uzN
         SqoL2E8iyQX+tkfSISNGLKl7L6I3Mbb7vH9hiMBPwwDe30VpeXNxmqlPBOlOpgOgg8tv
         Mxp1yeHA6mg3n7csXQKscsUFZoR+5jbyvYpluv8bY9A82sOFpj9rNmelB4HIgz2VYx3A
         uUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9pjwjXP7gvg+7JJOvzIRlHPm5IEKmfEvrU8I//CXbtY=;
        b=YfMLmb2YnqaIbj2rXxpkRUAKfF8gP76L7Htqde4RbHU1kqK8RCiLxgpkWe8s3qXhpK
         zIk/yVx92eTaYDMrGJPDIUNEN9rkJ2LRRVZxaLaexdAauJgwbeM/0Pl9CaxgtdLpUjiC
         gKXNYfC08P/IyItU0jWGvfvvs2Om8/iCeTyOKuXEoqkMjS2XSt21F7cj0AiRZjAu2cEs
         YjxBqD1mG9xVVejW2U2sqjv+ePKozzo6wZSMX7rYLD8YHwwG63/jpmcAa55dXY6Cfgqr
         BlxkfOjb70ETm9lzWEUoweCYj7eVaMBly4zzSBoyminsbFIOVLqEIAaxCQZw1YHOrMXD
         8xxA==
X-Gm-Message-State: AA+aEWZ1caHFH5Il4qVYyBSqehSu5JlSsD6pTlcQFgDdzRwZTAapolHE
        +PHn3Qzr1cDlw7sNUJ0d2T8=
X-Google-Smtp-Source: AFSGD/Vq1mJZ6wCAjoU1X3d2nIQDOkBU1RyVf9dSvMXY7UvsgVmL24MAFB5RvBLfdQd72cbhFOF19g==
X-Received: by 2002:a17:902:5a5:: with SMTP id f34mr15924335plf.161.1543253645692;
        Mon, 26 Nov 2018 09:34:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6sm1871102pfd.104.2018.11.26.09.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:34:04 -0800 (PST)
Date:   Mon, 26 Nov 2018 09:34:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
Message-ID: <20181126173404.GA12317@roeck-us.net>
References: <20181112160910.GA28440@redhat.com>
 <20181123171720.GA18841@roeck-us.net>
 <20181126122307.GA1660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126122307.GA1660@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On Mon, Nov 26, 2018 at 01:23:07PM +0100, Oleg Nesterov wrote:
> Hi Guenter,
> 
> On 11/23, Guenter Roeck wrote:
> >
> > On Mon, Nov 12, 2018 at 05:09:10PM +0100, Oleg Nesterov wrote:
> > > get_arg_page() checks bprm->rlim_stack.rlim_cur and re-calculates the
> > > "extra" size for argv/envp pointers every time, this is a bit ugly and
> > > even not strictly correct: acct_arg_size() must not account this size.
> > >
> > > Remove all the rlimit code in get_arg_page(). Instead, add bprm->argmin
> > > calculated once at the start of __do_execve_file() and change copy_strings
> > > to check bprm->p >= bprm->argmin.
> > >
> > > The patch adds the new helper, prepare_arg_pages() which initializes
> > > bprm->argc/envc and bprm->argmin.
> > >
> > > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > This patch results in various qemu boot failures in -next. Bisect logs
> > are attached. It looks like all nommu boots are failing.
>                                   ^^^^^
> 
> Ah, thanks.
> 
> Yes, I forgot about the !CONFIG_MMU version of get_arg_page() which doesn't
> check RLIMIT_STACK at all.
> 
> I'll send the trivial fix. Meanwile, could you test the patch below? to ensure
> this is the only problem.
> 

Tested-by: Guenter Roeck <linux@roeck-us.net>

with arm:mps2-an385, xtensa:kc705-nommu, and m68k:mcf5208evb.

Thanks,
Guenter

> Oleg.
> 
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -526,8 +526,10 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>  		pos = bprm->p;
>  		str += len;
>  		bprm->p -= len;
> +#ifdef CONFIG_MMU
>  		if (bprm->p < bprm->argmin)
>  			goto out;
> +#endif
>  
>  		while (len > 0) {
>  			int offset, bytes_to_copy;
> 
