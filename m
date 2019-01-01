Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C533C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C52521783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546304868;
	bh=Apcluayxjl+DZTz5Vqg+F/vi5tDwm6eEZZMhjPwXm0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hjh1XSD4VayEoVh3E8VMzqHxe0/cKecQoTNbP2mMaVDuQFf0O+LzZfW2xmVWQoAjM
	 ujvRzxXAqgNqhC1ok+0wNK+pL2wfcRBRPkQ7FbRq6S09bVfAASJyKGfl6t9HRHftE2
	 ThZLHjgivTyvG1p1dS+cNlp3xTrrer7/HRAAsjBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfAABHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 20:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbfAABHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 20:07:46 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9470821783;
        Tue,  1 Jan 2019 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546304865;
        bh=Apcluayxjl+DZTz5Vqg+F/vi5tDwm6eEZZMhjPwXm0I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HXMDt8WUSTzLkK4wc4N+66IKoIOjMXEEw+6U1UD5Ki9K2VIg8Y0nKkFy2hoC/dOtR
         NPW7Gal6uxIAKvDbZNrJbmNmbMV0Ea0cZ+CZsGepVtV3vZ+Xb3wHQQec8wPFKZ3J9D
         m70fDcgAz4LhcNDbwDmYNE+neu2m5EkjR9QTbqgE=
Received: by mail-ot1-f49.google.com with SMTP id n8so24356123otl.6;
        Mon, 31 Dec 2018 17:07:45 -0800 (PST)
X-Gm-Message-State: AJcUukeKX0FFwxkEY5UxHnQRyvOhPcCPrQ/e4L+wwc+9HOfyhZVSJnFB
        uM9xnqXkI9q8XvFgH+jUVMeJgL9T1rmwG4VbWNU=
X-Google-Smtp-Source: ALg8bN5u5DUj5Ppxgl38heDiQ+zEST+adCgRDXNUEZFXt1GmROlTgCh8jlNNwjAmNP4rNW+Qi5Aca9G1BlTHCbls9mY=
X-Received: by 2002:a05:6830:114a:: with SMTP id x10mr4318208otq.89.1546304864884;
 Mon, 31 Dec 2018 17:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk> <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk> <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
 <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com> <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
 <765ab3a1-f1f1-3b29-aabb-0f3328abd631@linux.intel.com>
In-Reply-To: <765ab3a1-f1f1-3b29-aabb-0f3328abd631@linux.intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 1 Jan 2019 04:07:34 +0300
X-Gmail-Original-Message-ID: <CAK9iUCOJxws-gAgHT4RWxHMZKUHq-p4X9USpEO-6N_oZPht1GQ@mail.gmail.com>
Message-ID: <CAK9iUCOJxws-gAgHT4RWxHMZKUHq-p4X9USpEO-6N_oZPht1GQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 1, 2019 at 12:42 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 12/31/18 2:35 PM, Sinan Kaya wrote:
> > On Mon, Dec 31, 2018 at 11:29 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >> On 12/31/18 1:35 PM, Sinan Kaya wrote:
> >>> On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrot=
e:
> >>>> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> >>>>> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wro=
te:
> >>>>>> I don't have the cover letter or anything for this series, what's =
going
> >>>>>> on with dependencies?
> >>>>> Here is the executive summary:
> >>>>> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACP=
I
> >>>>> used to select PCI. This is no longer true.
> >>>>> You can build an ACPI system without any PCI devices.
> >>>> So there's no dependency and I can just apply this?
> >>> The plan is to apply this patchset via ACPI tree. Need an Acked-by pe=
r patch.
> >> Anytime we change the Kconfig settings for audio, we get all kinds of
> >> problems with randconfig and 0day/kbuild due to depend/select issues.
> >> I'd like to give this a spin first, can you share a link to the entire
> >> series? Thanks!
> > Sure,
> >
> > You can find them here
> >
> > https://lore.kernel.org/patchwork/patch/1028330/
> >
> > Click related.
>
> Something must be missing, I get compilation errors when PCI is not
> defined? And I see tons of references to pci stuff in drivers/acpi.
>
> drivers/acpi/reboot.c: In function =E2=80=98acpi_reboot=E2=80=99:
> drivers/acpi/reboot.c:37:10: error: implicit declaration of function
> =E2=80=98pci_find_bus=E2=80=99; did you mean =E2=80=98pci_find_next_bus=
=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>     bus0 =3D pci_find_bus(0, 0);
>            ^~~~~~~~~~~~
>            pci_find_next_bus
> drivers/acpi/reboot.c:37:8: warning: assignment makes pointer from
> integer without a cast [-Wint-conversion]
>     bus0 =3D pci_find_bus(0, 0);
>          ^
> drivers/acpi/reboot.c:45:3: error: implicit declaration of function
> =E2=80=98pci_bus_write_config_byte=E2=80=99; did you mean =E2=80=98pci_wr=
ite_config_byte=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>     pci_bus_write_config_byte(bus0, devfn,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~
>     pci_write_config_byte
>
>

Please check out this tag next-20181224 and apply the patches afterwards.
