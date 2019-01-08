Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A88EC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26F920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghmn3qhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfAHVTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:19:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38146 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbfAHVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:19:16 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so4322532ioj.5;
        Tue, 08 Jan 2019 13:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ibgn2ja9DPSjoCLaCz4JNN4D7ZA8GQekBZ91JKB3zuA=;
        b=ghmn3qhSlP7NQXplHU42RRnPA1PCepRM28qA+tmdD8QIPpn42XfcYgJN8Rwi1cDe3D
         SgvN0NzowdC26HvIxUfSA4mdckICd4N8QO+65QUa8fY0TT1b3YVk6LMyEh6+OYdWOx3t
         xrzsoYuRPJV99XNn1NFAZrg7gO9hhAdW3NlLBZ24pSktFL2QxLMGiZB/Msxcm7oUiCNG
         YoGF5BuVDUmgSCV7SnNyD4PB4jAS9Noq3wPOdr9jKMeavrJovli4Jd/3ADJqgJbv4tAD
         OxiilpxK9sTU2JaBDgSckTBjULYHv1C2JbWD96FUjt19fkwsFdzGiHGr+6QSlbmVA5MT
         ZgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ibgn2ja9DPSjoCLaCz4JNN4D7ZA8GQekBZ91JKB3zuA=;
        b=RsyZEXh4jIcmUr0+SiLxsJ4YaEo25DM2Tn2OJM4FUcOf5s1I+QllfTRBbVKIyIUBVq
         SO6Rv+KOSyilXtP4nRfhy0gcPigyCLEZRjDC8samUEA65wJLcxMGgujxb8i92i3v6ICC
         T9vjVuYd8tY6kbX38tLDPtSgtLdJaV131/YukF11usXSA5WIiA9pO4+VHwn6hDs3pCay
         i/j6HpMTdeFjsoKF/J7UNRwDGW3qGtEi44EG0BbLipg4HnOp9CMN8J9IVGtvdTN5DV0Z
         qFrU3gYd9aLWMiI+qmWdfJFdKY+zdyo10Gbresbah+KkI6QZapjhn3X6uxTtVJhUZgrk
         WKeQ==
X-Gm-Message-State: AJcUukdfSvpf1KpKM3CnJE4WbiYqgqsg/8xKCHq9eVLdFS0GfItCViJh
        9wqdY4Nn4hQtxRntxKh19d33gGWVD65HcXEWv1c=
X-Google-Smtp-Source: ALg8bN6Tz+pkGgutIWKW1h822b4sZZTiDSM7H9AvKKU1zUDyLSOADmYRLqEl8nWUpneIQlyjD7fIPuzSPw6LlUpgYlM=
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr1997376iod.184.1546982354763;
 Tue, 08 Jan 2019 13:19:14 -0800 (PST)
MIME-Version: 1.0
References: <20190108052255.10699-1-deepa.kernel@gmail.com>
 <20190108052255.10699-3-deepa.kernel@gmail.com> <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
In-Reply-To: <CAK8P3a2T=dWgD1mvi77fbdKEsm=ZUwsQENv-btjhECjf+Y5wcg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 8 Jan 2019 13:19:05 -0800
Message-ID: <CABeXuvptd3G0kZ7K7j78cSGOnxBOkCoDe8Tzhfu4BQcYVtJNPg@mail.gmail.com>
Subject: Re: [PATCH 2/3] socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ccaulfie@redhat.com, Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        cluster-devel <cluster-devel@redhat.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 12:04 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jan 8, 2019 at 6:24 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > SO_RCVTIMEO and SO_SNDTIMEO socket options use struct timeval
> > as the time format. struct timeval is not y2038 safe.
> > The subsequent patches in the series add support for new socket
> > timeout options with _NEW suffix that are y2038 safe.
> > Rename the existing options with _OLD suffix forms so that the
> > right option is enabled for userspace applications according
> > to the architecture and time_t definition of libc.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>
> Looks good overall. A few minor concerns:
>
> The description above makes it sound like there is a bug with y2038-safety
> in this particular interface, which I think is just not what you meant,
> as the change is only needed for compatiblity with new C libraries
> that work around the y2038 problem in general by changing their
> timeval definition.

Right, there is y2038 safety issue, just the libc part that needs to be handled.
I will fix the commit text.

> > diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
> > index 76976d6e50f9..c98ad9777ad9 100644
> > --- a/fs/dlm/lowcomms.c
> > +++ b/fs/dlm/lowcomms.c
> > @@ -1089,12 +1089,12 @@ static void sctp_connect_to_sock(struct connection *con)
> >          * since O_NONBLOCK argument in connect() function does not work here,
> >          * then, we should restore the default value of this attribute.
> >          */
> > -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> > +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
> >                           sizeof(tv));
> >         result = sock->ops->connect(sock, (struct sockaddr *)&daddr, addr_len,
> >                                    0);
> >         memset(&tv, 0, sizeof(tv));
> > -       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, (char *)&tv,
> > +       kernel_setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO_OLD, (char *)&tv,
> >                           sizeof(tv));
> >
> >         if (result == -EINPROGRESS)
>
> It took me a bit to realize there that this is safe as well even if
> we don't use SO_SNDTIMEO_NEW, for the same reason.

Correct.

> > --- a/net/compat.c
> > +++ b/net/compat.c
> > @@ -378,7 +378,7 @@ static int compat_sock_setsockopt(struct socket *sock, int level, int optname,
> >                 return do_set_attach_filter(sock, level, optname,
> >                                             optval, optlen);
> >         if (!COMPAT_USE_64BIT_TIME &&
> > -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> > +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
> >                 return do_set_sock_timeout(sock, level, optname, optval, optlen);
> >
> >         return sock_setsockopt(sock, level, optname, optval, optlen);
> > @@ -450,7 +450,7 @@ static int compat_sock_getsockopt(struct socket *sock, int level, int optname,
> >                                 char __user *optval, int __user *optlen)
> >  {
> >         if (!COMPAT_USE_64BIT_TIME &&
> > -           (optname == SO_RCVTIMEO || optname == SO_SNDTIMEO))
> > +           (optname == SO_RCVTIMEO_OLD || optname == SO_SNDTIMEO_OLD))
> >                 return do_get_sock_timeout(sock, level, optname, optval, optlen);
> >         return sock_getsockopt(sock, level, optname, optval, optlen);
> >  }
>
> I looked at the original code and noticed that it's horrible, which of course
> is not your fault, but I wonder if we should just fix it now to avoid that
> get_fs()/set_fs() hack, since that code mostly implements what you
> also have in your patch 3 (which is done more nicely).

I did think of getting rid of set_fs()/ get_fs() here.
But, I wasn't sure as the maintainers seemed to prefer to leave to the
old code as is in the other series for timestamps.

> I'll follow up with a patch to demonstrate what I mean here. Your third
> patch will then just have to add another code path so we can handle
> all of old_timespec32 (for existing 32-bit user space), __kernel_old_timespec
> (for sparc64) and __kernel_sock_timeval (for everything else).

Cool, I will rebase on top of your patch.

Thanks,
Deepa
