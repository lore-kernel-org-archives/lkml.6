Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 903FBC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F80208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3KLtTul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F80208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935519AbeFMRd3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:33:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40214 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934979AbeFMRd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:33:27 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so4961342ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zPAYltCYvN+ZAP1CYS9422W4IZS+9dvkwtaPhMZYi6c=;
        b=s3KLtTulgZR/0Ax+vA80SfjlVNpddUGiSa35fzas0P5Lv4HA74zyyNFr9nKAXd/qWU
         qx0h5iNTEzmifQ7SkEYi+2VatwhPxIKnzRBkAN4OgmX2MjNF7BNGc6lK3kNOSzqgavib
         oUEcV9InH1YYmRI7lwceRPsc9+UXeK34yOIEYTty/ajija0V56EOhKgzhNw2NCaA3BDv
         WxjVhHhNkSWdJkyoEJLItixo81PxXtyeY9I+HD6TTzbJF3svIZm8rxkPjEPT9hvpVbMu
         2f3kTI5YkeUkAJpJ7lFQXAPSEfBYiwlNB3TJ872U4gR/nwEkGhROKkqTk1l8RtJaKZY+
         u3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zPAYltCYvN+ZAP1CYS9422W4IZS+9dvkwtaPhMZYi6c=;
        b=km5ay2gLgB1TJrSlMAc+qBpMTfAgpfUNOWjDcejgdsUR1t1T8CjfZ00kWtxoB0L/tI
         UMw4Xe/a4GteGqbCMOEtDt7EHNtijIbUOJ6RZoA9QFTzRFDIraVfX7+u9agsxBkqS55p
         Bj4/kSyqfZAwm1bswP4TdOHrNuZESNwIBijLkp5dJ0JkZcOou1OhNhqB4ySDm6yUg3tT
         6gmufsEzJyd8VDftWiWhrGfoxvitwNeHg0g3bYrRZVM4YPE1KK7IXC5Y5HJE6Na8RV57
         HNhrX9FMSWCp0q9xRYvc4xgS9s6zm/yM2HUKWL/RVdYcss8zV6cqjdmhQM1WVfNGsS9M
         9uEg==
X-Gm-Message-State: APt69E3pwrgJo6BIr3iTCRlq1E8wGPE7rJz7BbSjzWJvRNNjn+q19Uku
        E7/QRojhfTKRsh08ZIVdXSMBcWHUmGjX+JYtuMKDkA==
X-Google-Smtp-Source: ADUXVKI1mXghe1jhHKIvIf9BcT8tHOetLbAOFtIsT+Wd3TT+qmO3+pYeIZe/gF5IAzMg0hkvaA1Xd/Gr+1noMNi7eKg=
X-Received: by 2002:a24:4403:: with SMTP id o3-v6mr5646536ita.45.1528911206846;
 Wed, 13 Jun 2018 10:33:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:6b17:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:32:46
 -0700 (PDT)
In-Reply-To: <20180613165543.0F92DA09E2@unicorn.suse.cz>
References: <20180613164802.99B89A09E2@unicorn.suse.cz> <20180613165543.0F92DA09E2@unicorn.suse.cz>
From:   Yuchung Cheng <ycheng@google.com>
Date:   Wed, 13 Jun 2018 10:32:46 -0700
Message-ID: <CAK6E8=eCOLU9AX0+bSrOg_UYBm1mFxrGT=ybksba9B0OUfp7jg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tcp: avoid F-RTO if SACK and timestamps are disabled
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ilpo Jarvinen <ilpo.jarvinen@helsinki.fi>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 9:55 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
>
> When F-RTO algorithm (RFC 5682) is used on connection without both SACK and
> timestamps (either because of (mis)configuration or because the other
> endpoint does not advertise them), specific pattern loss can make RTO grow
> exponentially until the sender is only able to send one packet per two
> minutes (TCP_RTO_MAX).
>
> One way to reproduce is to
>
>   - make sure the connection uses neither SACK nor timestamps
>   - let tp->reorder grow enough so that lost packets are retransmitted
>     after RTO (rather than when high_seq - snd_una > reorder * MSS)
>   - let the data flow stabilize
>   - drop multiple sender packets in "every second" pattern
>   - either there is no new data to send or acks received in response to new
>     data are also window updates (i.e. not dupacks by definition)
>
> In this scenario, the sender keeps cycling between retransmitting first
> lost packet (step 1 of RFC 5682), sending new data by (2b) and timing out
> again. In this loop, the sender only gets
>
>   (a) acks for retransmitted segments (possibly together with old ones)
>   (b) window updates
>
> Without timestamps, neither can be used for RTT estimator and without SACK,
> we have no newly sacked segments to estimate RTT either. Therefore each
> timeout doubles RTO and without usable RTT samples so that there is nothing
> to counter the exponential growth.
>
> While disabling both SACK and timestamps doesn't make any sense, the
> resulting behaviour is so pathological that it deserves an improvement.
> (Also, both can be disabled on the other side.) Avoid F-RTO algorithm in
> case both SACK and timestamps are disabled so that the sender falls back to
> traditional slow start retransmission.
>
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Acked-by: Yuchung Cheng <ycheng@google.com>

Thanks for the patch (and packedrill test)! I would encourage
submitting an errata to F-RTO RFC about this case.

> ---
>  net/ipv4/tcp_input.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 355d3dffd021..ed603f987b72 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -2001,7 +2001,8 @@ void tcp_enter_loss(struct sock *sk)
>          */
>         tp->frto = net->ipv4.sysctl_tcp_frto &&
>                    (new_recovery || icsk->icsk_retransmits) &&
> -                  !inet_csk(sk)->icsk_mtup.probe_size;
> +                  !inet_csk(sk)->icsk_mtup.probe_size &&
> +                  (tcp_is_sack(tp) || tp->rx_opt.tstamp_ok);
>  }
>
>  /* If ACK arrived pointing to a remembered SACK, it means that our
> --
> 2.17.1
>
