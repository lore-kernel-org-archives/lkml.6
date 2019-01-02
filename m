Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969A6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE34218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546438544;
	bh=vHKW7dKsiO6fE1IxcZtzx9Hdgc8p8ihT2hm4/XbZGJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OfFu2YK7tvR1hYVVcmHaXI49VVVyGOwCz2dIspGyr7/xLhfMRIARuwZtxJunAuq4P
	 Ny4X1G3IIvG256kRTCSCYFw4ahv10rmUQTEe6XvCpvlEcAqe7rY60VAXoF4gldSyBY
	 Hd0Wd1Pearbb7Y2DW+kDnHmPSLb1T9mJzsuuKTP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfABOPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfABOPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:15:43 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10A2218E2;
        Wed,  2 Jan 2019 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546438541;
        bh=vHKW7dKsiO6fE1IxcZtzx9Hdgc8p8ihT2hm4/XbZGJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xUKt9P/zv8xXGhkh3WR6EhH56cX+0v1Qvj0/BfWD1a7w5z70z0Yq9VUtviiaA3vNf
         MHwCB6SPMWV0xrFwNT6pQbmqHbGyiztiI8Aqfc/5KTWRyE2FxLD6P6C/1DberB66oN
         c6PSyr8pFvE/pmIMmgSQMKOjTZictOTSqyQstV10=
Received: by mail-oi1-f173.google.com with SMTP id t204so25149160oie.7;
        Wed, 02 Jan 2019 06:15:41 -0800 (PST)
X-Gm-Message-State: AJcUukcNk2L898Eehs8eJrjLiXuPGzoyYGZGOBWEQDjFTaY1g39ln8p9
        9lSK2oT6uxLAD5QeWJPh+YQFzNnGDJ8dQjTFzqk=
X-Google-Smtp-Source: ALg8bN40o1BqSZLuE/173mD0xn00p30bx6oRGQ+deRiin83nChVPLTQMqqpkhuDW82bbQMZOv4frybvjlSIxds09mUY=
X-Received: by 2002:aca:5e09:: with SMTP id s9mr13041290oib.153.1546438540985;
 Wed, 02 Jan 2019 06:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
 <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
 <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
 <CAJZ5v0hw_=Odpok=6qWVWAfJ0wG7Z8NjwzMCpaFgxYnEAreKcg@mail.gmail.com> <21e732e8-84e4-72f9-4142-8e6af54f1346@intel.com>
In-Reply-To: <21e732e8-84e4-72f9-4142-8e6af54f1346@intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Wed, 2 Jan 2019 14:15:29 +0000
X-Gmail-Original-Message-ID: <CAK9iUCOce2x9NPGs9aryU8eqdWroPdjM0SP6LohhDjsCmdERAA@mail.gmail.com>
Message-ID: <CAK9iUCOce2x9NPGs9aryU8eqdWroPdjM0SP6LohhDjsCmdERAA@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Wed, Jan 2, 2019 at 2:04 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 31/12/18 11:40 AM, Rafael J. Wysocki wrote:
> > On Sun, Dec 30, 2018 at 7:57 PM Sinan Kaya <Okaya@kernel.org> wrote:
> >>
> >> On Wed, Dec 26, 2018 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>
> >>> On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
> >>>>
> >>>> Select IOSF_MBI only when PCI is set.
> >>>>
> >>>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> >>>> ---
> >>>>  drivers/mmc/host/Kconfig | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >>>> index e26b8145efb3..4c5f037b246d 100644
> >>>> --- a/drivers/mmc/host/Kconfig
> >>>> +++ b/drivers/mmc/host/Kconfig
> >>>> @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
> >>>>  config MMC_SDHCI_ACPI
> >>>>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> >>>>         depends on MMC_SDHCI && ACPI
> >>>
> >>> It should depend on PCI as well, shouldn't it?
> >>>
> >>
> >> I don't think so. The PCI dependency is at IOSF_MBI code so code
> >> should select IOSF_MBI only when x86 and pci is defined as below.
> >>
> >> This driver does not depend on PCI.
> >
> > Are you sure?
> >
> > Do you know any systems in which to use it without PCI?
> >
>
> Qualcomm use it and I don't know if those systems have PCI.
> AMD use it but probably also have PCI.  And yes Intel systems (just BYT and
> CHT IIRC) that use this driver will always have PCI.

QCOM doesn't use PCI for SDHC.
