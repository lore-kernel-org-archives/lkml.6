Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48251C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165B62080F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaE57+j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeLOU4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 15:56:22 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:43278 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOU4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 15:56:21 -0500
Received: by mail-io1-f52.google.com with SMTP id l3so7161446ioc.10;
        Sat, 15 Dec 2018 12:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxUIYK5jq5UFHGA9uu0rZ7mZo30FH8h4myjB1K/gJPk=;
        b=EaE57+j5uiOByuwN6hqdu1RyKysSVPETULK74LbAvzHx9c3ARjSCow5D3a7EBWh+Ri
         zJJ4pQQ5az5tbEa70GAw8ejjYnYFu9cPkcCCAE86IiYPbqb7SEQRbPU+1/H3YX4+pDC4
         3TTzM+uRMvUv+rEOZG+zcykyjUMDpfufsvONSMY09uRjn1H+OG91HHzfkHawe3wWMrIe
         JMmkE5onTp/Ge+GVfU/A1yzzE3yz8VUAGMGMj3JZGoPMRRVRx/9qWgVqRvNDFycaDRxy
         a+nSG2FzC5qi/cNws9yu2dsPCw2d/cba/InvuOWzdDuVuK1LwphU8Xu64Ejqal8Bzkee
         vx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxUIYK5jq5UFHGA9uu0rZ7mZo30FH8h4myjB1K/gJPk=;
        b=aNZR8a1kfqD1yV/E9uZtiKxZ6tz9pbGKdgLV0SoZmngUCjrnFJ43BU5zjdjjMnSKxW
         rYoVDG+64fkQDgZbnX15zxgFIM058PCLp8Eety0/vMXztBUZRcZb6A/9NP+aH2/nzHv4
         g584GPh1shRNiNjZsLbRiuO0onjUe8hyelBMwg/ZYevwExOQ1D/gD8xeWaN1AbCJ+ak5
         OQce1kUnvRsbJrEIdGm+yB7o4nK8/76cSinA86Gb4jHLVF6D4d43D8DaUw74wXATWpDu
         N5xQ8hJnpKCkqayPIYUhX3yFHjyxw28L/PyoiCaric95lnhPs898VPxWbOrOhfRwAz99
         ZNeg==
X-Gm-Message-State: AA+aEWYGLTrdpeQh76y9NruOI8ijki8oUN5vmql1gmnCw/O4Qi0WmT4e
        7FdAgCf5ij2VuGkqqS7dKPNC39wHu61OTgBcSbs=
X-Google-Smtp-Source: AFSGD/XizO6+SosvWysC4HJY/uLigM+kNpJUHJrJa7Z+a4hSMTmMfRrE3hAkm9ZRP7SVtvFZ19fQtRcMN1GGkX0FkMQ=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr7176331ioa.34.1544907380181;
 Sat, 15 Dec 2018 12:56:20 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com>
 <20181211202520.16799-7-deepa.kernel@gmail.com> <CAF=yD-LDWrjxK+XFv-KNAoyP7NCOZiL00n5PkzQ-5aEzq+eCLQ@mail.gmail.com>
 <CABeXuvpAZfd6gAdJbKxsOowXnDnwyQQRuYMJ-6LDo9BsRDDj-g@mail.gmail.com>
 <CAF=yD-L4xTU-KXsQ=uU36fEKv5St=69mmKqT8sD1mAmT_hfuVQ@mail.gmail.com>
 <CABeXuvqrZgEDF5RYQEPJ8RyXDg0uvXx_qMq=2ER8Bc9RXFPDGQ@mail.gmail.com> <CAF=yD-KFYdXRgL-HpAJLLHuywMcaBGfz7sDL35DBNs0hoq+zxQ@mail.gmail.com>
In-Reply-To: <CAF=yD-KFYdXRgL-HpAJLLHuywMcaBGfz7sDL35DBNs0hoq+zxQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 15 Dec 2018 12:56:07 -0800
Message-ID: <CABeXuvr7je=LG9+xO286b7HH2WNLSfoOL4V6nN0AkjsGr_SoCQ@mail.gmail.com>
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

> > Also for the other comment. The reason the conditionals were not
> > consistent is because they were not consistent to begin with.
>
> The only difference I see is an inversion of the test. Nesting order
> is the same:
>
>         int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
>         ...
>         if (need_software_tstamp) {
>                 if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                 } else {
>                 }
>         }
>
> vs
>
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>                         if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                         } else {
>                         }
>                 }
>
> I suggest just adding something like
>
>         if (need_software_tstamp) {
> +              if (sock_uses_new_tstamp(sk) {
> +                   __sock_recv_timestamp_new(msg, sk,
> ktime_to_timespec64(skb->tstamp));
> +              } else if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> -               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                 } else {
>                 }
>
> and
>
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
> +                      if (sock_uses_new_tstamp(sk) {
> +                           __sock_recv_timestamp_new(msg, sk, ts);
> +                      else if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> -                       if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
>                         } else {
>                         }
>
> I think we can use the same helper for both the sock and tcp variant.
> The only intended difference between the two functions, as described
> in the tcp_recv_timestamp function comment, is the absence of an skb
> in the tcp case. That is immaterial at this level.

I will just not refactor things into a function: __sock_rescv_timestamp_new().
I will just add new conditionals for the new timestamps.
When you guys refactor the other timestamp stuff like you mentioned
below maybe you can move the new timestamps to a new funtcion as you
see fit.

The helper functions in skbuff.h might first need to be refactored
first. But I again leave this to you guys.

> Note also (2) tentative helper function sock_uses_new_tstamp(const
> struct sock *sk) instead of testing sock_flag(sk, SOCK_TSTAMP_NEW)
> directly. Since the .._NEW variants are equivalent to .._OLD on 64-bit,
> I wonder if we can just compile out the branch. Something like
>
>     static inline bool sock_uses_new_tstamp(const struct sock *sk) {
>             return (sizeof(time_t) != sizeof(__kernel_long_t)) &&
>                        sock_flag(sk, SOCK_TSTAMP_NEW);
>     }
>

You could just ifdef CONFIG_64BIT if you are worried about branching.
Note that SO_TIMESTAMP is by default SO_TIMESTAMP_OLD on 64 bit machines.
But, I will again leave the optimization to you. I will implement in a
straight forward way and you guys can deicde how you want to optimize
the fast path or what should it even be.

-Deepa
