Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B0ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6B32081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXs4tk3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6B32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbeKEWlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:41:50 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39241 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbeKEWlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:41:50 -0500
Received: by mail-io1-f67.google.com with SMTP id n11-v6so6446903iob.6;
        Mon, 05 Nov 2018 05:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNdnWnJuHurJg6uw+S1W4nR3JcJ8nOZZGWcOSIfSkts=;
        b=LXs4tk3LFrqHrnApMllFLnwKbnfymJPDmMLyIAK0ws03yVjW2f1SW44MO4jQFwN8Gj
         LUsMPQ9rgb2aKd+IW4Ajc/kHTZHzJAErdgEtL7sILbk+WHzN0FhkTLpz1Iuyk6qbwhRP
         e/J7Ua4NT8rIfTfeOc0TsZoU76VrMUNNVhZTpAtrbQ1GHtZC1fLf6M3uHdJrTL/KUH6H
         kv6FupC8A3EEjPmqYBm8JoVWPIOff43QTkRDmrx04RdViqOGTb3pSCCZUDEDz1nNg+uo
         wy1QrQkg1Cb/H2/4C+748FtZ7XHfsWYcED6MoPyR7R6Pzb0IBzYG3skpDqp03z60N7pO
         u4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNdnWnJuHurJg6uw+S1W4nR3JcJ8nOZZGWcOSIfSkts=;
        b=s50W9+PvsquhV8j5CMQTcrzZ76cOafN/xSpRtL5lJ+kPWTOuVDR3tAQCz/gfrrmX5z
         r2Dqjfm+8Pg6tiVbMAMtLhI14fi4k07f3AcUuXkmGej3w8o6WQSbcfDlZgfoimy3E9fa
         PRPZK1joB7YZUq28DsR2nr30nbVOd/YzRMC1WYmQZbSiUwWl9FvEJ+3XBoz+8PAg4HAv
         eui6Wx8pNHyl9J2TlQilTiK1BH8VSS75wRdJkaA9vNq+5iur8YNcRhthbLI//Y8MYBWI
         wN/b5ih02wgiJYbSEJEjkK0V1lokkSxXY7AY8b/vcpCA5zsf+R+VXL5ahb4UbK5XeGDi
         ZkpQ==
X-Gm-Message-State: AGRZ1gKqY2SYlXEaONIQLQBy4QEPj44fkSw7WkR9yHheqWUoEfw5aPCO
        QtxfiBJSJ93iyCy+J3/29IImvm4pSp96kSKm8PQ=
X-Google-Smtp-Source: AJdET5fYHFtYe7RMHU+okDHjsKn20+8zddlambYznCswngZmCjL7/V5vYUU9MbBX/f8zyrqGYG1fZqj3fccKgDIJQuM=
X-Received: by 2002:a6b:bf44:: with SMTP id p65-v6mr15989090iof.225.1541424125501;
 Mon, 05 Nov 2018 05:22:05 -0800 (PST)
MIME-Version: 1.0
References: <20181104131444.4049-1-tiny.windzz@gmail.com>
In-Reply-To: <20181104131444.4049-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 5 Nov 2018 21:21:50 +0800
Message-ID: <CAEExFWuGN_R=7B4ueAVA8hVoix8ko8zQSXzHxZB5gjwP7jOjpg@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff.h: remove unnecessary unlikely()
To:     davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>, dja@axtens.net,
        ast@kernel.org, sbrivio@redhat.com, pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add netdev@vger.kernel.org
-- Yangtao
On Sun, Nov 4, 2018 at 9:14 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  include/linux/skbuff.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 0ba687454267..7dcfb5591dc3 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2508,10 +2508,8 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len);
>
>  static inline void __skb_set_length(struct sk_buff *skb, unsigned int len)
>  {
> -       if (unlikely(skb_is_nonlinear(skb))) {
> -               WARN_ON(1);
> +       if (WARN_ON(skb_is_nonlinear(skb)))
>                 return;
> -       }
>         skb->len = len;
>         skb_set_tail_pointer(skb, len);
>  }
> --
> 2.17.0
>
