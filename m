Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC059C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E645208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKDbmTc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfADMsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:48:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38968 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADMsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:48:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so17486269pgl.6;
        Fri, 04 Jan 2019 04:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV+GgAS/Pr2cUU2iYuBAkonPM6k8Ugrxg2d/emVMNcs=;
        b=MKDbmTc9vuv01Glg9+nobJQhJBUj98TI/Ki0ovdoVjhXeq6+hrzBmdOwRSCBbvUDzM
         gpkNsLBGOc8SzfjF25rXaE8M4tGj1cxx0ZMuUUtMayNhkI+BoFwx4tkh9uLF9LtuwI5H
         g/7shyG1i5T2OzpG4nKAinEhsIJ9Dyo+BpwpDkkjQLAs2aJx7veftC7ijFU3cdxWDa/C
         ggp9dbFE4cqnyqE3/5KgeQSzkCfi7VfjdWfoWbFBtfum/ccfO7IbmQesDCt489yC+m6D
         NnQlkLD5VfmJG8ZRgiz8Vjxy4Ggxgy1iKTM2DVQF4E6obPHTees/kzRAO/d0jjNhDhrS
         wzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV+GgAS/Pr2cUU2iYuBAkonPM6k8Ugrxg2d/emVMNcs=;
        b=IwkYxB3dHNbNXiwJ0sxHGmMbVoI1gj1P08xRxCYjUlPNtZJmIXhiCyXJAE9y8jwZq5
         xfwE3WIW+54f1iafug2kX6BWDeW3uiXZdVMtGqftzJAyJJNWkrFvuY7/Pq16CvwsrpOU
         7uK77hVo1I5E68YyFePG7JFtfer2+7p0JeGXYmFBrE3OlOZeDxhy0tu99TKdRQ72GVJe
         +Xe8Q5P7BgJN2x58QfP5feM5HI3YwlJpAwow9jciDwAIXjBuA9diO3HgXg2s5mMnK3Y1
         sx3fE5eFbve6IwFsZhX2Jzv+oTuHQNpQMQpuPn7VpbB5xwkW84nlBdU7+OgS2pD0o6We
         zXdQ==
X-Gm-Message-State: AA+aEWYx4sVLT2hEGClDVXwqRiW7uvvLu3VvQjfNS85qL5nOL7EaP5F/
        1JLqo4TspIq1cAbK0alcNrOVT1/t2EXsPtrCVdU=
X-Google-Smtp-Source: AFSGD/W3DywctE2EYC3hnOBaCT/J5jHvxBMCjmEN2aP8PPpMLSBikXwIRGqKjf//CUbYbH+f2WqU+SBScLjE1D+1/eM=
X-Received: by 2002:a62:43c1:: with SMTP id l62mr53223487pfi.22.1546606107989;
 Fri, 04 Jan 2019 04:48:27 -0800 (PST)
MIME-Version: 1.0
References: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com> <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
 <CAJr6mf2kr4BmCWZU0=EwXURWUZWRHHLifi_2aiUrJSCjnWusZg@mail.gmail.com>
In-Reply-To: <CAJr6mf2kr4BmCWZU0=EwXURWUZWRHHLifi_2aiUrJSCjnWusZg@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Fri, 4 Jan 2019 18:18:16 +0530
Message-ID: <CAJr6mf29hJft=rurUK8EJRQ1MS_3_MXb7f-zX0vyXUrQNLcWYA@mail.gmail.com>
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

On Wed, Dec 19, 2018 at 6:49 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Sat, Dec 1, 2018 at 6:40 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > On Wed, Nov 21, 2018 at 7:18 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > >
> > > Replace dma_alloc_coherent + memset with dma_zalloc_coherent
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Any comment on this patch?
>
> Any comment on this patch?

Any comment on this patch?

>
> >
> > > ---
> > >  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> > > index 3ac3437..495bddb 100644
> > > --- a/drivers/scsi/mvsas/mv_init.c
> > > +++ b/drivers/scsi/mvsas/mv_init.c
> > > @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
> > >         /*
> > >          * alloc and init our DMA areas
> > >          */
> > > -       mvi->tx = dma_alloc_coherent(mvi->dev,
> > > +       mvi->tx = dma_zalloc_coherent(mvi->dev,
> > >                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
> > >                                      &mvi->tx_dma, GFP_KERNEL);
> > >         if (!mvi->tx)
> > >                 goto err_out;
> > > -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> > > -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> > > +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> > >                                          &mvi->rx_fis_dma, GFP_KERNEL);
> > >         if (!mvi->rx_fis)
> > >                 goto err_out;
> > > -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
> > >
> > > -       mvi->rx = dma_alloc_coherent(mvi->dev,
> > > +       mvi->rx = dma_zalloc_coherent(mvi->dev,
> > >                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
> > >                                      &mvi->rx_dma, GFP_KERNEL);
> > >         if (!mvi->rx)
> > >                 goto err_out;
> > > -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
> > >         mvi->rx[0] = cpu_to_le32(0xfff);
> > >         mvi->rx_cons = 0xfff;
> > >
> > > -       mvi->slot = dma_alloc_coherent(mvi->dev,
> > > +       mvi->slot = dma_zalloc_coherent(mvi->dev,
> > >                                        sizeof(*mvi->slot) * slot_nr,
> > >                                        &mvi->slot_dma, GFP_KERNEL);
> > >         if (!mvi->slot)
> > >                 goto err_out;
> > > -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
> > >
> > >         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
> > >                                        TRASH_BUCKET_SIZE,
> > > --
> > > 2.7.4
> > >
