Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12421ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF8720882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXvSam4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF8720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIOCXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:23:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46309 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeIOCXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:23:01 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so5361083ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riMNSXIG1BZM/WhIt3n4PyZuYhb5kLa4qQ0ikFke5JQ=;
        b=bXvSam4biS+WEXmOPolrl8eQ322/h2H4irPEq7rtNfQkbtVaSEVLyFr9aaOeHRGvvz
         zAKlHmzI1WGCWE7rX24PpMgwHDJqyzNe3jGBke3ok77DPk9DaMiKCHXviFoO/g8u/bca
         FY5BQfZzNS5Tyt66DgdjUCbBOKDVohjFpQ8LxOxdzCC/2PQ4MMmud01DuTD7+1Nd1tN2
         F4s2IwiYpF6WXz/0++2nufRVYjNsZuUrnDf7H/1hvfN9hgSFaoV6lWf6/GB/Y4KhdvlJ
         tX10TA1N0XaH14q08eRY/6X7NRrbx5+PxjqL3KyhP6ezunNmYxOXBikMma5pcWIvUbg1
         t+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riMNSXIG1BZM/WhIt3n4PyZuYhb5kLa4qQ0ikFke5JQ=;
        b=MV632Bv4gBVs6iWY//7xRQFUdrLToET4b9vGPBt6Jg1Go0Jlz/IJbCMZ+fZbp15xKd
         zltZAto90g0Yn+30SRji9WekhMEkN9lrpx2ke6Knx61+0en5Xf4WWgcTz4uy5GqmO6gc
         sOOFUOP1pLDEvgqbJpD6IkV5jDnHbug1ePmSrwF4x5CJmZhno5Il40JmrViZMxtrWVH9
         HeCpSlz+Grm7NHF2jiqAXtTrfVR9xpkXFzC0uO4AZzRlTuffzQHGMA/cyXG8DJ4QhN1p
         FsU0bx7ez4dHJq1ghkD5+JoKZrDD2I0CEmbLzW4yucNtZz4g553Bb6MXJQ64PhvoereM
         p3pA==
X-Gm-Message-State: APzg51AtF62Ksuf6tZco4NqzGXBOoMZ7ra+B5EfzMT2QrFspUbyDFtlX
        9Xnm3deawQ+QXxzp5U1zrJ9kHiZB3TytpCM/IleWCQ==
X-Google-Smtp-Source: ANB0VdZ/aGNhl3r3rL4lOIUpjyldYM4gGbZg5oJ7tAyJgvjNZajuaUNee/F9lTYZF/fM/eIRY/VbusfFarQlmtT/lAY=
X-Received: by 2002:a25:b810:: with SMTP id v16-v6mr6395033ybj.58.1536959209373;
 Fri, 14 Sep 2018 14:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com> <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
In-Reply-To: <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 14 Sep 2018 14:06:13 -0700
Message-ID: <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Banik, Subrata" <subrata.banik@intel.com>, aamir.bohra@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 12:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 14, 2018 at 1:54 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > The Icelake does not have a community-3, and the memory resources are
> > laid out in the following order in the ACPI:
> >
> > resource-0: community-0 registers
> > resource-1: community-1 registers
> > resource-2: community-2 registers
> > resource-3: community-4 registers
> > resource-4: community-5 registers
> >
> > (EDS also describes the communities in the above order).
> >
> > Since the pinctrl driver exposes communities 0, 1, 4, 5, it needs to get
> > the corresponding community registers by getting the resourse number right.
> > Currently the resourse number is not correct for community 4 and 5, thus
> > fix that.
> >
>
> Can you share link to the ACPI dump of the tables? (you may get one by
> running `acpidump -o tables.dat`)

I don't have that command on my system, but I took
/sys/firmware/acpi/tables/DSDT from the system and disassembled it
using Intel disassembler (iasl -d) and here is the relevant portion
that describes the GPIO controller. The port IDs for communities can
be seen in the below output (i.e. the PCRB()):

            Device (GPIO)
            {
                Name (_HID, "INT3455")  // _HID: Hardware ID
                Name (_UID, Zero)  // _UID: Unique ID
                Name (_DDN, "GPIO Controller")  // _DDN: DOS Device Name
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y06)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y07)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y08)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y09)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y0A)
                    Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,, )
                    {
                        0x0000000E,
                    }
                })
                Method (_CRS, 0, NotSerialized)  // _CRS: Current
Resource Settings
                {
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y06._BAS,
BAS0)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y06._LEN,
LEN0)  // _LEN: Length
                    BAS0 = PCRB (0x6E)
                    LEN0 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y07._BAS,
BAS1)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y07._LEN,
LEN1)  // _LEN: Length
                    BAS1 = PCRB (0x6D)
                    LEN1 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y08._BAS,
BAS2)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y08._LEN,
LEN2)  // _LEN: Length
                    BAS2 = PCRB (0x6C)
                    LEN2 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y09._BAS,
BAS4)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y09._LEN,
LEN4)  // _LEN: Length
                    BAS4 = PCRB (0x6A)
                    LEN4 = 0x00010000
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y0A._BAS,
BAS5)  // _BAS: Base Address
                    CreateDWordField (RBUF, \_SB.PCI0.GPIO._Y0A._LEN,
LEN5)  // _LEN: Length
                    BAS5 = PCRB (0x69)
                    LEN5 = 0x00010000
                    Return (RBUF) /* \_SB_.PCI0.GPIO.RBUF */
                }

                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (0x0F)
                }
            }

Please let me know if this helps, or if you need more info.

Thanks & Best Regards,

Rajat

>
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/pinctrl/intel/pinctrl-icelake.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
> > index 630b966ce081..5b4eaf7c90df 100644
> > --- a/drivers/pinctrl/intel/pinctrl-icelake.c
> > +++ b/drivers/pinctrl/intel/pinctrl-icelake.c
> > @@ -331,8 +331,8 @@ static const struct intel_padgroup icllp_community5_gpps[] = {
> >  static const struct intel_community icllp_communities[] = {
> >         ICL_COMMUNITY(0, 0, 58, icllp_community0_gpps),
> >         ICL_COMMUNITY(1, 59, 152, icllp_community1_gpps),
> > -       ICL_COMMUNITY(2, 153, 215, icllp_community4_gpps),
> > -       ICL_COMMUNITY(3, 216, 240, icllp_community5_gpps),
> > +       ICL_COMMUNITY(3, 153, 215, icllp_community4_gpps),
> > +       ICL_COMMUNITY(4, 216, 240, icllp_community5_gpps),
> >  };
> >
> >  static const unsigned int icllp_spi0_pins[] = { 22, 23, 24, 25, 26 };
> > --
> > 2.19.0.397.gdd90340f6a-goog
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
