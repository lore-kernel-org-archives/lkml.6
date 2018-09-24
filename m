Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB5CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B552145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLcDTp0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B552145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbeIXXHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:07:44 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38389 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbeIXXHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:07:44 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so8532702ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w4qAOQnu9VVXzOUDiFJQ5prvd6BIyYPjzmyEnmUDEB8=;
        b=WLcDTp0vTWxfucdOgi0Ufo1TJjD5AbDIcU9GcUKs8K+gMkSGsyuc/F1gN4iuZiGpp+
         Kh3a61gtVwTIE3P0LrjADnLM2LvUdKkEox0SAAUdI6+7hcLSF0jnqOuF3mVCES/MPokL
         vh0L+anUY+XHcR/lYPLkgOYvfWZsU2b5Df9S6CdljKNHW4mq9/E32ncP3r25BiBujrHM
         4gZEUaz5qkHuDm7lKQEh8pvV5Ul507sX2YVXFDsr+Z8DtILJZphyaqfGapi5Jn8c6Yi4
         15ZmgRK/xEXImNkgWDPhJlQr5a8H0FRnNZNNczTVtA2H4Ly681FlZrn7h8CpJw5bvb4e
         pNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w4qAOQnu9VVXzOUDiFJQ5prvd6BIyYPjzmyEnmUDEB8=;
        b=f2a2EIcjrcC4CE3jUVNhDMh7DjQYu6ZazXDDCCF2ui7ufPc5MyLigh3oYEjGeMzeIU
         7J9mLnfDSKsJSkW/3wuLXAEW4VYeAe8EYU8IOEbYZgRoqarJMLQJ1LOfTuZkV+rCLGts
         3C/musstXOcM4zBLNKPDJRZd9lTPpqsqkl/Ly3KAbH8pv/Iqcq4ZKrkNrn6SAE2Reryf
         9vYXKf8Lz+Do8SJE4EsvUlWf5pxpTiy6YuHzg1JrTxEKwF/cPYi81f/uD8+z2fooNNTt
         L1lv6YblQj4m6NlInCpUNhxydSn29HKJv9Tt2smJol2c3Pw99N2G7IRMvE356CZ/GCLj
         gyBA==
X-Gm-Message-State: ABuFfoi43bk402GYOfnokBp2M58VfjpNNYf0Hlf/cWWbXGdJkGYCOlmr
        HnuzIr6RvG9Cf4AtQ93/0jmKzrPtBzoI6H3IOn/NqQ==
X-Google-Smtp-Source: ACcGV60Q8sdAeh9tc3lv8Bthf1z+bB5FCdDtyGewFN3IsjQhA1Wjt0h6FzQpt8FyyYYmhXmLMfJsP3get6QheV31EhQ=
X-Received: by 2002:a5b:c4b:: with SMTP id d11-v6mr5396743ybr.381.1537808677386;
 Mon, 24 Sep 2018 10:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180913223143.12664-1-rajatja@google.com> <CAHp75VcVkp6i_4oNVJvzde13MwaRQge91mvZF2aXgneZC9nzWg@mail.gmail.com>
 <CACK8Z6FhJhhfgk1zPMv5M0oRwz=o75YOKFmU+4Wx-X9-prPnKA@mail.gmail.com>
 <CACK8Z6GeZ+2uRsRDPfdd=i+WrdQwQgEBvEyDxQuKLygXqPp4dw@mail.gmail.com>
 <CACK8Z6FLPVSJpPuAXZsqHV2rY2zy3L-Fvd=QPn=+Ynp3aHyhaQ@mail.gmail.com>
 <20180924135935.GP15943@smile.fi.intel.com> <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
In-Reply-To: <70D28D5DAE32E9429B09AA8B7C84AC472C0000CB@BGSMSX106.gar.corp.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 24 Sep 2018 10:04:00 -0700
Message-ID: <CACK8Z6Ej=BVThT8gSHCNZadXbLpzqKe6TmLYGkeBMmJBby1n-g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for community-4/5
To:     "Banik, Subrata" <subrata.banik@intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Bohra, Aamir" <aamir.bohra@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Sep 24, 2018 at 7:54 AM Banik, Subrata <subrata.banik@intel.com> wr=
ote:
>
> HI Andy,
>
> You are right that this ASL code is not same with Intel reference BIOS co=
de because BIOS sources are different between what you are looking vs what =
Chrome OS is using. In Coreboot BIOS, we are more relying on EDS spec and a=
s COM 3 is dedicated for CPU GPIO hence we are mapping, 0/1/2/4/5 (whatever=
 present in EDS vol 1.1)
