Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7396DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CA420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b88b62M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CA420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeKTAmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:42:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33355 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeKTAmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:42:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so22554866eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2jd1BqXFqFZ3SG+Q8h9Z9F9RW51tXlkmLap4eUJhzE=;
        b=b88b62M+cMz3PK6aR3TIxKqoGjKIiRJiXEbdT4WqYL+kwyKv4WWmKlni3/wsSAKN8U
         SxfKoZWIv/RMcPHXECSJVGlq/v5DrPshPTQnW1fUTWNZSHjgYISgEfN5flcwWpJdIws/
         mFZYf+SJBRDFSvEOFquSgn2EJMxd9gDra77gQxjpmQwhtiFux/8iNy59h6vIzDzmXFqj
         +Ct1IYC+2k1Ahn/exqyLZquBri0Im8egiUYQ50WAuRSls2wkR0cL/yKyPcA+LeIMkytm
         A8UvgdiQU8MhMevmGp/Awy6ZSe3GMIRb5bDflxR/26DMR0FnDpfofR/ZO/P6/GWPxqbF
         /l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2jd1BqXFqFZ3SG+Q8h9Z9F9RW51tXlkmLap4eUJhzE=;
        b=tBfXmAs7wsxZc9qZqum7TMbcRmXPnsGHbpDnXUbVRKwAp158Qri113cIL9TptNprYy
         hkDze0MKIsS15N9YosLBpuqAqiJFoSubc4hdOCS1dWTRCXzJuavUXiFXbEdjB8HDQ5v3
         UyeGZ9LNmL2gwCzSwRQyy0exbRNA0vrdP0jY225+aT2ojAFB15+HYjuCRPKrF+R6np5K
         6zSPZbrWQvE52OPKiapeWcz51G48ZcZqAGbdNQnsSFsqOLd1Kc1bD0biWo7Iurk08o6r
         yS+f4WCrT0Y/5Xyv5eF66ScZIoPpZ9oVwlWe4loZOzGUGQMYC+75oUmIlLGYXm/+UxV1
         cfzQ==
X-Gm-Message-State: AA+aEWY/WJ7by7npggFNSkmcFOcxrfqrmezy1R2ScvaXG6ku/LkRwD0j
        aN8OLK9NhUjIzJCz4sadrXSadAbml+QYyvUZw8o=
X-Google-Smtp-Source: AFSGD/VS7mVvHebfFtOPFUfQ3RkYMTGfBYntxcPnt4zfge+s9oURNgu4W/9LxZO1hHKhAp6/pQpOf/dwrsR2/QiMa/Y=
X-Received: by 2002:a50:b8e5:: with SMTP id l92mr5313298ede.294.1542637093877;
 Mon, 19 Nov 2018 06:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20180927223539.28449-1-hch@lst.de> <20180927223539.28449-6-hch@lst.de>
 <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com> <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
In-Reply-To: <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
From:   Ramon Fried <ramon.fried@gmail.com>
Date:   Mon, 19 Nov 2018 16:18:02 +0200
Message-ID: <CA+Kvs9kPtTZavq91NXs-7edVO5Fxp8gPO=FD35i9_izAdGMkKw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
To:     benh@kernel.crashing.org
Cc:     alexander.duyck@gmail.com, hch@lst.de, linux@roeck-us.net,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 8:02 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> > > -        * Because 32-bit DMA masks are so common we expect every architecture
> > > -        * to be able to satisfy them - either by not supporting more physical
> > > -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > > -        * architecture needs to use an IOMMU instead of the direct mapping.
> > > -        */
> > > -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > > +       u64 min_mask;
> > > +
> > > +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> > > +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > > +       else
> > > +               min_mask = DMA_BIT_MASK(32);
> > > +
> > > +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> > > +
> > > +       if (mask >= phys_to_dma(dev, min_mask))
> > >                  return 0;
> > > -#endif
> > >          return 1;
> > >   }
> >
> > So I believe I have run into the same issue that Guenter reported. On
> > an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> > all probe attempts for various devices were failing with -EIO errors.
> >
> > I believe the last mask check should be "if (mask < phys_to_dma(dev,
> > min_mask))" not a ">=" check.
>
> Right, that test is backwards. I needed to change it here too (powermac
> with the rest of the powerpc series).
>
> Cheers,
> Ben.
>
>

Hi, I'm working on a MIPS64 soc with PCIe root complex on it, and it
appears that this series of patches are causing all PCI drivers that
request 64bit mask to fail with -5.
It's broken in 4.19. However, I just checked, it working on master.
We may need to backport a couple of patches to 4.19. I'm not sure
though which patches should be backported as there were at least 10
patches resolving this dma_direct area recently.
Christoph, Robin.
Can we ask Greg to backport all these changes ? What do you think ?

Thanks,
Ramon.
