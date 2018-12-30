Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104BFC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD35320836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546196227;
	bh=r/mtGw93pLNcIk80TUscHn5ixLW16gZUwAROr2fH6A0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u/ih3XeKVt1FCiqeJh46M9t7aUV9v483oh2FroCXglsGm9CmFCyOq0Kye9YhUmAxT
	 LPcledtMRRqDQJHL4ltlg1mYT4UNEVDAdPCon+hU66hnqfHLQRMzwAqE6xx/5s+LPN
	 1rdYZvAQSQNCNhfWflWRMsvVZkqp7wKGgdJ7lCLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeL3S5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 13:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbeL3S5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 13:57:06 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F95213F2;
        Sun, 30 Dec 2018 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546196225;
        bh=r/mtGw93pLNcIk80TUscHn5ixLW16gZUwAROr2fH6A0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gEhob2MtKKuq1Buh9V/zP3msUkGHST+V44Lvmvfmnemq+EvxyZjpW3Zof/8z95+8C
         +Y3G4/QUYIQHggnHBs5drO6+F1lCd7h5b/fKPGSRsVqAkq7ukuMpdQ3RME0TbzZp4b
         9CteEe428tc8W9YJuY/Z7G79LokCaDCO9tCVFb8M=
Received: by mail-oi1-f172.google.com with SMTP id i6so20749323oia.6;
        Sun, 30 Dec 2018 10:57:05 -0800 (PST)
X-Gm-Message-State: AA+aEWa8ElUGmpNmqLojjMOAvhXLv88OtXqFXhGtCdyKISBawn4J3KkC
        SMswmnJqduvAhn4Cm7swD4Yw30IMpyvVpPxvGC4=
X-Google-Smtp-Source: AFSGD/UA1g5qA2e0Oh2EI1pp8jEzcOfbJ/WWgeZHnIlFVN06GewiqfyQKxJM3T6LxTsPbHQMjHoavsyNZL1kd95+WNA=
X-Received: by 2002:aca:c312:: with SMTP id t18mr24023676oif.92.1546196224437;
 Sun, 30 Dec 2018 10:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
 <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Sun, 30 Dec 2018 21:56:53 +0300
X-Gmail-Original-Message-ID: <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
Message-ID: <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, faiz_abbas@ti.com,
        chunyan.zhang@unisoc.com, Jisheng.Zhang@synaptics.com,
        ludovic.barre@st.com, Arnd Bergmann <arnd@arndb.de>,
        alex.smith@imgtec.com, chris.brandt@renesas.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > Select IOSF_MBI only when PCI is set.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index e26b8145efb3..4c5f037b246d 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
> >  config MMC_SDHCI_ACPI
> >         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> >         depends on MMC_SDHCI && ACPI
>
> It should depend on PCI as well, shouldn't it?
>

I don't think so. The PCI dependency is at IOSF_MBI code so code
should select IOSF_MBI only when x86 and pci is defined as below.

This driver does not depend on PCI.

> As it stands with the patch applied, randconfig can still select it if
> PCI is unset AFAICS, can't it?

True, we also should be careful about separating ACPI from PCI.
Someone should be able to define a sdhci acpi object without PCI.

What do you think about this?

>
> > -       select IOSF_MBI if X86
> > +       select IOSF_MBI if (X86 && PCI)
> >         help
> >           This selects support for ACPI enumerated SDHCI controllers,
> >           identified by ACPI Compatibility ID PNP0D40 or specific
> > --
