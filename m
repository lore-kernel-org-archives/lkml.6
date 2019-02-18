Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3AA2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjcBjbah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfBRMrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:47:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42848 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbfBRMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:47:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so12171085lfh.9;
        Mon, 18 Feb 2019 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhM/mauBJck6aHRYgcqqFsOsl1B7ZjHg4yd8uzUwQDE=;
        b=mjcBjbahr86ojcygi/eLoNW179Ryv3mSs0MohtnrQAV6FyL+VV1pgHTqrSBRCfjxDD
         3P6j1Y+gqW+caEQE39wjF5Y8WsUDkaatY7qreO2lfZxw2xY9NceIH2vuB9qC2odbVX4U
         h1XX4saztnNAEoPDc82o6JaiCNHqLV2BlsDqGn7UCeKybvfN0NtqktNs3lRnKCLWD03g
         zLIXkVCt7YBC5z4sh6zI96IvebtIW/FypSqGFPqDqb5iSb6vBN31TKRKalKtaBaPdjV8
         Gv4g4zO6IeDglQk636jbmv73/AGMiHSBcis/aSCO1+g8BvwUZ6ArgCmxGQf4z7pfAf1j
         OXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhM/mauBJck6aHRYgcqqFsOsl1B7ZjHg4yd8uzUwQDE=;
        b=NTOygFR5tNinaiFF5BEsUQXbcaNC291Y4suHNTYCqLAgeRM1GTFoqryWPgr3tU0hVe
         IAFTwmuDgFYao5RMl8GfG2jbzRFkwYcFpqGswO2MTjoZQVBhEmauR3e3UL/2IZr23dU2
         4is9WSFrAfPzzi5+fLAHz0M3dRUjhkn4wVJ91XxXIuFNxyuKtIJ+QAEodSrOLLlMBgRX
         DoWCx/DxBeVFSM5m2Q9DnHQ7TOxSNZtyRxVV5nwZSphnn3nHxWUejD7zP1bc6CF9lJK1
         4Gz6JkacGZjM4Vz/aIB1hURhylxA9LLqCIuMNwvxBgetn50uHlNTgj6NA1JfFJfrC3TF
         JzMg==
X-Gm-Message-State: AHQUAubR48S/rI0NmycbbpFzvhxd8y/69MPj7Fspp6b+H5ZZrrBPszsa
        s7cDeyN88qfJ4Kjjb8eqepbN6rXzL2IPgTxPfOc=
X-Google-Smtp-Source: AHgI3IZuUyk0D28Ou67GADmhMyds23jk34C0/RBSJfPoSe4kiB+TgSQa5Tjz5Ptmy8SfkVo0CA5Gf1sx8Kh8TroF6hk=
X-Received: by 2002:a19:ab19:: with SMTP id u25mr13349710lfe.64.1550494031281;
 Mon, 18 Feb 2019 04:47:11 -0800 (PST)
MIME-Version: 1.0
References: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com> <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4>
In-Reply-To: <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 18 Feb 2019 18:16:58 +0530
Message-ID: <CAFqt6zYL8q16a0dKvNb_1MpJCuz4VrkT1pKe=eqpywxA-hnL0Q@mail.gmail.com>
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

Hi Mike,

On Fri, Feb 15, 2019 at 2:19 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 14 Feb 2019 07:59:37 PST (-0800), rppt@linux.ibm.com wrote:
> > The riscv version of free_initmem() differs from the generic one only in
> > that it sets the freed memory to zero.
> >
> > Make ricsv use the generic version and poison the freed memory.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Just for clarity, does same change applicable in below places -

arch/openrisc/mm/init.c#L231
arch/alpha/mm/init.c#L290
arch/arc/mm/init.c#L213
arch/m68k/mm/init.c#L109
arch/nds32/mm/init.c#L247
arch/nios2/mm/init.c#L92
arch/openrisc/mm/init.c#L231


> > ---
> >  arch/riscv/mm/init.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 658ebf6..2af0010 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -60,11 +60,6 @@ void __init mem_init(void)
> >       mem_init_print_info(NULL);
> >  }
> >
> > -void free_initmem(void)
> > -{
> > -     free_initmem_default(0);
> > -}
> > -
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  void free_initrd_mem(unsigned long start, unsigned long end)
> >  {
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> I'm going to assume this goes in with the rest of the patch set, thanks!
>
