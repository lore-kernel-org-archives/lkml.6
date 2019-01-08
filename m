Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A5AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676512087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546952625;
	bh=+cE+qR+L2VHBnI9nvdDhBuhgO/SrcnN3yWnbITObU0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ockgYvkNk4LRB0C7e0Z2zv/k6yTVTU4Pr2EMQKQhZxcYf3cG1skpuS43EQV07Kg4T
	 FxM11Z8w4u8T1xeWYQJOkQuixxhiauabw3Se0l4B6VtKPuZBYXCv0X0IJ8Cocuuwly
	 SYviAoTB2xMWFpu3/aE0fiIrQjvXjrn13OTN54Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfAHNDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:03:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfAHNDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:03:43 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19A72087E;
        Tue,  8 Jan 2019 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546952623;
        bh=+cE+qR+L2VHBnI9nvdDhBuhgO/SrcnN3yWnbITObU0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uwsb0AVyqyP5EjJEwYYhh4d3HX1Nv7OINDAfOGekB3xpObBLjH94+8x0BaEVpKvcM
         y01yJxtCmbtp4ACbCc1K+BExNvWsHbUJh1ApKSO631/Og3KO86zuoJtTz1dBA16lcP
         G9SaKBbtazGSt7Ln39q4asiQRsq1fYYIVsd91jpo=
Received: by mail-oi1-f181.google.com with SMTP id m6so3187750oig.11;
        Tue, 08 Jan 2019 05:03:42 -0800 (PST)
X-Gm-Message-State: AJcUukcBL/XY2bMNEAsmf8L/USJLWlsjfOSzrKXVsONg0V6zrCSPD7mo
        wRDmUPAAMSFXq9yHs7NVTQM1lrCEun2T39tQvhk=
X-Google-Smtp-Source: ALg8bN6rrzC+7nUcuXaVSlY0dmuFr5XyPKxEDrbQFVg9FfqepgWxEMgTtrP6lSBf6wYwdi1Xas6ZA/esCdqhWD2MdvM=
X-Received: by 2002:aca:5c4:: with SMTP id 187mr1043486oif.20.1546952622140;
 Tue, 08 Jan 2019 05:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-8-okaya@kernel.org>
 <CAJZ5v0gst1ZDgG-uP9GUUB1ziPnqhfArio3um=wCQjfbeH2_iw@mail.gmail.com> <1546948685.2072.95.camel@intel.com>
In-Reply-To: <1546948685.2072.95.camel@intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 8 Jan 2019 08:03:05 -0500
X-Gmail-Original-Message-ID: <CAK9iUCNPD_mVkN-NnuCyCpZ8n17OqfjQxBeo=gUms_SMX91scg@mail.gmail.com>
Message-ID: <CAK9iUCNPD_mVkN-NnuCyCpZ8n17OqfjQxBeo=gUms_SMX91scg@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] drivers: thermal: int3406_thermal: Make PCI
 dependency explicit
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 6:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On =E4=B8=80, 2019-01-07 at 12:19 +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
> > >
> > >
> > > After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built
> > > without
> > > CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> > > satisfied implicitly through dependencies on CONFIG_ACPI have to be
> > > specified directly. Need CONFIG_PCI to be set in order to be able
> > > to use
> > > this driver.
> > >
> > > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without
> > > CONFIG_PCI set")
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > ---
> > >  drivers/thermal/intel/int340x_thermal/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/intel/int340x_thermal/Kconfig
> > > b/drivers/thermal/intel/int340x_thermal/Kconfig
> > > index 0582bd12a239..fba1976d5f8d 100644
> > > --- a/drivers/thermal/intel/int340x_thermal/Kconfig
> > > +++ b/drivers/thermal/intel/int340x_thermal/Kconfig
> > > @@ -31,7 +31,7 @@ if INT340X_THERMAL
> > >
> > >  config INT3406_THERMAL
> > >         tristate "ACPI INT3406 display thermal driver"
> > > -       depends on ACPI_VIDEO
> > > +       depends on ACPI_VIDEO && PCI
> > >         help
> > >           The display thermal device represents the LED/LCD display
> > > panel
> > >           that may or may not include touch support. The main
> > > function of
> > > --
> > Rui, any objections here?  And for the [11/11]?
>
> CONFIG_INT3406_THERMAL depends on CONFIG_INT340X_THERMAL, so IMO, patch
> 11 is sufficient.

Yes, we can drop this patch. I found the issues in reverse order. Can
we get an ACK for 11/11?

>
> thanks,
> rui
