Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C821621A48
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbOP7omV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391327AbeLVRVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:21:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44487 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbeLVRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:21:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so9313761qte.11;
        Sat, 22 Dec 2018 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uKo4WKz8FDWRYGlShzLZwV2EQ+xC1QnDjYjG0fK+7qQ=;
        b=AbOP7omVH3CmqhUyW4emvOdTJSTmfMPPToFxF/hbRr3pf575J7UO+/SIcQGYvsKk+2
         s9JDhG+GCLnT+JMLEVxR4xxfd53bZSzlW4dAIZjkmnJ9INbOMutncDm4mqdlAjLG+Esw
         MylIpqqU0T/a0AJL7tdywru6jnEme95Ot71wVRQ1rW6pXaWLIhAGBTB6QySQ0rxerUCC
         zgagr0cyMTs9udZ6Q5NSV7AOfHoWvcAsa8kJBAk+1S/D2AAhQ917cTXQr9OMxYUk5423
         YOmSrTLWUs9wu9GaQad/DlzuLDGPYu568XTFX3wko9c0XfTtS/WWADLGTwchD0E9Ka4w
         Oing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uKo4WKz8FDWRYGlShzLZwV2EQ+xC1QnDjYjG0fK+7qQ=;
        b=O96ztGGy7O9Y0qL0cR4m6f6QnMfnvXcDYi8gLqAbEmewTZZqT1KGBwHKrr1c2tKYaG
         9Zbxip/LWz/UmCZxwhtSBLpv8LLq2iuyqO9twKbOkYfYWYOiQ+9neU+YLbCSzXYB6rkJ
         SOwlsjKKR/NNwCx9S8oJ9iBgF19hDKvAEl9G26rPvMzOt0gr7DUsTQawctWXBiRe2wLT
         G4D7wcLrmRooNIc3dHvbGjFhH7sSOdmKAnQ5xK2J9SBtIX3MpYN73rqEXR4X/Ap3HvLi
         lPuGL4ROSFpW8QM5EEUE2yi0uU2L3fdBDVViNlL8G8Tj6oBy82/TejHoYUEBeA8gNvr1
         jMiA==
X-Gm-Message-State: AJcUukeMQtrnjwwJTGxbioEAKXHS3dx6U3vTOH960rcetbwJ/KPtn0lQ
        PPhyPhwj9XOwT3b3wU9nuVw1Vtv5PG291HHBwwXdPfMA
X-Google-Smtp-Source: AFSGD/XUAwszM9g0NQwvR5U0omzv1waIBcRNaGFjuHHR9MQ6JPUoA8Bf1/y2utwUNGhWYTBLDy6DhxQ+9kcMjFxfXcw=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr5973543qte.212.1545485364088;
 Sat, 22 Dec 2018 05:29:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Sat, 22 Dec 2018 05:29:22
 -0800 (PST)
In-Reply-To: <20181221202733.19627-1-deepa.kernel@gmail.com>
References: <20181221202733.19627-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 22 Dec 2018 14:29:22 +0100
X-Google-Sender-Auth: uBGBR7bKI-_UJz-QalqlpiancFs
Message-ID: <CAK8P3a3LivERgLTTmS0A35CoebS3n+cNWNXkoYKGam+fVR-Dxg@mail.gmail.com>
Subject: Re: [PATCH] sock: Make sock->sk_tstamp thread-safe
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        y2038@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> diff --git a/include/net/sock.h b/include/net/sock.h
> index fe58aec00d09..2cb641606533 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2311,8 +2313,11 @@ sock_recv_timestamp(struct msghdr *msg, struct sock
> *sk, struct sk_buff *skb)
>  	    (hwtstamps->hwtstamp &&
>  	     (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
>  		__sock_recv_timestamp(msg, sk, skb);
> -	else
> +	else {
> +		write_seqlock(&sk->sk_stamp_seq);
>  		sk->sk_stamp = kt;
> +		write_sequnlock(&sk->sk_stamp_seq);
> +	}
>
>  	if (sock_flag(sk, SOCK_WIFI_STATUS) && skb->wifi_acked_valid)
>  		__sock_recv_wifi_status(msg, sk, skb);
> @@ -2332,10 +2337,15 @@ static inline void sock_recv_ts_and_drops(struct
> msghdr *msg, struct sock *sk,
>
>  	if (sk->sk_flags & FLAGS_TS_OR_DROPS || sk->sk_tsflags & TSFLAGS_ANY)
>  		__sock_recv_ts_and_drops(msg, sk, skb);
> -	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
> +	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP))) {
> +		write_seqlock(&sk->sk_stamp_seq);
>  		sk->sk_stamp = skb->tstamp;
> -	else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP))
> +		write_sequnlock(&sk->sk_stamp_seq);
> +	} else if (unlikely(sk->sk_stamp == SK_DEFAULT_STAMP)) {
> +		write_seqlock(&sk->sk_stamp_seq);
>  		sk->sk_stamp = 0;
> +		write_sequnlock(&sk->sk_stamp_seq);
> +	}
>  }
>

Hi Deepa,

Thanks a lot for the follow-up to our earlier discussion here!

Are we actually worried about concurrent writers here? I thought the
only problem was a race between writer and reader, which would mean
that we could solve it using only a seqcount_t which is cheaper to
update than a seqlock_t.

       Arnd
