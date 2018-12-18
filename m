Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F35217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgupyvP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeLRVWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:22:18 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41766 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeLRVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:22:17 -0500
Received: by mail-io1-f66.google.com with SMTP id s22so13926451ioc.8;
        Tue, 18 Dec 2018 13:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/VOC0siX+e+IYgW9eSmkOoRCsOcmM+sZ5ka8rYBApo=;
        b=cgupyvP+EkZd8Om/b5DpWBtAJjjve3GOyGg9Yfc9ZxW6BmAo9ImtYSKaRh2aYKEzNY
         1aEJWI59wKEdUkAkvVPFRgvbK6ZK/ZEPgLL2LUCD/+AtBT3jPOQGF5hc9g9xvc/tUjky
         Yzic0m/1pHSNle5Qv3hPFm4aliXJxk0Kzz//MuONDNlnmT3wmjvTsjL2XMBERLlKEXvv
         /m3CledYTyYYzI5tNIzY7BlcI7+OJPKumW6A/o6csvl1SzjRLp46DXV3YZKfJWhcLFJe
         mCPtIzCBIGzKWN13APWw1Gh+TKuDWDDJ7lOyUyo8bjz6Ls3BEnhapWGac+pyE3LEgTu4
         UqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/VOC0siX+e+IYgW9eSmkOoRCsOcmM+sZ5ka8rYBApo=;
        b=qesZMbE5BPj7t7sh2fPiU2nNtg4yutib/UErwWSYKNK5DAHNy6xInOuGoj9fCmtrzK
         xJOrfUwjX+9IqzYeBFkJzm36Jkl4Y45MAadpFZJoAJVIN+QH9Udc03dudDNRHptG4rz2
         oMfSr0PwDM2quV/irR0hSjIsNoGdyJhIwk5I9LhS+lnYlN0tHZd+Ny25PueWM9KpVJLy
         DmMA4JqYztfDR69/bCkYpd9MMFiuHzkP128kUYNZID/Q3Uw/w6RO7orIgxOt3AdRsuO6
         5UM/8PWQvN2bAcruit8DEWS6e3AgFBPtM0rSkuQHhibvFjQ+EE/MIOg9oMdrvqHB+zX+
         ogkA==
X-Gm-Message-State: AA+aEWZ6uDB1csukLjrP9v6cSA0p7ZYmg5yw2osDfzexhY4chpvhxDba
        rDUTOplqi39xhlkfCO83A1GIi6Pa80mpRYBVvxc=
X-Google-Smtp-Source: AFSGD/WCINwxYBADUAmRLLA2ZcI+PEoUO54nJUksunlIglMV5tMK5FMMjARRweh702G6oLCx5jqRZAidHRfkD8YqJ1g=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr16700155ioa.266.1545168136237;
 Tue, 18 Dec 2018 13:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-8-deepa.kernel@gmail.com> <CAF=yD-+mrKfq35g+EVkP-pNbBL=6BvYDdduks=yAxiADSRWvzg@mail.gmail.com>
 <CAK8P3a1xeZsrOv4+xhL5dbi02zfQcPEJvWDzmUNkFKmQubMkSA@mail.gmail.com>
In-Reply-To: <CAK8P3a1xeZsrOv4+xhL5dbi02zfQcPEJvWDzmUNkFKmQubMkSA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 18 Dec 2018 13:22:05 -0800
Message-ID: <CABeXuvofQQ6GoL9TEgaNRkkFE5RDdrWUmkKOPQUP4f9Zg1KBXA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] socket: Add SO_TIMESTAMPING_NEW
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Gleixner <tglx@linutronix.de>, ubraun@linux.ibm.com,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 12, 2018 at 4:25 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > On Tue, Dec 11, 2018 at 3:30 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > > @@ -851,39 +890,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
> > >                 break;
> > >
> > >         case SO_TIMESTAMPING_OLD:
> > > -               if (val & ~SOF_TIMESTAMPING_MASK) {
> > > -                       ret = -EINVAL;
> > > -                       break;
> > > -               }
> > > -
> > > -               if (val & SOF_TIMESTAMPING_OPT_ID &&
> > > -                   !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > -                       if (sk->sk_protocol == IPPROTO_TCP &&
> > > -                           sk->sk_type == SOCK_STREAM) {
> > > -                               if ((1 << sk->sk_state) &
> > > -                                   (TCPF_CLOSE | TCPF_LISTEN)) {
> > > -                                       ret = -EINVAL;
> > > -                                       break;
> > > -                               }
> > > -                               sk->sk_tskey = tcp_sk(sk)->snd_una;
> > > -                       } else {
> > > -                               sk->sk_tskey = 0;
> > > -                       }
> > > -               }
> > > -
> > > -               if (val & SOF_TIMESTAMPING_OPT_STATS &&
> > > -                   !(val & SOF_TIMESTAMPING_OPT_TSONLY)) {
> > > -                       ret = -EINVAL;
> > > -                       break;
> > > -               }
> > > -
> > > -               sk->sk_tsflags = val;
> > > -               if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
> > > -                       sock_enable_timestamp(sk,
> > > -                                             SOCK_TIMESTAMPING_RX_SOFTWARE);
> > > -               else
> > > -                       sock_disable_timestamp(sk,
> > > -                                              (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
> > > +               ret = setsockopt_timestamping(sk, optname, val);
> >
> > Once again a lot of needless code churn. The only functional change is adding
>
> I think moving the code out into a separate function is a useful cleanup,
> but if we want to do that, it may be better done in another patch, to
> make it easier to review.

I already removed this addition of function. I have open coded all the
logic here and in the patch 6.
I will post an update.

-Deepa
