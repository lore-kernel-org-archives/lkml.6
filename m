Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B42BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D3E205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmP2cPVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389453AbeLUQrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:47:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:33931 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeLUQrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:47:12 -0500
Received: by mail-io1-f67.google.com with SMTP id l22so955364ioh.1;
        Fri, 21 Dec 2018 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUjco7J9kVWuEfPsjLIgKKLiymgsurbAHnLXr7sZ6O0=;
        b=tmP2cPVV2u3STrgGDuN/pG2HgtJmDKYMPneQS7/lThIqWz1wtIYmu+GWttDdyBwyHA
         +b+P9PP0gZCeMgaHd88Kdg5HvvltK6oDdDuMNQacckUR2P+yFv6e8Lpgb9+Ps2TpT406
         aDFS/TD8891aXRbuXU3VpzeSvrH8L8kwU4og0p2tA/YRDyQXzMSKCbXGxpodxJfHSQVk
         XSWl9CzN7Rn7fCk7QI9Ak1v37kbywMW9id4u3ArtidNLGm8rMuqjlZ2fjBMyN4GPN1g0
         5QWZXnUa1jFWX7MiehirD8KMVDbB6hObFpH4RbBDvEKG3zl/efnfgWIYu93hYBwFZ7yl
         0G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUjco7J9kVWuEfPsjLIgKKLiymgsurbAHnLXr7sZ6O0=;
        b=LuAg3RS4+b3r9Ed57dwd5EUDJljnhTHHgdR8Fn5DMcJ1f/GtqTFjaSydnMtqVByfPN
         IwJ5xW8prLCz6UXCf/y3RDARxciV7ruB6Xgrh0+lvRn7l+Yoq1IvN9eMhLt1i237PsmY
         BBqlhPDyg9iUHzwIDofDngQ3jwap50cb2AGb7h8GwLfGrWLRkRB9uCo7uOjbdzu6xiMX
         FNGWjIlFjO/Z7eCbhe9oUgy0WqItMQlgvxhtBLrgZ+6uz7DUPSKD+jPnCtNDy9IDhVxH
         aydYeyUcQ6f/3eN4lkUPzCs7prUiJrQLMFZTayx4r1BljIhJGqQxqH95iJsAwcH/n2mB
         E/0w==
X-Gm-Message-State: AJcUukdA2Ebz6O+3ywhSmQAMN/ZFsc3mdEG6Cf8AwV3N9TvZUqNJH/su
        U4ZcQtZlGcC1gKIhPEGujq7MxVAGADnPw7cT2/Y=
X-Google-Smtp-Source: ALg8bN7k9JZrUy6Y8oM5gpnC1jX2d8ehU7gHWhGdi5P+F+AXbPLRmYHbKutdJJ/cIjmxYM5KCfguaZp1h6WUC7Y43kA=
X-Received: by 2002:a6b:d318:: with SMTP id s24mr2115167iob.6.1545410831671;
 Fri, 21 Dec 2018 08:47:11 -0800 (PST)
MIME-Version: 1.0
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOngxbsYFSbK1Y0okuiTmjWEQ8Zcd4vQ0OezhXBgXH82DtA@mail.gmail.com>
 <CAEdQ38FQNC0mnf6UWOeandwR2guLRGmbYaJAo8MrEKFn2U61Gw@mail.gmail.com> <CAK8P3a366UUWv8hXxWFQo9EQs++t5x4N+JmJ5abgD8BP99hECQ@mail.gmail.com>
In-Reply-To: <CAK8P3a366UUWv8hXxWFQo9EQs++t5x4N+JmJ5abgD8BP99hECQ@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 21 Dec 2018 11:46:59 -0500
Message-ID: <CAEdQ38EY3ix6XAwAjY8H4OhFwRcT1Yuvk4ofLa_GVyh5COpkRA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] alpha: system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 12:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 19, 2018 at 4:59 PM Matt Turner <mattst88@gmail.com> wrote:
> > On Fri, Dec 14, 2018 at 10:18 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > On Tue, 13 Nov 2018 at 15:02, Firoz Khan <firoz.khan@linaro.org> wrote:
> > >
> > > Could someone review this patch series and queue it for 4.21
> > > through alpha tree would be great.
> >
> > Thank you! I'll take a look.
>
> Hi Matt,
>
> I see that you merged the changes a while ago into
>
> git://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha#for-linus
>
> This all seems fine, but they never showed up in linux-next,
> which his what had both Firoz and me confused.
>
> Is that intentional, or should it be added there?

Probably so. This is just a super part-time thing for me, so I've
never figured out what I needed to do to be included in linux-next.

> Added Stephen to Cc here in case you want it added.

Thanks!
