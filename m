Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE51C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A4E222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMPY/j4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfBMOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:22:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35964 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbfBMOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:22:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so1206336pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VINywaqVsx/SKlGROTtYFcWn3xoANGvVCBKY156P9Bw=;
        b=gMPY/j4O6QISOewjTOOITqfv2oM8hqwdPSVDAyLiwWjIqYao7rJwXRM9OWfvEe7GvX
         6qsMB0KKsovapU5TwqlRKPx81F9j75ku2JtSNk66JrTla97sbgkLciGpWdR2ndZsSRn+
         v2xsNUQ18ffuYhKtvSAaFRWjyVkqwXI9kHKBsXiWHsgebf+YyMDCJF/tcwp+6doi8tYy
         3BeFQzcsa85PgsoNNHWzxBeYaG5qdsSLRo9g+l3pjKQGXIBTvJEN5FWU2ufxev9XtooE
         mLZQLYuszuQqhliME7s3qBCDAFg8/qtDLoMMlGDBZNoPuH/yDPdbMU+m+ts4JOrMdE8Q
         E8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VINywaqVsx/SKlGROTtYFcWn3xoANGvVCBKY156P9Bw=;
        b=PdNlxKMotxI+S57ovhERerVf75ymPsQqHCY8hR4E3I/G35B1zAYsJ1Q/9A8lO7Hz+b
         rDKp3mVodVpU5ZdOVnXcBL3Xr1SeIxrdc+8SmyJ3BlETnJl1en7+9MLHHpyxAOovqh8s
         VG2seXlqIMH2Ypmwuo3FCrpZII6SAPcK/84+DMcVQMovi1At1IhaFPbihYth2BkqlIS+
         AnGiMCLuiAyzc6zx4+jYkb7ZYuxbdHRD85voGrPSgSOR6VB2coTRdvmz4WsI8xZznsx1
         11ZSCflGHUig0T+I4iHz9c6+Spp13XavU6ogVgw+4slcjJRq34VyJVTgHtimaL4HwUC2
         hekA==
X-Gm-Message-State: AHQUAuYOdDDVKwZOGJFH7tlhXGgo61I/XIeXd5i6z8kAGEcFoG9HTLdu
        p8RALzeeypqv5cMs3uNYXofB0VMc
X-Google-Smtp-Source: AHgI3IbGRbr+T1cION+QPv9EoddpRe41vDOLWGD4O0hz+a2qc5p4mlhP3/E4v1nlhUeyzHMJQ0tNOQ==
X-Received: by 2002:a62:4389:: with SMTP id l9mr795861pfi.170.1550067731071;
        Wed, 13 Feb 2019 06:22:11 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id 15sm24800013pfr.55.2019.02.13.06.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 06:22:10 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:52:01 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>, devel@driverdev.osuosl.org,
        Forest Bond <forest@alittletooquiet.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
Message-ID: <20190213142159.GA4512@nishad>
References: <20190205150620.GA17522@nishad>
 <20190205184431.GD22198@kroah.com>
 <7771453cf380ce43d906f6648edecd8b58fec38a.camel@perches.com>
 <20190206162524.GA22989@kroah.com>
 <65ceabf611b845b5d278dba73d30f16b33e10d6d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ceabf611b845b5d278dba73d30f16b33e10d6d.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:17:35PM -0800, Joe Perches wrote:
