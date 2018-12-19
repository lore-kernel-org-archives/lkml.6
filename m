Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E86CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLQQ/NGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeLSHYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:24:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43826 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLSHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:24:32 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so14234156lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 23:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2FohPlTqqDlG6f3TAHjmUUruPHrATpRScTaxik8168=;
        b=hLQQ/NGJlN4QaGIb/X4rfRak9S/j9y4cOfuocHiF3yDseBs7k7IwKPMqQ2F/0Dat4S
         gR7kjWBZo1R+ArrsCBkZ+BWMrjjvmSST/Ir9rrZ8WtmeMU00b7vPxCJTL59nfwcdfT4g
         tZiqxsI6xlVMcphwSDnbAIFDVSXf/wbDCwJaP4jbdHwvvvN+ScILFMeDUw0WbeSBQBDy
         DFP+Vx5BXoN9yEry4KhRDeibYmj95L3oVJHluDxMaEQRVm6d12qTMNwirw80hxaQhM9g
         0cBXWvGVDSprU2jJWEHiwzukgSb+076Yiqx2vjruDMxBXWXbGanXE7KAsy/PbikAXdOL
         H1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2FohPlTqqDlG6f3TAHjmUUruPHrATpRScTaxik8168=;
        b=C5ToGkSiyzlQSzqbrvl20Jg3MX3NtJffRHCx6U68OQCk1kbHIckH/mV9vjoXYZdR3A
         FEELHEvu4pl8+ytga+Z5asIsvEWYpkOE0uQgbKyXsoedbNM7qH4bAl41Pd8YyJxKyrwE
         oZKAQbffgjDfDE0aGF0ZSYSrgP9IliIdYGBapOHSR1wbmeHeTPSyiG0SSqFq8TuHcceJ
         8IrxyH2c3WCl/EbI/c29DTyCJtkluv037zYmGwwB234xgUpK6Vn0sXOHqZk1N6RtyXeM
         dSC1F1GSjObjmHvopqqyLABYJBTkMduM5mu7Yt3xvdzjNn9meSP8AS7CKNp+yjxcDtJQ
         hCUQ==
X-Gm-Message-State: AA+aEWb3YIMl6j0SL+C7Zeswd12Cg1q2scYyR29eLTjp7N3HYQa2IJpt
        z/Du94qsymkJGJXQdPGYt1keIt0jqqJJ3yYfwhM=
X-Google-Smtp-Source: AFSGD/W75bu3aSShy6XJY9/NU4LyAPVHx94cqD93BE7YR86z/wz7sm02PIiivtNAzC78gVvPzTCUh1acMisM2ppThB4=
X-Received: by 2002:a19:2906:: with SMTP id p6mr3587675lfp.17.1545204270516;
 Tue, 18 Dec 2018 23:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20181217202246.GA10500@jordon-HP-15-Notebook-PC> <20181218104513.GM26090@n2100.armlinux.org.uk>
In-Reply-To: <20181218104513.GM26090@n2100.armlinux.org.uk>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 19 Dec 2018 12:54:18 +0530
Message-ID: <CAFqt6zZw2jO5qGjG3CdAZR2ZXt19+ykhyw+hhVDP7xTaemusiA@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] drivers/firewire/core-iso.c: Convert to use vm_insert_range
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stefanr@s5r6.in-berlin.de,
        Linux-MM <linux-mm@kvack.org>,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 4:15 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 18, 2018 at 01:52:46AM +0530, Souptick Joarder wrote:
> > Convert to use vm_insert_range to map range of kernel memory
> > to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  drivers/firewire/core-iso.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> > index 35e784c..7bf28bb 100644
> > --- a/drivers/firewire/core-iso.c
> > +++ b/drivers/firewire/core-iso.c
> > @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
> >  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
> >                         struct vm_area_struct *vma)
> >  {
> > -     unsigned long uaddr;
> > -     int i, err;
> > -
> > -     uaddr = vma->vm_start;
> > -     for (i = 0; i < buffer->page_count; i++) {
> > -             err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> > -             if (err)
> > -                     return err;
> > -
> > -             uaddr += PAGE_SIZE;
> > -     }
> > -
> > -     return 0;
> > +     return vm_insert_range(vma, vma->vm_start, buffer->pages,
> > +                             buffer->page_count);
>
> This looks functionally equivalent.  Note that if we go with my
> proposal to your patch 4, that would cause an issue for this
> implementation.
>
> Maybe we need two functions, but that then causes problems with
> which function should be used (which makes it easy to get wrong.)

I think, apart from patch [4/9] and [6/9], all others places can be
directly replaced
with vm_insert_range(). [4/9] and [6/9] are the places where
*vma->vm_pgoff* need to be
considered and need to adjust *count* accordingly. In my opinion, bugs
around these
[4/9] & [6/9] can be fixed (raised during review) to accommodate it to
use vm_insert_range().
>
> I'm beginning to wonder if the risks of causing regressions and
> introducing bugs is actually worth the effort of trying to clean
> this up.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
