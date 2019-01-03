Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B96C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B11218D8
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546527476;
	bh=Jy2kk+KR/izJhtknSYLrbNcbL9ZenmX0YWBxllOcO48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q7mr1PjTv+HoBwTCxkqU/sq2ZHMcdZNGy/CY7Gg4nNcHs262VeQ8bEkKv3rhuVqOG
	 hoX+HA0n7quwRn+7iEh6pydhUAR4d8NviGjMKDXQxWGSds4wJI90KH9iqP8hurAbfi
	 6p8oi35fQMQ+nJLR098kn9lBpnU92OoN+kIIUo6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfACO5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbfACO5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:57:54 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E956F217F5;
        Thu,  3 Jan 2019 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546527473;
        bh=Jy2kk+KR/izJhtknSYLrbNcbL9ZenmX0YWBxllOcO48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nNotkKgXyrQWUIFJzKVOta9GCK6xWe5WzmnuPNkm+Semsu67TBuhizIcSOkWor1Er
         iRsHtOtaKkriu94hWZIjCYTWc9/IoBvqFb3S6pq6cgrrIQnXCTrriaF7+fXeVKNLb9
         RCue4LL7xwB7XlveDCTugbjyKQhCnfyIJ4H69Zhg=
Received: by mail-oi1-f176.google.com with SMTP id a77so27862316oii.5;
        Thu, 03 Jan 2019 06:57:52 -0800 (PST)
X-Gm-Message-State: AA+aEWaC7Q1PBuSeysflm1rLJYTa2q++m1zjvst0j33tF0a9NPBhw+dP
        Xer71pR5zm0mW3trQwwqi7gGGH0tgbUq/OE8g5g=
X-Google-Smtp-Source: ALg8bN4HPnfpK9W4KuowF70soIb3zF26wHscuJeEwC5Kp8u+eRaLjBmNCdHcT9XZjPTT9YtiC7owMMzQM+DV7p0JE4E=
X-Received: by 2002:aca:3403:: with SMTP id b3mr30859034oia.242.1546527472178;
 Thu, 03 Jan 2019 06:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-10-okaya@kernel.org>
 <b52d51a4-3310-7873-db3d-bf5d0dffb7f8@intel.com>
In-Reply-To: <b52d51a4-3310-7873-db3d-bf5d0dffb7f8@intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Thu, 3 Jan 2019 14:57:40 +0000
X-Gmail-Original-Message-ID: <CAK9iUCOSP+UMW0q0jW_SBgF-5sE-YtYEOaVwON6ndwHeOM7VBQ@mail.gmail.com>
Message-ID: <CAK9iUCOSP+UMW0q0jW_SBgF-5sE-YtYEOaVwON6ndwHeOM7VBQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 2:50 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 2/01/19 8:10 PM, Sinan Kaya wrote:
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
> > on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>
> This driver does not rely on IOSF_MBI
>

X86 version does.

select IOSF_MBI if X86


> You wrote on the other email QCOM doesn't use PCI but here you are making
> them depend on it.  Please explain.
>

I matched the behavior before my change. This code wouldn't be
available without PCI and ACPI on previous kernel versions and left
kconfig cleanup as another exercise for some other day.

> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index e26b8145efb3..1b9401fe94c0 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -116,7 +116,7 @@ config MMC_RICOH_MMC
> >
> >  config MMC_SDHCI_ACPI
> >       tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> > -     depends on MMC_SDHCI && ACPI
> > +     depends on MMC_SDHCI && ACPI && PCI
> >       select IOSF_MBI if X86
> >       help
> >         This selects support for ACPI enumerated SDHCI controllers,
> >
>
