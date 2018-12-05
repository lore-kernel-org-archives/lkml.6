Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F183C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEB72082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJaPVBJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEB72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeLEJHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:07:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54396 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEJHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:07:49 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so20111205ita.4;
        Wed, 05 Dec 2018 01:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6glfVN2t2j7IWFh8jUfuduLOedDexDWKvkTtX6vX7uA=;
        b=OJaPVBJw7bRk1NOKEOj+xdeIHPnxq7ge+mAUGNBRKq+DUkRwBNzLtkFDek9EIp7hMX
         jARlaIazphu5n2M7mYX4/kZ/tDC07VaneXvAN59R0WiEt1csaOvcJciQTLiB9ImXB+3P
         HcPl/zA8dtDs+2F438BlPXFkGGlKp7U8SQz0FQsSH5A3X53eZuKao536XmKqjUJDSIHa
         LjGp59u3fWaDBMjy7or8OAX4WQWwAWZPjjOJnvFMXFpx+x0yM0oabOzsCgLDXH4yrTAG
         vVeKNr/BEVrRanDhPcOpc6G4m6k04OEA9T6KIde/puRWoEJA7STWqClEabWo9GI5OKr0
         19Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6glfVN2t2j7IWFh8jUfuduLOedDexDWKvkTtX6vX7uA=;
        b=d9RjvcK7DSioUqZNawTaiIkaGqJmPbgoYWM6+YlSPbnsheVnN5mtenPGchNkAdRWNR
         cdx43xrbzcteAUAaHd7F1OSnCIeFW6Bda9BQQUiWczFH7ofdgdfHpHkRoxbLS/qOkPrY
         ofo9BwGT8e1eTs+aImzYU+ipF4j7K4gH1hZqkqxToUFxaMcbLW92Z/110cQWuo5YuH2A
         9KiFaJHZv8+hNi2A+50Ttw5jUopKkQOf1v9Gj8OVJq7zWi2tuZFu8YCqXdtbrtVvzzs4
         wmRRuqD6aqD0ZtfBmI3hpWR1fFSfg1BNY7DLmJDsaRupUlJrVVcFuf8k0bHsi/XNDYlO
         guKg==
X-Gm-Message-State: AA+aEWYVZWPFl0wsJERQ5ZMzaGBgv5B5WBaajJXvwl4Efdwz4n3mrHlk
        MVoiJRGPK3SdrCG7NCSz1L0iHqRedayV88E5bjE=
X-Google-Smtp-Source: AFSGD/Wv6zVyRfkmpWD/yXo6N1LfSXwbHh9Pij4A1Dovb5KXdHtHCyJ9ThWYR4q9FNe57yWOOxFSfKif6sJNGqhTa/Q=
X-Received: by 2002:a24:fe41:: with SMTP id w62mr15352437ith.23.1544000868178;
 Wed, 05 Dec 2018 01:07:48 -0800 (PST)
MIME-Version: 1.0
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
 <1542535751-16079-5-git-send-email-pawell@cadence.com> <CAL411-rWbQ6yj1r_aaLP8UagVRJhsn7xdznQwXS9enkxXTs2LA@mail.gmail.com>
 <BYAPR07MB4709A8E4B0B0CC05A842B708DDAD0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <CAL411-rzhH+y-b0-xze4-WmeVtey4bXt4Jc6TWYyfw6E8x-5Eg@mail.gmail.com>
 <BYAPR07MB47090A16A7A8A85C6C3FD46ADDA80@BYAPR07MB4709.namprd07.prod.outlook.com>
 <MWHPR07MB3502A7A07AD114D6343BD6C0D8A80@MWHPR07MB3502.namprd07.prod.outlook.com>
In-Reply-To: <MWHPR07MB3502A7A07AD114D6343BD6C0D8A80@MWHPR07MB3502.namprd07.prod.outlook.com>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Wed, 5 Dec 2018 17:07:37 +0800
Message-ID: <CAL411-p+ShK7+T+QkebGit7LaUtgnrCs1_Uy04KrKvwUDfh3oQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/15] usb:cdns3: Driver initialization code.
To:     adouglas@cadence.com
Cc:     pawell@cadence.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, rogerq@ti.com,
        lkml <linux-kernel@vger.kernel.org>, jbergsagel@ti.com,
        nsekhar@ti.com, nm@ti.com, sureshp@cadence.com, peter.chen@nxp.com,
        pjez@cadence.com, kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 4:55 PM Alan Douglas <adouglas@cadence.com> wrote:
