Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43520C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136862177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548715239;
	bh=tbzSxD0+xFSM1ishrWAIPPJwZeIV502YIUzNV+Sd0uc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=rXX2BUP/kF8JiPliwCm9sPFOokc5Fk/IITC3382NGowisjrBuwwZtOy4REqBUVQ5i
	 jfWk1xobydb6arbS4sLTxA2eOhmfnUFvl81V+1RYxLWu9JlfbEDGSlKJmUFSfK/tgM
	 3G/dSDEgbX/cEOwl976a3dooUvydStPtorzyfYYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfA1Wkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfA1Wkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:40:37 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209A92148E;
        Mon, 28 Jan 2019 22:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548715236;
        bh=tbzSxD0+xFSM1ishrWAIPPJwZeIV502YIUzNV+Sd0uc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zzNW7Z4LR3ETzKrCTkVsT/OzrEOvNfZkXJeSaqXHB5jZnzvdsqT4Rwrs/k1y8fQwF
         7EQhRMf1ZbiFejPninoNPC3WzMAUpu/7gzvInJVIrFP2bI4Pgn45O7bgF+TqbGQ5KB
         0BqhdD68RW7CzO7wsKJaGW/s7ZDpXYe6JtRYX+FE=
Date:   Mon, 28 Jan 2019 14:40:35 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        sstabellini@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        xen-devel@lists.xenproject.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH] arch/arm/xen: Remove duplicate header
In-Reply-To: <d386f867-715f-0667-93bf-b42d728f546a@oracle.com>
Message-ID: <alpine.DEB.2.10.1901281440010.17936@sstabellini-ThinkPad-X260>
References: <20190107173719.GA30197@jordon-HP-15-Notebook-PC> <eab5c59d-cfb4-bd2a-de07-7db827830472@gmail.com> <CAFqt6zb0cU3TjAs0LO-DL3Ut98-7=b7cP9+hZ+bUxDLD2EN2vA@mail.gmail.com> <cd855c41-dca0-14dc-6703-886feccd34ea@gmail.com>
 <d386f867-715f-0667-93bf-b42d728f546a@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-120884440-1548715237=:17936"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-120884440-1548715237=:17936
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 28 Jan 2019, Boris Ostrovsky wrote:
> On 1/28/19 3:29 AM, Oleksandr Andrushchenko wrote:
> > +Boris and Juergen who can also help getting it in
> 
> I can put this in but I'd like to have Stefano's ack, this being ARM.

The patch is OK. Sorry for not replying earlier, this thread fell off my
radar somehow.

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> >
> > On 1/28/19 8:34 AM, Souptick Joarder wrote:
> >> On Mon, Jan 14, 2019 at 4:08 PM Oleksandr Andrushchenko
> >> <andr2000@gmail.com> wrote:
> >>> On 1/7/19 7:37 PM, Souptick Joarder wrote:
> >>>> Remove duplicate header which is included twice.
> >>>>
> >>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> >> Can we get this patch in queue for 5.1 ?
> >>>> ---
> >>>>    arch/arm/xen/mm.c | 1 -
> >>>>    1 file changed, 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> >>>> index cb44aa2..e1d44b9 100644
> >>>> --- a/arch/arm/xen/mm.c
> >>>> +++ b/arch/arm/xen/mm.c
> >>>> @@ -7,7 +7,6 @@
> >>>>    #include <linux/of_address.h>
> >>>>    #include <linux/slab.h>
> >>>>    #include <linux/types.h>
> >>>> -#include <linux/dma-mapping.h>
> >>>>    #include <linux/vmalloc.h>
> >>>>    #include <linux/swiotlb.h>
> >>>>
> >
> 
--8323329-120884440-1548715237=:17936--
