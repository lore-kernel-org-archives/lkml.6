Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC902145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUb6hNnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC902145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbeKNU6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:58:14 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40990 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeKNU6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:58:14 -0500
Received: by mail-yb1-f196.google.com with SMTP id t13-v6so6703804ybb.8;
        Wed, 14 Nov 2018 02:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cKBdH59M66pVE1mkFNjjgivtPYYb7pmZ+I+vSeOZYIU=;
        b=QUb6hNnVnNjXLFg364dSpcdzPM1VQOO4gb4DueTscFN98Lko/9Nas34duj6sB9XcXt
         AB2JwXFiawF+7pEkXV9S9pyYKoVjM/FYegEQpoYWihKNKkWw13/JqbY/XHJ60X0V/2Ed
         CLm8GkQ9L/ClSY+2gQm0pbDxxcpuDrOkabUpSwK12gmOrBkq4DctAm5kV6/JYlTKNsIz
         X2BrO1sGXL1Q0kSWzr+ctG6TWWDc2YL+ZDQiskmn4oZnfakwq6fwhMUCp/wmueZFzgy+
         0pWkcSc5CXQ7Z/p5MRdMuIoDPXrijOS6jviRmE1/oplif1ShK22qvFpMyQZT5I/Mbe6i
         i9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cKBdH59M66pVE1mkFNjjgivtPYYb7pmZ+I+vSeOZYIU=;
        b=eRB4w3JWoFevNc3lUUUiQ+VH/0xOwJ+rYb/wLrjsa3C77cuGjw2Qw1LokltVVpXGym
         Z7guXfcXWE4a4wEjIVyMXod3/wbqBNqAOx4nlLMAoGx3R7v3udlAyLJsC9xleHCAoH5j
         myGWVQnXq2HL98fOwrTlymIhWt8HBXSYFL81/T3dZNkb8d8BWdZE1jEzjG6dhWuslD+N
         Iptvd8NlLMBFG1bgB9c32aUTXHgab+bSBiNSMGkjdth7LZ+cXZsmSJVbkFheB+O4bYm1
         JbcDEqpdAt3+N8EuKOwxGioTs2iy7S/tiELSaFHaK7LOsdr4pQxWlsjhJZ9vadOcqhLG
         3+Vw==
X-Gm-Message-State: AGRZ1gJHrreExrLsr3TB0nNQ4CPGDCmY8WVOSm1wlJPQ86HD9xH/+GY8
        hx0xbsONDvUodSgBTKGxMVdwNTDcFzLksklfqnw=
X-Google-Smtp-Source: AJdET5eKxiMIGTNrdHAKM1dcEdY0ZshU0ePX8l8piP21PRyZWV+VZfrgxrnrCJUjTHsbqNzuVm79tFWfSewXrkGBQro=
X-Received: by 2002:a25:952:: with SMTP id u18-v6mr976985ybm.474.1542192928266;
 Wed, 14 Nov 2018 02:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20181108124934.32381-1-peron.clem@gmail.com> <20181113225135.GQ2089@sirena.org.uk>
In-Reply-To: <20181113225135.GQ2089@sirena.org.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 14 Nov 2018 11:55:17 +0100
Message-ID: <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118 S/PDIF transceiver
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrien Charruel <adrien.charruel@devialet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 13 Nov 2018 at 23:51, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
>
> This looks mostly good, a few small things below but nothing too major:
>
> > --- /dev/null
> > +++ b/sound/soc/codecs/ak4118.c
> > @@ -0,0 +1,449 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> > + *
>
> Please make the entire comment a C++ one so this looks more intentional.

I check from other files and also this article says :
"For normal C source files, the string will be a comment using the
"//" syntax; header files, instead, use traditional (/* */) comments
for reasons related to tooling"
https://lwn.net/Articles/739183/

>
> > +static const char * const ak4118_iec958_fs_texts[] =3D {
> > +     "44100",
> > +     "Reserved",
>
> If you use a _VALUE_ENUM_SINGLE you can hide the reserved/invalid values
> from userspace which is easier to use.

Ok will change to SOC_VALUE_ENUM_SINGLE_DECL

>
> > +     ret =3D request_threaded_irq(gpiod_to_irq(ak4118->irq), NULL,
> > +                                ak4118_irq_handler, IRQF_TRIGGER_RISIN=
G |
> > +                                IRQF_ONESHOT, "ak4118-irq", ak4118);
> > +     if (ret < 0) {
> > +             dev_err(component->dev, "Fail to request_irq: %d\n", ret)=
;
> > +             return ret;
> > +     }
>
> You should request resources in the device level probe, there's no point
> in requesting and releasing the interrupt like this.

Ok, will change to devm_request_threaded_irq and remove the irq_free

Thanks for the review,
Regards,
Cl=C3=A9ment
