Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCA0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA73C218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgZnM72Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfA3J7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:59:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41500 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3J7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:59:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so20140300ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 01:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO9lml+l22jOIyAkjdHX9mgdNk63cVEuzFUCTmyVOGY=;
        b=FgZnM72ZgZjEW0ORM0btMd9MaPOSZrwy4G9BeQws0rUHuJHemFIVbE0ZCoZpaoosFw
         N3PdCNT6kXYw8DLArD26ROZeZzX8+8jjnLe36XfsiwPdVYaU43zXcTbDoeiwCN+mqekZ
         zsoH+T/bie3kWtmE8bXeQ2qFizuDognaAGSBbIlF5jIr4yvCiyJNi5O0iEa6OXD864pj
         BpkiZ0YjlrSKJQbkgDtZBfRpE+Ti0E2FKogNXGRbdJ+XauSFmM8wamMDzXg6IiWxAQg2
         S+Sq6rxtBEO6tnO7W5lo0N1bX0uEQxNNNyjyTB1Ey2rgMaID4CY2GUA+/xaXoy8YJvrH
         vAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO9lml+l22jOIyAkjdHX9mgdNk63cVEuzFUCTmyVOGY=;
        b=YzVujh0A0GDdbMxinmrhiEFW+ers5FHx2Jdmmz4G6Xszg57VwspP1rgtlFo0R73BsA
         ibULt2AVjea60+ohd06yhsBLjFnUSLP2CwJJNy+mJPIeCyTVHoUtDu5arHWKahgyxvM7
         x3L4RttwvWHAuHf6otKMjl7G/M11f95ou0IpWdCGZCz19To/j73eChHKN68D8gXSuTpS
         rheX4O7rT7DDDUOvivL50AEuCIXGdpNENU4LN/HNMEE+Nmq/yNwY7MO8OwaO7OGY3Pg3
         RuMJqAWxfNOsg579y0m8YinuaaKEd5dF53cSyUpNZqV/JVuE42xNMkV1r47hM8Tqanb0
         YDQg==
X-Gm-Message-State: AJcUukcC01+skE0l8xPzbpYLT3sFkO4vSSE3AN14cKVc4zKZ9UKQsYbS
        xtnq6tF9WCNjdN1cPRAT9G8wnCWG40onViPHKXw=
X-Google-Smtp-Source: ALg8bN7/li39XaGpJQ6EMr2lSSqiHUCbw+mdn4YxxMLFOWbC7mmMJ4AR7eu7vhwFRP/Adj9lqWbSZT1zXyytNWz3m6c=
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr23772381ljd.31.1548842347483;
 Wed, 30 Jan 2019 01:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20190111150834.GA2744@jordon-HP-15-Notebook-PC> <CAFqt6zYLDrC7CtLawWUAQPyB_M+5H8BikDR6LOm+v0qaq1GvZw@mail.gmail.com>
In-Reply-To: <CAFqt6zYLDrC7CtLawWUAQPyB_M+5H8BikDR6LOm+v0qaq1GvZw@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 30 Jan 2019 15:28:55 +0530
Message-ID: <CAFqt6zY4YgsCUPFqR2yYegjqtHJ_aeE1Ao6p=fE92s2__3XTsA@mail.gmail.com>
Subject: Re: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use vm_insert_range_buggy
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stefanr@s5r6.in-berlin.de,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Fri, Jan 11, 2019 at 8:34 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > Convert to use vm_insert_range_buggy to map range of kernel memory
> > to user vma.
> >
> > This driver has ignored vm_pgoff and mapped the entire pages. We
> > could later "fix" these drivers to behave according to the normal
> > vm_pgoff offsetting simply by removing the _buggy suffix on the
> > function name and if that causes regressions, it gives us an easy
> > way to revert.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>
> Any comment on this patch ?

Any comment on this patch ?

>
> > ---
> >  drivers/firewire/core-iso.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
> > index 35e784c..99a6582 100644
> > --- a/drivers/firewire/core-iso.c
> > +++ b/drivers/firewire/core-iso.c
> > @@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
> >  int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
> >                           struct vm_area_struct *vma)
> >  {
> > -       unsigned long uaddr;
> > -       int i, err;
> > -
> > -       uaddr = vma->vm_start;
> > -       for (i = 0; i < buffer->page_count; i++) {
> > -               err = vm_insert_page(vma, uaddr, buffer->pages[i]);
> > -               if (err)
> > -                       return err;
> > -
> > -               uaddr += PAGE_SIZE;
> > -       }
> > -
> > -       return 0;
> > +       return vm_insert_range_buggy(vma, buffer->pages,
> > +                                       buffer->page_count);
> >  }
> >
> >  void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
> > --
> > 1.9.1
> >
