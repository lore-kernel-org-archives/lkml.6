Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736CC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1CE206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3929Rhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfBRMug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:50:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44384 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfBRMuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:50:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id q128so14201733ljb.11;
        Mon, 18 Feb 2019 04:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3mDCcqlTfvGRxpNOHBVgyu2R93YF4O1+jAeLCd5+y8=;
        b=d3929Rhyr7JOx9T5ZNS/6Yvki/jgtKOl1mQuZDiAuzD+uLmHBJA2ImNlzS57u0vjU/
         jNws9qOKr7mOkjYV/Nfm4TJXQmA33N16G6VlmjdgKbs310j7PDoFa0VRVneZTdZPGi0M
         W7HvYdSndWcBXb5ZtA7BY/f7kUN02sa4TH4GuisKrt6rTa5WM9LX6XPz7dnG81E2A270
         AvCoZSdQIfycQQEG4BM+aU/M1/S8c36XS6+kwzPIa9efHzaX/TzViHgV9HoS1C27/vME
         ezEEYRnpVK5/QuJAlIUGlOJjVjPEG/u5gaHDT/EpS2x94vaeTTERXn2sYEbj2LoO3qk9
         0TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3mDCcqlTfvGRxpNOHBVgyu2R93YF4O1+jAeLCd5+y8=;
        b=rOGeFKH9ArTk5vjj9hKkgUpaH4eXj/1tm8c2JbagUqP60weGT9PJ5PWROaoi1omMQq
         lgkKW+i9+xs73vOm8hCq/IR7m9DTjN8MMubWznZwMrqcLz4R/FWcQuISeJH7nHc21gq+
         xc/gz3aSHD56tLlhEJ9jhQzZbuH4pNNZWIPmsXRHOvC+r+IkOXdgFAY63ixEOvz3D0IS
         jZnekxPmG0hMfwpXs2Bk2WKU8/GNILwAP0Hk99FXXssKUiIOjvbwSF9TRntUkpyFR/aD
         s1M4rMh/+OEzzDIc+DObdPMVitPxztU9nKea0AL/A96Gn83DYJEf6hXWv7tBNMVVJBuw
         wLeQ==
X-Gm-Message-State: AHQUAuZb3yrLIPLwel+1n9sxCm+wfzoXSPOvLlP3KTa8VP0DH0jITwpE
        e8g46+KvCfFZrVPoyS6HfB49/gJ9EcRtEE8jszc=
X-Google-Smtp-Source: AHgI3Ia7IZsHQNFgpIiE0j0w/ytCYnL63rFO9AwxTQ8Wplej5TLVOxyA2h10iRJ1ZNJWTRv7b5EcitX5kmjrKENMz4g=
X-Received: by 2002:a2e:3807:: with SMTP id f7mr12365910lja.9.1550494232904;
 Mon, 18 Feb 2019 04:50:32 -0800 (PST)
MIME-Version: 1.0
References: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com>
 <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4> <CAFqt6zYL8q16a0dKvNb_1MpJCuz4VrkT1pKe=eqpywxA-hnL0Q@mail.gmail.com>
In-Reply-To: <CAFqt6zYL8q16a0dKvNb_1MpJCuz4VrkT1pKe=eqpywxA-hnL0Q@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 18 Feb 2019 18:20:20 +0530
Message-ID: <CAFqt6zZZaFU_i+srxk9rd_+5V9FTd767MH-rCocvJPfFcXJsCQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: switch over to generic free_initmem()
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, rkuo@codeaurora.org,
        linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 6:16 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Hi Mike,
>
> On Fri, Feb 15, 2019 at 2:19 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Thu, 14 Feb 2019 07:59:37 PST (-0800), rppt@linux.ibm.com wrote:
> > > The riscv version of free_initmem() differs from the generic one only in
> > > that it sets the freed memory to zero.
> > >
> > > Make ricsv use the generic version and poison the freed memory.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>
> Just for clarity, does same change applicable in below places -
>
> arch/openrisc/mm/init.c#L231
> arch/alpha/mm/init.c#L290
> arch/arc/mm/init.c#L213
> arch/m68k/mm/init.c#L109
> arch/nds32/mm/init.c#L247
> arch/nios2/mm/init.c#L92
> arch/openrisc/mm/init.c#L231

Please ignore this query. just saw the other patches.
Sorry for the noise.
>
>
> > > ---
> > >  arch/riscv/mm/init.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > >
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 658ebf6..2af0010 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -60,11 +60,6 @@ void __init mem_init(void)
> > >       mem_init_print_info(NULL);
> > >  }
> > >
> > > -void free_initmem(void)
> > > -{
> > > -     free_initmem_default(0);
> > > -}
> > > -
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > >  void free_initrd_mem(unsigned long start, unsigned long end)
> > >  {
> >
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> >
> > I'm going to assume this goes in with the rest of the patch set, thanks!
> >
