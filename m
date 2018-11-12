Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F723C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699B223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEuYIoCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E699B223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeKLV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:57:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41562 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbeKLV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:57:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id p16-v6so4266101plr.8;
        Mon, 12 Nov 2018 04:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYTMYFv1zxbnhoEXHeIKXqmQk06ZJTc50NB4EXspyPk=;
        b=eEuYIoCQWF7uedqRD1DOmH+qRQfQFcmt6zJuNETxzySYFnt4Gl0Waqnqx/HK5cOeV3
         bsaRy5sFsWOIwg/GpWemMndf5WlXX2vgrBfaBhFn3/DE5n7BrNJJvscjkpAaTLpt6Zzx
         tLtRtOAt6lMrkVB6WXl7fLxHQIVe9uOqrdaTitDKOE5cCviKwCiGMoPHvmpfJ1aqghoE
         BGA7CKSmvdIzGo7FZHXnU/0EvmQ4GSv3hbJYY3mP+HGlrAG4WnS6jQJWOq7xfeIPOk8C
         L3+uf+crjbWXRYAGaxWnnoe8OAyQMkt3AZHd1VMGCcNI7rCovVOMxzXegQq/oIEdw8h/
         s8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYTMYFv1zxbnhoEXHeIKXqmQk06ZJTc50NB4EXspyPk=;
        b=PUWuJf5pZUSBmAFcTyrruZ26Mzr46fuqpJbuLBTvqHjk7W+MyKQaSI0wQxDsn8WaEc
         cVYJ539COuB9zy5YYWjZvBuHcreDWczQ7m171FmJEVYiySBlo4VM/Fq3sRDZ512/Cbbx
         Jm/OV7+FZe51+qbF0Rv41Xo/Af+aK1WS1gCwoT90vx8M9hFxI0psarMa+9Js60F26BsJ
         lSpaOyhNrT6nqo/lprod1ZmE9BOWguqpenLUerrXfKgzNH092CQwjHkPVD62/5Ocxj7G
         2wCSrdb/PECRzduMI43jf1HXUbVk33KhT9Rd9vSdDoag54AYEVXPjLf9msfALY7DSdR+
         W99A==
X-Gm-Message-State: AGRZ1gJEKO8Yv1GflYKoYGDjVaebX1qmeOnSsy7K7DCSCsonsbcfRBVX
        VGcqi520XOa1Xr9ylbmKbLUnmCE9I9eU4rzVgXY=
X-Google-Smtp-Source: AJdET5cTjW7Q6t69AjfoFalfOnfMI9XyqkPUTp+izq40f70gFQQQ7tNO/Os83NKXSzdc+lqZaxXDWkzri3tQrXSM5ZE=
X-Received: by 2002:a17:902:7442:: with SMTP id e2mr655714plt.67.1542024294703;
 Mon, 12 Nov 2018 04:04:54 -0800 (PST)
MIME-Version: 1.0
References: <5be59bf8.1c69fb81.a231.dcd6@mx.google.com> <CAFqt6zY5PUB-=1PeNKHiWmgbrR=3EfqcYsWOVH5TLeJnQf0JBg@mail.gmail.com>
In-Reply-To: <CAFqt6zY5PUB-=1PeNKHiWmgbrR=3EfqcYsWOVH5TLeJnQf0JBg@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Mon, 12 Nov 2018 17:34:42 +0530
Message-ID: <CAJr6mf1Eeu8n+E37aEjw6NZh3dMgDQbxXi=gOrvmaf7qjxHqLA@mail.gmail.com>
Subject: Re: [PATCH] infiniband/hw/hns/hns_roce_hw_v2.c: Use dma_zalloc_coherent
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 11:57 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Nov 9, 2018 at 8:08 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>
> There are few other places in this file where same is applicable.
> Can we get those changes in same patch ?
> >
as all the changes are now in linux-next I am going to drop this patch

> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index a4c62ae..c9966ec 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -4972,13 +4972,12 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
> >                                 eqe_alloc = i * (buf_chk_sz / eq->eqe_size);
> >                                 size = (eq->entries - eqe_alloc) * eq->eqe_size;
> >                         }
> > -                       eq->buf[i] = dma_alloc_coherent(dev, size,
> > +                       eq->buf[i] = dma_zalloc_coherent(dev, size,
> >                                                         &(eq->buf_dma[i]),
> >                                                         GFP_KERNEL);
> >                         if (!eq->buf[i])
> >                                 goto err_dma_alloc_buf;
> >
> > -                       memset(eq->buf[i], 0, size);
> >                         *(eq->bt_l0 + i) = eq->buf_dma[i];
> >
> >                         eq_buf_cnt++;
> > --
> > 2.7.4
> >
