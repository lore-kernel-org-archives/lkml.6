Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C65C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F9E26473
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtUVtqQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F9E26473
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934302AbeF0M3s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:29:48 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34002 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933103AbeF0M3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:29:45 -0400
Received: by mail-ot0-f194.google.com with SMTP id i17-v6so1988822otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoGcdOYnPY9XIT4BiPzncYhe8nv+5XxhAuO7U0UQo6E=;
        b=rtUVtqQecJsRqLilFeAL7lYLvI66EgXB7wK+YujDYNZOmCF2vpbAv1HjZmuWiBrQb+
         wZkoPGQfGta5M3+DA8R1wB2Vbb8z5eLvduw/ExdjhGilEVoo94/L9Hx+JoidyHhpR4qn
         m1xwgScQKOXqfBxH1QpE2DAT5A33Jwh6n2D6rARt4flqzBIcmbhpVdtdXuOkFgcyk9Xm
         R7joUM96Dq0fLY6EoPRI49o533HHre8clZ95p1V8V1zGgNjGrcohRtbHq4Xb4JHUG44G
         XtLzs/Iu+/bOdw/NWP4SjmX/M6je+/1Vpgn05Jwo+BaxPCzbkMMu6tlKC7KXbqqXrgA7
         tjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoGcdOYnPY9XIT4BiPzncYhe8nv+5XxhAuO7U0UQo6E=;
        b=NXDdAMxkPC5mrGf0fbCnM6u9AW1HB1fAF5bAzOA5j3D6tFfG3/B16IZe3fe8GF25mT
         i4InEfT7EJGLOpI8tw2ED39TDhnTFxvOosP+2GMw2aNGXgMtQcfn8R8FQHV8x0o46ORN
         1UUNmY07RTQdv4DvHcS5Ec7MwgG8Axd9aZu7pmLDbai8ENw5o9hdLY9OKu1IoKJGfkII
         FGwzdzCwD2zcvpT39ywdxlfKiDdSw9BNPyTwDtWdwOtgB1YJYJwsqkQJpUVR24cxAFjw
         WrbFYttPDGzTN9q1u/OCNn8eQ6s6HXW5F/pvF4Ghrvkdjil3ZGhTvyuF+VYVCBjrAjEC
         y6pQ==
X-Gm-Message-State: APt69E1e2OXVkTHY8y4Ja0RX9XhMy/7pgu3Y+Q4qONCxFplcDMc1eOn8
        TelnZRJ14BJ9V7Xtb/bPVyDSVNkTVkf2smJ99fcHdg==
X-Google-Smtp-Source: AAOMgpclpYAcWHRMX42/GWDN4pBKolstxvODM+XUVhIWS/HL5bqYoBmEyftWuJ6f/S1wla/r1NZ0Bl5Nr6wsSkCBiS4=
X-Received: by 2002:a9d:2466:: with SMTP id p93-v6mr3094216ota.254.1530102584989;
 Wed, 27 Jun 2018 05:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163410.216168-1-jannh@google.com> <20180625164109.GF30522@ZenIV.linux.org.uk>
 <CAG48ez2i2Dpy5TLTjtLiGKdkFDYLGURqAGoTDbETaBGf5SgxPw@mail.gmail.com> <d23cd44b1e2e1521cedb1c514d392263ed976dca.camel@decadent.org.uk>
In-Reply-To: <d23cd44b1e2e1521cedb1c514d392263ed976dca.camel@decadent.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Jun 2018 14:29:33 +0200
Message-ID: <CAG48ez2JAj1daM5s7gyS0nzB+J85PkmUL5+D_BC4-afag9SWFA@mail.gmail.com>
Subject: Re: [PATCH] sys: don't hold uts_sem while accessing userspace memory
To:     ben@decadent.org.uk, Al Viro <viro@zeniv.linux.org.uk>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, security@kernel.org, hch@infradead.org,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:43 PM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Mon, 2018-06-25 at 20:16 +0200, Jann Horn wrote:
> > On Mon, Jun 25, 2018 at 6:41 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Mon, Jun 25, 2018 at 06:34:10PM +0200, Jann Horn wrote:
> > >
> > > > +     char tmp[32];
> > > >
> > > > -     if (namelen > 32)
> > > > +     if (namelen < 0 || namelen > 32)
> > > >               namelen = 32;
> > > >
> > > >       down_read(&uts_sem);
> > > >       kname = utsname()->domainname;
> > > >       len = strnlen(kname, namelen);
> > > > -     if (copy_to_user(name, kname, min(len + 1, namelen)))
> > > > -             err = -EFAULT;
> > > > +     len = min(len + 1, namelen);
> > > > +     memcpy(tmp, kname, len);
> > > >       up_read(&uts_sem);
> > > >
> > > > -     return err;
> > > > +     if (copy_to_user(name, tmp, len))
> > > > +             return -EFAULT;
> > >
> > > Infoleak, and similar in a lot of other places.
> >
> > I don't see a problem. copy_to_user() copies "len" bytes from "tmp".
> [...]
> > Can you please explain why there is an infoleak here?
>
> I think you're *fixing* information leaks in the Alpha syscalls,
> because a negative value of namelen used to result in a huge length
> argument to copy_to_user().

Ah, you're right. Looks like this was previously fixed in commit
21c5977a836e ("alpha: fix several security issues", first in v3.0),
and then un-fixed in commit 9ba3eb5103cf ("osf_getdomainname(): use
copy_to_user()", first in v4.13).
