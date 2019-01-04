Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11A0208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCuP2NqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfADMtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:49:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45206 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfADMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:49:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so17396552plm.12;
        Fri, 04 Jan 2019 04:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AycUfNSJycQhs83XV0Xsk3/MJF6stOLOivW4qLS2vBw=;
        b=BCuP2NqEgiwxHKx7B2JvLiD2fOEEkSHGs8lTByP45e/an7L/V/BD7wBlWolZSG8aNr
         Fz20ltIDDDzYBt0iyIl+wmmHBSnqkOaWZmfxvYtWvk27wmOCIS/aLjmLky3bmsTvwfJ2
         1bz4RJKAIM6ErMN/bB6/ugrezfQChuKe1lFAMJ2BOE20CKCULrRI6PhjSbAus+LZcmY0
         h4OOS1hTRHqOMRkviazUYZ2YSwl+qWL6kFwpeLcC8QZFVeZT/tZyTs7TFMe4lSm/Uksz
         uJpf2D8Q3eEFV2MrwjZDhQa58DE1zUGp7VwADcO/ZiVS2gQjBUwMXNbz9Q+CpNHAstzp
         LVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AycUfNSJycQhs83XV0Xsk3/MJF6stOLOivW4qLS2vBw=;
        b=F/VcouJkXRajCj9ThiFaUGAAvfpGdUHK7DHTCYaD1VhNfI3MQjAXrSmLgrmCere4Cd
         hxvPclG6ZbyDO3qE7w7ZXuiGux2zEvaynzbhPWfq3AVCqQmO7NxngimMUfpsSxFimTT+
         pk7EjvVbor/19HSlZzmlUqZFYXzu/vwkUmSU6Qaq0qWhVfnClWnmCV81Rgu3SzYhLJg9
         0MsJ2iFkMXqYyq1XkPDNmug8wor2o64sMKApoYKri89ZfXv5nQUbxcQWCIbeTSgaHqrh
         gWY7gGNgmztrrXpQQgxpLOZRlfny5Sym0AvmWMIxJgENqZeJvjP6CPOkRC5Ov/BbMswh
         XlUA==
X-Gm-Message-State: AJcUukdq3v2CduaYSKpy9YsfKm6ueLKshaVAuOJular9OdO+bKjL00Mg
        7HPLGktpOtCW03ctaTt4huY9J80KfNSW4XogLg4=
X-Google-Smtp-Source: ALg8bN7TAeCcJtI//GgZLHMFhMl7eyL/LPHD8hB8lX9JOMUEQXsmBfP5294ymzZh3Omd31rKwgLi4fycsnQgPb7RZ00=
X-Received: by 2002:a17:902:9f89:: with SMTP id g9mr51296219plq.214.1546606186008;
 Fri, 04 Jan 2019 04:49:46 -0800 (PST)
MIME-Version: 1.0
References: <5bf00de4.1c69fb81.7dd65.5785@mx.google.com> <CAJr6mf2Kvj0FJb2zf9FZUNEkyQtYZVbFNBwG+dH_LyhSDU92wg@mail.gmail.com>
 <CAJr6mf0ste8SLahS5Sy2aL9RidxJ_nf5hqeYFriDGtYpB2FUyg@mail.gmail.com>
In-Reply-To: <CAJr6mf0ste8SLahS5Sy2aL9RidxJ_nf5hqeYFriDGtYpB2FUyg@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Fri, 4 Jan 2019 18:19:34 +0530
Message-ID: <CAJr6mf0CE8wcKxoEEhdrp+j7=-LBe4Ue0xjqfCfJGCg-kiYFoA@mail.gmail.com>
Subject: Re: [PATCH] scsi/dpt_i2o.c: Use dma_zalloc_coherent
To:     aacraid@microsemi.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 6:41 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Sat, Dec 1, 2018 at 6:45 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > On Sat, Nov 17, 2018 at 6:17 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > >
> > > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Any comment on this patch?
>
> Any comment on this patch?
>
Any comment on this patch?

> >
> > > ---
> > >  drivers/scsi/dpt_i2o.c | 12 ++++--------
> > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> > > index 37de8fb..056383a 100644
> > > --- a/drivers/scsi/dpt_i2o.c
> > > +++ b/drivers/scsi/dpt_i2o.c
> > > @@ -1370,13 +1370,12 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
> > >                 schedule_timeout_uninterruptible(1);
> > >         } while (m == EMPTY_QUEUE);
> > >
> > > -       status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> > > +       status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> > >         if(status == NULL) {
> > >                 adpt_send_nop(pHba, m);
> > >                 printk(KERN_ERR"IOP reset failed - no free memory.\n");
> > >                 return -ENOMEM;
> > >         }
> > > -       memset(status,0,4);
> > >
> > >         msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
> > >         msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
> > > @@ -2836,14 +2835,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
> > >
> > >         msg=(u32 __iomem *)(pHba->msg_addr_virt+m);
> > >
> > > -       status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> > > +       status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> > >         if (!status) {
> > >                 adpt_send_nop(pHba, m);
> > >                 printk(KERN_WARNING"%s: IOP reset failed - no free memory.\n",
> > >                         pHba->name);
> > >                 return -ENOMEM;
> > >         }
> > > -       memset(status, 0, 4);
> > >
> > >         writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
> > >         writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
> > > @@ -2890,14 +2888,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
> > >                         pHba->reply_pool, pHba->reply_pool_pa);
> > >         }
> > >
> > > -       pHba->reply_pool = dma_alloc_coherent(&pHba->pDev->dev,
> > > +       pHba->reply_pool = dma_zalloc_coherent(&pHba->pDev->dev,
> > >                                 pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4,
> > >                                 &pHba->reply_pool_pa, GFP_KERNEL);
> > >         if (!pHba->reply_pool) {
> > >                 printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
> > >                 return -ENOMEM;
> > >         }
> > > -       memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
> > >
> > >         for(i = 0; i < pHba->reply_fifo_size; i++) {
> > >                 writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
> > > @@ -3126,13 +3123,12 @@ static int adpt_i2o_build_sys_table(void)
> > >         sys_tbl_len = sizeof(struct i2o_sys_tbl) +      // Header + IOPs
> > >                                 (hba_count) * sizeof(struct i2o_sys_tbl_entry);
> > >
> > > -       sys_tbl = dma_alloc_coherent(&pHba->pDev->dev,
> > > +       sys_tbl = dma_zalloc_coherent(&pHba->pDev->dev,
> > >                                 sys_tbl_len, &sys_tbl_pa, GFP_KERNEL);
> > >         if (!sys_tbl) {
> > >                 printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");
> > >                 return -ENOMEM;
> > >         }
> > > -       memset(sys_tbl, 0, sys_tbl_len);
> > >
> > >         sys_tbl->num_entries = hba_count;
> > >         sys_tbl->version = I2OVERSION;
> > > --
> > > 2.7.4
> > >
