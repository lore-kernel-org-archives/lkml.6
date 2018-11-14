Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5385C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CACF2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQjF2yKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CACF2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbeKOB2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:28:38 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35262 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbeKOB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:28:37 -0500
Received: by mail-yb1-f194.google.com with SMTP id z2-v6so7050106ybj.2;
        Wed, 14 Nov 2018 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bAZ2PW7C/QxlySraIosAGQi7Yw/xWhf6uYNP9bye6+U=;
        b=EQjF2yKh5NHWG2KTkknLmy7ArV9YgTXCNs0r2cFhVU6WS6PLr+DY+3yeoGENjgvs9h
         bSEsXpOqEUBznBFnzmP7JfYDeBlD7Mh/GJNaEizTY4sucffeXP3N7Igr9UJfGwdUoUfY
         UJRu3tHabjfsr/z0ez6arQ17I+SKCmXhPuMdt2yXKSi+YTkWSNUaMW667lG/XFTbmgHS
         Zl0fIpMxWaNFV1EaxUHCkVEQqZPSjiF4sBNPm8TrQMOSO/opzFxQJvmjXvVGG9dfZnvh
         klcB0nXC4rGgW1/OaThkfOIhrGKqasrrCHcDHIeSSgxq603uwQyaK5gWXb1974dYrcQP
         UHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bAZ2PW7C/QxlySraIosAGQi7Yw/xWhf6uYNP9bye6+U=;
        b=cz7woswZi16MwIeXEK/UEuOOsD1cihdAGldyqW5EHXLGpHSEJF8+ESlQJoW2uRK1cv
         9jKz/RTd+7r/HADiUESh+K8aKmBZn85ivCnoGPrVk+81P5okRXdtrBUYLDFbr62UnGJG
         9jxxPw6AS6PJCa/PldHlX0jHiOrJztzPpFyikfv4EjTANMNuA/340k0y4wTke49mASa8
         eBW1o91oeDdTMurO+hMgLpu/sSegudtgRcy1kReabHYwQG152kwCMUuvjULJt8I9bD1Y
         raptuA+fSne90zU+0xSkmNKZmhsZlwcw/o3gYCnGjNT1YiyL3A51eC2RUYDBAPxGK7R9
         N2rg==
X-Gm-Message-State: AGRZ1gKVwiaLjXTWRy01+2iZTtO1vlwRgNv4FQaqJ6iRyBVhSemzfGUU
        CrE9wRC/g6U2/xL7yd9+xau7dhpNvU3KC8FNH2Q=
X-Google-Smtp-Source: AJdET5dT6ej6x+zpt9ssEvTOdP99x0WWdQBMmxjG5BpRyXYICKOdLF2X5YUn4wjKCaOEnN/gqtQrE4ehLoM9GbBeIWA=
X-Received: by 2002:a25:c904:: with SMTP id z4-v6mr2032462ybf.427.1542209095883;
 Wed, 14 Nov 2018 07:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20181114121642.1404-1-peron.clem@gmail.com> <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com>
In-Reply-To: <alpine.DEB.2.20.1811141602590.20252@lnxricardw1.se.axis.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 14 Nov 2018 16:24:44 +0100
Message-ID: <CAJiuCcd_LAhODGGu=EBj4WBvx2PufcVbw=tO1+Mm+1Hj0k6BRw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: ak4118: Add support for AK4118
 S/PDIF transceiver
To:     ricard.wanderlof@axis.com
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Adrien Charruel <adrien.charruel@devialet.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricard,

On Wed, 14 Nov 2018 at 16:07, Ricard Wanderlof
<ricard.wanderlof@axis.com> wrote:
>
>
> On Wed, 14 Nov 2018, Cl=C3=A9ment P=C3=A9ron wrote:
>
> > From: Adrien Charruel <adrien.charruel@devialet.com>
> >
> > The AK4118A is a digital audio transceiver supporting 8 input channels
> > at 192kHz and with 24bits resolution.
> > It converts the S/PDIF signal to I2S format and is configurable over I2=
C.
> >
> > This driver introduce a minimal support of the AK4118, like selecting t=
he
> > input channel, reading input frequency and detecting some errors.
>
> I'm curious, from what it seems, there is no checking that the input
> sample rate actually matches the configured sample rate? It's perfectly
> understandable for a driver which has 'minimal support', but it's
> something a user must be aware of; for instance if someone does
>
> arecord -r 48000 output.wav
>
> when the input data actually has a rate of 44100 Hz then the file will be
> written with a header specifying 44100 Hz but the data will actually be
> 48000 Hz.
>
> It's not an objection on my part, just an observation. I don't know how
> ALSA could enforce this in any way; ideally (barring automatic sample rat=
e
> conversion) one would want an error message that the sample rate specifie=
d
> when opening the stream does not match the sample rate of the S/PDIF inpu=
t
> data.

I'm quite new with linux audio driver but adding in ak4118_hw_params a
check like if params_rate(params) =3D=3D ak4118_rate should do the job no
?

Regards,
Clement

>
> /Ricard
> --
> Ricard Wolf Wanderlof                           ricardw(at)axis.com
> Axis Communications AB, Lund, Sweden            www.axis.com
> Phone +46 46 272 2016                           Fax +46 46 13 61 30
