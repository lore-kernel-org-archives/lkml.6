Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A3CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D362080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+UUT341"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D362080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeLMEu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:50:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45163 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbeLMEu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:50:26 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so693835ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Ei4zhiuJTQT4ckP9LIS4RtQhY7la856WNzxCgSqbEE=;
        b=d+UUT341AxkPB/HtWo/SLAt7NR3mfWTWgFKEV5vH1TdNLDo0CUU4DQY4o/lPLnY1CM
         K+8g97H7gz8aEnTzsGmWOjZLol9YTbZUkg2nzmFZFT58RVj9hY3sn1ts5SXI9EU9wdy8
         IX5Kt6gs+mrkbFP8QDfehhjzxsC6wXx9V6MXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Ei4zhiuJTQT4ckP9LIS4RtQhY7la856WNzxCgSqbEE=;
        b=OBehDlNDLfP7NnHWmT7e+vBIZSC3bnsLGrR8qN1q5GOndQk9jTQZfPJX9kZULJSwee
         mVuh5q4Nb15jNe4tmpQHSDr2yAlacKhroa3Qt1vPN9+786YvfAWyxdTrpzmbRbwzc5mA
         pDulzw1Al26qIgWSRPPV5LYCl2/Lxih8AEPZqRjgjIZp9rMhVLjCaFxNqLAa2iKdBOim
         3JD9VJFjJ0di3JlOJ7XUzZUOZl3U+GrD+vfZJXDoVSiahJHHb/JrfyFkGc9hxqxcvRyu
         2hZyYDkjrftoLyUSus6kMc1eIhyD91XR0Wv/kecyhdaNMoih1PJGkySmto2DJOqfgsez
         VOkA==
X-Gm-Message-State: AA+aEWb4H4S04E/cVMvHCSy9RENpLsrtNC16aSh0wrVnHSETY+FcCZ0W
        UuoGF9hkuBYAiyclKRw/UhZxGpZtVDjJPF5WBrPBfg==
X-Google-Smtp-Source: AFSGD/XRzZn6psTkodBupHe1UVBMjXGnHMSXvn3B+Z8uD54tiLqMOCJlnoiXC1MNjJBmbHNebFj6rDdgbsX480C/NZ4=
X-Received: by 2002:a9d:5c88:: with SMTP id a8mr15232105oti.64.1544676625837;
 Wed, 12 Dec 2018 20:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20180926032455.224600-1-louiscollard@chromium.org> <568ea3447a8116ef460d191bf3599e2761bca3a5.camel@mniewoehner.de>
In-Reply-To: <568ea3447a8116ef460d191bf3599e2761bca3a5.camel@mniewoehner.de>
From:   Louis Collard <louiscollard@chromium.org>
Date:   Thu, 13 Dec 2018 12:50:15 +0800
Message-ID: <CAKNRAJVF5bf7LgyxQRkRFq3ihm9TmbGO8=wCo8i8NWds2yr2bg@mail.gmail.com>
Subject: Re: [PATCH] Allow hwrng to initialize crng.
To:     linux@mniewoehner.de
Cc:     linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David R. Bild" <david.bild@xaptum.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 4:15 AM Michael Niew=C3=B6hner <linux@mniewoehner.d=
e> wrote:
>
> Hi Louis,
>
> On Wed, 2018-09-26 at 11:24 +0800, Louis Collard wrote:
> > Some systems, for example embedded systems, do not generate
> > enough entropy on boot through interrupts, and boot may be blocked for
> > several minutes waiting for a call to getrandom to complete.
> >
> > Currently, random data is read from a hwrng when it is registered,
> > and is loaded into primary_crng. This data is treated in the same
> > way as data that is device-specific but otherwise unchanging, and
> > so primary_crng cannot become initialized with the data from the
> > hwrng.
> >
> > This change causes the data initially read from the hwrng to be
> > treated the same as subsequent data that is read from the hwrng if
> > it's quality score is non-zero.
> >
> > The implications of this are:
> >
> > The data read from hwrng can cause primary_crng to become
> > initialized, therefore avoiding problems of getrandom blocking
> > on boot.
> >
> > Calls to getrandom (with GRND_RANDOM) may be using entropy
> > exclusively (or in practise, almost exclusively) from the hwrng.
> >
> > Regarding the latter point; this behavior is the same as if a
> > user specified a quality score of 1 (bit of entropy per 1024 bits)
> > so hopefully this is not too scary a change to make.
> >
> > This change is the result of the discussion here:
> > https://patchwork.kernel.org/patch/10453893/
> >
> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
> > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >  drivers/char/hw_random/core.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/cor=
e.c
> > index aaf9e5afaad4..47f358aa0c3d 100644
> > --- a/drivers/char/hw_random/core.c
> > +++ b/drivers/char/hw_random/core.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +#include <crypto/chacha20.h>
> >
> >  #define RNG_MODULE_NAME              "hw_random"
> >
> > @@ -64,13 +65,17 @@ static size_t rng_buffer_size(void)
> >  static void add_early_randomness(struct hwrng *rng)
> >  {
> >       int bytes_read;
> > -     size_t size =3D min_t(size_t, 16, rng_buffer_size());
> > +     /* Read enough to initialize crng. */
> > +     size_t size =3D 2*CHACHA20_KEY_SIZE;
> >
> >       mutex_lock(&reading_mutex);
> >       bytes_read =3D rng_get_data(rng, rng_buffer, size, 1);
> >       mutex_unlock(&reading_mutex);
> >       if (bytes_read > 0)
> > -             add_device_randomness(rng_buffer, bytes_read);
> > +             /* Allow crng to become initialized, but do not add
> > +              * entropy to the pool.
> > +              */
> > +             add_hwgenerator_randomness(rng_buffer, bytes_read, 0);
> >  }
> >
> >  static inline void cleanup_rng(struct kref *kref)
>
> I found your patch by chance, searching for a solution for crng init dela=
y on my
> headless machine. Unfortunately it hardly makes any difference for me. Wi=
th the
> patch the system hangs for about 80s instead of 120s until the "crng init=
 done"
> message.In contrast, doing a `cat /dev/hwrng >/dev/random` or running rng=
d
> initializes the crng instantly.
>
> Isn't that delay the problem this patch tries to fix? Any idea what is wr=
ong
> here?
>
> Thanks!
>
> Best regards
> Michael
>
>

Yes that is the problem this is trying to address. My guess would be
rng_get_data() is not returning as much data as requested, so the
delay is reduced but not eliminated. Looking at implementation of
rng_get_data() it appears this could be caused by device support for
read() vs data_read(). I don't have a good feel for whether looping to
retrieve more data here would be acceptable, it is certainly a bigger
change than currently proposed.

Thanks,
Louis
