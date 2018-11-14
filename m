Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D71C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF132243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx7aepP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF132243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732334AbeKNUzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:55:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44628 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeKNUzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:55:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id n12so24875113qkh.11;
        Wed, 14 Nov 2018 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oILDwk+dze61xBA2crzRxnTFLGC3E2KD7D6N85/WTVI=;
        b=Xx7aepP8Ak0MGzdUibTtnMSFtRYS6VlYRoPhQHqyPINRT+QB5TA3LERQv2NE/EQa/g
         MYk12MvVlEfMyf/DKo846Jj4HjX+OSHuozvChOyFYCj0WOgpHGo7IvHXDllH/besLr+b
         4rYnzLV/IhzAYc1nVplknD2ds2jFP5PdAIjkHM5DXt2HSiOoF91adZ97UMzAbvq63IHd
         CNIKmU7yO7ORr3Z5g2L0+iri0NUs0jxyYzVEgcWx9BELMmmMEyu37W8rHAY7GcnLtesw
         VVH9ip1i6HbLwGj5FFB13Mk5mQswg0dYR3HzFD8EeBH3p0K5xALuFKf8iebRPXxYuY2R
         kY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oILDwk+dze61xBA2crzRxnTFLGC3E2KD7D6N85/WTVI=;
        b=U8Q5Soup7UjOzBkldyhCUTOH1OMzylbV8zCHiFid8O9MNKSXq6L5WStVjuDIXDBwIK
         3JEaDxIpf2PHgWBxWu72WP1tXUIHGD6TCKJLSh0dWq7viLGBQKu+IJXHm9JAnnyEB5Rp
         EUaNyENEq4e6vhl7c5Hss1bTwhbWQWHwHFPBkb+qoXUxJXg65p7Q1HNYVHMwbh3WbEQM
         c9RfoRrsNFw9V1vpTtK/amGaqKUxG8kMcPzID217EIQZJrGanlJtYGlyblDAoawKn7Fe
         paTonoeTVwEofYMX/B3S7PCCkfmYf5SyXLIY3c+C203jJhM2GmtSUkRLt2H3iw1+Gu22
         NQvQ==
X-Gm-Message-State: AGRZ1gLi0nYx3ltpsp6e7VLnc2u6KU1Ymxvg3gsQGzthAts1N1tUtBAM
        Q2Yec7DrbyJTuIe3NjRTF0yDJE5W6sNNpeR/v2U=
X-Google-Smtp-Source: AJdET5dHZSlB6yPIR2OfhC+P0Zk1Rkj3yoGmwlFniEkOTEYgEBQZuJqtxb9IZzDIm67OXZdH2NNSRyVjhJL6LMxTTRE=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr1061264qtf.99.1542192754789;
 Wed, 14 Nov 2018 02:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20181114022245.5798-1-loic.wyn@gmail.com> <20181114051603.GF7890@fedora.eng.vmware.com>
 <CAJxRB+DyrRWLTsW6fpOYuhS5W3iS3FATSRsoQTFx9ZJjzLv_dg@mail.gmail.com>
In-Reply-To: <CAJxRB+DyrRWLTsW6fpOYuhS5W3iS3FATSRsoQTFx9ZJjzLv_dg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 12:52:23 +0200
Message-ID: <CAHp75VeE4ktOQ7AwL6v5Rend0EapEobYymyq2JW=D=nzM2qSbQ@mail.gmail.com>
Subject: Re: [PATCH] ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill
 DMI list
To:     Loic Wei-Yu-Neng <loic.wyn@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Ike Panhc <ike.pan@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Jiri Kosina <trivial@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 9:48 AM Loic Wei-Yu-Neng <loic.wyn@gmail.com> wrote:
>
> Hello Darren,
> Yes, the current driver fails to match match my laptop. I need to add this patch to have wifi functional on my laptop.
> Here is the dmidecode snippet from my laptop:
>
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> Manufacturer: LENOVO
> Product Name: 20344
> Version: Yoga 2 13
> Serial Number: 3438666500284
> UUID: 933A1748-ACE0-E311-A534-F8A9633129FA
> Wake-up Type: Power Switch
> SKU Number: LENOVO_MT_20344_BU_idea_FM_Yoga 2 13
> Family: IDEAPAD
>

Yeah, it has slightly different Version string in your case.

Since patchwork (*) still didn't catch your patch you need to resend
with all maintainers and mailing lists included like Darren suggested.

(*) patchwork is a database which is tracking patches and patch series
that are communicated thru mailing lists. It makes maintainer's life
easier and allow to keep a trail of what has been done and when.
The web interface to our project is here
https://patchwork.kernel.org/project/platform-driver-x86/list/


> Loic
>
> On Tue, Nov 13, 2018 at 9:16 PM Darren Hart <dvhart@infradead.org> wrote:
>>
>> On Tue, Nov 13, 2018 at 06:22:45PM -0800, Loic WEI YU NENG wrote:
>> > Some Lenovo ideapad models lack a physical rfkill switch.
>> > On Lenovo models Yoga 2 13, ideapad-laptop would wrongly report all
>> > radios as blocked by hardware which caused wireless network connections
>> > to fail.
>> > Add these models without an rfkill switch to the no_hw_rfkill list.
>> >
>> > Signed-off-by: Loic WEI YU NENG <loic.wyn@gmail.com>
>>
>> Thank you for the patch.
>>
>> In the future, please be sure to check MAINTAINERS and include the
>> relevant lists, now Cc'd.
>>
>> I see this in the context of your patch, but can you confirm the current
>> driver fails to match your system? It contains the following, which I
>> would expect to match:
>>
>>                .ident = "Lenovo Yoga 2 11 / 13 / Pro",
>>                 .matches = {
>>                         DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>                         DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
>>                 },
>>
>> If it doesn't match, what does dmidecode report for SYS_VENDOR and
>> BOARD_NAME on your system? Perhaps we need to make the above more
>> generic.
>>
>> > ---
>> >  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
>> > index b6489cba2985..1589dffab9fa 100644
>> > --- a/drivers/platform/x86/ideapad-laptop.c
>> > +++ b/drivers/platform/x86/ideapad-laptop.c
>> > @@ -1188,6 +1188,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
>> >                       DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
>> >               },
>> >       },
>> > +     {
>> > +             .ident = "Lenovo Yoga 2 13",
>> > +             .matches = {
>> > +                     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> > +                     DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
>> > +             },
>> > +     },
>> >       {
>> >               .ident = "Lenovo Yoga 3 1170 / 1470",
>> >               .matches = {
>> > --
>> > 2.17.1
>> >
>> >
>>
>> --
>> Darren Hart
>> VMware Open Source Technology Center
>
>
>
> --
> Loic WEI YU NENG
> US phone: +1 408 218 2826
> FR phone: +33 674201069
> email: loic.wyn@gmail.com



-- 
With Best Regards,
Andy Shevchenko
