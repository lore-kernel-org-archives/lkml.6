Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE194C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864720858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9mLvvkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7864720858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJHRqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:46:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45490 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:46:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id e10-v6so9278109qtq.12;
        Mon, 08 Oct 2018 03:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhz/UDFYeej9FX5sTH80LGKhr+Gd2rtRa8v4oZaDtV4=;
        b=l9mLvvkBAmyHpDnxXQjjSa0qznNVZIL9RwP8z9+Hn5FGWNu9ejGTe9nw282IEa4k27
         g4d+QCIXNkytt4FOIW5JZCFB8/nayRfjfOeJPjZTzXccnyB/R52gznkepwMT/VixcRAd
         IHAWtYdUVQwrBSPdFCkHwta0eqPW63nx+aIT8BegPTyE1cG+BoTMFgxz7Upe2dAChXX0
         S5vlFE5gqAe7OWiEO1Frpu6wqLvfJ5hvR/20+k0gP6URZR7dmG2pH+/7Din3il8/0uoc
         9p8UGfEsVs2Qqt5iDO85QdXJWXs+YMItnAQ0HBMigG8j4ge14bCiQSOx+7QlRAk5Sr9a
         UrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhz/UDFYeej9FX5sTH80LGKhr+Gd2rtRa8v4oZaDtV4=;
        b=p27hNiusyDTt6RfK6NtQyKm5XXDQx8/oLHaZUYje7oMqWONCvz8KnadSqpBW/EZuJL
         3yW/40nb9kplm/Nec1ykfAdXoVRAbd++1nzduPWig2ZdBKsQakasAJ+scu4aRU6C4C/z
         K2H4vYNFEbMmBOcW7lOT/6Z8I2Rlk0+UU5wAFgDhGoZaNH9YZRXvy78X+Ty52gUJaETE
         y2sHk1xYiZCH9stoe/Wz7wZET878pv/8GN5wLGQM2iZJ6/FDg4LsGhuy75iNuQXLUuRk
         tL0TY2JiJxiYSTfbhTHeg365s+SpWkAX2TLwnxDlavoCf9PZ5iU184A86o59bhe6SgHV
         GYLw==
X-Gm-Message-State: ABuFfohds25+yGA/XKLUBwY4hQVVBTrd8hTYRsDyxy++wUIYhcuPoxMJ
        /GyyP/R3WoW1dPl/ep+FUMR5vblHmZNlls35Cxo=
X-Google-Smtp-Source: ACcGV62ug8A7uidmSkQJovVp35Z6ORq3AORXt+f90LyQmdtHwNA62VsZqKxLl2NvFZSv1g/UbNfPzY7SclL1PchkGJI=
X-Received: by 2002:ac8:29d3:: with SMTP id 19-v6mr18051196qtt.174.1538994902473;
 Mon, 08 Oct 2018 03:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181008134449.64aad97e@canb.auug.org.au> <4344904.ysa79Efigr@aspire.rjw.lan>
