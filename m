Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC29C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9DF217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ7RT1td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeLSNLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:11:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42561 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbeLSNLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:11:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so9805633pfr.9;
        Wed, 19 Dec 2018 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUCr3Yr5Mj43tGxrB02mbszV1TmHVrGqCtzMbIx6uNM=;
        b=NQ7RT1tdRkhjTv2NyctBbXn7b5n5KEs/h/vvnM2RwDHgW1L6m+dPQ7BIuktlcQoEqw
         D8cFvnpjl3Sjs/VrS6TaI96wmmFif+6ulH5gccXEcclrdjfmTe0Cn/4OT5ue/71LUq5U
         5oS0SLfCnL5TFREGc8DMPIPCWIPVz9v+N/a89kIauAhrUFFgT2I8p7BOzBFT2QtPfjXI
         YYkhHN5pzhXZd5J/SNQjv+xDmL7EZQU2OduABe6IG3mA71y6dCv039ZrjEXCwYmNlBGQ
         rDUJF2OkQ2lt+qAmdGoHYq2KZ7KXHSwgZ/mJt0EXInfHuLQplQbIybtCRJQtz1VBGnAw
         a6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUCr3Yr5Mj43tGxrB02mbszV1TmHVrGqCtzMbIx6uNM=;
        b=aGVR/6DMen/JyT/iZ3AoFWa2syzs9k2e+cqI810d9i0aezMXgnQnNfiTtXq+vZbXqN
         QS2iTnmbvBmOlM7E0gErwxG0hpmrP4pkeaaR3M3Uq877fznc0GTfjJCJXzo5JeoQZhkq
         0/mRBcE58SoUQ13AzI7V8SokRvnPngnjvXDCssmvtGstG48HEH+7l6k+IeFfH/SVFJ0Q
         CirAiiWuvb8b/VDPbZhiPwBRFOVKoFYLFkY+VUvC4vXJlCUVIaWOf7KVDd0B/il8h98M
         m6Jj2K8A7Mo9MCp3cytfIgdbyz+pC8fa2PR8PI0OFdeNFuJKC2ChiUAMV9SRHZEK8N61
         BNvA==
X-Gm-Message-State: AA+aEWZiWiX0sQwfg9Wd0zj6h88SjbooEPYjpZ/GRl56GE5M3dbKErXM
        qdgS1STrvOoTQSIaZG/wD05CXSAG4HfgxRzEuec=
X-Google-Smtp-Source: AFSGD/WAuV65yiY4RlQRDk1W7LIKy4EVRhw00Vngs+7o/SC0n7n0Uoe16DQ4fP2/eTIHFMFV3LzOtfJo0ZC6ocZDXqk=
X-Received: by 2002:a62:d448:: with SMTP id u8mr20363875pfl.105.1545225075716;
 Wed, 19 Dec 2018 05:11:15 -0800 (PST)
MIME-Version: 1.0
References: <5bf00de4.1c69fb81.7dd65.5785@mx.google.com> <CAJr6mf2Kvj0FJb2zf9FZUNEkyQtYZVbFNBwG+dH_LyhSDU92wg@mail.gmail.com>
In-Reply-To: <CAJr6mf2Kvj0FJb2zf9FZUNEkyQtYZVbFNBwG+dH_LyhSDU92wg@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 19 Dec 2018 18:41:03 +0530
Message-ID: <CAJr6mf0ste8SLahS5Sy2aL9RidxJ_nf5hqeYFriDGtYpB2FUyg@mail.gmail.com>
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

On Sat, Dec 1, 2018 at 6:45 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Sat, Nov 17, 2018 at 6:17 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> >
> > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Any comment on this patch?

Any comment on this patch?

>
> > ---
> >  drivers/scsi/dpt_i2o.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> > index 37de8fb..056383a 100644
> > --- a/drivers/scsi/dpt_i2o.c
> > +++ b/drivers/scsi/dpt_i2o.c
> > @@ -1370,13 +1370,12 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
> >                 schedule_timeout_uninterruptible(1);
> >         } while (m == EMPTY_QUEUE);
> >
> > -       status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> > +       status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> >         if(status == NULL) {
> >                 adpt_send_nop(pHba, m);
> >                 printk(KERN_ERR"IOP reset failed - no free memory.\n");
> >                 return -ENOMEM;
> >         }
> > -       memset(status,0,4);
> >
> >         msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
> >         msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
> > @@ -2836,14 +2835,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
> >
> >         msg=(u32 __iomem *)(pHba->msg_addr_virt+m);
> >
> > -       status = dma_alloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> > +       status = dma_zalloc_coherent(&pHba->pDev->dev, 4, &addr, GFP_KERNEL);
> >         if (!status) {
> >                 adpt_send_nop(pHba, m);
> >                 printk(KERN_WARNING"%s: IOP reset failed - no free memory.\n",
> >                         pHba->name);
> >                 return -ENOMEM;
> >         }
> > -       memset(status, 0, 4);
> >
> >         writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
> >         writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
> > @@ -2890,14 +2888,13 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
> >                         pHba->reply_pool, pHba->reply_pool_pa);
> >         }
> >
> > -       pHba->reply_pool = dma_alloc_coherent(&pHba->pDev->dev,
> > +       pHba->reply_pool = dma_zalloc_coherent(&pHba->pDev->dev,
> >                                 pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4,
> >                                 &pHba->reply_pool_pa, GFP_KERNEL);
> >         if (!pHba->reply_pool) {
> >                 printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
> >                 return -ENOMEM;
> >         }
> > -       memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
> >
> >         for(i = 0; i < pHba->reply_fifo_size; i++) {
> >                 writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
> > @@ -3126,13 +3123,12 @@ static int adpt_i2o_build_sys_table(void)
> >         sys_tbl_len = sizeof(struct i2o_sys_tbl) +      // Header + IOPs
> >                                 (hba_count) * sizeof(struct i2o_sys_tbl_entry);
> >
> > -       sys_tbl = dma_alloc_coherent(&pHba->pDev->dev,
> > +       sys_tbl = dma_zalloc_coherent(&pHba->pDev->dev,
> >                                 sys_tbl_len, &sys_tbl_pa, GFP_KERNEL);
> >         if (!sys_tbl) {
> >                 printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");
> >                 return -ENOMEM;
> >         }
> > -       memset(sys_tbl, 0, sys_tbl_len);
> >
> >         sys_tbl->num_entries = hba_count;
> >         sys_tbl->version = I2OVERSION;
> > --
> > 2.7.4
> >
