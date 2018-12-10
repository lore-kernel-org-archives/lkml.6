Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A928C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG6frN4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4A62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbeLJRFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:05:02 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:41065 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeLJRFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:05:01 -0500
Received: by mail-vk1-f173.google.com with SMTP id t127so2681375vke.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8d6hJDj9WYGcZt3sOxU9jJpzctdAC7KsWBf92Fbncno=;
        b=IG6frN4IFhlnXf7eyBGJBso/GIv3zt8BhHbMAXIo/2+8/FzmSnipAK4TOGUNbD/fbx
         ALGPxa1j0Sr5UuWMR4PtuPUsWivjAEG6H5JGFVLGCgi6pL9iVex/+a2xLXidzM+cazoU
         4jsCiJiD5MMi0ZSy6V2S4JdXIWH48qYyJB9pyO6n/UZSiz6cl9lflxv+LqEPPpUwYGnD
         OP834UdnBTkqgn4LqcYt3etoj9n4wtxlFs79+CIOU2LTvGH/U+i9A5hGYQm6NhpoTuq8
         4tjPkz80mwZL+pjiL8Gn7ocP47/Jj2eaVgixeRMLxU51FKIsvHuCNQR9moX3AQJsNEpW
         G8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8d6hJDj9WYGcZt3sOxU9jJpzctdAC7KsWBf92Fbncno=;
        b=tVrE8NKCJTghmEqsI+zUuNO56LvvyC4YDerbWH3CuHNgNdEs7WGkGS9LIPK1rRjMVy
         syjD6hScvz1F7i7IOKaGQjya4322O5zS+aVcfN/akY5ppfhCJMYIwWkFarqPc/HDBtZJ
         mSKtgBMpOyGUnKY2oAYeVrUMQETXAEq313IlDtNdG2VCQ4dDRiuDD5UfAS80TyfOFRH1
         rhYsjIk/8SSqOauMeFQ7zfE4KQBBVnIiHOginn1HJERDFD6yFJviT2q6bh621h1Jz1oA
         HgHeRYMHxHBwJRqwTejkjVRMOhIwt4iX+sDma+Kh3GnbtL6Y+CmoJ2jZxngjTkExXqyo
         JxAA==
X-Gm-Message-State: AA+aEWYx4bIa/KlbnS9oapkwLYgSPoRy6PrwvDzdre50GbCtyVNZYZU8
        E9PxUV+AXoCmwaHm2iCvjwPMjgVZdV/pyXYsihQWrPE=
X-Google-Smtp-Source: AFSGD/XwD+ohLgnHVWDVpPif+ofSWFVZqhWkMcZLZLTLZ1xX5bP8T8LpKUW5pVPkDlxiOhTSZKX7OIonH6+NZYPeRkM=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr5436394vka.4.1544461498701;
 Mon, 10 Dec 2018 09:04:58 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de> <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
 <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org> <20181208171746.GB15228@lst.de>
In-Reply-To: <20181208171746.GB15228@lst.de>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 10 Dec 2018 17:04:46 +0000
Message-ID: <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To:     hch@lst.de
Cc:     benh@kernel.crashing.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2018 at 17:17, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Dec 02, 2018 at 05:11:02PM +1100, Benjamin Herrenschmidt wrote:
> > Talking of which ... Christoph, not sure if we can do something about
> > this at the DMA API level or keep hacks but some adapters such as the
> > nVidia GPUs have a HW hack we can use to work around their limitations
> > in that case.
> >
> > They have a register that can program a fixed value for the top bits
> > that they don't support.
> >
> > This works fine for any linear mapping with an offset, provided they
> > can program the offset in that register and they have enough DMA range
> > to cover all memory from that offset.
> >
> > I can probably get the info about this from them so we can exploit it
> > in nouveau.
>
> I think we can expose the direct mapping offset if people care enough,
> we just have to be very careful designing the API.  I'll happily leave
> that to those that actually want to use it, but I'll gladly help
> reviewing it.

Hi, Christoph and Ben,

It just came to my mind (and this is most likely a stupid question,
but still)=E2=80=A6 Is there any possibility of these changes having an
(positive) effect on the long-standing problem of Power Mac machines
with AGP graphics cards (which have to be limited to PCI transfers,
otherwise they'll hang, due to coherence issues)? If so, I have a G4
machine where I'd gladly test them.

Thanks,

Rui
