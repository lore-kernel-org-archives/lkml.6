Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40D0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24772133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546249246;
	bh=903ZCcxDva9GucZkJLIEp0YDBSLawEJ5xBwiXRMhjlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QTxPxlxVR7sybMcsFeMTmIeMQENMBDX11/Y6CJTbAQDGkQK/hiiT9+LNXO0J+9/9o
	 s2Bc6Lz69WTKUdbl+k6vWC19i2BaGwlZuO97Ua4zI6+0VNlXhpjGxihQIXPorD1ESj
	 6byY/GH0EqyHWZbz8z3pV5Vv0Efa1GKbMXRqggIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLaJkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:40:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46929 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeLaJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 04:40:35 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so23083023otm.13;
        Mon, 31 Dec 2018 01:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nq24lDkKraTY4bjIdAGLlfBWIjQkT6w30f+DfzP/XcE=;
        b=nePMBsTPIdX14mSUMEObiZ/85fuA7dPLh4wfTp0EvRTIO5WyALaKwASC0SQ5+Bacu0
         Hrcq/FPAsfgPTjNePmVF+QpmpQQj+teMKw4WT8TAihoE2n23eXdwZAMZbVKFhEsQApA+
         iGEh99UE8ZJ6ozbHxnA5AYLSARGyzJPub99ZYEQtvSecIJYrXNlyvyVLH3I7zn3GUsXO
         TeZ4BRWumVgTTQBVo+MT/5ubpXb5sDM8o+HskQXu3q+/NXtVFuZOOXHsTNe4tAt+2h+C
         gBjR6WVMA//QvZZ7AZmWG+GQTNfKPS4lw8KMpxqsfNEi22l4J526MsOGWw+8TCqCBnt+
         bVmA==
X-Gm-Message-State: AJcUukcEs4nHzQE1fhikEWSRChzpDaUQqz/ZXbI4YAdTyENQ/nY1Epe9
        tFVmqTK7GoZ8DSfTJg3e9XpMZ5Y8OoGXr3THkX4=
X-Google-Smtp-Source: ALg8bN5b+vq8a0jLYV5Zk394aY3Sl987a6RZyYxFS0H+1cqefMM874MrLFVnf8fMJQ5R9/O2AbpQZAGeSl1+ytm8e+E=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr24110349otq.119.1546249233232;
 Mon, 31 Dec 2018 01:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
 <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com> <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
In-Reply-To: <CAK9iUCPqqyK7KMvchM4jY_FBgujnQm019J27TpDJjXUXvu5sjQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 31 Dec 2018 10:40:15 +0100
Message-ID: <CAJZ5v0hw_=Odpok=6qWVWAfJ0wG7Z8NjwzMCpaFgxYnEAreKcg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
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

On Sun, Dec 30, 2018 at 7:57 PM Sinan Kaya <Okaya@kernel.org> wrote:
>
> On Wed, Dec 26, 2018 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
> > >
> > > Select IOSF_MBI only when PCI is set.
> > >
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > ---
> > >  drivers/mmc/host/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > > index e26b8145efb3..4c5f037b246d 100644
> > > --- a/drivers/mmc/host/Kconfig
> > > +++ b/drivers/mmc/host/Kconfig
> > > @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
> > >  config MMC_SDHCI_ACPI
> > >         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> > >         depends on MMC_SDHCI && ACPI
> >
> > It should depend on PCI as well, shouldn't it?
> >
>
> I don't think so. The PCI dependency is at IOSF_MBI code so code
> should select IOSF_MBI only when x86 and pci is defined as below.
>
> This driver does not depend on PCI.

Are you sure?

Do you know any systems in which to use it without PCI?
