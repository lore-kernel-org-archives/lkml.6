Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71003C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35012082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 05:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/dhXWRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E35012082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeKBPAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 11:00:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33082 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeKBPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 11:00:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so729944ljz.0;
        Thu, 01 Nov 2018 22:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YntZ9gwJCNSVIPM5t3GqVt6hvE3MJCbg0KiZiWVKHk0=;
        b=Z/dhXWRhTgfXJGfWsUBUmvL4OIrwcHVVqZOuwBSE+E+vEstcs6iW+rMCY31tbSBHOQ
         akNiLdZrepoUHdJfSE1l7sPNIUfil6snrccGS9Eu0sv2EnYDZFQFx0JiT8Y6pwM4yme3
         MoVOwK7LQAbWpMwk1CkoMcJXg1QNjx6pTIo0MfOhNLeA7eCNWOZmDcQg31upoBd7EMwl
         Fl4DjujJrkfZKYyMyseeMQcd8rWr/SC5Y7zcsL5hB5D/wL8tmmsK/Wm0uo62PSUjQ19W
         Omh5vxSimDFVB8a5CVStd/tbEklz9zJVo+aIuD1pE85yVTLkb8QtuS/DRw9oCsdHIPGa
         XGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YntZ9gwJCNSVIPM5t3GqVt6hvE3MJCbg0KiZiWVKHk0=;
        b=PnUuwhpMlb8aK0wijxaC/4bYL8+QrbgXqiFltEPy/m2bgWQoztonkZ53JBxJFs8dbN
         RWoGUzaCs+A7DDdGKN40O5XE/FY2KrQ9CDLkqIGub+LQ6/g2Y/vUjoG4BalBeLxgNV85
         TH6Z07Mk4jFqV8BLzB+6UCdLwo7cAy6GyyA6mFTkoyZBIAix45gLuEsNUbFtUFGAuk24
         fZVqlKKc24vGmfFxgZVeO421mP3hY08JPZJxWDlYFyzyrVlNL1fPfooUj91nN3X/5yYQ
         QMqg5DtcGuF9wdoNIh2dvOW3t4S6xibDazOLiTCr9R3KE1nFMjvfDA6yywt2tVtfWXaB
         INEQ==
X-Gm-Message-State: AGRZ1gJYRjCrFSxmV2R3/m5Vo3+0osFKKb9/ANVh+AFz4lrwK6ld6Lwx
        E+NQr5RheP0I9RjiMAr7KFUgR1vpLNeg6QLXr+o=
X-Google-Smtp-Source: AJdET5dSOR+a4lQNovexJOB965sIjkrn/qfqgXi0xdO3GxDJCdqOICA+9LLqueJ2BP5tawjmqniw7LK8FALCCslHMrw=
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr5706858lji.149.1541138056235;
 Thu, 01 Nov 2018 22:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20181101041909.GA3241@jordon-HP-15-Notebook-PC> <CAGXu5jLYaT7LtUS+t98GjMjjzz2kbs6JZ_WJRYnWo7iZ9nOFKQ@mail.gmail.com>
In-Reply-To: <CAGXu5jLYaT7LtUS+t98GjMjjzz2kbs6JZ_WJRYnWo7iZ9nOFKQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 2 Nov 2018 11:24:03 +0530
Message-ID: <CAFqt6zbfizXX8myKgE_5k6X2gDrQGJmhWJDubgqiTL2r62gb_Q@mail.gmail.com>
Subject: Re: [PATCH] scsi/aic94xx/aic94xx_hwi.c: Use dma_pool_zalloc
To:     Kees Cook <keescook@chromium.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 2:25 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 31, 2018 at 9:19 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > Replaced dma_pool_alloc + memset with dma_pool_zalloc
> >
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks Kees.
>
> -Kees
>
> > ---
> >  drivers/scsi/aic94xx/aic94xx_hwi.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
> > index 3b8ad55e59de..2bc7615193bd 100644
> > --- a/drivers/scsi/aic94xx/aic94xx_hwi.c
> > +++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
> > @@ -1057,14 +1057,13 @@ static struct asd_ascb *asd_ascb_alloc(struct asd_ha_struct *asd_ha,
> >
> >         if (ascb) {
> >                 ascb->dma_scb.size = sizeof(struct scb);
> > -               ascb->dma_scb.vaddr = dma_pool_alloc(asd_ha->scb_pool,
> > +               ascb->dma_scb.vaddr = dma_pool_zalloc(asd_ha->scb_pool,
> >                                                      gfp_flags,
> >                                                     &ascb->dma_scb.dma_handle);
> >                 if (!ascb->dma_scb.vaddr) {
> >                         kmem_cache_free(asd_ascb_cache, ascb);
> >                         return NULL;
> >                 }
> > -               memset(ascb->dma_scb.vaddr, 0, sizeof(struct scb));
> >                 asd_init_ascb(asd_ha, ascb);
> >
> >                 spin_lock_irqsave(&seq->tc_index_lock, flags);
> > --
> > 2.17.1
> >
>
>
>
> --
> Kees Cook
