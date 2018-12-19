Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CE121841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Yk5jHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeLSNbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:31:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33160 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbeLSNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:31:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id p6so16997356eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3GX7SkRDg0kmhYomF/yqDiLWJgcao3tWYo/YzqdOjs=;
        b=K2Yk5jHKIjLrv3TK2/FctPuPLpSoo/i0l024Ih0j4SgCh3air09fYZKRqxza48HqVV
         ZDtBMvUdEj8o8w9CPsl2RegdHQGHPuIYYkdNZIJBoXwvK/UxwJnLimbmNO//naI/9rrj
         ErK7Z6Si8+sMnD/YMyyHuDqJ1qTgtL1x+oW1bP8psc5ro+Sgxn84TarI0dNjg+WaKccQ
         H+1PCjw0wA1KddlumZ1+PaDlbP3z4/eFDSxYXovkdte7lclQn3WsTKaNZfqKAVS95SP1
         e87Hsc8f4N/caucciJVDxfTHu2z+nRUspHAlThDqjtTciL3eUs4wt4nRtXKeCYyYBJiU
         Ig1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3GX7SkRDg0kmhYomF/yqDiLWJgcao3tWYo/YzqdOjs=;
        b=I9MZ6lvy3QzGKPGz2Tnfw+kRsUriuMg6Zd/e5zk+NTLa0zbJQrIff0tFIExNjwRotk
         t4PDeRx+Vjrrif5cswn8BxkGeoQXFRLNWBIksauQVBNLMzQyGErgC5XntxwWCA+Y/RyT
         T9x23htaKe/9wNEnCVdhGPXtAR72xW1D+s6Ymj3wBDMg3U7lX3N6eOGw1zY4yDYm/YlQ
         m6Z/R2mlrWx0PDn5O4EmuoQHA5/BruO7jbHHdZ0IDFJwpgh2NxDz/dr9xOr82y/LKXX0
         4M2wgCCJ4QIUb5ZB3/0cqI8q0fFvrCizwT+5PClr5TIUrUwhtBw9t/BEEEpiZpv3hivK
         5lFQ==
X-Gm-Message-State: AA+aEWY3nJoDzDzrUXAaWbMEAWFDypqU8NOE++eTu8kHoDo/FLeOqOo2
        8rZW6Cm99WlLEmbPSbEgWGnaDvOwyRIhmLKgIXQ=
X-Google-Smtp-Source: AFSGD/U9LhvI9CHqijITu5KSQlR5MfLR4tQY4oEEiPpEW+0idKmdQ9gy9M5t7Jz1utQku0jLzRjfsgGV3gK18xu+INQ=
X-Received: by 2002:a50:9106:: with SMTP id e6mr19157603eda.148.1545226298578;
 Wed, 19 Dec 2018 05:31:38 -0800 (PST)
MIME-Version: 1.0
References: <fcbce8f7ba22014a8f06b7f52ad56faaa03b948b.camel@toradex.com> <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
In-Reply-To: <8d6905f9aed82a0181d1d8eb2259946c47825a7f.camel@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 19 Dec 2018 15:31:27 +0200
Message-ID: <CAEnQRZAHE77GsaES--LtWs3F4uHP2ePp3-KmP4xmZDh7NM4njw@mail.gmail.com>
Subject: Re: [REGRESSION] imx_v6_v7_defconfig: undefined reference to `__hyp_stub_vectors'
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        dl-linux-imx <linux-imx@nxp.com>, robh@kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 3:17 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
>
> On Wed, 2018-12-19 at 12:42 +0000, Marcel Ziswiler wrote:
> > Hi there
> >
> > I noticed that at least today's and yesterdays -next won't build with
> > the imx_v6_v7_defconfig giving the following error:
> >
> >   LD      arch/arm/boot/compressed/vmlinux
> > arch/arm/boot/compressed/head.o: In function `restart':
> > (.text+0xa8): undefined reference to `__hyp_stub_vectors'
> > (.text+0xac): undefined reference to `__hyp_stub_vectors'
> >
> > Has anybody seen that as well and knows what is going on?
>
> Hmm, works for me.
>
> Using linux-next, master branch. HEAD commit:
>
> commit 02fc169594e96f7c51c4f23114e12b7a18e85a0a (HEAD -> master, tag:
> next-20181219, origin/master, origin/HEAD)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Wed Dec 19 18:42:46 2018 +1100
>
>     Add linux-next specific files for 20181219
>
>     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
>
> Using gcc version 7.3.0 (GCC).


On the other hand I'm getting this warning:

arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning (spi_bus_bridge):
/soc/aips-bus@40080000/spi@400ad000: incorrect #address-cells for SPI
bus
  also defined at arch/arm/boot/dts/vf610-bk4.dts:107.8-119.3
arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
prerequisite 'spi_bus_bridge'


Maybe Rob can jump in?

thanks,
Daniel.
