Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EDCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3087821A1C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYIbQz41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3087821A1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeHQUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:49:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45840 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeHQUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:49:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so15316413oic.12;
        Fri, 17 Aug 2018 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=47bva1FwOvZha3+c6EC0lnETgaFc5rRSsy1ialbGhBQ=;
        b=tYIbQz414mOGf2qqXpQVtfWJRjVPqTnFcB5hRqsnJxCVaeydHmpXwTBXhXVBdjAN5R
         RYUSTJPgMwMfWVIxFt6RMkvHi8ejmwSTBtmvsxRulHo53HxzRc9KsSCYuI2LTkkyjC54
         rA9lRwyYvSSrNDj8VI/ZAG0J4pTi/6MvnVR5iPFyikEj4gUifmTBfWhUYzgVWApy6n9w
         ObzDPQnWUk2x1u8WVgCygVw0pBMceI2d8iBRcK+GUkG2UG1/ABICEv4xVqx8XyFYqtxi
         f+0UwiUlzhZRBJmo1+xYrSRaPrqapgAZwnaNkQ34M9XLffCboZR9NXHwRogOzzquyR2o
         NtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=47bva1FwOvZha3+c6EC0lnETgaFc5rRSsy1ialbGhBQ=;
        b=lmMRBSHB1+etmfO3YnVjxvnC5TPZhiw8GlAbzcNqcoU2B1aSuNKrdTFd3OEQOqqtLN
         wl8X41GdvpKDN/jhC7WXpmzWAYCqeJIG2c/oU6OEbY/6Qbn6/654mOqXL+wd36pMHl/9
         PGXTR9IT6Y9kJqTDL/lNd+RmfuZhVakb+JQ55eT6zrfXaECyQ67XnC+BWHhN9iWJQi5o
         9rjCeThzPoFiw1+NNREZL7eirhFm/tD9259Zi5HO5eecRQ1Zlz8IaXW+EBxRKi8iOAAL
         bu9iLrN27lJvtZyzMN4uoxa/FHZ9F5plOBtWabTQaheFi7sIWeJz3XZAt58KZA5GMHTj
         eCIQ==
X-Gm-Message-State: AOUpUlGy6+UDa3gBQasSpb3RH5++0kNAfqEOa4+ZRZfMjt9nkchHttr+
        qWAD7HvO/OUWU+yIEoyWBEb04eyi2RTsTiccDZo=
X-Google-Smtp-Source: AA+uWPxgHwXgXlUFNX8BMoF/IRrCPj59IAsh+2dP07HxITYMZByEBtuw9g5KZmWzeD2R8mdaXcHQLjYk+SHEn8hsvoI=
X-Received: by 2002:aca:56d1:: with SMTP id k200-v6mr3553944oib.319.1534527901096;
 Fri, 17 Aug 2018 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <66694963.VB7x4V86dC@avalon> <Pine.LNX.4.44L0.1808101019550.1425-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1808101019550.1425-100000@iolanthe.rowland.org>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Fri, 17 Aug 2018 20:44:49 +0300
Message-ID: <CAJs94EYH2BrHseveJV_xqYs5zK0NxrdQ8NhjrCp7tytK=KsF0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] media: usb: pwc: Don't use coherent DMA buffers
 for ISO transfer
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Mike Isely <isely@pobox.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        keiichiw@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D1=82, 10 =D0=B0=D0=B2=D0=B3. 2018 =D0=B3. =D0=B2 17:27, Alan Stern =
<stern@rowland.harvard.edu>:
>
> On Fri, 10 Aug 2018, Laurent Pinchart wrote:
>
> > > > Aren't you're missing a dma_sync_single_for_device() call before
> > > > submitting the URB ? IIRC that's required for correct operation of =
the DMA
> > > > mapping API on some platforms, depending on the cache architecture.=
 The
> > > > additional sync can affect performances, so it would be useful to r=
e-run
> > > > the perf test.
> > >
> > > This was already discussed:
> > >
> > > https://lkml.org/lkml/2018/7/23/1051
> > >
> > > I rely on Alan's reply:
> > >
> > > > According to Documentation/DMA-API-HOWTO.txt, the CPU should not wr=
ite
> > > > to a DMA_FROM_DEVICE-mapped area, so dma_sync_single_for_device() i=
s
> > > > not needed.
> >
> > I fully agree that the CPU should not write to the buffer. However, I t=
hink
> > the sync call is still needed. It's been a long time since I touched th=
is
> > area, but IIRC, some cache architectures (VIVT ?) require both cache cl=
ean
> > before the transfer and cache invalidation after the transfer. On platf=
orms
> > where no cache management operation is needed before the transfer in th=
e
> > DMA_FROM_DEVICE direction, the dma_sync_*_for_device() calls should be =
no-ops
> > (and if they're not, it's a bug of the DMA mapping implementation).
>
> In general, I agree that the cache has to be clean before a transfer
> starts.  This means some sort of mapping operation (like
> dma_sync_*_for-device) is indeed required at some point between the
> allocation and the first transfer.
>
> For subsequent transfers, however, the cache is already clean and it
> will remain clean because the CPU will not do any writes to the buffer.
> (Note: clean !=3D empty.  Rather, clean =3D=3D !dirty.)  Therefore transf=
ers
> following the first should not need any dma_sync_*_for_device.
>
> If you don't accept this reasoning then you should ask the people who
> wrote DMA-API-HOWTO.txt.  They certainly will know more about this
> issue than I do.

Laurent,

I have not seen any data corruption or glitches without
dma_sync_single_for_device() on ARM and x86.
It takes additional ~20usec for dma_sync_single_for_device() to run on
ARM. So It would be great to ensure that we can reliable save another
15% running time.

>
> Alan Stern
>


--
With best regards,
Matwey V. Kornilov
