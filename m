Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C05ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4330C20833
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4330C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeJYEwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:52:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35733 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbeJYEwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:52:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id e2-v6so6328577edn.2;
        Wed, 24 Oct 2018 13:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wd5Mf7uCqOKe1IS7J9h5HMp+qrUaFP2+rUpZ+W81aF0=;
        b=rhzPKhyQyNnuQPS9AAnZ0/7RwDQb8327O9T8jwv2/jmvpuighziwT5NypqFMY3jUVA
         xTYGxY6AzxujlDHNu2gC4ukwlLtWY56nXKpXM2qI6Je4jN1lUGo3qGaOngzNVCf4dbgd
         3L4HmKjKJLE0RDfTcFuaAuSRkU0XryuPdwYYOxGvkRcllia8ctNsNt798ezImemPxuJI
         B8dYa6JFMkHrM15Mhg5f//U/qsmifnCTR9wThKIoGBDB35+wn0silPT2L9rD6nXySGkV
         q10qwr/kEG1IWINN0d3e3ay3F6d0rMJy2wdTzCnADXn+J3n72F8yzc+mLoRhGnNLlA+7
         xDDw==
X-Gm-Message-State: ABuFfojVrONNQ9Ym3BTvyhMRaBN+T74N7JP/gCirSQVpvkuptQmG4HhG
        LWpobI9tzkRq3hXkzcDWVqBIGMVhtyY=
X-Google-Smtp-Source: ACcGV63TjpVPPrrRXoYoe3ABIowc3eQfnheQLKpnvIjoak34IjgPUzi5+EvuFWLQlSOQj9ChVS0YXA==
X-Received: by 2002:a50:c202:: with SMTP id n2-v6mr20560338edf.162.1540412563486;
        Wed, 24 Oct 2018 13:22:43 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id w37-v6sm2187836edc.2.2018.10.24.13.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:22:43 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id b14-v6so4091194wmj.3;
        Wed, 24 Oct 2018 13:22:43 -0700 (PDT)
X-Received: by 2002:a1c:1752:: with SMTP id 79-v6mr4258899wmx.145.1540412562450;
 Wed, 24 Oct 2018 13:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-10-jagan@amarulasolutions.com> <20181015182448.GA7134@bogus>
 <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com> <CAL_JsqJPn9hhGsk62RzLc1dPQyF2_iCSau+MvY9mD_QADybgvg@mail.gmail.com>
In-Reply-To: <CAL_JsqJPn9hhGsk62RzLc1dPQyF2_iCSau+MvY9mD_QADybgvg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 24 Oct 2018 21:22:30 +0100
X-Gmail-Original-Message-ID: <CAGb2v64euJCAZvyGFL+pr+CLQfY8ypnhRAJFKZQ9xGai6RvLDQ@mail.gmail.com>
Message-ID: <CAGb2v64euJCAZvyGFL+pr+CLQfY8ypnhRAJFKZQ9xGai6RvLDQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16
 MIPI-DSI panel bindings
To:     Rob Herring <robh@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:11 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 22, 2018 at 5:22 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi Rob,
> >
> > On Mon, Oct 15, 2018 at 7:24 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Thu, 27 Sep 2018 17:18:47 +0530, Jagan Teki wrote:
> > > > Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
> > > > same panel PCB comes with parallel RBG which is supported via
> > > > panel-simple with "bananapi,s070wv20-ct16" compatible.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > >  .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > This "panel" is actually an RGB panel with a MIPI-DSI-to-RGB bridge
> > tacked on. On one particular revision of this module, one can also
> > directly use the RGB interface.
> >
> > Would it be better to model this as bridge+panel? We already have
> > a binding for the RGB version [1]. This would make it harder to
> > make a driver though, as there is no publicly available datasheet
> > for the bridge chip, so it's likely that part of the init sequence
> > would have to be hard-coded.
>
> Perhaps you can use the same compatible and detect based on the OF
> graph connection whether it is DSI or RGB interface? That would mean
> the RGB version doesn't use simple-panel driver, but that should be
> okay.

I think that would work.

> If there's other users of this bridge chip, then modeling the bridge
> separately would be better.

I doubt we'd find it. And given that there are no docs for the init
sequence, even though we could make out some parts, it will always
be a partially binary sequence tied to the compatible for the panel.

Thanks
ChenYu
