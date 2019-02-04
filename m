Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77F8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9712520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549298482;
	bh=Ss66ahMFpJjx2AXq5p89HNr6rZeaiszEgbJtSZn9kF8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l+R1f1SDTDM2vYoK+HKcK9JmB3qXW6MdgCqfUAyNHkXaonw+z4upcrlKOF4FNGfkE
	 bKsUiDL+dvu/ZzzEZzySWpAMH+rYUI4LomTnklAaZU6UUwm0F/XKwr5RXGoAyLE8Ac
	 xUQMs0V5p8vdk9d1uUP6ttotkpUpP84jiXnpy3GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfBDQlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:33340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbfBDQlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:41:20 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E05218A1;
        Mon,  4 Feb 2019 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549298479;
        bh=Ss66ahMFpJjx2AXq5p89HNr6rZeaiszEgbJtSZn9kF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ywXQsdsxfY/02cfGV+cNmFU5Q3zWTPx0baxoErM4b9RrPbm76eEGw7fXDMPvXFHmo
         guSyBLeHDMw8Yy1G3hvmt5JLfe59sfUn3OkmTHY44ZiJLQNOhPY+MYt+eWA9LYhFDd
         11PaLhnS2JqZBN1DEb6RaU5IJCY8QXVdxe2NJ90g=
Received: by mail-qk1-f179.google.com with SMTP id z18so293132qkj.10;
        Mon, 04 Feb 2019 08:41:19 -0800 (PST)
X-Gm-Message-State: AHQUAuYd6IkCBXyXbBrzJJ7r+opdDB8mLrnRUK8x0HjZchG5ac7Lt7Q3
        7AkUCX4anW0ibGO6D1sE/nEE/wY4MkyzmESbAg==
X-Google-Smtp-Source: AHgI3IY4IOsZzDE6yuHz1ZhKqDg+gUuEQp7ZZ0732weFIIysT+Az3A99N65wCfpMD2ci1Jx4wDPDzb/P6wodZaj5Cn0=
X-Received: by 2002:a37:6451:: with SMTP id y78mr170404qkb.147.1549298478828;
 Mon, 04 Feb 2019 08:41:18 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx> <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr> <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx> <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx> <f2bdb061-2fdf-ee78-fc46-a38ebb40b03f@free.fr>
 <f6ea664b-68e9-de57-e5de-c691d828c8a2@free.fr> <20190204152505.GA12918@kroah.com>
In-Reply-To: <20190204152505.GA12918@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Feb 2019 10:41:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFEs087VEAMKUUTAPErO_tKDNSe5fsK=tsuCnM=kMf4w@mail.gmail.com>
Message-ID: <CAL_JsqJFEs087VEAMKUUTAPErO_tKDNSe5fsK=tsuCnM=kMf4w@mail.gmail.com>
Subject: Re: [PATCH v2] of: fix kmemleak crash
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 9:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Feb 04, 2019 at 11:10:39AM +0100, Marc Gonzalez wrote:
> > + GKH
> >
> > On 01/02/2019 17:23, Marc Gonzalez wrote:
> >
> > > On 23/01/2019 13:31, Mike Rapoport wrote:
> > >
> > >> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > >> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > >> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > >> ---
> > >>  drivers/of/of_reserved_mem.c | 18 +++++-------------
> > >>  1 file changed, 5 insertions(+), 13 deletions(-)
> > >
> > > Thanks for the patch, Mike.
> > >
> > > Whose tree should this patch go through?
> >
> > By the way, I think we can add
> >
> > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > Cc: stable@vger.kernel.org # 3.15+
>
> What am I supposed to do with this?

Nothing til I apply it.

Rob
