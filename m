Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85913C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B59B2192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 23:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuijNltV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392971AbeLVXdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 18:33:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37404 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbeLVXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 18:33:10 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so7818485ljd.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 15:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uaXvQie81CfER90A1a3K1Frz9R+L5jm3ZU5ec+n1254=;
        b=HuijNltVcbgUkCvvvJZcCmqk5vpYFPKam2shFkMC9BYmI1CjM1CM4QcbnY27YL3RIK
         uQGVkcjLGI4rYMPYRjeTrdFoxsrLBYGAZAIPXXnTPjwPVsPmoA2bLnuc7Pbc+r7AfbFK
         dEGZCSUBdKq52VkJuC+JdbFwy58IJ5AIQFEg67D8g+Sl4x1JYNEWZXa+P7xU0RZNGHpO
         LFX3jao4U+aT+xalchH/Ibhod3imv7CU4MvFfD01uXHTdQlt5VlGLAyXKL4cp4Tl7Sjq
         ZT4mDKroQYZVbLPpQfNb6GsC4SihiPRbbS1qa9n6+y40jRD6/5YFybbwPtCRYxJUqMpD
         SIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uaXvQie81CfER90A1a3K1Frz9R+L5jm3ZU5ec+n1254=;
        b=SMFEJgehN1DjEGMzIquVi8iVTG5ZySvrRDYiHFz0iX54HVHXWvMO4x9a5tPdXGnDyg
         v4Xs1Uglle87abDHXqcDxgvmbkBqB849Bvktp1jkWlTPriEMZgHr4ny0v9OlB9M49Lr1
         r0NtAPICSSnXpISxKyYo/gxzC+o0z2WInMKNB6cuV6NaDXZs4JfW7Cye7kY5onc9PwV4
         sTSERF87+vnqHMGbWKsxJNPN5akJjqUfpcQjv5n15H5jZ5RU50JJLvA22MSpP4oo/g0n
         PhX8QdJLJRoUgUa5i+zabGAretbO0jcOQwPfcJroVFNX4v8ugntuUS0v39aA/4wgws1D
         t5ZA==
X-Gm-Message-State: AJcUukfSWoe52GK14sd1T5x18XQcg4VTYybt1i7hlgGCWLZWcYGZqvd3
        fSYwoegUFp6FFubBj1Sc1+j9DG8tjo2DRy/Txw==
X-Google-Smtp-Source: ALg8bN6LzSSmV4T5iUNw0yLhz7vFwVcFC5+bqbaUEhVfwKqmHM11wKZQv02Ueng7pY4JjfjrsHMZ9t0e1jbVu8Fluig=
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr4525484ljj.95.1545521587836;
 Sat, 22 Dec 2018 15:33:07 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
 <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com> <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
In-Reply-To: <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Sun, 23 Dec 2018 00:32:41 +0100
Message-ID: <CAEJqkgjF7HBcvD=2QHTTipjv1kmpWwRATp1VLnu8KDe6cGMvhg@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christian.brauner@canonical.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ellie Reeves <ellierevves@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am So., 23. Dez. 2018 um 00:02 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
>
> On Sat, Dec 22, 2018 at 2:49 PM Christian Brauner
> <christian.brauner@canonical.com> wrote:
> >
> > To be fair, no one apart from me was pointing out that it actually
> > breaks people including systemd folks
> > even though I was bringing it up with them. I even tried to fix all of
> > userspace after this got NACKED
>
> Seriously, the "we don't break user space" is the #1 rule in the
> kernel, and people should _know_ it's the #1 rule.
>
> If somebody ignores that rule, it needs to be escalated to me.
> Immediately. Because I need to know.
>

I do that usually but I didn't saw Christian's revert the time and I
never hit that issue.
Just saw that now because the unusual  [BREAKAGE] prefix.

> I need to know so that I can override the bogus NAK, and so that we
> can fix the breakage ASAP. The absolute last thing we need is some
> other user space then starting to rely on the new behavior, which just
> compounds the problem and makes it a *much* bigger problem.
>

Yes and you are right ..
https://github.com/lxc/lxc/pull/2438

I've added an comment there about 4.20.0.

BR,

Gabriel
