Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB5C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E2B2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx4nfOLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E2B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLLPZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:25:45 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46756 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeLLPZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:25:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so15839684edt.13;
        Wed, 12 Dec 2018 07:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZOA9Q/EwFVBGA2nbJQH+VK3C5raT+In9SRFaanRHI4=;
        b=mx4nfOLH8FWy4SC4UCnDHvBoFEeIcYW6Tf/D3LiTwu7pMOWduE0mc5nyxyL4cCP6R3
         H8ThKR3zCxis8vn+J2/vtuIPbimxprb7VNm2U8s9lluPWvlWcpmrrB+avza9WcKI0pLm
         pip88D0hCXEM5oCIPMmTtOSxxgeNiaZCfPfHQUXWPm9hpmqBEA8yLOvTjsHPcHPt3xli
         3t5CXWOE4VMmyG2GBDFxNF02ZuV98++ZA7PFIKRMSyAsIu4C45WX2xcEPkrYrE/95iKz
         fwnJEIJK4zPJRrh2e223p20i6FIVxMiks3jkfCOFqVKMo9chmt5b+V4UbWNXqEbx1iNO
         muXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZOA9Q/EwFVBGA2nbJQH+VK3C5raT+In9SRFaanRHI4=;
        b=oBCuKXCDgt/fI2ZgD16L/CnMX8NLIZx2Q3/oNikUaxro5Fyy2i5fvHbf2P6He1d5we
         KFJKugfdrF8duA3GsI+kQQdh4OLZylDxrgV5hh2bcqahc1kbYjvu4gc7n6sU5kfYPP37
         rbPRwVSWGOmIX1Rr9qfbkPhWwEx6xrgPu+Uv8tbMUKMtEWVI7Z4rfjBpeLZaqp4hEC2Y
         2Ol/+1YmdEQl8CX7KIP5olhdteUtLXavdwm0zYWir44AUVOEsPmxQAN5+MaOPzFDvbt0
         bMANK5Gq0DaYwQSFglSBQJMVR+x0XqlRjt18TNqIxOistGKc7Wi/+jTKNJFNbcckgtZw
         IHXg==
X-Gm-Message-State: AA+aEWY1CGbk01Ou2VEFhmK3J2FSp6T7mp2EQl3gOC3HKbt3ncJb7yzG
        DrAMr6Ec/239wtQwArhiZYuljYKH1CoDUkzbwaE=
X-Google-Smtp-Source: AFSGD/Vm2cUUzH0BbUxBjzSpyY7eFPjmWHyThnl0rmBMrX6CZWFypItevgGCjNWa5X/g6hnXS0pcxmpBwotPVXhtPgU=
X-Received: by 2002:a17:906:2313:: with SMTP id l19-v6mr15318188eja.204.1544628341340;
 Wed, 12 Dec 2018 07:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20181211202520.16799-1-deepa.kernel@gmail.com> <20181211202520.16799-8-deepa.kernel@gmail.com>
In-Reply-To: <20181211202520.16799-8-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 12 Dec 2018 10:25:04 -0500
Message-ID: <CAF=yD-+mrKfq35g+EVkP-pNbBL=6BvYDdduks=yAxiADSRWvzg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] socket: Add SO_TIMESTAMPING_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>, fenghua.yu@intel.com,
        rth@twiddle.net, Thomas Gleixner <tglx@linutronix.de>,
        ubraun@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 3:30 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD
> for all architectures.
>
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: chris@zankel.net
> Cc: fenghua.yu@intel.com
> Cc: rth@twiddle.net
> Cc: tglx@linutronix.de
> Cc: ubraun@linux.ibm.com
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: sparclinux@vger.kernel.org
> ---
>  arch/alpha/include/uapi/asm/socket.h  |  5 +-
>  arch/mips/include/uapi/asm/socket.h   |  5 +-
>  arch/parisc/include/uapi/asm/socket.h |  5 +-
>  arch/sparc/include/uapi/asm/socket.h  |  8 +--
>  include/linux/socket.h                |  7 +++
>  include/uapi/asm-generic/socket.h     |  5 +-
>  include/uapi/linux/errqueue.h         |  4 ++
>  net/core/scm.c                        | 27 ++++++++++
>  net/core/sock.c                       | 73 +++++++++++++++------------
>  net/ipv4/tcp.c                        | 29 ++++++-----
>  net/smc/af_smc.c                      |  3 +-
>  net/socket.c                          | 15 ++++--
>  12 files changed, 122 insertions(+), 64 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 352e3dc0b3d9..8b9f6f7f8087 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -116,19 +116,20 @@
>
>  #define SO_TIMESTAMP_NEW         62
>  #define SO_TIMESTAMPNS_NEW       63
> +#define SO_TIMESTAMPING_NEW      64
>
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG == 64
>  #define SO_TIMESTAMP           SO_TIMESTAMP_OLD
>  #define SO_TIMESTAMPNS         SO_TIMESTAMPNS_OLD
> +#define SO_TIMESTAMPING                SO_TIMESTAMPING_OLD
>  #else
>  #define SO_TIMESTAMP (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMP_OLD : SO_TIMESTAMP_NEW)
>  #define SO_TIMESTAMPNS (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPNS_OLD : SO_TIMESTAMPNS_NEW)
> +#define SO_TIMESTAMPING (sizeof(time_t) == sizeof(__kernel_long_t) ? SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
>  #endif

