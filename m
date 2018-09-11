Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA0EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC61B20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQFOODGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC61B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeIKTRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:17:47 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37384 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:17:46 -0400
Received: by mail-yb1-f196.google.com with SMTP id f145-v6so9382733ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WkGRCR/i4oZwHNHqCrejEMImsEUXo0k+2hMIVZOFlko=;
        b=TQFOODGW2+IkhzQhjlO6ISqn2cT4ctbkrhfl4lraZ+A0gZ8fKrV5zUAFkzJoJaXKjr
         Vv3xfmNLoPelorZCkyaqaLXIqZLJH0TmtEF/JOP4Av/XLnl0aO+247Hp2+Fiw6N03BbN
         IneN+QzpUMGzU/6pObKBpAPL7tFvG+HMljfM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WkGRCR/i4oZwHNHqCrejEMImsEUXo0k+2hMIVZOFlko=;
        b=cOqqqJzkpRdnc+2awU3pK5q2MPdmH6J4zgBamUGg1hX0zXYHP3D8lw2GxnbWeWKjTB
         6obftyfjvJ0XNKr2C1p+uhijxd2H/tROI0QxelbHH1fU1fCu29xnmzWAk7zfsZPZyti1
         B0cJf7/3fYXFSQGhLUWzK6sEBaq2NKi8uK9yp3OpsFufHsL8COXl+efntKgp6/Jow5CB
         G/PCo7rPr+HbATLIOxDltYI6evOjDYSprv0j6XvfI3P2rLO+BnDvDE+OZbtjDrPdVMQv
         ymofSCtnjbc3O8010SigK6WbfY6b0xTVTbssT6xRrKtyEPA9IQwLSBfplAe6fslX+Ru+
         1icQ==
X-Gm-Message-State: APzg51DBAAFWaUvPPUQwrpQErjdDA+sz8Qhrv60NRtJaEoEvbulkH0L0
        DKtX7V1q2vbaGoWqJSf78mYWGwho4YXohjc/gA9WRA==
X-Google-Smtp-Source: ANB0Vdbmx4K2/ymOthC7zOUvVIXgytDRtJLYVv6m+uMNy0BjuEHCZydqzFvuXUSpMD3sA0UhncJTP8++DrIKJOiXH0M=
X-Received: by 2002:a25:858f:: with SMTP id x15-v6mr9145057ybk.270.1536675494837;
 Tue, 11 Sep 2018 07:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180911082559.24214-1-anders.roxell@linaro.org> <s5hbm941law.wl-tiwai@suse.de>
In-Reply-To: <s5hbm941law.wl-tiwai@suse.de>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 11 Sep 2018 16:18:03 +0200
Message-ID: <CADYN=9JqdmfVfWWWB3VtDcdVDPD6bBfKOnemaKFLd4SRrKi33g@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: fix unused variable warning
To:     tiwai@suse.de
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 at 10:38, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 11 Sep 2018 10:25:59 +0200,
> Anders Roxell wrote:
> >
> > When CONFIG_X86=3Dn function azx_snoop doesn't use the variable chip it
> > only returns true.
> >
> > sound/pci/hda/hda_intel.c: In function =E2=80=98dma_alloc_pages=E2=80=
=99:
> > sound/pci/hda/hda_intel.c:2002:14: warning: unused variable =E2=80=98ch=
ip=E2=80=99 [-Wunused-variable]
> >   struct azx *chip =3D bus_to_azx(bus);
> >               ^~~~
> >
> > Create a inline function of azx_snoop.
> >
> > Fixes: a41d122449be ("ALSA: hda - Embed bus into controller object")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  sound/pci/hda/hda_controller.h | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_control=
ler.h
> > index 0053b704ddc4..aa20048742d0 100644
> > --- a/sound/pci/hda/hda_controller.h
> > +++ b/sound/pci/hda/hda_controller.h
> > @@ -170,11 +170,10 @@ struct azx {
> >  #define azx_bus(chip)        (&(chip)->bus.core)
> >  #define bus_to_azx(_bus)     container_of(_bus, struct azx, bus.core)
> >
> > -#ifdef CONFIG_X86
> > -#define azx_snoop(chip)              ((chip)->snoop)
> > -#else
> > -#define azx_snoop(chip)              true
> > -#endif
> > +static inline bool azx_snoop(struct azx *chip)
> > +{
> > +     return IS_ENABLED(CONFIG_X86) || (chip->snoop);
> > +}
>
> The idea is good, but the patch is obviously wrong; it should be
> !IS_ENABLED() :)

oops, right.

>
> Also, please remove the parentheses around chip->snoop.

OK.

Sending v2 shortly.

Cheers,
Anders
