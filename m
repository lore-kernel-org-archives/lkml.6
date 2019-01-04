Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDA9C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9A4218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBxpvQup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfADTpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:45:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41309 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:45:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so26171121lfj.8;
        Fri, 04 Jan 2019 11:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uH/wgimKjqrM5iFdQKXcIq0AYEGNEBqbrt33Xw4U+4s=;
        b=dBxpvQupeOXqaO1+UsiqXqQ/Xi95kmOVBomcE/pidzH1jvn/dZlF2uLQAAPS/H9Bx+
         g7MSn0x05x2mh8Mtmh9rWR7Gs4o3PONRHWnr81p+h4s4DTLogJ/xu7tAg3+hOXSvesnk
         JzuR5bARhorAN12fcGRHryG/zVXe28hxb1L4dcbG2i2f82454IRFIBrKunVVs7p04bpX
         ZR45W01U5PWYyQ0WTGUTXqsZlhrNqlmXaWNTRfLXHffo6h8NSDjBvdcWeoEsZF1fD5fV
         O8KPdS2TWexDkLR1ah/xsZV9XmlFgdzMKa+y7tFyB4/deMBc6FGfH0vF9onSfS93SaGh
         TrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uH/wgimKjqrM5iFdQKXcIq0AYEGNEBqbrt33Xw4U+4s=;
        b=lnOXbWilzNeaVPutaXwfix1WkiXsqlPvIHCRR6WWpQYYysPeTFTt/gp7Hz4rQyk1IR
         tYJstSaU1fK+JKK/PZBBB9OaIuoPPqnVU2DVC1K2SwVyZd2pKT/7EH6vwIdRUvfa9cQo
         dy5Tgw84Aw7pv3dLEQ8Fj0IWU5XGJPxC9P5LPSUfOaQLaiiNoL1DT4Fg42xCxuagjM66
         Prhg4BTJoPs/FNWJLKz1tS7m6UXS2KqquesPbcOgqIo4H+QsJ0wa3vgPLDXL8A1l5wkG
         bn95hqLr3ZN/CUtHovNnLx1rC09RvqBZ1THUVzW/1h38YoE9rEhQEf9KynldfYus4AW3
         rjYA==
X-Gm-Message-State: AA+aEWZomqM49nfy7pXTHL5m/8VjN5g/hkdTxW4wuwKE9bX10TNa3haB
        j+8WDozIofu+FVJuvXAkmqjfaB0GNnmwMXdAndo=
X-Google-Smtp-Source: AFSGD/V7pRb2QpZ/4Wbyvab3kBcV5IdxMjs0WJS/fhKBYIz9VgNVLpAWDWPSFBd+HhTHgFwx++xsfnWz6jOHEBk9fUI=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr25251387lfg.24.1546631149007;
 Fri, 04 Jan 2019 11:45:49 -0800 (PST)
MIME-Version: 1.0
References: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com> <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
 <CAJr6mf2kr4BmCWZU0=EwXURWUZWRHHLifi_2aiUrJSCjnWusZg@mail.gmail.com>
 <CAJr6mf29hJft=rurUK8EJRQ1MS_3_MXb7f-zX0vyXUrQNLcWYA@mail.gmail.com>
 <ff090818-2f5f-1fa0-2eff-6988e1660345@huawei.com> <CAJr6mf1ebw16j0AZSDDxnK2t_=8wdzZBm=X_3DW=zP+XRbRFsw@mail.gmail.com>
 <8af8ef0a-add1-1010-6ef3-7e5c6ff51aa9@huawei.com>
