Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BA4C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B620862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 03:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FB2SpV5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25B620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeG1EiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 00:38:18 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36572 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeG1EiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 00:38:18 -0400
Received: by mail-it0-f66.google.com with SMTP id p81-v6so10014874itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 20:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPXR33qs6O5Wu9AZBbuJIhlfYQJYZOynPDRzjJ3xVmk=;
        b=FB2SpV5MXzxZUAU42WjQctJcROzJaizqGmxn6ixKhVaZZl/RfaTUREVSH/yVIO8aUr
         aubx+lQGJpAThvobShtSJvbo+SAreFiA82V8DoybVMRyBBlwIB5Rj8gIDDt/vfGQJm8v
         zRy67Bxq2DgPUrJt91afSIRJGRKhAO+pPwr7zo0/sTlb8xQiAuKcvtZk6Us2XmP94umJ
         zFF7qxj5Iqvq22O0LKym7akvribVrwfDqPBaIm+edJqiZL24aVJ96sRBN/Ennd+n+Qlf
         CpZGfXCIw7tYy1/FASje1oe055NxjH708GZlBXnICjBfGZ3RjK6yVes8egeu6FFml924
         8mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPXR33qs6O5Wu9AZBbuJIhlfYQJYZOynPDRzjJ3xVmk=;
        b=rCUKhRiphWGJI7XaW1ef4CQmUfQ8tR/K5Ne7e808hAEBjd0Bbxjn2CXJaEBxz6Hs4V
         VSriJzHuaNiX/XFFQ/3sHMnV7efbsdMbBwVp6F6uBg606TDxFR5ty1hLVgb6UNjQpMKe
         XaI5wjrUwVEaei0BrcvtaHnew4RvVzj98iW2h2qYu9/dVbR2mF6o074WqS4cW1gWNGp2
         YoWGtdzO3AtaBwhWREpeNGZYn6jBppL1EkNFVgovuuzWwn+lZuHMvG+ghayX6NIhC/5w
         48V7nHC9AUxAVstKn1abxlNTdP+xL18tyblJy4dZ2qjbpxi66l7fpppdBbQWBAC0jknU
         HnOA==
X-Gm-Message-State: AOUpUlFiTZ7j8pOH771yfP1jQL5FwTQQGEgWqkqT/XbaZSDXtqYzEyz3
        9Ngq+S7LoRUopOuZF0260Ieo9HRGVsfz1bGxY5BpQg==
X-Google-Smtp-Source: AAOMgpdINjw7ALm+bhGc4DweKBPOxM+dcuX0ED3oiz0EDGmeCcYWtYul0d1UUAsJZyF9peDUrJ+IkfmZ+KdP2VduY0Y=
X-Received: by 2002:a24:7414:: with SMTP id o20-v6mr7729248itc.116.1532747610973;
 Fri, 27 Jul 2018 20:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <1532746900-11710-1-git-send-email-laoar.shao@gmail.com> <1532746900-11710-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1532746900-11710-2-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 27 Jul 2018 20:13:19 -0700
Message-ID: <CANn89iKFH_F0_Ri76Zsez2Nn8JZ9obprsk+OE7i+enGC=n8Syw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: propagate GSO to the new skb built in
 tcp collapse
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
> Currently the collapsed SKB doesn't propagate the GSO information to the
> new SKB.
> The GSO should be propagated for better tracking, i.e. when this SKB is
> dropped we could know how many network segments are dropped.

What is "the GSO"  ?

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 90f83eb..af52e4e 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4893,6 +4893,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>                 if (!nskb)
>                         break;
>
> +               skb_shinfo(nskb)->gso_size = skb_shinfo(skb)->gso_size;
> +               skb_shinfo(nskb)->gso_type = skb_shinfo(skb)->gso_type;

Why gso_size and gso_type are important ?

Where later in the stack these values are used ?

>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>  #ifdef CONFIG_TLS_DEVICE
>                 nskb->decrypted = skb->decrypted;
> @@ -4906,18 +4908,24 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>
>                 /* Copy data, releasing collapsed skbs. */
>                 while (copy > 0) {
> -                       int offset = start - TCP_SKB_CB(skb)->seq;
>                         int size = TCP_SKB_CB(skb)->end_seq - start;
> +                       int offset = start - TCP_SKB_CB(skb)->seq;

>
>                         BUG_ON(offset < 0);
>                         if (size > 0) {
> -                               size = min(copy, size);
> +                               if (copy >= size)
> +                                       skb_shinfo(nskb)->gso_segs +=
> +                                               max_t(u16, 1, skb_shinfo(skb)->gso_segs);
> +                               else
> +                                       size = copy;
> +

So... what happens if copy was partial ?

Your patch does not really fix the uncertainty, it merely shifts it a bit.
