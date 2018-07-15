Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229E8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25B02089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XaOYhMOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25B02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeGOPVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:21:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36454 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeGOPVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:21:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so29432090wro.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEe7uB4POPTvuS7j1nml2EfZds2MWNvQ7PQqfxqOBnc=;
        b=XaOYhMOU1KSyEfUzBUgJHuEswxLg8uI7dq8V9vYh1yOd+Hu2RbF503Bdc07fzee37N
         GYswA0sTkhDUIbMSKuMavTigt8op6ytvLMClwvneTN8J2p9RDNR6uUkbx0z/Lg/aA2bq
         6/fiBAg/705SpaKWYJFuW3750tAc5sw3rT/UbTp0mrj3tdDaNzhrce7/rkAkNH8MkU64
         m/2mKVrBCjUUOM785k2HvoTHGQ8xOxYm3HXcrsqQ6VZZ3qZOrK5v7TWblsdn7r1MxIg+
         DRe8SVU3VJUB2iGPxdOxWm+rsdRSaPndowHN0pq5rsD+KiTX59SJJIsNtOgcTnaxYLEw
         E1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEe7uB4POPTvuS7j1nml2EfZds2MWNvQ7PQqfxqOBnc=;
        b=nWR5aszExRtm5R0rld8ZNHjklvYIM9FrN3cS/sO6i7jOqSc393BuBQ0mAN8XBSXq4B
         PA6kZrr53XrTgPSvx6QpqfmZJj9666PYvWC47USYmB9cFxOJmxi/iERhS3n4ekxxY3yS
         +VQvOV+ZzKdNyApUZL5qhIAa2tru30addyq+bWgPxPFCzS6s44tD7KpSuWKETw6hYWNO
         +rAhbmLmgLIY9W/Z8sW7rmL1GS5YwMATp2RDq2Y//JT9kmELgOtVc7YI48c97tmoh4K2
         Dwk9Dr2cVxBcdbq0jD8chT3ZQSrn8lm7YmerMJPaUJYf9inOCEqZrcoCPAhU6EDaiZ15
         mnVQ==
X-Gm-Message-State: AOUpUlECShNsaatpk5JmaKJvZiSNBfDd0yZog4hIT8n5cRpeQXITpUMf
        +vDWo3oNYejrnUNnnseIF7qu7AVR0hFYPi89KucJgQ==
X-Google-Smtp-Source: AAOMgpf0Mqs24ZVlTXK6z/dO/v+I59VYiAgeOesl80NQYdTbw2Iqmx8LFBLnsQpTO3L6hqw615robpBcuDPyKOhg9xE=
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr9313493wre.268.1531666667174;
 Sun, 15 Jul 2018 07:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <1531619649-1518-1-git-send-email-sbaranoff@gmail.com>
In-Reply-To: <1531619649-1518-1-git-send-email-sbaranoff@gmail.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Sun, 15 Jul 2018 10:57:30 -0400
Message-ID: <CADVnQyn9o4rwHsc_QutS=ZDGn7DydST9y=qDbtAW5fx3H7ZQbA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix broken repair socket window probe patch
To:     sbaranoff@gmail.com
Cc:     avagin@virtuozzo.com, xemul@virtuozzo.com,
        Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 9:54 PM Stefan Baranoff <sbaranoff@gmail.com> wrote:
>
> Correct previous bad attempt at allowing sockets to come out of TCP
> repair without sending window probes. To avoid changing size of
> the repair variable in struct tcp_sock, this lets the decision for
> sending probes or not to be made when coming out of repair by
> introducing two ways to turn it off.
>
> Fixes: 70b7ff130224 ("tcp: allow user to create repair socket without window probes")
> Signed-off-by: Stefan Baranoff <sbaranoff@gmail.com>
> ---
>  include/uapi/linux/tcp.h |  4 ++++
>  net/ipv4/tcp.c           | 12 +++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 29eb659..e3f6ed8 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -127,6 +127,10 @@ enum {
>
>  #define TCP_CM_INQ             TCP_INQ
>
> +#define TCP_REPAIR_ON          1
> +#define TCP_REPAIR_OFF         0
> +#define TCP_REPAIR_OFF_NO_WP   -1      /* Turn off without window probes */
> +
>  struct tcp_repair_opt {
>         __u32   opt_code;
>         __u32   opt_val;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8e5e2ca..9163fb1 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2824,15 +2824,17 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
>                 if (!tcp_can_repair_sock(sk))
>                         err = -EPERM;
>                 /* 1 for normal repair, 2 for no window probes */

Looks like this comment is now inconsistent with the code.

cheers,
neal
