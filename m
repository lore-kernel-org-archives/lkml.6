Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F06C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E45020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hgUBenEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E45020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeLEUot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:44:49 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38444 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeLEUos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:44:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so19978762otl.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 12:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=itL+PDZ6L8PljYHpMiPFekz6RKZZlMPLOO6AiiV/B1g=;
        b=hgUBenEYALvl9hb0vydFgeLvSL/eaEHRdMHdscyJRhyjXpODAt4IO5QUpr3tFB+B+N
         +TDCR1CMxJH0a9k4D0JQhPkjAUit/9gf+YpH+1y3TzuWIUtszKQej3B7+d6j6eVYd+Vb
         btyPFg2PekqFwYgtDF2WL7V5E5+352/o7JnyGYoN4bj+xxhOCS3lymo9OL6ossnJjNZj
         UxMLXXJVc0SzXSjLJRHKi9987erJjEWWeKQQDKSeeDWXTnwOWd4td6hicKY+Hn04Numq
         66lqDg1u+b700/x6g8El1mrt0YsHs2s+v/9y5SM8BYnTBk8WL0/H19opAEptT0kFcZYn
         iwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=itL+PDZ6L8PljYHpMiPFekz6RKZZlMPLOO6AiiV/B1g=;
        b=QY9LcVgPCJseGKNSYUsr9CCOwNLuFUo4O0x5tnCWAH8aCBVDEwUv4dLDAWtUNfvSa8
         B0zbNnY8lMaqYS+6dkA+QXTWtlfIs1sNO9obbB0t30JUUEkXXR6hRvLUo9Ph/ggNk1ey
         RJ5gBh+DjDhIkFkip2GeefCvSaQ+RLRf7nG+a0WyJZa8qPGclTQEwCuGFpUVMNesz/fS
         AS31sYjw8Uf+KNOdZd++jpqFjUCX92OULHmiTGkcPaX5U2qDh2RCWfLVZ2Exv3Tajvrc
         y93mOAsga17nyPQtjNFBBZTXTsV9TDkGGcOsJag10XmIB51QYW7LYTA3FKxHXjeLGRwO
         b6Dg==
X-Gm-Message-State: AA+aEWZOUbZNLnZTdVr18+tZWSKEk/G4YY4Fo3GClTiz3HwH36taMuHJ
        hvh4pjiKQXvvRP8YlSG4eHk1aT0c9zBe8BQGnCzxfQ==
X-Google-Smtp-Source: AFSGD/XnY77z6ZgGfQ8VCdB3Jy4FKHlBmVkeIJnvJVduD3Co1koBXuxuv7ZI5F0MaZaoxQAtz6qo6n2qXfqH3agYceg=
X-Received: by 2002:a9d:4595:: with SMTP id x21mr15842221ote.234.1544042688102;
 Wed, 05 Dec 2018 12:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20181204181550.29122-1-brgl@bgdev.pl> <20181204181550.29122-2-brgl@bgdev.pl>
 <20181205153534.GF6205@sirena.org.uk>
In-Reply-To: <20181205153534.GF6205@sirena.org.uk>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 5 Dec 2018 21:44:37 +0100
Message-ID: <CAMpxmJUoC0sU4K-Qo6QGnNUMVYXKZOuyvuGmZiv6aUWk0x+MmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] regmap: irq: handle HW using separate mask bits for edges
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 5 gru 2018 o 16:35 Mark Brown <broonie@kernel.org> napisa=C5=82(a=
):
>
> On Tue, Dec 04, 2018 at 07:15:50PM +0100, Bartosz Golaszewski wrote:
>
> > Let's reuse the existing type fields in struct regmap_irq to make
> > regmap_irq_chip available to such HW.
>
> I'm not sure this is ideal, it makes the interface less clear for users
> especially since there's nothing in the comments in the header that
> users will look at which mentions the feature.
>
> > If the type_base and mask_base offsets are the same - assume there
> > are separate bits for falling and rising edge interrupts and use
> > the value previously written to the type buffer by the set_type()
> > callback instead of the entire mask specified for this interrupt
> > so that we only enable the requested edge interrupts.
>
> This feels like it's very strongly tied to a specific implementation of
> the feature and TBH I'm somewhat unclear on what this ends up concretely
> meaning.  It sounds like this hardware represents the two edges as
> separate interrupts but you want to combine them into one but I can't
> see exactly how the interrupt number gets mapped with your change.

Yes, it's two edges represented as separate interrupts. I will post a
patch with a different (hopefully clearer) approach together with an
example snippet from the code actually using it.

Bart
