Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E7CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BF02173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546874006;
	bh=Qpdkhe6ezOVGwh6c0sjT9W2JB++Qc3RlkMqeaRoedYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G5eekfzb7j+jOj5hZNvJysiFzZeLf0tRwtm+FHRhCCOIX6NocR9/MF/JlDfqQm1Nt
	 DCdidKSKYqLE2tOx3MwzXuJlKr4XRYH+7IsQGQiHMJQdGkHMHvRmVgOtuZMhEjBkUq
	 2XqHqThHAZvWZ+VXMIdWGZNeB2qsXaDZ+yn+r+qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfAGPNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfAGPNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:13:24 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A901B2173C;
        Mon,  7 Jan 2019 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546874002;
        bh=Qpdkhe6ezOVGwh6c0sjT9W2JB++Qc3RlkMqeaRoedYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cMzlT0cPKK74vbyC2HgKvsb4BtysxgNM8MTbFBlFHzsrA7+s963ejFeOJ0jGZ/VMX
         6td49NDtNpuayQvTCNSslNN1LUY/HcX+Rk69M5TP0uM/6ZLFnsHYhVdES/s/MTxbAp
         WKhFLxSzTuel23WRsaGE0mzmmrfHwi1ySRigG7qg=
Received: by mail-oi1-f179.google.com with SMTP id v6so578992oif.2;
        Mon, 07 Jan 2019 07:13:22 -0800 (PST)
X-Gm-Message-State: AJcUukeVO51PbD2C/QWCD2kYKckAufxyx0Sihc1qbIyNOLO7a6b6dSqb
        BLzlZFpwCSDaYQ2aAC/Qf71ZSI8aC5GQSZmBgto=
X-Google-Smtp-Source: ALg8bN6x1J2kPCNfCwPnUy+JJ+tOpxFnpFztPqANj+lI0yM+w7mMGoNLTZQ15hDtqKghFQuapvzfeMB3YQwa4GyqwIU=
X-Received: by 2002:aca:5e09:: with SMTP id s9mr24384540oib.153.1546874001892;
 Mon, 07 Jan 2019 07:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Mon, 7 Jan 2019 10:13:10 -0500
X-Gmail-Original-Message-ID: <CAK9iUCPXK+-M8C7XvpSwNAPEV5RGv0gAya7rYDWhbNcsDVruzg@mail.gmail.com>
Message-ID: <CAK9iUCPXK+-M8C7XvpSwNAPEV5RGv0gAya7rYDWhbNcsDVruzg@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 6:15 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
> >
> > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> > on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> > IOSF_MBI driver.
> >
> > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
> Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?
>

Yes, there was an ack assuming that I fixed the ia64 kconfig. Since I
didn't, I took it back.
Later ia64 failure was fixed by another patchset and Pierre-Louis said
"looks good to me". I didn't
assume it was an ack unless explicitly stated.

It might be good if Pierre-Louis acked this version instead.

> > ---
> >  sound/soc/intel/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> > index 99a62ba409df..bd9fd2035c55 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> >  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
> >         tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> >         default ACPI
> > -       depends on X86 && ACPI
> > +       depends on X86 && ACPI && PCI
> >         select SND_SST_IPC_ACPI
> >         select SND_SST_ATOM_HIFI2_PLATFORM
> >         select SND_SOC_ACPI_INTEL_MATCH
> > --
>
> Mark, assuming that the ACK above was given here, do you want me to
> take this patch or do you want to take care of it yourself?
