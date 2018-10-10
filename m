Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1201A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1201A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJJWEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:04:50 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:36798 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:04:50 -0400
Received: by mail-vk1-f195.google.com with SMTP id b80-v6so1327700vke.3;
        Wed, 10 Oct 2018 07:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oaBBvn3p9lV6aCcOLbNo17yjZy2T1rKHnC6cV1h9hE=;
        b=qXkUBuIgK7pSwxGFrU41tRXULKPPlDnk6r4VC1g2WQ39aF4IQxtcPGh2TNtc/EumAR
         D43d6Gr99U68NBw2TJA+y1b2EEx3Eb0Sae9r6X0U/sV89Q5NxIyW/BGyDtaYqDHpeBQE
         XGnE1DcSzQi6BmYNVF1kLDeoLd+6B1Yo4P8bubc/Oq20XDuMCTZY3YnSrvb41XSOBfwn
         JjYlwwXnS5z8S58ZmOnpST2SqjjNWsMq5fiBl6JRWWfvORBkKTZP+kpTFmg5ffmIUnps
         FQ2iSI3dWhhS5hJum+8fKpfiIFqPZqnCS5X/UA4jOHn84LIeVx8xfExXkQptTbfD58TJ
         Hupg==
X-Gm-Message-State: ABuFfoibkxzir5fQvk8wbrPWJD/1Ww6Y+uGsDGtYfWREbWCo7ra/TR8W
        ypqjYkRZbNym/x3hvcqtjCsuz2QD1nzL6nCXatM=
X-Google-Smtp-Source: ACcGV60fwGEiteAQNXj697UhCezvv5IdVGvZ117BTIMEgHQKGmKrOI73eZIUw9ccRuSvn8jYGVXEsPavBh2EAJpQoZM=
X-Received: by 2002:a1f:2d56:: with SMTP id t83-v6mr13132959vkt.65.1539182539783;
 Wed, 10 Oct 2018 07:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be> <20181010134317.8466-2-geert+renesas@glider.be>
 <CAK8P3a1vSqKk4jRoz-YOnLKP6uL7sPRLj9=BVz92mnjNjbJ3Tg@mail.gmail.com>
In-Reply-To: <CAK8P3a1vSqKk4jRoz-YOnLKP6uL7sPRLj9=BVz92mnjNjbJ3Tg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Oct 2018 16:42:06 +0200
Message-ID: <CAMuHMdVs7CTqeyxM_dZ2aLZOc_Deo3cOWocwFBCGCY8xcyJo0g@mail.gmail.com>
Subject: Re: [PATCH 1/3] eeprom: at25: Drop obsolete cast in at25_ee_write()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Oct 10, 2018 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On 10/10/18, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
> > dependency") changed the type of "off" from "loff_t" to "unsigned int",
> > there is no longer a need to cast it to "unsigned".
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/misc/eeprom/at25.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> > index 840afb398f9e4c88..7707d3fb49b526d9 100644
> > --- a/drivers/misc/eeprom/at25.c
> > +++ b/drivers/misc/eeprom/at25.c
> > @@ -160,7 +160,7 @@ static int at25_ee_write(void *priv, unsigned int off,
> > void *val, size_t count)
> >       do {
> >               unsigned long   timeout, retries;
> >               unsigned        segment;
> > -             unsigned        offset = (unsigned) off;
> > +             unsigned        offset = off;
> >               u8              *cp = bounce;
> >               int             sr;
> >               u8              instr;
> > --
>
> This looks correct, but why not remove the extra variable completely
> and rename 'off' to 'offset'?

Thanks, good point. Will do.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