>
> We have ensured that PCR ID and offsets are correct in ASL code for respe=
ctive community, I don't think anything else really matter from BIOS unless=
 you tell me, that you are having any required that your drive code will on=
ly probe for 4 COMM for LP and 5 for ICL-H?
>
> Thanks,
> Subrata
>
> -----Original Message-----
> From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
> Sent: Monday, September 24, 2018 7:30 PM
> To: Rajat Jain <rajatja@google.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>; Linus Walleij <lin=
us.walleij@linaro.org>; linux-gpio@vger.kernel.org; Linux Kernel Mailing Li=
st <linux-kernel@vger.kernel.org>; Rajat Jain <rajatxjain@gmail.com>; Banik=
, Subrata <subrata.banik@intel.com>; Bohra, Aamir <aamir.bohra@intel.com>
> Subject: Re: [PATCH] pinctrl: icelake: Fix the resource number for commun=
ity-4/5
>
> On Thu, Sep 20, 2018 at 10:19:34AM -0700, Rajat Jain wrote:
> > On Fri, Sep 14, 2018 at 2:38 PM Rajat Jain <rajatja@google.com> wrote:
> > > On Fri, Sep 14, 2018 at 2:06 PM Rajat Jain <rajatja@google.com> wrote=
:
> > > > On Fri, Sep 14, 2018 at 12:41 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Fri, Sep 14, 2018 at 1:54 AM Rajat Jain <rajatja@google.com> w=
rote:
> > > > > >
> > > > > > The Icelake does not have a community-3, and the memory
> > > > > > resources are laid out in the following order in the ACPI:
> > > > > >
> > > > > > resource-0: community-0 registers
> > > > > > resource-1: community-1 registers
> > > > > > resource-2: community-2 registers
> > > > > > resource-3: community-4 registers
> > > > > > resource-4: community-5 registers
> > > > > >
> > > > > > (EDS also describes the communities in the above order).
> > > > > >
> > > > > > Since the pinctrl driver exposes communities 0, 1, 4, 5, it
> > > > > > needs to get the corresponding community registers by getting t=
he resourse number right.
> > > > > > Currently the resourse number is not correct for community 4
> > > > > > and 5, thus fix that.
> > > > > >
> > > > >
> > > > > Can you share link to the ACPI dump of the tables? (you may get
> > > > > one by running `acpidump -o tables.dat`)
> >
> > Hello Andy,
> >
> > Any feedback on this patch? I provided a dump of the ACPI below,
> > please let me know if you need more info.
>
> Sorry it took a while (I had to get tested on our reference BIOS(es) on I=
ce Lake platforms we have).
> See my reply below.
>
> > > > I don't have that command on my system, but I took
> > > > /sys/firmware/acpi/tables/DSDT from the system and disassembled it
> > > > using Intel disassembler (iasl -d) and here is the relevant
> > > > portion that describes the GPIO controller. The port IDs for
> > > > communities can be seen in the below output (i.e. the PCRB()):
> > >
> > > I realized PCRB() is an ACPI method defined in the same disasembly:
> > >
> > >             Method (PCRB, 1, NotSerialized)
> > >             {
> > >                 Return ((0xFD000000 + (Arg0 << 0x10)))
> > >             }
> > >
> > > >
> > > >             Device (GPIO)
> > > >             {
> > > >                 Name (_HID, "INT3455")  // _HID: Hardware ID
> > > >                 Name (_UID, Zero)  // _UID: Unique ID
> > > >                 Name (_DDN, "GPIO Controller")  // _DDN: DOS Device=
 Name
> > > >                 Name (RBUF, ResourceTemplate ()
> > > >                 {
> > > >                     Memory32Fixed (ReadWrite,
> > > >                         0x00000000,         // Address Base
> > > >                         0x00000000,         // Address Length
> > > >                         _Y06)
> > > >                     Memory32Fixed (ReadWrite,
> > > >                         0x00000000,         // Address Base
> > > >                         0x00000000,         // Address Length
> > > >                         _Y07)
> > > >                     Memory32Fixed (ReadWrite,
> > > >                         0x00000000,         // Address Base
> > > >                         0x00000000,         // Address Length
> > > >                         _Y08)
> > > >                     Memory32Fixed (ReadWrite,
> > > >                         0x00000000,         // Address Base
> > > >                         0x00000000,         // Address Length
> > > >                         _Y09)
> > > >                     Memory32Fixed (ReadWrite,
> > > >                         0x00000000,         // Address Base
> > > >                         0x00000000,         // Address Length
> > > >                         _Y0A)
> > > >                     Interrupt (ResourceConsumer, Level, ActiveLow, =
Shared, ,, )
> > > >                     {
> > > >                         0x0000000E,
> > > >                     }
> > > >                 })
> > > >                 Method (_CRS, 0, NotSerialized)  // _CRS: Current
> > > > Resource Settings
> > > >                 {
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y06._BAS,
> > > > BAS0)  // _BAS: Base Address
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y06._LEN,
> > > > LEN0)  // _LEN: Length
> > > >                     BAS0 =3D PCRB (0x6E)
> > > >                     LEN0 =3D 0x00010000
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y07._BAS,
> > > > BAS1)  // _BAS: Base Address
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y07._LEN,
> > > > LEN1)  // _LEN: Length
> > > >                     BAS1 =3D PCRB (0x6D)
> > > >                     LEN1 =3D 0x00010000
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y08._BAS,
> > > > BAS2)  // _BAS: Base Address
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y08._LEN,
> > > > LEN2)  // _LEN: Length
> > > >                     BAS2 =3D PCRB (0x6C)
> > > >                     LEN2 =3D 0x00010000
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y09._BAS,
> > > > BAS4)  // _BAS: Base Address
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y09._LEN,
> > > > LEN4)  // _LEN: Length
> > > >                     BAS4 =3D PCRB (0x6A)
> > > >                     LEN4 =3D 0x00010000
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y0A._BAS,
> > > > BAS5)  // _BAS: Base Address
> > > >                     CreateDWordField (RBUF,
> > > > \_SB.PCI0.GPIO._Y0A._LEN,
> > > > LEN5)  // _LEN: Length
> > > >                     BAS5 =3D PCRB (0x69)
> > > >                     LEN5 =3D 0x00010000
> > > >                     Return (RBUF) /* \_SB_.PCI0.GPIO.RBUF */
> > > >                 }
> > > >
> > > >                 Method (_STA, 0, NotSerialized)  // _STA: Status
> > > >                 {
> > > >                     Return (0x0F)
> > > >                 }
> > > >             }
> > > >
> > > > Please let me know if this helps, or if you need more info.
>
> First of all, this is pre-production chip, so, I don't think there is a b=
ug in the driver (yet) discovered.
>
> Looking to the above ASL code I may conclude that is definitely is *not* =
from our reference BIOS.
> I have checked two versions of it and found that in both we have the foll=
owing mapping:
> for LP variant: there are only 4 communities are exported for H variant: =
there are only 5 communities are exported
>
> So, I guess the problem is in ASL code you provided. It simple should not=
 export that community at all.
>
> In case you need to do so, there are ways:
>  - contact Intel and ask for a change in reference BIOS
>  - acquire another ACPI ID for the case, or, perhaps use special constant=
s like
>    _HRV for that purpose (also need to contact Intel while doing that)

As Subrata clarified (Subrata & Aamir are from Intel's Coreboot team),
that is not *the* Intel reference BIOS that you are using, but it is
*an* Intel generated BIOS/Coreboot image.

Andy, can you please let us know in what order are the resources laid
out in your reference BIOS for the case when it exports 5 communities
(i.e. community-0-2, 4-5)?

Thanks,

Rajat

>
> P.S. I think EDS covers it as it present in HW, though not exported by FW=
.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
