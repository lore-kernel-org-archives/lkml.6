Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E9C04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5A20865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjorkavK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F5A20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeKYPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 10:08:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46593 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeKYPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 10:08:13 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so13075230edt.13;
        Sat, 24 Nov 2018 20:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=peBHLQfMZprZ7Y8obIOHLEWYp3Ixk/YUySRgAo0Jafw=;
        b=NjorkavKui9Tc7buhACLon/lY1784aUUvSYflHH+QPFX8yqDS6zSJEeeIkPW/eqAb+
         /XTfFxzVG02YA3LbBnv8xXF2x3eQGCUgXH9G1rmR3PxMBOK7TRdTk0GMJfn5itImNOym
         Xp+alG1ykMs38TNqe1LlJKPdaVabnfpGDyROppKmXzTx4Wkp31ZbJ+kkuvIsXyq9umM0
         5rTL4qlsrJ8uOEOAPy3yFffyyIUlA5f3hJcHZbstrD5sx+H3yuhYo6E6uhok+p//g8+h
         EJhkJguTrr6l/8stGIAo8jxAmWHOFu9/Tjh+nEE/AFVG4KJK71Y6fHTSNhQe5tYauyCP
         Aunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=peBHLQfMZprZ7Y8obIOHLEWYp3Ixk/YUySRgAo0Jafw=;
        b=twwbQd2L3HZyZjeJbVj3ZYBHanIwm91Dlk7zjmm8s4BPe0IincGuyDX8WVCdPjA4Hl
         l1nd/f6DUrqLTVYHqRBdq7dmeU1DLTDBii15MWdiXatyaQXgzBwR9NNfzQzDXBJ/rKZp
         IU5xQzmmhn/XxTPrFK2fR+sQZ1lSUo4uDcHyR7euKauc4N6Kda2ShdHWnuCHD5I+BaAj
         RYB2juSvtv8PiOqEHCVKavgUCXkGV6iGJdKd3i69lMjx8tIheE5BwvQGgSw08mKAyPaO
         q4Wxg94WlgCBnXIn9FyPeZDmSH9SOB5W7t53O8C8uSz3RliDxSLIyk+p4HWwmfzcbAQM
         LOzw==
X-Gm-Message-State: AA+aEWaZOd1qMLXSZOctKHVHogsFM0bEKXyB+lJYtPjlCJDhzrpDdgla
        HvTXBImyaUFo+gyoW4HdVRZK9rMYzRP80O9tRQc=
X-Google-Smtp-Source: AFSGD/WFxCqokbbTRO6Hk8K9wcilVroJIfm/Lok7h/4afEenadq1vGvymFhQe8/+ZimaS+/sLdCfXU8DeE36FK40u8M=
X-Received: by 2002:a50:b31c:: with SMTP id q28mr18322945edd.241.1543119482776;
 Sat, 24 Nov 2018 20:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-8-deepa.kernel@gmail.com> <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
In-Reply-To: <CAF=yD-K=ZLZ_S=Y6YnhvvkfKQS=21ujwiGd7+JB9yDMtiX_9hg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 23:17:25 -0500
Message-ID: <CAF=yD-K3Ga8qojSh5Epa6m4EYn-Lvdo=e38MnFqOKch1128VHw@mail.gmail.com>
Subject: Re: [PATCH 7/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        jejb@parisc-linux.org, ralf@linux-mips.org, rth@twiddle.net,
        linux-alpha@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 10:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
> > socket timestamp options.
> > These are the y2038 safe versions of the SO_TIMESTAMP_OLD
> > and SO_TIMESTAMPNS_OLD for all architectures.
> >
> > Note that the format of scm_timestamping.ts[0] is not changed
> > in this patch.
> >
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> > Cc: jejb@parisc-linux.org
> > Cc: ralf@linux-mips.org
> > Cc: rth@twiddle.net
> > Cc: linux-alpha@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-parisc@vger.kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Cc: sparclinux@vger.kernel.org
> > ---
>
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8143c4c1a49d..9edf909dc176 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -801,6 +801,7 @@ enum sock_flags {
> >         SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
> >         SOCK_TXTIME,
> >         SOCK_XDP, /* XDP is attached */
> > +       SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>
> sk_flags is getting exhausted. Commit b9f40e21ef42 ("net-timestamp:
> move timestamp flags out of sk_flags") added a new u16 sk_tsflags
> specifically for timestamps. That may be a better choice here, too.
>
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index e60036618205..7b485dfaa400 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -652,15 +652,23 @@ static void setsockopt_timestamp(struct sock *sk, int type, int val)
> >         if (!val) {
> >                 sock_reset_flag(sk, SOCK_RCVTSTAMP);
> >                 sock_reset_flag(sk, SOCK_RCVTSTAMPNS);
> > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> >                 return;
> >         }
> >
> > +       if (type == SO_TIMESTAMP_NEW || type == SO_TIMESTAMPNS_NEW)
> > +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> > +       else
> > +               sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> > +
>
> if adding a boolean whether the socket uses new or old-style
> timestamps, perhaps fail hard if a process tries to set a new-style
> option while an old-style is already set and vice versa. Also include
> SO_TIMESTAMPING_NEW as it toggles the same option.
>
> > diff --git a/net/socket.c b/net/socket.c
> > index d3defba55547..9abeb6bc9cfe 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -699,6 +699,38 @@ static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb)
> >                  sizeof(ts_pktinfo), &ts_pktinfo);
> >  }
> >
> > +static void sock_recv_sw_timestamp(struct msghdr *msg, struct sock *sk,
> > +                                  struct sk_buff *skb)
> > +{
> > +       if (sock_flag(sk, SOCK_TSTAMP_NEW)) {
> > +               if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > +                       struct sock_timeval tv;
> > +
> > +                       skb_get_new_timestamp(skb, &tv);
> > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_NEW,
> > +                                sizeof(tv), &tv);
> > +               } else {
> > +                       struct __kernel_timespec ts;
> > +
> > +                       skb_get_new_timestampns(skb, &ts);
> > +                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> > +                                sizeof(ts), &ts);
> > +               }
> > +       }
> > +       if (!sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> > +               struct __kernel_old_timeval tv;
> > +
> > +               skb_get_timestamp(skb, &tv);
> > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMP_OLD,
> > +                        sizeof(tv), &tv);
> > +       } else {
> > +               struct timespec ts;
> > +
> > +               skb_get_timestampns(skb, &ts);
> > +               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> > +                        sizeof(ts), &ts);
> > +       }
> > +}
> >  /*
> >   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
> >   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> > @@ -719,19 +751,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> >                 false_tstamp = 1;
> >         }
> > -       if (need_software_tstamp) {
>
> Considerably less code churn if adding __sock_recv_timestamp_2038 and
> calling that here:
>
>                    if (sock_flag(sk, SOCK_TSTAMP_NEW))
>                            __sock_recv_timestamp_2038(msg, sk, skb);
>                    else if ...
>
> Same for the tcp case above, really, and in the case of the next patch
> for SO_TIMESTAMPING_NEW

That naming convention, ..._2038, is not the nicest, of course. That
is not the relevant bit in the above comment.

Come to think of it, and related to my question in patch 2 why the
need to rename at all, could all new structs, constants and functions
be named consistently with 64 suffix? __sock_recv_timestamp64,
SO_TIMESTAMPING64 and timeval64 (instead of sock_timeval,
it isn't really a sock specific struct)?

I guess that there is a good reason for the renaming exercise and
conditional mapping of SO_TIMESTAMP onto old or new interface.
Please elucidate in the commit message.
