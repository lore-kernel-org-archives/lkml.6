Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576E6C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A5720020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihBvOxsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A5720020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeFTTjS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:39:18 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40148 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932154AbeFTTjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:39:16 -0400
Received: by mail-lf0-f67.google.com with SMTP id q11-v6so1046503lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+bGIcXmDE965Tgr4jqeEcUc0dUFmZwxE1NNypNEQe5g=;
        b=ihBvOxsifkQNJvJS0I/l+HF/5E3AMNv0u5j8H0cVryWpUbT/T1sIm/OZxzKHPylsQ1
         8L5blw3k52Kxc7Vwhy667mbsndHzSAFla9L0yVelt8BB9qC9qEw9Um31WOpzsJzIwfko
         HOHKDlsYCcgFq8fa55S38d+l2Tz1tofXf7gnnis/SL2m/NaYH8zmsxq8/tMG5boK9keg
         3hTDL8iqvAeUOQ461DgkH2gkz87u44dQ5eR5ngTtC6nu2D7pVuUSrNRGtDdUiG5ogtqg
         7T9OtyaxlE8iye7EVIrtAiOrrPwEQcWK2xkAX2ITjdBKRXK1MUZn5WRIBssKfAnv+DHZ
         WO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+bGIcXmDE965Tgr4jqeEcUc0dUFmZwxE1NNypNEQe5g=;
        b=DtG93oltVbwCvaHWsWoVE9+ocQWGIyXZeTT0BXEyZ+GjO+IVjkyaMEX/y6yqSL8347
         LZLsFEbso8DrniPioBl2nzO2fLcyxYyRyByh/vBZx8S4FYP4tQScN+X4VDAPD78rRkPy
         NQtCsiOy7Z/ByzRRKynzqT+6fmihMjgT4Hi+Bn4Cyg3uFmXxHV+3+sQnVu+3jzUqA874
         ym3V/VAataRa1eA0QCECRETDW7l8CxnZa4foGpRufiV7MvJ6jlqcEDl2YTfsZ79JqPMT
         GKkeBf+vTXONvWVg9jMDqvZ9/ZbF6NZQtKiAB79ltx6ASGmQfJGJT5ME1cRUvqlRlq6l
         5ZYA==
X-Gm-Message-State: APt69E2ZrvzBMYc7ZtHDbixopPpHBPXU1CjQZsH1irhce6ac2fKNRPzv
        LaTjAJeaCIAAqhJ43bWM02Js9M4nJ6bMOnJNdsU=
X-Google-Smtp-Source: ADUXVKKnRgaYWL1wBV7/5+rbgv1GwRxrbAm8wolcfgIDQj4C/akO22G6CNjaDUbGWwHvYtJLcZC0fJ9rX+gFixq5LVM=
X-Received: by 2002:a19:cd08:: with SMTP id d8-v6mr14598206lfg.41.1529523554848;
 Wed, 20 Jun 2018 12:39:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1a4e:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 12:39:14
 -0700 (PDT)
In-Reply-To: <s5hmuw1bgmd.wl-tiwai@suse.de>
References: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
 <520e80a8b8de0f532e8dd3ee15af9efbc748dd9a.camel@linux.intel.com> <s5hmuw1bgmd.wl-tiwai@suse.de>
From:   =?UTF-8?Q?=C3=89meric_MASCHINO?= <emeric.maschino@gmail.com>
Date:   Wed, 20 Jun 2018 21:39:14 +0200
Message-ID: <CAA9xbM7_vrn-f_m67eowzLzWjoJP=9Hkgyxfc=yu=aDtmk=Qvw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: fm801: add error handling for snd_ctl_add
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jiazhouyang09@gmail.com, alsa-devel@alsa-project.org,
        BhumikaGoyal <bhumirks@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch tested on my ia64 workstation. Works flawlessly.

Thanks,

     =C3=89meric


2018-06-11 15:24 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> On Mon, 11 Jun 2018 10:49:56 +0200,
> Andy Shevchenko wrote:
>>
>> On Mon, 2018-06-11 at 16:04 +0800, jiazhouyang09@gmail.com wrote:
>> > When snd_ctl_add fails, the lack of error-handling code may
>> > cause unexpected results.
>> >
>> > This patch adds error-handling code after calling snd_ctl_add.
>> >
>>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Though I can't test this (I have FM-only card). Last person who would
>> able to test was =C3=89meric (Cc'ed).
>
> I applied now as this change is pretty safe.
>
>
> thanks,
>
> Takashi
>
>>
>> > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>> > ---
>> >  sound/pci/fm801.c | 16 ++++++++++++----
>> >  1 file changed, 12 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
>> > index 73a67bc..e3fb9c6 100644
>> > --- a/sound/pci/fm801.c
>> > +++ b/sound/pci/fm801.c
>> > @@ -1068,11 +1068,19 @@ static int snd_fm801_mixer(struct fm801 *chip)
>> >             if ((err =3D snd_ac97_mixer(chip->ac97_bus, &ac97,
>> > &chip->ac97_sec)) < 0)
>> >                     return err;
>> >     }
>> > -   for (i =3D 0; i < FM801_CONTROLS; i++)
>> > -           snd_ctl_add(chip->card,
>> > snd_ctl_new1(&snd_fm801_controls[i], chip));
>> > +   for (i =3D 0; i < FM801_CONTROLS; i++) {
>> > +           err =3D snd_ctl_add(chip->card,
>> > +                   snd_ctl_new1(&snd_fm801_controls[i], chip));
>> > +           if (err < 0)
>> > +                   return err;
>> > +   }
>> >     if (chip->multichannel) {
>> > -           for (i =3D 0; i < FM801_CONTROLS_MULTI; i++)
>> > -                   snd_ctl_add(chip->card,
>> > snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
>> > +           for (i =3D 0; i < FM801_CONTROLS_MULTI; i++) {
>> > +                   err =3D snd_ctl_add(chip->card,
>> > +                           snd_ctl_new1(&snd_fm801_controls_mult
>> > i[i], chip));
>> > +                   if (err < 0)
>> > +                           return err;
>> > +           }
>> >     }
>> >     return 0;
>> >  }
>>
>> --
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Intel Finland Oy
>>
