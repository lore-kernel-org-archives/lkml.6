Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C67C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BF321871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcyKwfDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfADPLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:11:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41585 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfADPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:11:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so17629003pgq.8;
        Fri, 04 Jan 2019 07:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ykevx0nGBspU04Q/rzgX0xdKqM8eDjaERaoZK6Fzxc4=;
        b=gcyKwfDHMUdiYLkN76Vq5KQHFAqX1PKOS8RAbhwWn3Wju4xdYmSnHzfwmQFYTaUtZE
         4n0xTtfGnSm9i3T5ARh5ZYJPgwpC1qYIn7m+PfMlFeDX3tKN3s1AGPSYPtCx+N+J2Ek6
         Cp03WRRWhC0aA5m5vjsOnj8UqkHTdMmt23RsZ1ftAFZdQ6p9QRSr0AR6716H1/nvHc4D
         acWEB36phx7pQLEjJemnWH9mZgGepJAvzP3TupPGz+w1TWd0bcGQS+kJVz0PeH0p42OJ
         iHuzoOGDG5LjVJgIp93EaZc7ZzrOjxWI2MSufAO+L6yRU33Qv2YhHDCXiYx7uzUushaY
         LQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ykevx0nGBspU04Q/rzgX0xdKqM8eDjaERaoZK6Fzxc4=;
        b=HplIDKhHVTzt9BMGD9resPfjlNWpXBL4ng4mMTRTndclxKEGj8bqStDTyuaRWHL3S+
         7XLtSKE9Mt8srzbHYSItUakiV8jtUGoIInII47n3CtfQX6J0V32PQAely4a+7DiFO76M
         GbKkkO6sfjqBJDs81lL3oBdtaEd7DxdCtlYGxcPTelIE2a2OnASviRp/Jqgt1kW1wRD9
         WEmy72QIL3VS3dTR89FvNKMkhDzHSvBplUojzaA+SOA3FMdmctEP0xHQXhOaY5/RsiFI
         8WO37iY2mUTkYuDqwATa9jmTjKRL5TP6vD+g4BBnAjyMaoqjwheCnQtM9bF/ueyVj63d
         nBpg==
X-Gm-Message-State: AJcUukcQVFyiC9f12pU8L+qPszp7laMJ2zUxZrsVMlqOa5+eGgiCQldF
        R7UlPzjfwSzmVtuVzt50nlD+CORM9xkaoZp8Vhk=
X-Google-Smtp-Source: ALg8bN6srmYHGQZWn438RqfNivarEq5KUnBbkqIsyQOgABlCFzCv+4z6KMwDi1aXTSVgL62NhliDpm8pwmDJoo6KTOo=
X-Received: by 2002:a63:4d66:: with SMTP id n38mr49362239pgl.270.1546614707675;
 Fri, 04 Jan 2019 07:11:47 -0800 (PST)
MIME-Version: 1.0
References: <5bf56248.1c69fb81.21a6e.5a72@mx.google.com> <CAJr6mf11gp9iV=NiFEFyo7kSZfCfMsEySdijem_PhMFEAwqucA@mail.gmail.com>
 <CAJr6mf2kr4BmCWZU0=EwXURWUZWRHHLifi_2aiUrJSCjnWusZg@mail.gmail.com>
 <CAJr6mf29hJft=rurUK8EJRQ1MS_3_MXb7f-zX0vyXUrQNLcWYA@mail.gmail.com> <ff090818-2f5f-1fa0-2eff-6988e1660345@huawei.com>
In-Reply-To: <ff090818-2f5f-1fa0-2eff-6988e1660345@huawei.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Fri, 4 Jan 2019 20:41:36 +0530
Message-ID: <CAJr6mf1ebw16j0AZSDDxnK2t_=8wdzZBm=X_3DW=zP+XRbRFsw@mail.gmail.com>
Subject: Re: [PATCH] scsi/mvsas/mv_init.c: Use dma_zalloc_coherent
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        jthumshirn@suse.de, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 6:43 PM John Garry <john.garry@huawei.com> wrote:
>
> On 04/01/2019 12:48, Sabyasachi Gupta wrote:
> > On Wed, Dec 19, 2018 at 6:49 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> >>
> >> On Sat, Dec 1, 2018 at 6:40 PM Sabyasachi Gupta
> >> <sabyasachi.linux@gmail.com> wrote:
> >>>
> >>> On Wed, Nov 21, 2018 at 7:18 PM Sabyasachi Gupta
> >>> <sabyasachi.linux@gmail.com> wrote:
> >>>>
> >>>> Replace dma_alloc_coherent + memset with dma_zalloc_coherent
> >>>>
>
> If you're going to make this change, then how about change these to the
> managed version, so that we can avoid the explicit free'ing at driver
> removal?

I can't get it

>
> >>>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >>>
> >>> Any comment on this patch?
> >>
> >> Any comment on this patch?
> >
> > Any comment on this patch?
> >
> >>
> >>>
> >>>> ---
> >>>>  drivers/scsi/mvsas/mv_init.c | 12 ++++--------
> >>>>  1 file changed, 4 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> >>>> index 3ac3437..495bddb 100644
> >>>> --- a/drivers/scsi/mvsas/mv_init.c
> >>>> +++ b/drivers/scsi/mvsas/mv_init.c
> >>>> @@ -253,33 +253,29 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
> >>>>         /*
> >>>>          * alloc and init our DMA areas
> >>>>          */
> >>>> -       mvi->tx = dma_alloc_coherent(mvi->dev,
> >>>> +       mvi->tx = dma_zalloc_coherent(mvi->dev,
> >>>>                                      sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ,
> >>>>                                      &mvi->tx_dma, GFP_KERNEL);
>
> I'm guessing that this does not pass checkpatch with --strict option.
>
> Thanks,
> John

I have not not checked with --strict option

>
> >>>>         if (!mvi->tx)
> >>>>                 goto err_out;
> >>>> -       memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
> >>>> -       mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> >>>> +       mvi->rx_fis = dma_zalloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
> >>>>                                          &mvi->rx_fis_dma, GFP_KERNEL);
> >>>>         if (!mvi->rx_fis)
> >>>>                 goto err_out;
> >>>> -       memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
> >>>>
> >>>> -       mvi->rx = dma_alloc_coherent(mvi->dev,
> >>>> +       mvi->rx = dma_zalloc_coherent(mvi->dev,
> >>>>                                      sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
> >>>>                                      &mvi->rx_dma, GFP_KERNEL);
> >>>>         if (!mvi->rx)
> >>>>                 goto err_out;
> >>>> -       memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
> >>>>         mvi->rx[0] = cpu_to_le32(0xfff);
> >>>>         mvi->rx_cons = 0xfff;
> >>>>
> >>>> -       mvi->slot = dma_alloc_coherent(mvi->dev,
> >>>> +       mvi->slot = dma_zalloc_coherent(mvi->dev,
> >>>>                                        sizeof(*mvi->slot) * slot_nr,
> >>>>                                        &mvi->slot_dma, GFP_KERNEL);
> >>>>         if (!mvi->slot)
> >>>>                 goto err_out;
> >>>> -       memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
> >>>>
> >>>>         mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
> >>>>                                        TRASH_BUCKET_SIZE,
> >>>> --
> >>>> 2.7.4
> >>>>
> >
> > .
> >
>
>
