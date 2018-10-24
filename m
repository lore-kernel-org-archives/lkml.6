Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB3C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8C72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KktD3WCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8C72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJXMD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:03:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42952 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:03:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id l25-v6so1553465lja.9;
        Tue, 23 Oct 2018 20:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZ9aEOUcDHthwjHrDq31u+c5bAPuU9fCj0i5N/RjvFs=;
        b=KktD3WCsS4z6HHX3L+eW+UvFIoAoQUgQJcNgmx5audcUGyPpzRjgnecya2MlC6QsgC
         D3EmGQa0khHVi4icGZnmA6o+1ypAqJJXCyw4VgYKTPvB7hZ9R6hvoFGPo8BngI/PHE4L
         okRNwXSktqCYul0QpNVBgiFOarOKcoTwd/Bl8gEz+hTdBaPxz2IvfcUWcbqkVkwjeOh0
         HOXQ0XK36SFXRRCwcW1y1ZGDWG2FPZuqb36FDY31b8U+vTCgOP0XG/ZY8NL5wP6jzihY
         LAdKLiQLIJKxr+ZrmPulsofQKtPpxqaB0OgWVD+YUe24xTdOLh6vuUTLx5M1TO1cIbCz
         DWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZ9aEOUcDHthwjHrDq31u+c5bAPuU9fCj0i5N/RjvFs=;
        b=qfP8DxDy4tYGTm8sTGibT2QvAw3T6NQE+g/T0Z1259GWKqqAD9yCu3NufDK2Nxze8y
         tKo7cw6M13meE4A14jxQLDL1pMsD4UIh4NJnAu/03QjruMBKzZ+EbtTSQYLFupImOsb1
         VnJFb0hxAMLMM4LGXHkcfvmCS0sJD97mjzmB9sPyxSVRTjZPzCkS+TmH93cTTa1a3Q7B
         yLV1Qn0m780Yu2cF/GWcOFCy4dBdtB2IClGzr5N9HjCfJhH5wrjRqD3a8INuBGItkQ07
         Z+lMiBIZZLXmhB71DZmi1+7r9yAtnXDZTiMWpsOghf6lBubzeXDFGvGot0FqHZh7uM45
         5XRA==
X-Gm-Message-State: AGRZ1gIyJFYkFWwryHRP788BFmcEr+2Ct1AnFi/nf4MWBUZbB5jQg15H
        Q9Msc3hASFDV+4TdcGAa4Rm+6McOFHT45iFz8o8=
X-Google-Smtp-Source: AJdET5eCRxXt78wpRcFML1XJwTBKbq4oy8QUYYbtKcBaBQqkHAD9+QYFrxleHogs+/KGCsmJbM6rGdebUP1BS8hXmBY=
X-Received: by 2002:a2e:91d9:: with SMTP id u25-v6mr474739ljg.64.1540352231777;
 Tue, 23 Oct 2018 20:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181002052631.GA2853@jordon-HP-15-Notebook-PC> <CAFqt6zbnVTc2EHQR7Bc8LJjix+23o9k5_qYbJfiWmL3tz5+6=g@mail.gmail.com>
In-Reply-To: <CAFqt6zbnVTc2EHQR7Bc8LJjix+23o9k5_qYbJfiWmL3tz5+6=g@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 24 Oct 2018 09:06:59 +0530
Message-ID: <CAFqt6zYpU=2FBnMHQisdTrnKR5F7BY2+hWP-NZH6kRNaTT=NJg@mail.gmail.com>
Subject: Re: [PATCH] scsi/pmcraid.c: Use dma_pool_zalloc
To:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 9:58 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Tue, Oct 2, 2018 at 10:53 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Replaced dma_pool_alloc + memset with dma_pool_zalloc.
> >
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Any comment on this patch ?

Any comment on this patch ?

>
> > ---
> >  drivers/scsi/pmcraid.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
> > index 4e86994..84a2734 100644
> > --- a/drivers/scsi/pmcraid.c
> > +++ b/drivers/scsi/pmcraid.c
> > @@ -4681,7 +4681,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
> >
> >         for (i = 0; i < PMCRAID_MAX_CMD; i++) {
> >                 pinstance->cmd_list[i]->ioa_cb =
> > -                       dma_pool_alloc(
> > +                       dma_pool_zalloc(
> >                                 pinstance->control_pool,
> >                                 GFP_KERNEL,
> >                                 &(pinstance->cmd_list[i]->ioa_cb_bus_addr));
> > @@ -4690,8 +4690,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
> >                         pmcraid_release_control_blocks(pinstance, i);
> >                         return -ENOMEM;
> >                 }
> > -               memset(pinstance->cmd_list[i]->ioa_cb, 0,
> > -                       sizeof(struct pmcraid_control_block));
> >         }
> >         return 0;
> >  }
> > --
> > 1.9.1
> >
