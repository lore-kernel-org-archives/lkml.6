Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81579C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6B52082E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 04:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqOmSidS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6B52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeKYOuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 09:50:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43859 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbeKYOuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 09:50:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id f4so13073920edq.10;
        Sat, 24 Nov 2018 20:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obtjhgtDDsP+5Ip6HZR8RzVAI2Sl/WwjveNuv60FNDs=;
        b=YqOmSidS95BPQYBVzqnNeBa4T7rgsx5jQyJB8lWWrWUOypCe3UU48DBr5T6RKM/rQa
         hPYciCQu0hNgfnKSkX29QKmwqkarhfaTT3FkHPIdeC04uGRgL0FBLnGbWv9Rw2S7521Q
         +nVEk46+FXxcZm8WQ3ZYsHn/xr+3veZkjqDUgQdm8YINbiDQO/wN7oxCxAYLN1bcWLsw
         GQy8by3SgVIRMl331D//UNZxLAb7EOtAVSNCQhmKf9mYCjbE/Q5X5CFVbztRRL+Kz3N7
         8HB+Xrp3toMt+Y3gE8GdDCC2HyUJtC0ePC1rg/E8+RqQE1DgJ3w8NfPAXutLtKtIam9h
         qFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obtjhgtDDsP+5Ip6HZR8RzVAI2Sl/WwjveNuv60FNDs=;
        b=P++kHbDe/DE06EhQKsQ5ixzCeyVPJjYWRM1Ql2LlXcpJD18fMtPiQ9CsRRZZb2TzIG
         zV7AnLvKHNSv2nje8X+e8B0D+dfJR78fIf/0LuXJFIP534YtWd8tmvgZRnjTGzQ74AOf
         TpKrXMkjlXiTLPlrS3UGc4kg00x6cKH9xfV0Z2rn5n+CaUy0QHQsH09mmlV0x0Shf1VO
         qeXg5DK/xvgeC4OKHTwMePz0ry7lwowdHiEiPsP8+eH4bf2Zg7XdCyINN6YQEc/nH6+0
         ZdkF/6lN5+d/eLI24RG5Wx159nDNjP8SFt2uKhgMm9pDtxswX+EBZHidwrRzZIV8PBl8
         tdgw==
X-Gm-Message-State: AA+aEWbGEhRWCBQQtwKkB+AMtfemVk/MY4bh2TfDTqLHjxXRxhL4POCw
        WEPt6kr+tT115KSeLU1+1qBmFe6kTb+ubiDw68A=
X-Google-Smtp-Source: AFSGD/WZnElXfbGNhd/Endw6qrCamTs/4J1B/Q9FZt5jGoDda+QJMvhqU/aMWzRGqoIBi/YOjQkiFTOLMj9kMyN0O30=
X-Received: by 2002:aa7:dace:: with SMTP id x14mr19123754eds.13.1543118445903;
 Sat, 24 Nov 2018 20:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com> <20181124022035.17519-9-deepa.kernel@gmail.com>
In-Reply-To: <20181124022035.17519-9-deepa.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 23:00:08 -0500
Message-ID: <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
Subject: Re: [PATCH 8/8] socket: Add SO_TIMESTAMPING_NEW
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        chris@zankel.net, fenghua.yu@intel.com, rth@twiddle.net,
        Thomas Gleixner <tglx@linutronix.de>, ubraun@linux.ibm.com,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 3:58 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
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

>  /*
>   * called from sock_recv_timestamp() if sock_flag(sk, SOCK_RCVTSTAMP)
>   * or sock_flag(sk, SOCK_RCVTSTAMPNS)
> @@ -739,8 +740,8 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>         struct sk_buff *skb)
>  {
>         int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP) || sock_flag(sk, SOCK_RCVTSTAMPNS);
> -       struct scm_timestamping tss;
> -       int empty = 1, false_tstamp = 0;
> +       struct scm_timestamping_internal tss;
> +       int empty = 1, false_tstamp = 0, new_tstamp = 0;
>         struct skb_shared_hwtstamps *shhwtstamps =
>                 skb_hwtstamps(skb);
>
> @@ -756,20 +757,23 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
>
>         memset(&tss, 0, sizeof(tss));
>         if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> -           ktime_to_timespec_cond(skb->tstamp, tss.ts + 0))
> +           ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
>                 empty = 0;
>         if (shhwtstamps &&
>             (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
>             !skb_is_swtx_tstamp(skb, false_tstamp) &&
> -           ktime_to_timespec_cond(shhwtstamps->hwtstamp, tss.ts + 2)) {
> +           ktime_to_timespec64_cond(shhwtstamps->hwtstamp, tss.ts + 2)) {
>                 empty = 0;
>                 if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
>                     !skb_is_err_queue(skb))
>                         put_ts_pktinfo(msg, skb);
>         }
>         if (!empty) {
> -               put_cmsg(msg, SOL_SOCKET,
> -                        SO_TIMESTAMPING_OLD, sizeof(tss), &tss);
> +               new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> +               if (new_tstamp)

nit: no need for explicit variable

> +                       put_cmsg_scm_timestamping64(msg, &tss);
> +               else
> +                       put_cmsg_scm_timestamping(msg, &tss);
>
>                 if (skb_is_err_queue(skb) && skb->len &&
>                     SKB_EXT_ERR(skb)->opt_stats)
> --
> 2.17.1
>
