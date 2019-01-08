Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BFEC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B1F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0+x7bHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfAHNqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:46:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33737 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfAHNqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:46:52 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so4313225eds.0;
        Tue, 08 Jan 2019 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHgzhP9K7K8m1D/XNz3T2VgzBVdxwCI7I+qk/Fabdtw=;
        b=h0+x7bHJJn/ukkZ0v+7g7sfQi+ulVssNYRwbR7VtjIziZ4oCzCrkA11nOLjZZ4uO2U
         yOzsa7IZ1Mu5kHI/skzGmSixYjhvz4HJn2dPha21Y5X7FfqhkZ7sTqX+n5Ljt8wpEov/
         t/eLxHFvavrlkei/Sb66f5D5vFhH8lGUfFxunt5HzmqJgcYP1y344KKoiuy8EKOJ2KGm
         4S9bSHSRkDNh3uG7Y2cvMwcEr6eblaked4c73HffVoGT+0x0G4k5oeh/kQ0W3zgvNhJW
         mjFYyITbTptuu2GbuOOunYEqDkbd2gBX41KlzhajqUVZPV+R5OWO/mGacAxjpCiMnBi5
         Y8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHgzhP9K7K8m1D/XNz3T2VgzBVdxwCI7I+qk/Fabdtw=;
        b=dw2BYEEiXgK3HGP3LHNCsvc8SM7aLM7k0KE2YOAJy0LScjPxQJBDOHXi2uSrtN8x4q
         0eXuKFdLzA82rb1MVIVdTt8J5LKJ5TLvP9o5f41j42ZcYVTCAcucy34wfs+d12Xlc1sh
         mXbKkFAU5B+q6sgI7yCiotUIy29YYfD+tZfPkNXqKV69Bkj3oY3qHqRcKoKbp/uAgrVb
         tTVgjSPXhId8KJ85dade9lMPoaiCdOBbV2cNM5FGPHLsfM3kEGX+1C6+Udq1ibCnoDSI
         uu+GB8DyDG1xcNIDrkdYHhJfBg6n94nk8lKAKmCfE/4xGGmvCZk84fkSTfxiSZMKjwZh
         b7hg==
X-Gm-Message-State: AJcUukcMGF1uez75sqoQ0XTKI2Nvzn84MO1JzSzLuJDFWqXT7/br1Gu5
        EarF8UgSHFpBWxQ9hj+OkVGdRIyTsIjf0NoY6Os=
X-Google-Smtp-Source: ALg8bN4SNRxCowKEzmbXSYaGDrCqhghOMyJ95G5ZWI+nLOdcVlUlZUZtmYEP1TTKQXzN2gcl4odkjkXiQiaVnXZUSQw=
X-Received: by 2002:aa7:dace:: with SMTP id x14mr2234851eds.13.1546955209723;
 Tue, 08 Jan 2019 05:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20190108032657.8331-1-deepa.kernel@gmail.com> <20190108032657.8331-7-deepa.kernel@gmail.com>
In-Reply-To: <20190108032657.8331-7-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Jan 2019 08:46:13 -0500
Message-ID: <CAF=yD-LDd0jOgFPQWNSw_h7vMJ+tMB+G+ZS67ZZFKOJc4oFFrQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] socket: Add SO_TIMESTAMP[NS]_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
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

On Mon, Jan 7, 2019 at 10:29 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Add SO_TIMESTAMP_NEW and SO_TIMESTAMPNS_NEW variants of
> socket timestamp options.
> These are the y2038 safe versions of the SO_TIMESTAMP_OLD
> and SO_TIMESTAMPNS_OLD for all architectures.
>
> Note that the format of scm_timestamping.ts[0] is not changed
> in this patch.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: jejb@parisc-linux.org
> Cc: ralf@linux-mips.org
> Cc: rth@twiddle.net
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-rdma@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: sparclinux@vger.kernel.org

> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 00e45c80e574..352e3dc0b3d9 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -3,6 +3,7 @@
>  #define _UAPI_ASM_SOCKET_H
>
>  #include <asm/sockios.h>
> +#include <asm/bitsperlong.h>
>
>  /* For setsockopt(2) */
>  /*
> @@ -110,12 +111,22 @@
>
>  #define SO_TIMESTAMP_OLD         29
>  #define SO_TIMESTAMPNS_OLD       35
> +

nit: unnecessary whitespace line

> @@ -1864,20 +1864,39 @@ static void tcp_update_recv_tstamps(struct sk_buff *skb,
>  static void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>                                struct scm_timestamping *tss)
>  {
> -       struct __kernel_old_timeval tv;
>         bool has_timestamping = false;
> +       int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
>
>         if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>                         if (sock_flag(sk, SOCK_RCVTSTAMPNS)) {
> -                               put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_OLD,
> -                                        sizeof(tss->ts[0]), &tss->ts[0]);
> -                       } else {
> -                               tv.tv_sec = tss->ts[0].tv_sec;
> -                               tv.tv_usec = tss->ts[0].tv_nsec / 1000;
> +                               if (new_tstamp) {
> +                                       struct __kernel_timespec kts = {tss->ts[0].tv_sec, tss->ts[0].tv_nsec};
> +
> +                                       put_cmsg(msg, SOL_SOCKET, SO_TIMESTAMPNS_NEW,
> +                                                sizeof(kts), &kts);
> +                               } else {
> +                                       struct timespec ts_old = tss->ts[0];

nit: intermediate variable not needed as tss->ts[0] is also of type
struct timespec.
