Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445DE2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lng1O8PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445DE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbeKOBTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:19:01 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42873 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKOBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:19:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so8154464lfh.9;
        Wed, 14 Nov 2018 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tx/TesI950m2ReX0G8JJHQawEjbatCHZbq34Iu0+zMM=;
        b=lng1O8PTydK18xYY30bOl49TszqA8PulF1/TQ0wo3rgYngtwht/m9qhk/yJGzzCTS8
         1lEmLXtUgujS86JwhVI/sSAfWz01iQjICl14vwCPDPqIceTQ4wCddG2qrduaAnJhbtuq
         FqvuUkKcxhLINSoHjiF9mQIjnN4i+nBwq7eOZAwuizmUfg1BO+eJf9ZMhpFfeuXil0fq
         mtg7jbV1OGzxzB/Z4QhbEL1sf/fkE3UUNrY/A44Lk/1TQBhGsJ+zJNMJjMSEMnc85D4u
         t3QzjBN8pwuQ4MnBrInRnlsGW4wfLCFnRbLlkYe/QOMO2eZpivpAPbiSaJ2f6/bpxoWT
         EZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tx/TesI950m2ReX0G8JJHQawEjbatCHZbq34Iu0+zMM=;
        b=T1916DZey4R+tUnBU51+d21yFzxEHGdOIjFOsbNAf79GuKlyHtqdH5So/eoaZvuMbS
         K4NSY4pnq71DUMaF7kEKPU57kytvioBG+qK08ZVukvzP2Z/cIAxl4sQfmdZuNnxObXS4
         2t1d3+X3/lutAYvckicZT00kMpJD/+B7mkjCyLMPnayNwQ5FR9EoqpN/ULeqEEyzowQU
         cnKR2wpHTOz+yzADgahxKE41nq0EWtUqq/lwV2l2X+d0qCRZV46CDmrKBNZbwZUNDJ9Q
         BJ9o8ROJQtySkI6vjKbWBdewfWVg+8iBqpMLuidvJTPD4ApUdtOL7JGOh7QAXRCWfIw5
         2exw==
X-Gm-Message-State: AGRZ1gJs22+nTe+IGIPWrmDIX/9TL4b+xMHAYo2c+1MGBbP7/oudj0+s
        yn68pEwYojd4IR4dD1RarBlePa2hrUwWK/9zfJA=
X-Google-Smtp-Source: AJdET5elTAH0g8b3hyM1V4pCM/kP4c61zmM9xgm2UGOPWaie/cXaeUvp5Z1Lt5BICnMj7Q/4j/+nVi9O/FLnL89VvTA=
X-Received: by 2002:a19:6514:: with SMTP id z20mr1226452lfb.31.1542208519438;
 Wed, 14 Nov 2018 07:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20181114022245.5798-1-loic.wyn@gmail.com> <20181114051603.GF7890@fedora.eng.vmware.com>
 <CAJxRB+DyrRWLTsW6fpOYuhS5W3iS3FATSRsoQTFx9ZJjzLv_dg@mail.gmail.com> <CAHp75VeE4ktOQ7AwL6v5Rend0EapEobYymyq2JW=D=nzM2qSbQ@mail.gmail.com>
In-Reply-To: <CAHp75VeE4ktOQ7AwL6v5Rend0EapEobYymyq2JW=D=nzM2qSbQ@mail.gmail.com>
From:   Loic Wei-Yu-Neng <loic.wyn@gmail.com>
Date:   Wed, 14 Nov 2018 07:15:07 -0800
Message-ID: <CAJxRB+BqibM3cyUvWH-3j6dPnF1EuYWyFhAvf5zRyf=-UraR_Q@mail.gmail.com>
Subject: Re: [PATCH] ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill
 DMI list
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Ike Panhc <ike.pan@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Jiri Kosina <trivial@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good,
I can me my patch here now:
https://patchwork.kernel.org/patch/10682745/
Loic

