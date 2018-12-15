Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBF2C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6427A206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2wouQXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbeLOBHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:07:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35470 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLOBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 20:07:31 -0500
Received: by mail-io1-f65.google.com with SMTP id o13so5919412ioh.2;
        Fri, 14 Dec 2018 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TiFeAR+gXonspDtobNBEyWJOfkBdqNTcEQRPyHH6Us=;
        b=M2wouQXUzfnRChoeEgWx0WVO3+FYFLad2sEV3iW9wa9ZY+BlA76xCyeRrHBN2EspZA
         WwNQI+wFPBXSvaMm/IHwljtQXJuigadLCCRWavIz+nj+J+D/2+SwmRfmtevxBO11/8sM
         DHRNZBJ6MOMudJwVZ+mKtPFAYQOf/yKT5vd/2imI7UbttIJ0Wa1yOYxyEafXUxU+QmWW
         eIDF4Vi/wCnFK4Qa58QdTG/OX7QSYkEmYzduMDYutmyw6MnhEgvCU06AJ1G/POhqr0gE
         yyVkn1r1Ci5TZpz9w+41Fwp13s+O2lNxu1nwMnLlyLgVZfr4bASTVHEE27VXOOhQOwNF
         Oq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TiFeAR+gXonspDtobNBEyWJOfkBdqNTcEQRPyHH6Us=;
        b=ZWkrpcQIvQSdefnlbtR3ILpMcJE1zdiynC2nC1Rd+VZe+RKG8h8Ny9PCO19Nk06naZ
         d1BQ/aLvziAT3kRVw/nXcKLBTMgA+kZ4GaAJakB2kV3RueRiT4m3leT2anmkKi3QtYoX
         wta4nmfa5bjajP29zDr/qjxAy8Kl0eBoqHeD0VMLft3TtVKivn7xveoxSojktLVE1bZi
         goqVdOfk22KXgN6WqXqrIbux90Cr20hDMJXBOzRPMBB9YHMf5nVxLpBDq7q867KgyM2y
         iAsMaG7t6TMbxV4KlS3UBBVLrKzmOFtAj8zVt8KlwXZSt+MkRLmjoJ6YSUBmcLwwt+FO
         i+mw==
X-Gm-Message-State: AA+aEWadnZkOPi0W7eT+NE6PNlO9JPorLmnuK0PO2kZL9CUy1YE/jWFD
        z9QNoql2YVpEvGkBGSoP9zYVaJGzqUROQ2W5nV4=
X-Google-Smtp-Source: AFSGD/XNFPwhxPEPFW5cm0PfP8DOgtnRudWwxdFYn9W5uwmQXm9erAAPa3f2DPoR6oXRriUrrcFqzccjtJ+cp4qOdgM=
X-Received: by 2002:a6b:8b4e:: with SMTP id n75mr4007937iod.184.1544836049910;
 Fri, 14 Dec 2018 17:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
In-Reply-To: <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 14 Dec 2018 17:07:17 -0800
Message-ID: <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ralf Baechle <ralf@linux-mips.org>, rth@twiddle.net,
        linux-alpha@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-rdma@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> > index 00e45c80e574..352e3dc0b3d9 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -3,6 +3,7 @@
> >  #define _UAPI_ASM_SOCKET_H
> >
> >  #include <asm/sockios.h>
> > +#include <asm/bitsperlong.h>
> >
> >  /* For setsockopt(2) */
> >  /*
> > @@ -110,12 +111,22 @@
> >
> >  #define SO_TIMESTAMP_OLD         29
> >  #define SO_TIMESTAMPNS_OLD       35
> > +
> >  #define SO_TIMESTAMPING_OLD      37
> >
> > +#define SO_TIMESTAMP_NEW         62
> > +#define SO_TIMESTAMPNS_NEW       63
> > +
> >  #if !defined(__KERNEL__)
> >
> > -#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > -#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > +#if __BITS_PER_LONG == 64
> > +#define SO_TIMESTAMP           SO_TIMESTAMP_OLD
> > +#define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> > +#else
> > +#define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
> > +#define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
> > +#endif
> > +
>
> This is not platform specific. Perhaps it can be deduplicated. The
> interface expects callers to include <linux/socket.h>, not
> <asm/socket.h> directly. So perhaps it can go there?

I'm not following what you are saying here.

Are you talking about in kernel users or userspace interface?

Userspace should always include sys/socket.h according to the man page.
I'm not sure if userspace can even include linux/socket.h directly.
On my distribution this includes bits/socket.h which in turn includes
asm/socket.h.

Which file gets installed as asm/socket.h is defined per architecture
in the kbuild file such as
arch/ia64/include/uapi/asm/Kbuild (without series applied):

 generic-y += poll.h
 generic-y += sembuf.h
 generic-y += shmbuf.h
 generic-y += socket.h

Also the new timestamp numbers being added are not the same for all
architectures.

So I'm not sure how this can be moved to linux/socket.h.

> This did not address yet the previous comments on consistency and
> unnecessary code churn.
>
> The existing logic to differentiate SO_TIMESTAMP from SO_TIMESTAMPNS
> in both tcp_recv_timestamp and __sock_recv_timestamp is
>
>   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>       if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>           /* timespec case */
>       else
>           /* timeval case */
>   }
>
> A new level of nesting needs to be added to differentiate .._OLD from .._NEW.
>
> Even if massively changing the original functions, please do so
> consistently, either
>
>   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>       if (sock_flag(sk, SOCK_TSTAMP_NEW) {
>           /* new code */
>       } else {
>           if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>               /* timespec case */
>           else
>               /* timeval case */
>      }
>   }
>
> or
>
>   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>       if (sock_flag(sk, SOCK_TSTAMP_NEW) {
>           if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>               /* new timespec case */
>           else
>               /* timespec case */
>       } else {
>            if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>                /* new timespec case */
>            else
>                /* timespec case */
>       }
>   }
>
> But not one variant in one function and one in the other.
>
> Deep nesting is hard to follow and, once again, massive code changes
> (even indentations) make git blame harder to use. So where possible,
> try to avoid both and just insert a branch to a new function for the
> .._NEW cases instead:
>
>   if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> +      if (sock_flag(sk, SOCK_TSTAMP_NEW)
> +          __sock_recv_timestamp_new(..);
> -      if (sock_flag(sk, SOCK_RCVTSTAMPNS))
> +      else if (sock_flag(sk, SOCK_RCVTSTAMPNS))
>           /* timespec case */
>       else
>           /* timeval case */
>   }
>
> and leave the rest of the function unmodified.

Ok, I will keep the functions consistent.

-Deepa
