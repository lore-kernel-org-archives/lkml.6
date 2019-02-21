Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40975C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D53720880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FofwJLNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfBUJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:53:42 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42915 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:53:42 -0500
Received: by mail-io1-f66.google.com with SMTP id p196so964929iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z0kREDWUPJKp6Tug6zsZ7z3oetvN6alSAxG+i0EQ0Ls=;
        b=FofwJLNx+GlfewFcRaiAdIcQBfK9O4vP3HRq8IDpWmkYeP0/m/soRkuJqpZPiQtbP9
         Jt4kIIlcR0yQJBqYlaPgrRtG17FZ1hdz91xVxfGfHGHgwxMx8wqW9WTToR6f5ygOLl7e
         +0yZkB3xXKTVnzqUhIwgYRWswftbaj4U5m4Rq0YpWRPESkGjbQ0j2mt3ZnQWHGj3GMNz
         IbaSBj0t8ydo+c5sv6ChL5duEmB/EyX/hPkxUT0P7usB38hXkOu4wEXD6UGwWMOIE/o5
         kVVd4VeJCrMkEzNy5S25ZRQFzNivM6gsPYIKSB26UM4oNtdgKChqrCljwwQ9iOTpLGLg
         ATcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z0kREDWUPJKp6Tug6zsZ7z3oetvN6alSAxG+i0EQ0Ls=;
        b=md3g8I/RO99Lfi1TMaR694VnmNABtoO2T8ltoslQkG9UPvS+rFwViEF34ptKi+4p+T
         NzFpDOX2ckTIe+JZBzCqvpicicevtNtAD1pWAi95Hyvn0Qm0seuI/kXgCXTSRwP0yMhf
         5pRs+sCL72nrqWw07vOB4vzTyErmsd01ocM5dKI7EyXuPR+sdKfQW0J8defVT91VNaJk
         IiF9RXK9pu6eJZUjgel8dUMCvCvsygfyDVeGmqX1K/6gNUhxLNlil+Eix8C6ifqY/CZ1
         LuvzRzx3Gx0FARkDE966I4JTJZhkcGbFj+Cqqkap+veBPilp3vTXv/eS1YoWdE0N736M
         zMNA==
X-Gm-Message-State: AHQUAuYXyTDOh9jnH9lSLD7BgEorLaBVTFi+glX2yVM/cqW7z4PghjWa
        20thBdC5lBL3m8420MNENQsfsSiuYLviS4X/QPMKsw==
X-Google-Smtp-Source: AHgI3IYKCJRVYBMcQb2U1gUyMGsqLYXZbB5Why+0yIiG1eQ02HH3pGIVuWHojfvxlGsXbrxESZrd/kFqyVxF1CaGrhc=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr22482650ior.258.1550742820811;
 Thu, 21 Feb 2019 01:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20190220111240.10041-1-brgl@bgdev.pl> <20190220111240.10041-2-brgl@bgdev.pl>
 <20190220111650.GA13077@kroah.com> <CAMRc=MeXPsJCsKAnzUD7Cvhj2gy3pyd6X79e602awv3_Ys6mYA@mail.gmail.com>
 <20190220121506.GA23933@kroah.com>
In-Reply-To: <20190220121506.GA23933@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 21 Feb 2019 10:53:29 +0100
Message-ID: <CAMRc=Md0sqouS+p2RvW+fwM41eN5=P9Nd7V=gYuqxunfa3j-nA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drivers: provide devm_platform_ioremap_resource()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 20 lut 2019 o 13:15 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Wed, Feb 20, 2019 at 12:21:26PM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 20 lut 2019 o 12:16 Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> napisa=C5=82(a):
> > >
> > > On Wed, Feb 20, 2019 at 12:12:39PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > There are currently 1200+ instances of using platform_get_resource(=
)
> > > > and devm_ioremap_resource() together in the kernel tree.
> > > >
> > > > This patch wraps these two calls in a single helper. Thanks to that
> > > > we don't have to declare a local variable for struct resource * and=
 can
> > > > omit the redundant argument for resource type. We also have one
> > > > function call less.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> >
> > Should this go through the driver-core tree?
>
> No need, put it through the tree for patch 2/2.
>
> thanks,
>
> greg k-h

Linus,

can you take the two patches for v5.1?

Bart