On Wed, Nov 14, 2018 at 2:52 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Nov 14, 2018 at 9:48 AM Loic Wei-Yu-Neng <loic.wyn@gmail.com> wrote:
> >
> > Hello Darren,
> > Yes, the current driver fails to match match my laptop. I need to add this patch to have wifi functional on my laptop.
> > Here is the dmidecode snippet from my laptop:
> >
> > Handle 0x0001, DMI type 1, 27 bytes
> > System Information
> > Manufacturer: LENOVO
> > Product Name: 20344
> > Version: Yoga 2 13
> > Serial Number: 3438666500284
> > UUID: 933A1748-ACE0-E311-A534-F8A9633129FA
> > Wake-up Type: Power Switch
> > SKU Number: LENOVO_MT_20344_BU_idea_FM_Yoga 2 13
> > Family: IDEAPAD
> >
>
> Yeah, it has slightly different Version string in your case.
>
> Since patchwork (*) still didn't catch your patch you need to resend
> with all maintainers and mailing lists included like Darren suggested.
>
> (*) patchwork is a database which is tracking patches and patch series
> that are communicated thru mailing lists. It makes maintainer's life
> easier and allow to keep a trail of what has been done and when.
> The web interface to our project is here
> https://patchwork.kernel.org/project/platform-driver-x86/list/
>
>
> > Loic
> >
> > On Tue, Nov 13, 2018 at 9:16 PM Darren Hart <dvhart@infradead.org> wrote:
> >>
> >> On Tue, Nov 13, 2018 at 06:22:45PM -0800, Loic WEI YU NENG wrote:
> >> > Some Lenovo ideapad models lack a physical rfkill switch.
> >> > On Lenovo models Yoga 2 13, ideapad-laptop would wrongly report all
> >> > radios as blocked by hardware which caused wireless network connections
> >> > to fail.
> >> > Add these models without an rfkill switch to the no_hw_rfkill list.
> >> >
> >> > Signed-off-by: Loic WEI YU NENG <loic.wyn@gmail.com>
> >>
> >> Thank you for the patch.
> >>
> >> In the future, please be sure to check MAINTAINERS and include the
> >> relevant lists, now Cc'd.
> >>
> >> I see this in the context of your patch, but can you confirm the current
> >> driver fails to match your system? It contains the following, which I
> >> would expect to match:
> >>
> >>                .ident = "Lenovo Yoga 2 11 / 13 / Pro",
> >>                 .matches = {
> >>                         DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >>                         DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
> >>                 },
> >>
> >> If it doesn't match, what does dmidecode report for SYS_VENDOR and
> >> BOARD_NAME on your system? Perhaps we need to make the above more
> >> generic.
> >>
> >> > ---
> >> >  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
> >> >  1 file changed, 7 insertions(+)
> >> >
> >> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> >> > index b6489cba2985..1589dffab9fa 100644
> >> > --- a/drivers/platform/x86/ideapad-laptop.c
> >> > +++ b/drivers/platform/x86/ideapad-laptop.c
> >> > @@ -1188,6 +1188,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
> >> >                       DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
> >> >               },
> >> >       },
> >> > +     {
> >> > +             .ident = "Lenovo Yoga 2 13",
> >> > +             .matches = {
> >> > +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> >> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
> >> > +             },
> >> > +     },
> >> >       {
> >> >               .ident = "Lenovo Yoga 3 1170 / 1470",
> >> >               .matches = {
> >> > --
> >> > 2.17.1
> >> >
> >> >
> >>
> >> --
> >> Darren Hart
> >> VMware Open Source Technology Center
> >
> >
> >
> > --
> > Loic WEI YU NENG
> > US phone: +1 408 218 2826
> > FR phone: +33 674201069
> > email: loic.wyn@gmail.com
>
>
>
> --
> With Best Regards,
> Andy Shevchenko



-- 
Loic WEI YU NENG
US phone: +1 408 218 2826
FR phone: +33 674201069
email: loic.wyn@gmail.com