In-Reply-To: <8af8ef0a-add1-1010-6ef3-7e5c6ff51aa9@huawei.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 5 Jan 2019 01:19:39 +0530
Message-ID: <CAFqt6zbZaOA9+SX8CwYobBN_3hhhWOWkcBJ_qdgEuELoOBU5=w@mail.gmail.com>
Subject: Re: [PATCH] scsi/mvsas/mv_init.c: Use dma_zalloc_coherent
To:     John Garry <john.garry@huawei.com>
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 9:34 PM John Garry <john.garry@huawei.com> wrote:
>
> On 04/01/2019 15:11, Sabyasachi Gupta wrote:
> > On Fri, Jan 4, 2019 at 6:43 PM John Garry <john.garry@huawei.com> wrote:
> >>
> >> On 04/01/2019 12:48, Sabyasachi Gupta wrote:
> >>> On Wed, Dec 19, 2018 at 6:49 PM Sabyasachi Gupta
> >>> <sabyasachi.linux@gmail.com> wrote:
> >>>>
> >>>> On Sat, Dec 1, 2018 at 6:40 PM Sabyasachi Gupta
> >>>> <sabyasachi.linux@gmail.com> wrote:
> >>>>>
> >>>>> On Wed, Nov 21, 2018 at 7:18 PM Sabyasachi Gupta
> >>>>> <sabyasachi.linux@gmail.com> wrote:
> >>>>>>
> >>>>>> Replace dma_alloc_coherent + memset with dma_zalloc_coherent
> >>>>>>
> >>
> >> If you're going to make this change, then how about change these to the
> >> managed version, so that we can avoid the explicit free'ing at driver
> >> removal?
> >
> > I can't get it
>
> Please see dmam_alloc_coherent(). You can set __GFP_ZERO in the gfp
> argument to memset(0).

and dma_zalloc_coherent() did the same. So both are same right ? No ?

>
> I would say that this is a more useful change.
>
> >
> >>
> >>>>>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >>>>>
> >>>>> Any comment on this patch?
> >>>>
> >>>> Any comment on this patch?
> >>>
> >>> Any comment on this patch?
> >>>
> >>>>
> >>>>>
> >>>>>> ---
> >>>>>>  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
> >>>>>>  1 file changed, 4 insertions(+), 8 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> >>>>>> index 3ac3437..495bddb 100644
> >>>>>> --- a/drivers/scsi/mvsas/mv_init.c
> >>>>>> +++ b/drivers/scsi/mvsas/mv_init.c
> >>>>>> @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
> >>>>>>         /*
> >>>>>>          * alloc and init our DMA areas
> >>>>>>          */
> >>>>>> -       mvi->tx = dma_alloc_coherent(mvi->dev,
> >>>>>> +       mvi->tx = dma_zalloc_coherent(mvi->dev,
> >>>>>>                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
> >>>>>>                                      &mvi->tx_dma, GFP_KERNEL);
> >>
> >> I'm guessing that this does not pass checkpatch with --strict option.
> >>
> >> Thanks,
> >> John
> >
> > I have not not checked with --strict option
>
> It may warn that you're not maintaining alignment.
>
> >
> >>
> >>>>>>         if (!mvi->tx)
> >>>>>>                 goto err_out;
> >>>>>> -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> >>>>>> -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> >>>>>> +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> >>>>>>                                          &mvi->rx_fis_dma, GFP_KERNEL);
> >>>>>>         if (!mvi->rx_fis)
> >>>>>>                 goto err_out;
> >>>>>> -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
> >>>>>>
> >>>>>> -       mvi->rx = dma_alloc_coherent(mvi->dev,
> >>>>>> +       mvi->rx = dma_zalloc_coherent(mvi->dev,
> >>>>>>                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
> >>>>>>                                      &mvi->rx_dma, GFP_KERNEL);
> >>>>>>         if (!mvi->rx)
> >>>>>>                 goto err_out;
> >>>>>> -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
> >>>>>>         mvi->rx[0] = cpu_to_le32(0xfff);
> >>>>>>         mvi->rx_cons = 0xfff;
> >>>>>>
> >>>>>> -       mvi->slot = dma_alloc_coherent(mvi->dev,
> >>>>>> +       mvi->slot = dma_zalloc_coherent(mvi->dev,
> >>>>>>                                        sizeof(*mvi->slot) * slot_nr,
> >>>>>>                                        &mvi->slot_dma, GFP_KERNEL);
> >>>>>>         if (!mvi->slot)
> >>>>>>                 goto err_out;
> >>>>>> -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
> >>>>>>
> >>>>>>         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
> >>>>>>                                        TRASH_BUCKET_SIZE,
> >>>>>> --
> >>>>>> 2.7.4
> >>>>>>
> >>>
> >>> .
> >>>
> >>
> >>
> >
> > .
> >
>
>
