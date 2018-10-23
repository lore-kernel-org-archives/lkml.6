Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A675AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD572080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSs8SzGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD572080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeJWXfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWXfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:35:15 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C33A2080A;
        Tue, 23 Oct 2018 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540307485;
        bh=5THInnF/+UZEyhuPPwIWwpxnHX1plRKirGdIobQf960=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DSs8SzGudxaybBQT86mQc+Xp8cntO2w4z2hBxcMvAJFXBjmXBXUWumUwD5e+Fby+1
         y3NjwbyEr+zEOL9pErMtpD580+fY66K29N1PnnF0wyusRMNFaCib2pr9xeqexp/mlM
         veLFW2v1Q+kbmRpZbooZ0xawLZSzFtBveMWFXMlA=
Received: by mail-qt1-f182.google.com with SMTP id c16-v6so1843184qtj.13;
        Tue, 23 Oct 2018 08:11:25 -0700 (PDT)
X-Gm-Message-State: ABuFfohHYzZnN0TFjX6RsbT46ddJvO5UYdSGOK+/yqcxs53dtWMIJLWD
        FWF7iyvZ3MBYVkLv4yzcKfIE4vhM7qncpkhb4A==
X-Google-Smtp-Source: ACcGV60fXzjwz8jOpRW1aeTNgtb1V2P1rT/mzWLwUAcKjveHlJEMyVqFt4GGUzYLFKqDUoyksLvA4+E6jiT6ncaoLok=
X-Received: by 2002:a0c:ade7:: with SMTP id x36mr34383109qvc.218.1540307479607;
 Tue, 23 Oct 2018 08:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-10-jagan@amarulasolutions.com> <20181015182448.GA7134@bogus>
 <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com>
In-Reply-To: <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 23 Oct 2018 10:11:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJPn9hhGsk62RzLc1dPQyF2_iCSau+MvY9mD_QADybgvg@mail.gmail.com>
Message-ID: <CAL_JsqJPn9hhGsk62RzLc1dPQyF2_iCSau+MvY9mD_QADybgvg@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16
 MIPI-DSI panel bindings
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 5:22 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi Rob,
>
> On Mon, Oct 15, 2018 at 7:24 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, 27 Sep 2018 17:18:47 +0530, Jagan Teki wrote:
> > > Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
> > > same panel PCB comes with parallel RBG which is supported via
> > > panel-simple with "bananapi,s070wv20-ct16" compatible.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
> > >
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> This "panel" is actually an RGB panel with a MIPI-DSI-to-RGB bridge
> tacked on. On one particular revision of this module, one can also
> directly use the RGB interface.
>
> Would it be better to model this as bridge+panel? We already have
> a binding for the RGB version [1]. This would make it harder to
> make a driver though, as there is no publicly available datasheet
> for the bridge chip, so it's likely that part of the init sequence
> would have to be hard-coded.

Perhaps you can use the same compatible and detect based on the OF
graph connection whether it is DSI or RGB interface? That would mean
the RGB version doesn't use simple-panel driver, but that should be
okay.

If there's other users of this bridge chip, then modeling the bridge
separately would be better.

Rob
