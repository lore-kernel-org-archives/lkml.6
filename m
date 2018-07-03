Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F6CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF8924F76
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AO0vjZTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF8924F76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbeGCBQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:16:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38957 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGCBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:16:02 -0400
Received: by mail-lf0-f65.google.com with SMTP id a134-v6so205055lfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5B12Tp4kN08gqEtK4R1GQeACKedJPoZ7RdgtD/9EY+s=;
        b=AO0vjZTkSN95CWk0cSaFLQ2nPlLEBwtOkSyD5GQ6BVa1m4R+LqWnxS46KYnNUoHsHK
         1mzewFxRWUuXW3l3ljcnqsJFlLLz4PoXfDAt+yv279mOHsnubVrSx4HoAf3fIYsCNmZK
         ZklKN3cb4GASjP7Pros+7/DrnBW+AK3zJEb3oq4g0z2ya8VEUGlysdJq5DkOGWWFx7i7
         o/R6i5FTHwwTRNvDwKjjLvkqneXf19OrEtAKij6jIgzjeywfSz/4hSOQDq2GxuKt9foq
         z8/J/KA0plXUe02NFKY+rnwS7RswjkQoycHXmwxz1QCAYfGfTMZGDGhl3iAJUZAYuNIF
         DxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5B12Tp4kN08gqEtK4R1GQeACKedJPoZ7RdgtD/9EY+s=;
        b=CGEllY0ASsQGQtrT4eZZEKRp5WABqPRjoSPopanG77yhxmptHigtSqzhE+orwHoZ0H
         FJS4W5fLdbB0b7oku+zETz4AzGrQAR7XcC+rVkJ+y+hHdAWeBiG1VfPECuXxGfLS+lhN
         49MtVuEFdDyg6Oxi/zltsGF9/CjsVwM6Imf1R4oqBNoT/bFRZWjx8CQJE1BlnqmqRhr+
         h6TluS6GYUxAYRPk5rYOW80EPOISdjBT3RIYLv/zh6lCF5PZWLeydkFUAJqogsv3l0KD
         44UMUykQ6WmVo5lMQgL/w5LSBhRytc2Lyr0jkDLxDlqeBwTznXnZtUDqUW3kFe/fJNF5
         VpNQ==
X-Gm-Message-State: APt69E3YhFrJQRyDkfBILX9IRATl591gkCbHJOPsHgsqHobCaGUJHMB1
        HoNyICH+72UbDd2jK9rEo6DBuo3e3M0DLbhYUyNv
X-Google-Smtp-Source: AAOMgpdsKkRSruOgTg0QrhnXQjZP/4hqhMHtQGcKIkOOPE5YOFTfV3JL8dbfrnnDFTp4BMlEzgzXc9YE5H2BYhGSbh0=
X-Received: by 2002:a19:d7d1:: with SMTP id q78-v6mr17498761lfi.40.1530580561185;
 Mon, 02 Jul 2018 18:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <3880c8030c55a97ee38335fc0dbf5dfd4f296c59.1529476660.git.joe@perches.com>
 <CAHC9VhS_UmWfv0aFGLfaqw-fLSmoGiDEcXGFZ3bvwNgp2PF=zg@mail.gmail.com> <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
In-Reply-To: <d729f7dc451cf26f5fdb63e44930c8fb67da41d3.camel@perches.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 Jul 2018 21:15:49 -0400
Message-ID: <CAHC9VhTzV5QKcjaQL0L_mTZECCexUq=FaSuQjC1AZjubD+VdJA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use pr_fmt to prefix "SELinux: "
To:     joe@perches.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, peter.enderborg@sony.com,
        selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:31 PM Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-07-02 at 16:51 -0400, Paul Moore wrote:
> > On Wed, Jun 20, 2018 at 2:39 AM Joe Perches <joe@perches.com> wrote:
> > > pr_fmt can be used with the pr_<level> macros to prefix
> > > arbitrary content to logging messages.
> > >
> > > So add '#define pr_fmt(fmt) "SELinux: " fmt' to selinux files
> > > that use pr_<level> and remove embedded "SELinux: " prefixes
> > > from the format strings.
>
> []
> > > @@ -1644,13 +1640,12 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
> > >
> > >                                 if (rc == -EINVAL) {
> > >                                         if (printk_ratelimit())
> > > -                                               pr_notice("SELinux: inode=%lu on dev=%s was found to have an invalid "
> > > -                                                       "context=%s.  This indicates you may need to relabel the inode or the "
> > > -                                                       "filesystem in question.\n", ino, dev, context);
> > > +                                               pr_notice("inode=%lu on dev=%s was found to have an invalid context=%s.  This indicates you may need to relabel the inode or the filesystem in question.\n",
> > > +                                                         ino, dev, context);
> >
> > Please split up lines like this.  I realize that there isn't much room
> > left, but this message wraps a silly amount in my 80-char terminal; if
> > you need to wrap, please limit it to a word or two.
> >
> > To stop the argument before it starts, I don't care what checkpatch.pl
> > says about splitting printk format strings like this.
>
> I do, so does Linus.  It's also specified in CodingStyle.
>
> 2) Breaking long lines and strings
> ----------------------------------
> []
> never break user-visible strings such as
> printk messages, because that breaks the ability to grep for them.
> ----------------------------------
>
> Likely this would also use pr_notice_ratelimited(etc...)
> to reduce indentation a bit too.
>
> Probably these should be output on 2 lines as the output
> dmesg line length is extremely long.

That line is too long.  Split it please.

> > What tree did you base your patch on?
>
> next-20180619 on the day it was sent.
>
> > Please base SELinux patches
> > either on the SELinux tree or Linus' tree.  The SELinux tree can be
> > found at the links below:
> >
> > * git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
> > * https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>
> It's almost always better to use selinux/next.
> Why should this patch be different?

Yes, that's what I said, please base your patch against the selinux/next branch.

-- 
paul moore
www.paul-moore.com
