Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E91C217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZC7Vlb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeLSNTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:19:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45723 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbeLSNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:19:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so9454117plm.12;
        Wed, 19 Dec 2018 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+Om3m/eo0lXfruqJJ7SzvrT6DnHrr9AyLqsWkyXuFk=;
        b=bZC7Vlb4LhldqDmAKaCkEFkIRRttBwe8qd+iz/4uy5C4JS8W+zOzcgO+lh90En/QRC
         pLrGcfxW7U8bmlztXGevLYUD61kmelj3rglTcCgqftQZ7KyVRQZPRxv/NUbY5Q5djxA5
         3O6lvRehZLCHEjaPxukm74dxdDv0PT381i6SZSmLRzP+tDtproETGf5qEKhmFAUmqJrf
         UJxCYjhWgkm+busBZgsfEXyolfSu+p77yzj8m6MZnRcOILO6eIrK9Tl210sOTr2WZIhE
         FQhLijU2QPheG7dQQ9ehK621/idImeAG3U73hA6jVcFc0ucB2ribLQfcSr0XeMEYtK2B
         mXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+Om3m/eo0lXfruqJJ7SzvrT6DnHrr9AyLqsWkyXuFk=;
        b=O8tZkZhkqKhUwcs+LKNYdCHTDAO1fVk6+IViDMOvX9yklwbUrqEZUMpKInbrZPTdFO
         amVYRf1eiM6UCO/gsO9gO346T6JrVi/wOmmXuwvYH2wOu4KZnMEjvB48kDwFfOHTH4Ff
         8RjMiwE0PPGtEDbsAz5Dwh1yA4MQUPa2Hz+eBzIl52rs3TKoxl4SF5YyjsOpNG+bZACo
         ud3uMcRhvoX1OxREuXcoxwP5YpkGJJ6178Bi0Rw3F+FUJtQp7vBvOBSmoZftTBVu6ruI
         haI2RkLZ6w9FMlaIiqHkuMUDiMagzBbGAnzTyiXgTVBXzSLyXmeYqLFPBp1mIWij48tN
         mHhg==
X-Gm-Message-State: AA+aEWYs02CTErA++1vAqRUO29iNb/xDDVzV2PeOvllNQjgy7pbmxmmQ
        gVnF84POYP9SixtM58UHbHORCbupWL9SYyU9UIs=
X-Google-Smtp-Source: AFSGD/WveOPDG1FosPHY26/2FNP1/zzPIeatOzfYGPeShN1JdX+9sEFZMdNBmgHSQQgEbHvplTE8yoVt2//mFJbp/ks=
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6mr20120870plo.67.1545225579209;
 Wed, 19 Dec 2018 05:19:39 -0800 (PST)
MIME-Version: 1.0
References: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com> <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
In-Reply-To: <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 19 Dec 2018 18:49:27 +0530
Message-ID: <CAJr6mf2kr4BmCWZU0=EwXURWUZWRHHLifi_2aiUrJSCjnWusZg@mail.gmail.com>
Subject: Re: [PATCH] scsi/mvsas/mv_init.c: Use dma_zalloc_coherent
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        jthumshirn@suse.de
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 6:40 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Wed, Nov 21, 2018 at 7:18 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Replace dma_alloc_coherent + memset with dma_zalloc_coherent
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> > index 3ac3437..495bddb 100644
> > --- a/drivers/scsi/mvsas/mv_init.c
> > +++ b/drivers/scsi/mvsas/mv_init.c
> > @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
> >         /*
> >          * alloc and init our DMA areas
> >          */
> > -       mvi->tx = dma_alloc_coherent(mvi->dev,
> > +       mvi->tx = dma_zalloc_coherent(mvi->dev,
> >                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
> >                                      &mvi->tx_dma, GFP_KERNEL);
> >         if (!mvi->tx)
> >                 goto err_out;
> > -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> > -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> > +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> >                                          &mvi->rx_fis_dma, GFP_KERNEL);
> >         if (!mvi->rx_fis)
> >                 goto err_out;
> > -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
> >
> > -       mvi->rx = dma_alloc_coherent(mvi->dev,
> > +       mvi->rx = dma_zalloc_coherent(mvi->dev,
> >                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
> >                                      &mvi->rx_dma, GFP_KERNEL);
> >         if (!mvi->rx)
> >                 goto err_out;
> > -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
> >         mvi->rx[0] = cpu_to_le32(0xfff);
> >         mvi->rx_cons = 0xfff;
> >
> > -       mvi->slot = dma_alloc_coherent(mvi->dev,
> > +       mvi->slot = dma_zalloc_coherent(mvi->dev,
> >                                        sizeof(*mvi->slot) * slot_nr,
> >                                        &mvi->slot_dma, GFP_KERNEL);
> >         if (!mvi->slot)
> >                 goto err_out;
> > -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
> >
> >         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
> >                                        TRASH_BUCKET_SIZE,
> > --
> > 2.7.4
> >
