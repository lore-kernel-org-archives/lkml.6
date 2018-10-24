Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B88ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D78205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D78205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeJYFGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:06:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40039 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJYFGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:06:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id r1-v6so6334702edd.7;
        Wed, 24 Oct 2018 13:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/rvii0iCV8LZe97kR0t93pWpIHHCGdJMYSNkWyGB28=;
        b=rRD4jiSpSy4dn8qK8WVVabgY+MZkyzTkwz6STazh13a5Pix2wW8+Ll5cPWrVS3Y8Ux
         ran728Yo/TK/w6FkiIz8b5yfYuzlIvegHMewXRCKFVsgFZYJsLAeZKzs4T/xfJpkxu41
         khJzJSKQMx3GhjFU2OWVs+UPbdxh56roBFFIcRkS6yuA2ipz5AB3ywRMOCs1UpOch+8f
         A2KZlJYuFpWMH5Clsxy2i70/UClaF01Ali00icDx4hIyIqpLjvjOdVHfr6JcCkXjM/Mz
         zJYGwioug/3f5VpuqQgR4I52DSEDTi5vqPJaJCpXwHXJ7ovVNXrVIwmwMq+w0Id1LXHT
         V66Q==
X-Gm-Message-State: AGRZ1gJqv9QDiRD1yfGRL1iOOqylVdkAYL6k25XEoPTG2U5CXSFMIJTr
        yutED3MV+8Ud7Ffc73MKc09fwqYuLpc=
X-Google-Smtp-Source: AJdET5cwGTjLw777OdxSx4TYRjl79mBOAlQjgnT0SQu6SdzR37AAe/lBmU4fjv+VZOeTMzfzpoViAA==
X-Received: by 2002:a17:906:6a13:: with SMTP id o19-v6mr2021354ejr.99.1540413432944;
        Wed, 24 Oct 2018 13:37:12 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id g13-v6sm1500945edp.46.2018.10.24.13.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:37:11 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id d2-v6so6983181wro.7;
        Wed, 24 Oct 2018 13:37:10 -0700 (PDT)
X-Received: by 2002:a5d:53d1:: with SMTP id a17-v6mr1207752wrw.41.1540413430140;
 Wed, 24 Oct 2018 13:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-11-jagan@amarulasolutions.com> <20181024180754.pfae27y6i7jhcdgy@flea>
In-Reply-To: <20181024180754.pfae27y6i7jhcdgy@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 24 Oct 2018 21:36:57 +0100
X-Gmail-Original-Message-ID: <CAGb2v67NeVjB7b57pmUN3rw8JsE+3CKEDXtT-91GiFvRRaU3cA@mail.gmail.com>
Message-ID: <CAGb2v67NeVjB7b57pmUN3rw8JsE+3CKEDXtT-91GiFvRRaU3cA@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: panel: Add Bananapi S070WV20-CT16
 ICN6211 MIPI-DSI to RGB bridge
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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

On Wed, Oct 24, 2018 at 7:08 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Oct 23, 2018 at 09:20:30PM +0530, Jagan Teki wrote:
> > Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge panel,
> > the same panel PCB comes with parallel RBG which is supported via
> > panel-simple driver with "bananapi,s070wv20-ct16" compatible.
> >
> > But this binding is specific for MIPI DSI to RGB bridge panels,
> > which usually accessed using MIPI DSI controller driver.
> >
> > for information:
> > - "bananapi,s070wv20-ct16" compatible for parallel RGB panels
> > - "bananapi,s070wv20-ct16-icn6211" compatible for MIPI-DSI to RGB
> > bridge panels
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Why not just reusing the same binding document?

Agreed. Just put the MIPI-DSI-specific information you added here
into the existing document.

Rob suggested that we could even use the same compatible. That would
make sense if you are modelling the entire panel + PCB as a module,
instead of a panel node + a bridge node as I originally wanted.
Don't worry, I gave it some thought and I think having a single
combined panel node makes more sense.

ChenYu
