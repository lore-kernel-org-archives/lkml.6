Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDFFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536A5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9BHypU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536A5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeGaVc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:32:28 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35344 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732471AbeGaVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:32:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so5012199oic.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3RtSzZ4Ihm3OpO4QhKtXNpbFTqw2cBpAUS/UXSFe/w=;
        b=O9BHypU7AXIWKZR/YX8iF0R+iBdwi62Ndl+JAi4wgFPoIffGL09YJGEy0w0VcGBSP9
         mz2nIgOWk/uDSNIkgNeg6opJgze3EBso7yOlOkVlZSIH8kA0QBGGW634xaGMcEYM2TWz
         l0PYUDtgd1V4TMGfAOCecByv6Su7TZhl4zUH9ij/3WXx7n7Er5dv1VMYosXP3ToS8NXj
         olU7vwccchJ7QLAz5n2LCcDhiZxv22H6OkZsfO20OYVJF9AlKhpCC1fUMB78ABFX2XfA
         X+UAxLvP5FR4uxCg9c3FiqmvKpEeet4qAR29vJ0X1AHyUReq+B20OJ0V1z0jUOxqwcY9
         Sirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3RtSzZ4Ihm3OpO4QhKtXNpbFTqw2cBpAUS/UXSFe/w=;
        b=DChnuZNW7SdN5nPgYJKl5O7rDHlFL0G5tGb/0kzbZmZoJCZ2wYrjVeFZVVrJo+opDw
         ksT0Ia3evn3N0uz/7l3UhRG/5tGMB2lOkH+aFC68H4ab+4UJgNFb1T4BNtM78rNXAXIE
         k5KRNXltIGm8JWFtIUm58gRKI7Cv44IMZlyYMwhH0I6Uk7fUfTCA6zNEkHXp2ABylX1j
         CtSOisU3ZfsAadP1GJFLC7Tnv980fxDY/mAZln6zGVaOVe9XESLcWwg2TA8vQ1e5mDEt
         B6bUG4OyvKm6QjcgXyFvK8X57MRCwS95lI4kCQGQb746pvhSK11Jtjtk5W95xPxvMSiJ
         n3tA==
X-Gm-Message-State: AOUpUlFA17DjIuON4qxTKLjGePH5AZTNcO0GegecBXv39ztGiWNLUR8m
        fgM8qIb5oOFigNsjp/1Oq4VL08g0v6GoVwpQWYb7Rg==
X-Google-Smtp-Source: AAOMgpcf66mwLF3SXdupNGlC12hXZJhPPSDNimLWlJPTAJUUox9IWJmDDNNvdTmJ6RwzN8LFQX5jwhJLbWK8Z+liJ0s=
X-Received: by 2002:aca:5155:: with SMTP id f82-v6mr381511oib.272.1533066634870;
 Tue, 31 Jul 2018 12:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161025.189534-1-jannh@google.com> <20180731165112.GJ30522@ZenIV.linux.org.uk>
In-Reply-To: <20180731165112.GJ30522@ZenIV.linux.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 31 Jul 2018 21:50:08 +0200
Message-ID: <CAG48ez2WUWCdicfUk5ytP8sv6yfwDeW-stCrnfwkYhqBe8d_pw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: don't let getdents return bogus names
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru,
        Matt Turner <mattst88@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 6:51 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jul 31, 2018 at 06:10:27PM +0200, Jann Horn wrote:
> > +/*
> > + * Most filesystems don't filter out bogus directory entry names, and userspace
> > + * can get very confused by such names. Behave as if a low-level IO error had
> > + * happened while reading directory entries.
> > + */
> > +bool bogus_dirent_name(int *errp, const char *name, int namlen,
> > +                    const char *caller)
> > +{
> > +     if (namlen == 0) {
> > +             pr_err_once("%s: filesystem returned bogus empty name\n",
> > +                         caller);
> > +             *errp = -EUCLEAN;
> > +             return true;
> > +     }
> > +     if (memchr(name, '/', namlen)) {
> > +             pr_err_once("%s: filesystem returned bogus name '%*pEhp' (contains slash)\n",
> > +                         caller, namlen, name);
> > +             *errp = -EUCLEAN;
> > +             return true;
> > +     }
> > +     return false;
> > +}
>
> > +     if (bogus_dirent_name(&buf->result, name, namlen, __func__))
> > +             return -EUCLEAN;
>
> These calling conventions st^Ware rather suboptimal.  First of all,
>         * none of ->actor() callbacks will ever get called directly.
>         * there are only 4 callers.  3 of them (all in fs.h) are
> of the form return ....->actor(...) == 0;  The fourth is
>         return orig_ctx->actor(orig_ctx, name, namelen, offset, ino, d_type);
> in ovl_fill_real(), which itself is an ->actor() callback.
>
> So all these "return -E..." in the instances are completely pointless;
> we should just turn filldir_t into pointer-to-function-returning-bool
> and get rid of that boilerplate, rather than adding more to it.

Do you want me to try to write a patch that does that change?

> Furthermore, who the hell cares which callback has stepped into it?
> "The first time it happened from getdents(2) in a 32bit process and
> that's all you'll ever get out of me" seems to be less than helpful...

Yeah, true. Should I just remove the method name from the pr_err_once?
Or should I also use one of the _ratelimited things and print multiple
messages?

> And frankly, I would prefer
>         buf->result = check_dirent_name(name, namelen);
>         if (unlikely(buf->result))
>                 return false;
> making that thing return -EUCLEAN or 0.  Quite possibly - inlining it
> as well...

I guess that would conform to normal kernel coding standards a bit better.

Thanks for the quick feedback!