If the previous patch moves this block to a platform-independent
header, that allows this patch to shrink considerably, too.

> +static int setsockopt_timestamping(struct sock *sk, int type, int val)
> +{
> +       if (type == SO_TIMESTAMPING_NEW)
> +               sock_set_flag(sk, SOCK_TSTAMP_NEW);
> +
> +       if (val & ~SOF_TIMESTAMPING_MASK)
> +               return -EINVAL;
> +
> +       if (val & SOF_TIMESTAMPING_OPT_ID &&
> +           !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> +               if (sk->sk_protocol == IPPROTO_TCP &&
> +                   sk->sk_type == SOCK_STREAM) {
> +                       if ((1 << sk->sk_state) &
> +                           (TCPF_CLOSE | TCPF_LISTEN))
> +                               return -EINVAL;
> +                       sk->sk_tskey = tcp_sk(sk)->snd_una;
> +               } else {
> +                       sk->sk_tskey = 0;
> +               }
> +       }
> +
> +       if (val & SOF_TIMESTAMPING_OPT_STATS &&
> +           !(val & SOF_TIMESTAMPING_OPT_TSONLY))
> +               return -EINVAL;
> +
> +       sk->sk_tsflags = val;
> +       if (val & SOF_TIMESTAMPING_RX_SOFTWARE) {
> +               sock_enable_timestamp(sk,
> +                                     SOCK_TIMESTAMPING_RX_SOFTWARE);
> +       } else {
> +               if (type == SO_TIMESTAMPING_NEW)
> +                       sock_reset_flag(sk, SOCK_TSTAMP_NEW);
> +               sock_disable_timestamp(sk,
> +                                      (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   *     This is meant for all protocols to use and covers goings on
>   *     at the socket level. Everything here is generic.
> @@ -851,39 +890,7 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>                 break;
>
>         case SO_TIMESTAMPING_OLD:
> -               if (val & ~SOF_TIMESTAMPING_MASK) {
> -                       ret = -EINVAL;
> -                       break;
> -               }
> -
> -               if (val & SOF_TIMESTAMPING_OPT_ID &&
> -                   !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> -                       if (sk->sk_protocol == IPPROTO_TCP &&
> -                           sk->sk_type == SOCK_STREAM) {
> -                               if ((1 << sk->sk_state) &
> -                                   (TCPF_CLOSE | TCPF_LISTEN)) {
> -                                       ret = -EINVAL;
> -                                       break;
> -                               }
> -                               sk->sk_tskey = tcp_sk(sk)->snd_una;
> -                       } else {
> -                               sk->sk_tskey = 0;
> -                       }
> -               }
> -
> -               if (val & SOF_TIMESTAMPING_OPT_STATS &&
> -                   !(val & SOF_TIMESTAMPING_OPT_TSONLY)) {
> -                       ret = -EINVAL;
> -                       break;
> -               }
> -
> -               sk->sk_tsflags = val;
> -               if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
> -                       sock_enable_timestamp(sk,
> -                                             SOCK_TIMESTAMPING_RX_SOFTWARE);
> -               else
> -                       sock_disable_timestamp(sk,
> -                                              (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
> +               ret = setsockopt_timestamping(sk, optname, val);

Once again a lot of needless code churn. The only functional change is adding

   +       if (type == SO_TIMESTAMPING_NEW)
   +               sock_set_flag(sk, SOCK_TSTAMP_NEW);


>  void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>         struct sk_buff *skb)
>  {
> +
>         int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
> -       struct scm_timestamping tss;
> +       struct scm_timestamping_internal tss;
> +

Unnecessary whitespace line

>         int empty = 1, false_tstamp = 0;
>         struct skb_shared_hwtstamps *shhwtstamps =
>                 skb_hwtstamps(skb);
> @@ -755,20 +758,22 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>
