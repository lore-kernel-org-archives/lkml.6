Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B26EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C8120856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn4hDx6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfAQORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:17:46 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41921 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfAQORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:17:45 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so7901255ioc.8;
        Thu, 17 Jan 2019 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Dm8L+k0shzfS/c/F8HVP6yw3Qqt/VIEBz4LrddkGM8=;
        b=Vn4hDx6KgsBz8FwF5a74tjqi7RFW1hPrt6XPEEcsWGWSrAPs1N+9mx591UktvqqJxy
         Vb0PZiwh/eSso/ZZb3VHzr/fohA/+yKHDs3Iz5Inbzdob4fEetj6Bn0xtWiNZqLdyy5+
         VaPgXeTNnCWdJ9rc9LHGMabRqWafDKov6ccGBpug0ey0gaDNk94l4fGl0n8fK17UCkAf
         G1LQwlYfNPuprCnl7sAdfAbwaNiad43Vo4oZEDqw/SQQWNVrM0yx72/s18WfCLo6VnAQ
         AEku7G//99yqywqEEL9CsG11m1ckoY8Z30V9XLXAzyYZXGMWb37Z52SOpJDJRzB7MtiY
         DtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Dm8L+k0shzfS/c/F8HVP6yw3Qqt/VIEBz4LrddkGM8=;
        b=d4Iipi7Q+KrYVdNx+axPxwaGqzbfU9ZuIAVFoKgIogw6ajMiiud08Hae/rPF1wAA9s
         7BrzDHUxBzga9WFf4c0miJjiSKZtPaN35JzpTLzAXlklnjVHHEfWbLjN+PQZ9DcF1Mdn
         2y/hIOmQGhteD51qtQjfqI/vJspbixwwhbAf7iGO7agzQ9ZHG9++wtvPResrtvbUDjb4
         WvnhOXkG47yjSIAhRFlGHg/2J7OD2tU5IomEeukU+MXV8SEHxu9bV3x62cc4Qo8E30Oc
         ekL0SwHeeiKSm8/bjoSoPFpwfbJL8+plqLGhZhY/uy8bPmWqZvYQGO6n9CnrZwiUHnk3
         3O7g==
X-Gm-Message-State: AJcUukdG010VXZ//UdMGW/sr3bj2XuZ7B1fTLcjhPjYusjC5D89yFFOI
        MtfUIwnb87zhd6+kzs2tcZswhw0EBQlwaZHXuTq2YwaP
X-Google-Smtp-Source: ALg8bN5lwhKKJqs0NqCJHXGhvnU1qXt6ID/+i7dkRiiV3LdaSZBBR00hTOzoDjQnjOWqPlSk69Ney/mQjmyfBY382TM=
X-Received: by 2002:a6b:92d7:: with SMTP id u206mr8075903iod.174.1547734664644;
 Thu, 17 Jan 2019 06:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20190115194153.GA9565@embeddedor>
In-Reply-To: <20190115194153.GA9565@embeddedor>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 17 Jan 2019 15:17:33 +0100
Message-ID: <CAOi1vP_yWH2mhquFObC6VnUzNTzc7PX7tqA3RP=ci71BMm-gqA@mail.gmail.com>
Subject: Re: [PATCH net-next] libceph, ceph: use struct_size() in kmalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 8:41 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>
> instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  net/ceph/osdmap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 98c0ff3d6441..48a31dc9161c 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -495,9 +495,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>                           / sizeof(struct crush_rule_step))
>                         goto bad;
>  #endif
> -               r = c->rules[i] = kmalloc(sizeof(*r) +
> -                                         yes*sizeof(struct crush_rule_step),
> -                                         GFP_NOFS);
> +               r = kmalloc(struct_size(r, steps, yes), GFP_NOFS);
> +               c->rules[i] = r;
>                 if (r == NULL)
>                         goto badmem;
>                 dout(" rule %d is at %p\n", i, r);

Applied.

Thanks,

                Ilya
