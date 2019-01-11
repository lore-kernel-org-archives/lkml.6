Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F53EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297EE20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYvPcBRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfAKJx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:53:57 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55901 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730378AbfAKJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:53:56 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so1487672ith.5;
        Fri, 11 Jan 2019 01:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X8BlbWN2HjYlOQtiuSrwPdZOJRLE+ItQTDWpVSJ/AoM=;
        b=VYvPcBRcZVLM7E3GxT8ji68L/CDLZHjqlnGqFP2mWgISzWPJ+0iaEDA5kfN51DbK+t
         RrGRUmJIB7ccFbJC3XBmJN5k0WiMdsnmHP8ECfSDGsYn484QCQ0Sn1KUAQaqi0LWNVC0
         wytD3d4Plm4j4OUHSuMsD0nKcPVVag/YyARZS3gALBEpC/kaHkc3TwHAJhBWw0620sH6
         IbUvtbp61RRrrSAu7tYJeiOprYcJEWEUpFT2erTQWt5WpsgwP75Na0BA77EIYdOkgX60
         TR1Fo02YwUpcKhPfO6qQQrijprvd8Fsw656bC933wmSP+w+cz9S9+DIh3MFFN9ePc3bI
         k2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X8BlbWN2HjYlOQtiuSrwPdZOJRLE+ItQTDWpVSJ/AoM=;
        b=LkipgFTRdC1b9NxhUupf2yVD0NdP2EdRuENNWvBewaqMUPpIqh9JwSL5d06mgEhHYx
         ww0YpOqe/g97XDllKd1VqIDFdOtrFhi9+5ZpCGkT46Y0rLOwo0cFFEoNd8XdWJuIkzbU
         Lab2qz3m7G4slBCUWqy59hmTTrwHCLnea9spPs28DYPkFMNDGARm9HHQ3xyQNEUTqJ+6
         yNnMR4SVq63O5YYhfSM4lhpb+S7Sz1dj+MTuVwpfH7gHK/lgsEK+nIukwMZ5EIZe7BcT
         yJ9QQn+CjXw9zcUWkGznWj0DWaxuTPhEqdDDoOWvb8+6oOEz8pQNOFHQoMVZwc26CuSl
         92VA==
X-Gm-Message-State: AJcUukfZWMTEAa5t4M//BkbGyDpqQzldsQyiWgmwlYUsehD9YwHrN1Q7
        VLkAbrQPe9VhcvZpiqwE85lyq1dKsBYzrmT7HoI=
X-Google-Smtp-Source: ALg8bN52T1VUQ0452u28Ck2IgbKwCIo7u0arkYUYOB7DIXGsCnKFnh2P+dQ7xTUxKqdviqaM0dGeIG+plosJXqy29Sk=
X-Received: by 2002:a24:b34f:: with SMTP id z15mr671096iti.61.1547200435077;
 Fri, 11 Jan 2019 01:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
In-Reply-To: <CAJKOXPdz-LfQ1-jPXB5Y7pVVVBDdH0Q=5xZJxvabjhZ-Ush+dg@mail.gmail.com>
From:   =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date:   Fri, 11 Jan 2019 10:53:44 +0100
Message-ID: <CAKpie0S3ce1gYqf2-ncz9jQdxG-e58bzn2GkCOkT468sL_EapA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting
 regulators fail
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 11 sty 2019 o 10:46 Krzysztof Kozlowski <krzk@kernel.org> napisa=C5=82=
(a):
>
> On Thu, 10 Jan 2019 at 21:53, Pawe=C5=82 Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >
> > There is possibility, that when probing driver, regulators are not yet
> > initialized. In this case we should return EPROBE_DEFER and wait till
> > they're initialized, since they're required currently for cpufreq drive=
r
> > to work. Also move regulator initialization code at beginning of probe,
> > so we can defer as fast as posibble.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v1:
> >   - Fix compilation error
> >   - Reorganize code so it's smaller
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 32 ++++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv21=
0-cpufreq.c
> > index f51697f1e0b3..6df95941ba96 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -594,6 +594,25 @@ static int s5pv210_cpufreq_probe(struct platform_d=
evice *pdev)
> >          * this whole driver as soon as S5PV210 gets migrated to use
> >          * cpufreq-dt driver.
> >          */
> > +       arm_regulator =3D regulator_get(NULL, "vddarm");
> > +       if (IS_ERR(arm_regulator)) {
> > +               if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
> > +                       pr_debug("vddarm regulator not ready, defer\n")=
;
> > +               else
> > +                       pr_err("failed to get regulator vddarm\n");
> > +               return PTR_ERR(arm_regulator);
> > +       }
> > +
> > +       int_regulator =3D regulator_get(NULL, "vddint");
> > +       if (IS_ERR(int_regulator)) {
> > +               if (PTR_ERR(int_regulator) =3D=3D -EPROBE_DEFER)
> > +                       pr_debug("vddint regulator not ready, defer\n")=
;
> > +               else
> > +                       pr_err("failed to get regulator vddint\n");
> > +               regulator_put(arm_regulator);
> > +               return PTR_ERR(int_regulator);
> > +       }
> > +
>
> Error paths are now not correct. You should put the regulators when
> returning later. The previous code had these error paths wrong as well
> - not iounmapping - but if you move things around, maybe let's fix
> things.
Ok, will fix this in new version and will resend it (only this one
patch, since all other looks ok/applied).
Also will add missing iounmapping/etc to fix all other error paths.

Thanks
>
> Best regards,
> Krzysztof
