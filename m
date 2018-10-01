Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA833C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91768208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="DvsbQFq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91768208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeJAWt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:49:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40260 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:49:29 -0400
Received: by mail-io1-f68.google.com with SMTP id w16-v6so9864040iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=28ikbkritnwd0X0sDqtZ2GOJdZgiK1O30ZJZmBmHzCo=;
        b=DvsbQFq4WR1P4zaro854x10NWgaBW5qdCo8GMmb4N/MpacWUkcG3COITmoSgjnDJEc
         m3ArTfRMiSfsekJe2b5+cO54s3UeVq3qEiV1wwjf2ELOd1F76i+/YoDIiT+l2eDPkIbz
         asrPdZ3vsw6som3MzmmDWC9Hrc8Qy7ZJ+frttWUTs/HHlXOZo6e1/DEFoSaD9Fx3esb4
         CTOt878RQkPHbujaq5+S9zfdB0wV/3dBH/qLr9oeyGwdzd2sZdeQkjkNfJWZ2LPzKOc5
         cKlU+N/zDI7TWk+cVRQOYGg147k4ukkUgTrkBpYHAXDBiPDLsXBgFANA2gxrEdH8Mn5+
         fpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=28ikbkritnwd0X0sDqtZ2GOJdZgiK1O30ZJZmBmHzCo=;
        b=Nh8CokNwfHv27Pl9E8rwBgOV+ChydGVRbubkQe2ZkYlAng4kHMPhVF0C5vMcpB+B/Y
         16k/9TVu8kg7bdml8xBwWr4+t84GVjAyXCt/DbfSBxqgHKn0T5/3sGWaNyaWw/ILTBVV
         YCI3FF+DKYaZ3CvfBZT1QubUudzyxdFMqZgqcTXkQBpPKZK+bNIHTfxywpVGxqLO4wHv
         mJ6TdKV0SPDw2sy0KmGrA93GmjpElNPruE46tWYmH6YzxfZjRY7FOjkDapDcpTUiBBfi
         aNieRZv/eB/6BME5z50jn3Hs+6m7SvPiFXlMF9UMjy/y21WyDBfzHAu2V6YzOlGcFeac
         qBsA==
X-Gm-Message-State: ABuFfoi2Az/rzbHIz6Mjp9lzOdVW0iIdfB/v9BN694Ss0BSzy3ciC10E
        RuVF+dijvSTU8nymIxelAKls7YqNqxVOf51qDSnwZw==
X-Google-Smtp-Source: ACcGV63q62iaoQPF8aWWv66BAGnOkWti5UzYq1Ic84D4lHB8XJL3hTbt7ePvuC1HUIZ+j1yyrFkwCXcW41oJ9zR6asc=
X-Received: by 2002:a5e:8d11:: with SMTP id m17-v6mr4019218ioj.258.1538410257133;
 Mon, 01 Oct 2018 09:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181001100052.3580-1-brgl@bgdev.pl> <44adbace-6849-e37f-70f0-d11661e6bdc9@lechnology.com>
In-Reply-To: <44adbace-6849-e37f-70f0-d11661e6bdc9@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 1 Oct 2018 18:10:45 +0200
Message-ID: <CAMRc=Mec1AYX20ZVf0BJmMpovtONW5VifB70-dRXp+PJ-zGvYA@mail.gmail.com>
Subject: Re: [PATCH] nvmem: fix nvmem_cell_get_from_lookup()
To:     David Lechner <david@lechnology.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 1 pa=C5=BA 2018 o 18:03 David Lechner <david@lechnology.com> napisa=
=C5=82(a):
>
> On 10/01/2018 05:00 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We check if the pointer returned by __nvmem_device_get() is not NULL
> > while we should actually check if it is not IS_ERR(nvmem). Fix it.
> >
> > While we're at it: fix the next error path where we should assign an
> > error value to cell before returning.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   drivers/nvmem/core.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index ad1227df1984..8249621d11a6 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, cons=
t char *con_id)
> >                   (strcmp(lookup->con_id, con_id) =3D=3D 0)) {
> >                       /* This is the right entry. */
> >                       nvmem =3D __nvmem_device_get(NULL, lookup->nvmem_=
name);
> > -                     if (!nvmem) {
> > +                     if (IS_ERR(nvmem)) {
> >                               /* Provider may not be registered yet. */
> > -                             cell =3D ERR_PTR(-EPROBE_DEFER);
> > +                             cell =3D (struct nvmem_cell *)nvmem;
>
> perhaps ERR_CAST() would better indicate the intent here?
>

Wow so that exists too...

Thanks, I'll resend tomorrow.

Bart

> >                               goto out;
> >                       }
> >
> > @@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, cons=
t char *con_id)
> >                                                      lookup->cell_name)=
;
> >                       if (!cell) {
> >                               __nvmem_device_put(nvmem);
> > +                             cell =3D ERR_PTR(-ENOENT);
> >                               goto out;
> >                       }
> >               }
> >
>
