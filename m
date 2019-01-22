Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D668C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F5021726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0TiVM6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfAVXLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:11:05 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33904 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfAVXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:11:05 -0500
Received: by mail-ua1-f66.google.com with SMTP id c24so105258uak.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUa76ueEhCQvNbKtPQb2mHmncpNfRpiFmLfNvYO5FBQ=;
        b=T0TiVM6MOIgLwJD27hPa0S3OrmIbMuJ7FpOAoWmxpUpaESq+8Yrf9TtW3WjpPI1LE2
         sESR3IVGm+GKgKe6F3dXurK4EvXhMdy2FCELGAYTJuSaLvVEhmomgxFaotO0wp/vzLOZ
         8jgXFaT59EFAC8U6KJkJGsXSj/KZlTch5jnxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUa76ueEhCQvNbKtPQb2mHmncpNfRpiFmLfNvYO5FBQ=;
        b=CIq+JvXB7F6QDVocvYt7AFUzxCah5caOYm+dUGqzP4Htm0J1VQJe4evNd8+S97kFL3
         NGXAtzePyIhrgKUvsIi3LvxcwzOKlzwbvZV/7A8qJsz9CLwGnT5c6NlurohVgnT4DlfN
         ibz2RWDdcJFGeVdMb0kDQwXYa0/rDM99IvCr9enIHiA/ecgnCyIi86w7bVLC5TFxrOku
         P3UbI/V/2Q+UixkakfT55VkEWfjBFZnM9nFygTxaAL4S02he130/amDyQgJUiqjUpMlr
         e9HwiYh/rWummBO2WeKqSTYpMYAZNCMLqrhuyKrxxBUurtZubDvSivNtxl0XssHf+uMW
         I6aw==
X-Gm-Message-State: AJcUukdh8gDgs/9I4+I6N9TMQ/oAkMh48xczHozlewOMJnIJJ6rdsTQW
        KM15+dO9EqGpOsIVqA065467UbXHyB8=
X-Google-Smtp-Source: ALg8bN6vAt3TRBRJ7vvcOxWhvhRuuYMb2YpYo4AegjTy4pr+1oTWWB5d/dMSkzL7yB4bQCO0ure4ag==
X-Received: by 2002:ab0:45d4:: with SMTP id u78mr13873266uau.52.1548198663384;
        Tue, 22 Jan 2019 15:11:03 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a6sm7875416vse.30.2019.01.22.15.11.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:11:02 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id x64so178872vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:11:02 -0800 (PST)
X-Received: by 2002:a67:dd94:: with SMTP id i20mr15781200vsk.111.1548198661895;
 Tue, 22 Jan 2019 15:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-2-bjorn.andersson@linaro.org> <154818353130.20280.17905705223316470797@swboyd.mtv.corp.google.com>
 <20190122192404.GB31919@minitux>
In-Reply-To: <20190122192404.GB31919@minitux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 15:10:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UgQtPZj-EWCzqGqgAbfijjd+j7kO8XsXttJKfejEzBzg@mail.gmail.com>
Message-ID: <CAD=FV=UgQtPZj-EWCzqGqgAbfijjd+j7kO8XsXttJKfejEzBzg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region
 memory map
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2019 at 11:24 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 22 Jan 10:58 PST 2019, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2019-01-21 21:51:03)
> > > @@ -103,10 +138,30 @@
> > >                         no-map;
> > >                 };
> > >
> > > +               venus_mem: memory@95800000 {
> > > +                       reg = <0 0x95800000 0 0x500000>;
> > > +                       no-map;
> > > +               };
> > > +
> > > +               cdsp_mem: memory@95d00000 {
> > > +                       reg = <0 0x95d00000 0 0x800000>;
> > > +                       no-map;
> > > +               };
> > > +
> > >                 mba_region: memory@96500000 {
> > >                         reg = <0 0x96500000 0 0x200000>;
> > >                         no-map;
> > >                 };
> > > +
> > > +               slpi_mem: memory@96700000 {
> > > +                       reg = <0 0x96700000 0 0x1400000>;
> > > +                       no-map;
> > > +               };
> > > +
> > > +               spss_mem: memory@97b00000 {
> > > +                       reg = <0 0x97b00000 0 0x100000>;
> > > +                       no-map;
> > > +               };
> > >         };
> > >
> >
> > What's the plan if certain configurations don't use all these carveouts?
> > Can we mark the reservation nodes as status = "disabled", or the reverse
> > and mark them as status = "ok" in all boards, and then reclaim the
> > memory for peripherals we don't care to use?
> >
>
> The code path that picks these up does look for "status", so I suggest
> that we leave them all enabled in the platform dtsi and then let the
> device's reclaim them as needed.

Does that mean we should add labels for all of the sub-nodes so that
boards can easily mark them "disabled"?

-Doug
