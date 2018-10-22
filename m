Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B994C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF45B2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF45B2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeJVSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:40:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34527 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbeJVSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:40:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id w19-v6so37370747eds.1;
        Mon, 22 Oct 2018 03:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmEUl2c/TvYC2x3YNqUgBuBpwv+sQVLuRIaJ7lLrym0=;
        b=XOd/sZyQ8gHWkhNhnnbH+L37lfdR7RI7joPbjIEp67GAVuysqM513ags/YWgXN9e42
         sp390MJ62iAo74+VUGXrv73IVimf9CbTKQRoloX6+5axwXZv/ggyoePOJxQr5WXFHxne
         n+SZZ4Vnx4Ll5hVfzmr7KTmSSUBleqadDyoTqo7PJ+J1VbixWeT6bn8FrQ4+m6oM2Z9R
         TQ+H1ddNt0+vqBEl35xNOVbKhpKNyUdjM9sFSe8DprcF6u4lEIOREg2uOoJnPTNhHzSp
         IFm0mDSl2KtofhQL6/YBkxasvyh0T9vPuLydk86bWYLzgKuTHVwqK83bdaCm1VC3iWar
         3tHg==
X-Gm-Message-State: ABuFfohYmEe0lTEJqHCA7C/XyFNZ7t5GyKClHNjnZjbFs0HBzJWyOhJI
        wG7kCgybLAgaBd9YhjkJpgMEa987HwA=
X-Google-Smtp-Source: ACcGV62zNLCJcPtG4pFnPGeqhmfzdU/IckC54BjJX9ASjjRj6SSqo8ShRqgOJCYO/Bg0Txqytplfnw==
X-Received: by 2002:a17:906:b30d:: with SMTP id n13-v6mr35941639ejz.34.1540203760348;
        Mon, 22 Oct 2018 03:22:40 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id h15-v6sm14526956edk.62.2018.10.22.03.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 03:22:40 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id y144-v6so9709462wmd.4;
        Mon, 22 Oct 2018 03:22:39 -0700 (PDT)
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr15352048wmb.151.1540203759292;
 Mon, 22 Oct 2018 03:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-10-jagan@amarulasolutions.com> <20181015182448.GA7134@bogus>
In-Reply-To: <20181015182448.GA7134@bogus>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 22 Oct 2018 11:22:26 +0100
X-Gmail-Original-Message-ID: <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com>
Message-ID: <CAGb2v64QEhy1J05L9W0_uWhmrky8wD+vg3v5wA7Yd3_U-DdpKg@mail.gmail.com>
Subject: Re: [PATCH 09/12] dt-bindings: panel: Add Bananapi S070WV20-CT16
 MIPI-DSI panel bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
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

Hi Rob,

On Mon, Oct 15, 2018 at 7:24 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 27 Sep 2018 17:18:47 +0530, Jagan Teki wrote:
> > Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel, the
> > same panel PCB comes with parallel RBG which is supported via
> > panel-simple with "bananapi,s070wv20-ct16" compatible.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../panel/bananapi,s070wv20-ct16-dsi.txt      | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-dsi.txt
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

This "panel" is actually an RGB panel with a MIPI-DSI-to-RGB bridge
tacked on. On one particular revision of this module, one can also
directly use the RGB interface.

Would it be better to model this as bridge+panel? We already have
a binding for the RGB version [1]. This would make it harder to
make a driver though, as there is no publicly available datasheet
for the bridge chip, so it's likely that part of the init sequence
would have to be hard-coded.

Thanks
ChenYu

[1] Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
