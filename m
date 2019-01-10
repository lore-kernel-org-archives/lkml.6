Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C02F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+y9FrIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfAJIDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:03:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35188 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAJIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:03:46 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so14994649itp.0;
        Thu, 10 Jan 2019 00:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D1GLZJ7izl6n7wousL+JuQK/SWu+qMmRURLM0AUj8aA=;
        b=G+y9FrIpld9R3OnBXxn3iPO98OsU3GT+vhXjY5k716N8Jc3rE+mPcQ3AfSJl94w9cZ
         xxFigV54SUbFJYBTz12egg/6TBq2meysXnm6sm7mAiw8+AdRtizI+v07PPbjp2FnpP05
         8qoljIzbgy49fW5Nb2gCo3bkCoFr7M/pADsv1xurDvni7R7R1qjadXoSKREfbtlfztcs
         Olgh74tjw7m3/ogT2otkuHfaFTxJfKJhP3NOQweoXQbf769AcKHaOaTB9Qx41kSvfzMR
         akkh78RJeufC3qfPSNwS7WGxEvaI5m/CIdasK/fH4/fMCLf1BtE8+/YxImTm9zXLVU62
         RLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D1GLZJ7izl6n7wousL+JuQK/SWu+qMmRURLM0AUj8aA=;
        b=O1y/Xsjiyzx9Jb3luMh2UwluQg1MvDNFiQJBE7mY5POUTnQlKp36d1F9172A5X8Ega
         5cNLIyNfLwcVgGI5o1DONAGJzG+Jv8F7LBgtWG0EFdlqE3+kO3LLGGWnD7WCLoYla90n
         dKT4whk4vTh/I1ZfNOqHglkE66lTL2VQ/NQNRC8ZUCgIK28rmJGg2uTSXagtMg9N3ULV
         39/R9DqO1TZc8fzvgFG3pbhchntQx5HiPwCi5ztnVO7JihRVzPFz943U0u2CrwqM6suQ
         BniJOiHEWiVx27PaBpa9eIOw2AC20nMEMAkCApFwZqqvNb8ZXyViwExGzI38zCHamB45
         4QKw==
X-Gm-Message-State: AJcUukcVfc+ktfWp8zmAqhjT21wQLt2QB7Jkv3fqwLFefqWqrGcn3pEL
        VjE9wyNlX0mH2MEABp8zWqtsZeCNXANkxTUc2iA=
X-Google-Smtp-Source: ALg8bN7yX4GRuF4bu+joz4mWwSnF+YRtqun4NIUT1+jpOmUrspGUTUe6oEZ1eb8a8nXgluEpTKmiObwd3lgYTPbKxwA=
X-Received: by 2002:a02:89dd:: with SMTP id e29mr6665653jak.21.1547107425038;
 Thu, 10 Jan 2019 00:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com> <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
In-Reply-To: <20190110070127.ymukpnbabjr5n5fe@vireshk-i7>
From:   =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Date:   Thu, 10 Jan 2019 09:03:34 +0100
Message-ID: <CAKpie0RE=F04JB+_G2K4P4d-5OLB8mvK8P0Q-+DKjwxj7aeA_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators fail
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        rjw@rjwysocki.net,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
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

czw., 10 sty 2019 o 08:01 Viresh Kumar <viresh.kumar@linaro.org> napisa=C5=
=82(a):
>
> On 08-01-19, 21:05, Pawe=C5=82 Chmiel wrote:
> > There is possibility, that when probing driver, regulators are not yet
> > initialized. In this case we should return EPROBE_DEFER and wait till
> > they're initialized, since they're required currently for cpufreq drive=
r
> > to work. Also move regulator initialization code at beginning of probe,
> > so we can defer as fast as posibble.
> >
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 33 +++++++++++++++++++------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv21=
0-cpufreq.c
> > index f51697f1e0b3..2d0e4dc7ede7 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -594,6 +594,26 @@ static int s5pv210_cpufreq_probe(struct platform_d=
evice *pdev)
> >        * this whole driver as soon as S5PV210 gets migrated to use
> >        * cpufreq-dt driver.
> >        */
> > +     arm_regulator =3D regulator_get(NULL, "vddarm");
> > +     if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER) {
> > +             pr_dbg("vddarm regulator not ready, defer\n");
> > +             return -EPROBE_DEFER;
> > +     } else if (IS_ERR(arm_regulator)) {
> > +             pr_err("failed to get regulator vddarm\n");
> > +             return PTR_ERR(arm_regulator);
> > +     }
>
> The only difference between the two cases is pr_dbg vs pr_err, its
> ugly that we have to add special code for that :(
>
> Maybe write it as:
>
>         if (IS_ERR(arm_regulator)) {
>                 if (PTR_ERR(arm_regulator) =3D=3D -EPROBE_DEFER)
>                         pr_dbg...
>                 else
>                         pr_err
>                 return PTR_ERR(arm_regulator);
>         }
>
> > +
> > +     int_regulator =3D regulator_get(NULL, "vddint");
> > +     if (PTR_ERR(int_regulator =3D=3D -EPROBE_DEFER) {
>
> Does this even compile ?
Looks like i broke it after testing (where it was working fine - was
able to change freq and gov),
and didn't catch this before sending patch for review :/.
Sorry, this (and first issue) will be fixed in v2.

Thanks for review
>
> > +             regulator_put(arm_regulator);
> > +             pr_dbg("vddint regulator not ready, defer\n");
> > +             return -EPROBE_DEFER;
> > +     } else if (IS_ERR(int_regulator)) {
> > +             regulator_put(arm_regulator);
> > +             pr_err("failed to get regulator vddint\n");
> > +             return PTR_ERR(int_regulator);
> > +     }
> > +
> >       np =3D of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock=
");
> >       if (!np) {
> >               pr_err("%s: failed to find clock controller DT node\n",
> > @@ -633,19 +653,6 @@ static int s5pv210_cpufreq_probe(struct platform_d=
evice *pdev)
> >               }
> >       }
> >
> > -     arm_regulator =3D regulator_get(NULL, "vddarm");
> > -     if (IS_ERR(arm_regulator)) {
> > -             pr_err("failed to get regulator vddarm\n");
> > -             return PTR_ERR(arm_regulator);
> > -     }
> > -
> > -     int_regulator =3D regulator_get(NULL, "vddint");
> > -     if (IS_ERR(int_regulator)) {
> > -             pr_err("failed to get regulator vddint\n");
> > -             regulator_put(arm_regulator);
> > -             return PTR_ERR(int_regulator);
> > -     }
> > -
> >       register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
> >
> >       return cpufreq_register_driver(&s5pv210_driver);
> > --
> > 2.17.1
>
> --
> viresh
