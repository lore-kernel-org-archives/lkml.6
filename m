Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18765C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9F20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsZocwpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF9F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeHaRqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:46:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33420 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbeHaRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:46:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id d8-v6so1019241edv.0;
        Fri, 31 Aug 2018 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUCftkCp6Jqh9Z2Jl/NP6xX//9GoNgfFRLIXsUhDty4=;
        b=lsZocwpXQPd4uVtlg4Vpmdcbyh+PCVXIBI4FRY9vVUPqa89Qjumy6PlIo3nGSDKYqj
         2E1u5Fmb4eI0C5i5nv6kzgDrAaaHmJHpggGRcsPG+Bh5SSou9HdECDYWDUHgUp+WUCQp
         p12DvK8o4L+T5Hse/7Va9JpJYFyDj+585SnPUdDmDPjKDe/pP1pLGDocx3v8GJ+jAqyc
         7Q+g6/ei88MRyBSTa6y6MGbWcFaN+ojxVYMQHRZyUfqb1SxDaYTCj3QJeDGsZdC5wlzM
         hsuyqq9F4f0bA1Ui6+Aitb/TYZFYiIvcaoF5eSudVKdF5vU7szmlEOHTN8pKynmIZG2C
         edog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUCftkCp6Jqh9Z2Jl/NP6xX//9GoNgfFRLIXsUhDty4=;
        b=BKyLtYDaWFIALdi+UzRoXl0QaprGYZM872wwxlZGzcD8Bc7PwtShJWBJwP5WSRmlX/
         cx+bhNouLKCzlbkuYIRO/CDIbfDbQ7bvUXaI4czWmXfielGW7e7k5ZGiLcVxYWjWnsbO
         PYJK1+np3+MK2VcEEVmifWBBBIDYHETzj0a2E2PA5gx19z/k5cKmEe5QB0PhJ1pe2s1v
         W9hEXnA9n4VAhKnkwov0aQrVb+XR2J3ho3NS4MU0gIQGNtmPHMCLXgkl77Vzb8UkZ0fl
         uCg/nb8ltcxJ5JfRXYa7rTMWeyW2nDX/5TsKKo2b68ZRRwmh8DVQ4EqpCrBGRyTjPjhP
         jT6A==
X-Gm-Message-State: APzg51AJDQI+fq52vTuQ6vdfQ2XApL2xu5ZSh7LEJJ3VPTeuQVTGaYpV
        DylHDBhOcMXJbgyjUNHPJ/lVeDvmqBq8sUfq3nRdDw==
X-Google-Smtp-Source: ANB0Vdaol25RdiBlDH2OC1ZweoWvkSNdvaHF1CwOm87m6V2C1B5YpJehXB/knyT9oKQmcsLIu7abTRvnksA7qZwtIHg=
X-Received: by 2002:a50:aa83:: with SMTP id q3-v6mr18298780edc.64.1535722714897;
 Fri, 31 Aug 2018 06:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180829130308.3504560-1-arnd@arndb.de> <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
 <CAK8P3a2XTUZJUqGu6v=SZqcoJTqM3fgtDAWBnBopX3=4NJYcRA@mail.gmail.com>
In-Reply-To: <CAK8P3a2XTUZJUqGu6v=SZqcoJTqM3fgtDAWBnBopX3=4NJYcRA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 31 Aug 2018 09:37:57 -0400
Message-ID: <CAF=yD-+9yc838Y_DO1S4HsBpLrBk8iNt0oAj1ceO1S6sE+tCdg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Network Development <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
        dccp@vger.kernel.org, linux-wpan@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 6:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 30, 2018 at 10:10 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Wed, Aug 29, 2018 at 9:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> > > socket protocol handlers, and all of those end up calling the same
> > > sock_get_timestamp()/sock_get_timestampns() helper functions, which
> > > results in a lot of duplicate code.
> > >
> > > With the introduction of 64-bit time_t on 32-bit architectures, this
> > > gets worse, as we then need four different ioctl commands in each
> > > socket protocol implementation.
> > >
> > > To simplify that, let's add a new .gettstamp() operation in
> > > struct proto_ops, and move ioctl implementation into the common
> > > sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> > > through.
> > >
> > > We can reuse the sock_get_timestamp() implementation, but generalize
> > > it so it can deal with both native and compat mode, as well as
> > > timeval and timespec structures.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This also will simplify fixing a recently reported race condition with
> > sock_get_timestamp [1]. That calls sock_enable_timestamp, which
> > modifies sk->sk_flags, without taking the socket lock. Currently some
> > callers of sock_get_timestamp hold the lock (ax25, netrom, qrtr), many
> > don't. See also how this patch removes the lock_sock in the netrom
> > case. Moving the call to sock_gettstamp outside the protocol handlers
> > will allow taking the lock inside the function.
>
> I suppose it would be best to always take that lock then, rather than
> removing the lock as my patch does at the moment.

Yes, although that can also be a separate follow-on patch. The
patch as is better matches the existing behavior of the majority
of protocols.

> > If this is the only valid implementation of .gettstamp, the indirect
> > call could be avoided in favor of a simple branch.
>
> I thought about that as well, but I could not come up with a
> good way to encode the difference between socket protocols
> that allow timestamping and those that don't.
>
> I think ideally we would just call sock_gettstamp() unconditonally
> on every socket, and have that function decide whether timestamps
> make sense or not. The part I did not understand is which ones
> actually want the timestamps or not. Most protocols that
> implement the ioctls also assign skb->tstamp, but there are some
> protocols in which I could not see skb->tstamp ever being set,
> and some that set it but don't seem to have the ioctls.

These probably only use cmsgs SCM_TIMESTAMP(NS|IMG)
to read timestamps.

> Looking at it again, it seems that sock_gettstamp() should
> actually deal with this gracefully: it will return a -EINVAL
> error condition if the timestamp remains at the
> SK_DEFAULT_STAMP initial value, which is probably
> just as appropriate (or better) as the current -ENOTTY
> default, and if we are actually recording timestamps, we
> might just as well report them.

Yes, that's a nice solution. There is always some risk in changing
error codes. But ioctl callers should be able to support newly
implemented functionality. Even if partially implemented and
returning ENOENT instead of ENOIOCTLCMD.

> > Acked-by: Willem de Bruijn <willemb@google.com>
>
> Thanks,
>
>       Arnd