> On Wed, 2019-02-06 at 17:25 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 05, 2019 at 10:59:40AM -0800, Joe Perches wrote:
> > > On Tue, 2019-02-05 at 19:44 +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Feb 05, 2019 at 08:36:24PM +0530, Nishad Kamdar wrote:
> > > > > This patch corrects the style for SPDX license Identifier in mac.h
> > > > > by using "/* */" in place of "//" as per Linux kernel licensing rules.
> > > > > Issue found by checkpatch.
> > > > > 
> > > > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > > > ---
> > > > >  drivers/staging/vt6656/mac.h | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> > > > > index 94e700fcd0b6..75166020f7c6 100644
> > > > > --- a/drivers/staging/vt6656/mac.h
> > > > > +++ b/drivers/staging/vt6656/mac.h
> > > > > @@ -1,5 +1,5 @@
> > > > > -// SPDX-License-Identifier: GPL-2.0+
> > > > > -/*
> > > > > +/* SPDX-License-Identifier: GPL-2.0+
> > > > 
> > > > Should really be:
> > > > 
> > > > /* SPDX-License-Identifier: GPL-2.0+ */
> > > 
> > > There's a fair number of style inconsistencies in the kernel
> > > sources for that already.
> > > 
> > > ~8% of the .h files that have an 'SPDX-License-Identifier:'
> > > don't use the recommended style.
> > > 
> > > $ git grep -h "SPDX-License" -- '*.h' | \
> > >   perl -p -e 's@Identifier:.*\*/*@Identifier: ... */@; s@Identifier: [^\.].*@Identifier:@' | \
> > >   sort | uniq -c | sort -rn
> > >    8506 /* SPDX-License-Identifier: ... */
> > >     593 // SPDX-License-Identifier:
> > >     154 /* SPDX-License-Identifier:
> > >      53  * SPDX-License-Identifier:
> > >       1  * SPDX-License-Identifier:	GPL-2.0
> > >       1 //SPDX-License-Identifier:
> > >       1 /*  SPDX-License-Identifier: ... */
> > 
> > Then let's fix them, the documentation says what the correct format is,
> > there's no reason we can't actually follow what is written...
> 
> So here's a script that does most all of them except
> the 50 or so that use the SPDX-License-Identifier
> in the middle of a comment block.
> 
> Using:
> 
> $ git grep --name-only 'SPDX-License-Identifier:' -- '*.h' | \
>   xargs grep -L '/\* SPDX-License-Identifier:.*\*/'| \
>   while read file ; do perl -i update_spdx.perl $file ; done
> 
> produces
> 
> $ git diff --shortstat
>  748 files changed, 902 insertions(+), 902 deletions(-)
> 
> And
> 
> $ git grep -h "SPDX-License" -- '*.h' | \
>   perl -p -e 's@Identifier:.*\*/*@Identifier: ... */@; s@Identifier: [^\.].*@Identifier:@' | \
>   sort | uniq -c | sort -rn
>    9254 /* SPDX-License-Identifier: ... */
>      53  * SPDX-License-Identifier:
>       1  * SPDX-License-Identifier:	GPL-2.0
>       1 /*  SPDX-License-Identifier: ... */
> 
> and the perl script below is also attached
> 
> $ cat update_spdx.perl
> local $/;
> my $file = (<>);
> 
> my $spdx_regex = '/\*[ \t]*SPDX-License-Identifier:[ \t]*';
> my $spdx_actual = '/* SPDX-License-Identifier: ';
> 
> # any // use converted to /* ... */
> $file =~ s@^//[ \t]*SPDX-License-Identifier:[ \t]*(.*)\n@/* SPDX-License-Identifier: $1 */\n@;
> 
> # first line use with /* without trailing */ gets */ added and 2nd line updated
> $file =~ m@^\s*${spdx_regex}([^\n]+)\n@;
> if (defined $1 && $1 !~ m@\*/$@) {
>     $file =~ s@^[ \t]*${spdx_regex}([^\n]+)\n@${spdx_actual}$1 */\n/* @;
>     $file =~ s@^[ \t]*${spdx_regex}([^\n]+)\n[ \t]*/\*[ \t]+\*@${spdx_actual}$1\n/* @;
>     $file =~ s@^\s*${spdx_regex}([^\n]+)\n/\* \n@${spdx_actual}$1\n/*\n@;
> }
> 
> print $file;
> 

Ok, Thanks for the suggestion and the script.

I'll try to use it and correct the format.

Thanks and regards,
Nishad