In-Reply-To: <4344904.ysa79Efigr@aspire.rjw.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Oct 2018 13:34:51 +0300
Message-ID: <CAHp75Vf7EEpv-oukQCAver==yd28CCYx4aChCaBvg23E1F-YKQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the pm tree
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:11 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, October 8, 2018 4:44:49 AM CEST Stephen Rothwell wrote:
> >
> > --Sig_/bNRy8ryxcqLmcoGqvlETGhp
> > Content-Type: text/plain; charset=US-ASCII
> > Content-Transfer-Encoding: quoted-printable
> >
> > Hi all,
> >
> > Today's linux-next merge of the tip tree got a conflict in:
> >
> >   drivers/powercap/intel_rapl.c
> >
> > between commit:
> >
> >   17ed15183c24 ("powercap: RAPL: Get rid of custom RAPL_CPU() macro")
> >
> > from the pm tree and commit:
> >
> >   f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")
> >
> > from the tip tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --=20
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc drivers/powercap/intel_rapl.c
> > index bb92874b1175,8cbfcce57a06..000000000000
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@@ -1133,40 -1133,47 +1133,40 @@@ static const struct rapl_defaults rapl_
> >       .compute_time_window =3D rapl_compute_time_window_atom,
> >   };
> >  =20
> >  -#define RAPL_CPU(_model, _ops) {                    \
> >  -            .vendor =3D X86_VENDOR_INTEL,           \
> >  -            .family =3D 6,                          \
> >  -            .model =3D _model,                      \
> >  -            .driver_data =3D (kernel_ulong_t)&_ops, \
> >  -            }
> >  -
> >   static const struct x86_cpu_id rapl_ids[] __initconst =3D {
> >  -    RAPL_CPU(INTEL_FAM6_SANDYBRIDGE,        rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_SANDYBRIDGE_X,      rapl_defaults_core),
> >  -
> >  -    RAPL_CPU(INTEL_FAM6_IVYBRIDGE,          rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_IVYBRIDGE_X,        rapl_defaults_core),
> >  -
> >  -    RAPL_CPU(INTEL_FAM6_HASWELL_CORE,       rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_HASWELL_ULT,        rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_HASWELL_GT3E,       rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_HASWELL_X,          rapl_defaults_hsw_server),
> >  -
> >  -    RAPL_CPU(INTEL_FAM6_BROADWELL_CORE,     rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_BROADWELL_GT3E,     rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_BROADWELL_XEON_D,   rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_BROADWELL_X,        rapl_defaults_hsw_server),
> >  -
> >  -    RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,    rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_SKYLAKE_MOBILE,     rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_SKYLAKE_X,          rapl_defaults_hsw_server),
> >  -    RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,    rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,   rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,  rapl_defaults_core),
> >  -
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT,    rapl_defaults_byt),
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,       rapl_defaults_cht),
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT_MID,        rapl_defaults_tng),
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT_MID,   rapl_defaults_ann),
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,      rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_PLUS, rapl_defaults_core),
> >  -    RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT_X,    rapl_defaults_core),
> >  -
> >  -    RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,       rapl_defaults_hsw_server),
> >  -    RAPL_CPU(INTEL_FAM6_XEON_PHI_KNM,       rapl_defaults_hsw_server),
> >  +    INTEL_CPU_FAM6(SANDYBRIDGE,             rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(SANDYBRIDGE_X,           rapl_defaults_core),
> >  +
> >  +    INTEL_CPU_FAM6(IVYBRIDGE,               rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(IVYBRIDGE_X,             rapl_defaults_core),
> >  +
> >  +    INTEL_CPU_FAM6(HASWELL_CORE,            rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(HASWELL_ULT,             rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(HASWELL_GT3E,            rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(HASWELL_X,               rapl_defaults_hsw_server),
> >  +
> >  +    INTEL_CPU_FAM6(BROADWELL_CORE,          rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(BROADWELL_GT3E,          rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(BROADWELL_XEON_D,        rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(BROADWELL_X,             rapl_defaults_hsw_server),
> >  +
> >  +    INTEL_CPU_FAM6(SKYLAKE_DESKTOP,         rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(SKYLAKE_MOBILE,          rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(SKYLAKE_X,               rapl_defaults_hsw_server),
> >  +    INTEL_CPU_FAM6(KABYLAKE_MOBILE,         rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(KABYLAKE_DESKTOP,        rapl_defaults_core),
> >  +    INTEL_CPU_FAM6(CANNONLAKE_MOBILE,       rapl_defaults_core),
> >  +
> > -     INTEL_CPU_FAM6(ATOM_SILVERMONT1,        rapl_defaults_byt),
> > ++    INTEL_CPU_FAM6(ATOM_SILVERMONT,         rapl_defaults_byt),
> >  +    INTEL_CPU_FAM6(ATOM_AIRMONT,            rapl_defaults_cht),
> > -     INTEL_CPU_FAM6(ATOM_MERRIFIELD,         rapl_defaults_tng),
> > -     INTEL_CPU_FAM6(ATOM_MOOREFIELD,         rapl_defaults_ann),
> > ++    INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,     rapl_defaults_tng),
> > ++    INTEL_CPU_FAM6(ATOM_AIRMONT_MID,        rapl_defaults_ann),
> >  +    INTEL_CPU_FAM6(ATOM_GOLDMONT,           rapl_defaults_core),
> > -     INTEL_CPU_FAM6(ATOM_GEMINI_LAKE,        rapl_defaults_core),
> > -     INTEL_CPU_FAM6(ATOM_DENVERTON,          rapl_defaults_core),
> > ++    INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,      rapl_defaults_core),
> > ++    INTEL_CPU_FAM6(ATOM_GOLDMONT_X,         rapl_defaults_core),
> >  +
> >  +    INTEL_CPU_FAM6(XEON_PHI_KNL,            rapl_defaults_hsw_server),
> >  +    INTEL_CPU_FAM6(XEON_PHI_KNM,            rapl_defaults_hsw_server),
> >       {}
> >   };
> >   MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> >
> > --Sig_/bNRy8ryxcqLmcoGqvlETGhp
> > Content-Type: application/pgp-signature
> > Content-Description: OpenPGP digital signature
> >
> >
> > --Sig_/bNRy8ryxcqLmcoGqvlETGhp--
>
> This looks good to me too.  Andy, any concerns?

Nope, looks good to me!

--
With Best Regards,
Andy Shevchenko
