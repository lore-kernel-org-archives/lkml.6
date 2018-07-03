Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15631C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F2B214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZN9TdquV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F2B214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeGCOoh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:44:37 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:40973 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932724AbeGCOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:44:33 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so816662ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wsz+5lKMl5mcnGw5D81ux93dFhf6mwC00Vkbz/5zpEg=;
        b=ZN9TdquVWn8axTnhd6rQUJ4yUwoFmezaTp367IPpq1fltYqXTVewws5p+N6iznz3av
         gjrtah1GRgRzD6tW7y7e8AbXctEEjLraoLg31gmGAlvxvfZa3PTMdOa3a5JEvEJZzXc2
         MZ4tyfY6MIN8yaxO4mXv6Bt9/4OoqC8YhPzg81S3q7ntcC6ND5Yr3ivkN4qSEC7k+WgI
         603xMfOQ9WwXzdHUbO7z80TwoNOIpPHFTvRzzo9bR+FkdUtJGFyg3pSjL1DY/Q9su+/h
         mbisFq7a7oejuHTYp/ZMCMaTAgmneZLVP0CDgdSjpQJeXE5qYp8sSW2Z/t1+sKHW/UMR
         TaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wsz+5lKMl5mcnGw5D81ux93dFhf6mwC00Vkbz/5zpEg=;
        b=e+VY5803dGIkLgkC3RJ7x93j0Qy3gIXFz0tEYdQamdfj27eectqQWqvJrbOhoqOpPp
         Kvs67oJv/NsQCV2Bql+dLvotkgWgw2+YwfXb8AUSxiNqMjglLUrv9HXXbr2rckSMQwHC
         4Pm2c4Z54JqS4gKrzRe5phJLkO8OySAGHi3CnJky3xkbg3M9R2S0b1/SkSLmZJhaX5yx
         M+hvL5hTtqnDNsf3FS8ce2EloSUBw6/NZkmEY3fYboIpKPXWw30XA0mlQbVr7jhJbm+3
         wHShbFMIdRYoEfeIUlOIGHTaxsM31zwrcnoPgPu6jd4eD9n/zm9o8b+cE2KZpcG7S1js
         +Wbw==
X-Gm-Message-State: APt69E1ixFh8DgAM/lllf0Yp6vvqxPT5AlJaJmqu1HpUY2IN74dnOr/F
        rZDEnrCDqmI6GYmqRwG6I2eEhj268RtdtXfO4FKS
X-Google-Smtp-Source: AAOMgpcRrlxXs6cvIrjHzIVeZ5c6BHHEf7E8zAK1OOPjgYzrT2MNrUvXKZ7GOwbOI2Uq0blzneKSjwCDtpxgJvBldvk=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr4623250ybd.497.1530629072436;
 Tue, 03 Jul 2018 07:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180702210234.107361-1-tarick@google.com> <20180703062111.GC3014@mtr-leonro.mtl.com>
In-Reply-To: <20180703062111.GC3014@mtr-leonro.mtl.com>
From:   Tarick Bedeir <tarick@google.com>
Date:   Tue, 3 Jul 2018 07:44:25 -0700
Message-ID: <CABwnudxZbGumr+XNjOsz5+_iZkZ9mn0zhk+UOmxDNynAQJfWtQ@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Test port number before querying type.
To:     leon@kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>, dledford@redhat.com,
        jgg@ziepe.ca, Eric Dumazet <edumazet@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 11:21 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Jul 02, 2018 at 02:02:34PM -0700, Tarick Bedeir wrote:
> > rdma_ah_find_type() can reach into ib_device->port_immutable with a
> > potentially out-of-bounds port number, so check that the port number is
> > valid first.
> >
> > Fixes: 44c58487d51a ("IB/core: Define 'ib' and 'roce' rdma_ah_attr types")
> > Signed-off-by: Tarick Bedeir <tarick@google.com>
> > ---
> >  drivers/infiniband/hw/mlx4/qp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
> > index f045491f2c14..4f1dabecf9a5 100644
> > --- a/drivers/infiniband/hw/mlx4/qp.c
> > +++ b/drivers/infiniband/hw/mlx4/qp.c
> > @@ -4034,9 +4034,9 @@ static void to_rdma_ah_attr(struct mlx4_ib_dev *ibdev,
> >       u8 port_num = path->sched_queue & 0x40 ? 2 : 1;
> >
> >       memset(ah_attr, 0, sizeof(*ah_attr));
> > -     ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
> >       if (port_num == 0 || port_num > dev->caps.num_ports)
>
> Did you get any warning from any checker about out-of-bounds access?

Indeed, I observed a KASAN warning for an out-of-bounds read in
to_rdma_ah_attr().

> According to the line above, port_num can be 2 or 1 which are valid ports for mlx4
> and the check above doesn't do much.

There are mlx4 devices with only one port.

>
> >               return;
> > +     ah_attr->type = rdma_ah_find_type(&ibdev->ib_dev, port_num);
> >
> >       if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE)
> >               rdma_ah_set_sl(ah_attr, ((path->sched_queue >> 3) & 0x7) |
> > --
> > 2.18.0.399.gad0ab374a1-goog
> >
