Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E1BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F362087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJ8oRlkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F362087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJIV3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:29:30 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51905 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbeJIV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:29:30 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so2810712itw.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZKEA8iSBgjK4ckiRdSruGBtaPbqaH+9W4Nc1s97l7c=;
        b=BJ8oRlkk/f+7UGOvzxK9z7TgYRjF9P9jwYbSyvNeMnRDC+cRzi6gmuFTiXhlBgyV5B
         BXpUExJF6mBub8dHTPWn8sIk3LKBTxdwVzDsgl/KofC4u9yw+0McW/x9f690dg1bnsBS
         Zvkeg8tkBZhQwP522lxTBKsYujmqn4Fj1xDFegzG5fICGwfIi9x5oLs6cbl2uklqAIxS
         Cn6yXO8zzD2RTMEFYXAqem6z6/FuT9zR6hJAYReQI7j6LUNYugUfcxB1vlWhlX1TSoke
         FyU5ac7XcnGNuVtiKI8wxQSPgVomMMk8886LrH6E1bvbJoJLDY6P7eaYx7P2MgJvRDs/
         te9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZKEA8iSBgjK4ckiRdSruGBtaPbqaH+9W4Nc1s97l7c=;
        b=daE5pQ1gx+08AKKVK+BRJCL5Hr4Qu2jTZFQyASkd79SJgWUuVwFyb2KN3Gf0v9DW7z
         cI2Rqt2ideptRBDQvxtgvmIF+1gnmFGjMAXbbWxfB2j3uRi8WRXbkgbq1+54KxkeT9MW
         QToVtBDdhRfcRUhOHa30jHBBNmcmw6OcEGTk/jxryvuiPrLTDerhkA4aVOrX0jRRi6P3
         S5IrDftJMzh/wFvZog6tvTn4jX2gtURFtE2rgUFEwN8xplP6GDuR/UPhu5VPkb+iuNll
         TF7aoW+OIzQaL5VwAi2NCzoa0gne1NQ3hBDdAvQANjO+sOLn6aFIlKxu+/wfGR9tinIo
         /lEw==
X-Gm-Message-State: ABuFfojVrQm5cMsCkZ829ha5b3wa+eZiYn2U/K1vSJusOevFcu/KiqeY
        Bn0TfZjdOk9HgU/l7D5RkrEYjqHnw9HC9QugWKiOeA==
X-Google-Smtp-Source: ACcGV60rgrbhoF/R4vQIFynZxsyd7gCB+SiHm02aVqzeMVYld1XBnL3oNSSryqAoSRPup6pEMcXYUG2cjueYkElAM2M=
X-Received: by 2002:a24:6486:: with SMTP id t128-v6mr1861870itc.136.1539094341234;
 Tue, 09 Oct 2018 07:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <1539086718-4119-1-git-send-email-laoar.shao@gmail.com> <1539086718-4119-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1539086718-4119-2-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 9 Oct 2018 07:12:09 -0700
Message-ID: <CANn89iL1BMCx3Mbsj3TijR3Srjji95q86px0k98r7JYJbwLzcw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: forbid direct reclaim if MSG_DONTWAIT is
 set in send path
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 5:05 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> By default, the sk->sk_allocation is GFP_KERNEL, that means if there's
> no enough memory it will do both direct reclaim and background reclaim.
> If the size of system memory is great, the direct reclaim may cause great
> latency spike.
>
> When we set MSG_DONTWAIT in send syscalls, we really don't want it to be
> blocked, so we'd better clear __GFP_DIRECT_RECLAIM when allocate skb in the
> send path. Then, it will return immediately if there's no enough memory to
> be allocated, and then the appliation has a chance to do some other stuffs
> instead of being blocked here.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 43ef83b..fe4f5ce 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1182,6 +1182,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>         bool process_backlog = false;
>         bool zc = false;
>         long timeo;
> +       gfp_t gfp;
>
>         flags = msg->msg_flags;
>
> @@ -1255,6 +1256,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>         /* Ok commence sending. */
>         copied = 0;
>
> +       gfp = flags & MSG_DONTWAIT ? sk->sk_allocation & ~__GFP_DIRECT_RECLAIM :
> +             sk->sk_allocation;
> +
>  restart:
>         mss_now = tcp_send_mss(sk, &size_goal, flags);
>
> @@ -1283,8 +1287,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>                         }
>                         first_skb = tcp_rtx_and_write_queues_empty(sk);
>                         linear = select_size(first_skb, zc);
> -                       skb = sk_stream_alloc_skb(sk, linear, sk->sk_allocation,
> -                                                 first_skb);
> +                       skb = sk_stream_alloc_skb(sk, linear, gfp, first_skb);
>                         if (!skb)
>                                 goto wait_for_memory;


How have you tested this patch exactly ?

Most of TCP payloads are added in page fragments, and you have not
changed the page allocation fragments.

Also, I do not see how an application will get future notifications
that it can retry the failed system call ?
How are you really going to deal with this in high performance applications ?

I would rather prefer a socket setsockopt() to eventually be able to
flip __GFP_DIRECT_RECLAIM in sk->sk_allocation,
to not add all these tests in fast path, but honestly I do not see how
applications can really make use of this.