>
> Hi Peter,
>
> On 05 December 2018 07:20, Pawel Laszczak wrote:
> > Hi,
> >
> > >> >>
> > >> >> Patch adds core.c and core.h file that implements initialization
> > >> >> of platform driver and adds function responsible for selecting,
> > >> >> switching and running appropriate Device/Host mode.
> > >> >>
> > >> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > >> >> ---
> > >> >>  drivers/usb/cdns3/Makefile |   2 +
> > >> >>  drivers/usb/cdns3/core.c   | 413 +++++++++++++++++++++++++++++++++++++
> > >> >>  drivers/usb/cdns3/core.h   | 100 +++++++++
> > >> >>  3 files changed, 515 insertions(+)
> > >> >>  create mode 100644 drivers/usb/cdns3/core.c
> > >> >>  create mode 100644 drivers/usb/cdns3/core.h
> > >> >>
> > >> >> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> > >> >> index dcdd62003c6a..02d25b23c5d3 100644
> > >> >> --- a/drivers/usb/cdns3/Makefile
> > >> >> +++ b/drivers/usb/cdns3/Makefile
> > >> >> @@ -1,3 +1,5 @@
> > >> >> +obj-$(CONFIG_USB_CDNS3)                        += cdns3.o
> > >> >>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)       += cdns3-pci.o
> > >> >>
> > >> >> +cdns3-y                                        := core.o
> > >> >>  cdns3-pci-y                            := cdns3-pci-wrap.o
> > >> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > >> >> new file mode 100644
> > >> >> index 000000000000..f9055d4da67f
> > >> >> --- /dev/null
> > >> >> +++ b/drivers/usb/cdns3/core.c
> > >> >> @@ -0,0 +1,413 @@
> > >> >> +// SPDX-License-Identifier: GPL-2.0
> > >> >> +/*
> > >> >> + * Cadence USBSS DRD Driver.
> > >> >> + *
> > >> >> + * Copyright (C) 2018 Cadence.
> > >> >> + *
> > >> >
> > >> >Please add NXP copyright too.
> > >>
> > >> Ok, I don't know why I omitted this.
> > >> I know that you are the main author of this file
> > >> Sorry for that.
> > >>
> > >> One additional question. What year I should add in Copyright for NXP?.
> > >> The original year 2017 or I should modified all to 2018.
> > >>
> > >Please use below copyright, thanks.
> > >
> > >Copyright 2017-2018 NXP
> >
> > I add this in all files  modified or created by you.
> > >
> > >
> > >
> > >> >> +       mutex_init(&cdns->mutex);
> > >> >> +
> > >> >> +       cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
> > >> >> +       if (IS_ERR(cdns->phy)) {
> > >> >> +               dev_info(dev, "no generic phy found\n");
> > >> >> +               cdns->phy = NULL;
> > >> >> +               /*
> > >> >> +                * fall through here!
> > >> >> +                * if no generic phy found, phy init
> > >> >> +                * should be done under boot!
> > >> >> +                */
> > >> >
> > >> >If the phy driver is defer-probed, it will be here, it is not an error.
> > >> >I think you could have a generic phy driver or usb generic phy driver
> > >> >(drivers/usb/phy/phy-generic.c) even you don't need any operations for
> > >> >PHY. It will be easy for other platforms.
> > >>
> > >> Yes, Roger ask me to modify this fragment. In next version it will look like:
> > >>         cdns->phy = devm_phy_get(dev, "cdns3,usbphy");
> > >>         if (IS_ERR(cdns->phy)) {
> > >>                 ret = PTR_ERR(cdns->phy);
> > >>                 if (ret == -ENOSYS || ret == -ENODEV) {
> > >>                         cdns->phy = NULL;
> > >>                 } else if (ret == -EPROBE_DEFER) {
> > >>                         return ret;
> > >>                 } else {
> > >>                         dev_err(dev, "no phy found\n");
> > >>                         goto err0;
> > >>                 }
> > >>         }
> > >>
> > >>         phy_init(cdns->phy);
> > >>
> > >> We are going to use phy driver. I don't know if it correct.
> > >> I don't have experience in this filed.
> > >> We need phy initialization but I don't have testing platform now.
> > >> In most usb drivers I see that there are used usb phy driverd instead phy dirverd.
> > >>
> > >
> > >At my CDNS3 platform, there are some USB PHY initialization for register setting
> > >and clock enable. You could add generic PHY driver under: drivers/phy/cadence/.
> > >
> > >Above PHY initialization code is OK for me.
> >
> > It will be added as separate driver.
> > I think that Allan Douglas working on it.
> > I ask him to add you to -cc in patch for phy.
> Patch series for the cadence Sierra generic PHY driver can be found here:
> https://lore.kernel.org/patchwork/cover/1011486/
>
> It can also be found in Kishon's linux-phy git tree at
>     git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
> in the 'next' branch.
>
> It will be great if you are able to take a look at it.

I will test it, and submit some changes if needed, thanks.

Peter
