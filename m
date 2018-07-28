Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273D5C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC2C20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CS35gKYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC2C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeG1EbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:31:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34668 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeG1EbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:31:06 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so5713018ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onm8mXfE6xFzwHbybl1j+WNjU0RRlLK7PzLbBMjpozA=;
        b=CS35gKYsnyWsBpH2ijs9F3/aBFoYTpO3jqTesV1Znm99/PjWhvkBTk03gDAx94QYry
         YtJr/k1ZpZBIAK3wa51dIbSw5mUIpb1l/qA4QrbSyjrCTUz08yR2AOt+HKwvph37AbQ+
         +6eS4ghnHKf1zti1/ctBaCzraAI7ewXaQH6OSUX+Gsw9yO4cdQVuNsnawZ1EX3vBbRHX
         ZeFliz2yJ42rVMFa1bwlUZnR/i8s+9GTaRy5+34Azlky026MJ8G0/2Ndd2ZEV73ooTT6
         LERzy5/8k4wHipwLzaCQ0JIjWhTS5qbyTr0x7KH7MGKly5CNBiOK4/3q2NokfAusmEXP
         Ubbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onm8mXfE6xFzwHbybl1j+WNjU0RRlLK7PzLbBMjpozA=;
        b=pfmKbhlsDzWDzFIQZNK0rje/WuQ9+jTVt3JvL/R7dBd06RqbAfUv649EireqCqggEr
         itynw206nyg0rAsklDHYnLpP/nijYIB7uT5Gd6Z84DAVZmKPaMset7YK6EmdBVeTk/sk
         7xSvcoGFiaeRuTpaiaHu5/hp8GXMqIzgJjLXc+NSdXZDMpf285OjqR5tlkMn0bUJZV8M
         Y3Xce9sYH0qj9LolfljYYUcolUZjLdH90jgpRyUKYeeyl40soesky9KzsRyxDtEwlHZv
         RPGLDKQZ6KOuz3bdeLKwDC35voUxM8m8rfz94iP/KIgeRkZPeTl54rCrz+zMQ647K2bB
         aY7g==
X-Gm-Message-State: AOUpUlE14jdl7u/fS8LPLvSgwqPiRKlULwnHEoRFyVPSafxUfOEnESOV
        nZRVBZQgPLeQlcIy2Rkzxw/hjOsLG6T/TkGXGnRVH9r+
X-Google-Smtp-Source: AAOMgpfc7dbKReGO6oelXBZzizicWLhTi8q4rA45LedQ/ZSsKa8rnqWlNEygXIWPLb9TM6QEafbIuodmguchW7OZ9Lg=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr7088093iod.118.1532747180476;
 Fri, 27 Jul 2018 20:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 27 Jul 2018 20:06:09 -0700
Message-ID: <CANn89iJ=Ad7sVWr3zBmXNSyePJJZaxgnMymN8S7x6fCSvG2jTQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: call tcp_drop() in tcp collapse
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 8:02 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> When this SKB is dropped, we should add the counter sk_drops.
> That could help us better tracking this behavior.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index d51fa35..90f83eb 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4802,7 +4802,7 @@ static struct sk_buff *tcp_collapse_one(struct sock *sk, struct sk_buff *skb,
>         else
>                 rb_erase(&skb->rbnode, root);
>
> -       __kfree_skb(skb);
> +       tcp_drop(sk, skb);


Absolutely not.

We do not drop the packet, we have simply lowered the memory overhead.
