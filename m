Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A0BECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4502082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aj21Fxn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4502082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeJ2VXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:23:18 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38840 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeJ2VXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:23:18 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so9155164ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qzh+nc/WJFA19Mi6CEL9oUj+Ckly36XHhrfGvrAh4eE=;
        b=aj21Fxn4V+hXQ8PQ0ZPE/Uy3sAMCcSU5+kxUm6Oi/CCEUSkqfHNONe8ulHyHeNCI7K
         HVQC8CcZUKBOCmT2bPROiI9mFLAPcaiWUz9QOQV19YnWH6pY9FVUwvgca0gI7KJiF2l7
         L0XYmZ9J+1WtnOdgOBYFZlNNX+i5rQnzB87bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qzh+nc/WJFA19Mi6CEL9oUj+Ckly36XHhrfGvrAh4eE=;
        b=WqPUM6zv3oVoJtMqhMXalg9PnI34m1MCUG2gTSfJ4VMektxPBbuLpg92jz9cfWarHu
         AMlUkNG9ggXd8gzPA58H/Izs3MJwm4LZERkblQyPYVIjWxaTsMOB3Wg47advW6ywvNdu
         cLTN8ScyX9xGFa5ZVgh7sxN+POCZpxOIyS45asjKeg0wlK7NrNd2ZFbfLIiZ9qu8r6tP
         9PMbsHdcoxMDsGWTNNpb3lAoKwp+OlUmIBuFFU9yeMEmgr6Zy8Xpr4vOakeCcgRKybGN
         4ZaIPTW1jtDUoInw/qCYujAfFHJI5NpAOZ6hROdMUMIr1EFtNcLL3MFcIUpVQwVBSEMg
         rwXg==
X-Gm-Message-State: AGRZ1gKFwGAOFe4HedH3Za5ew3orPOOb4QUP0ZIKik9is5k83XtAI7Lg
        pxXRGPMdsUHBTksytnEabaZFvz3pmwtO3n6y2x6P2A==
X-Google-Smtp-Source: AJdET5dCOhS6cd+Ao2bZOA839hqMOf9obbW8R6QyqvPDzQOR+gazdoHJ8sUmKxr0bC9/R7YotPOFarDpRqufFN0UNMA=
X-Received: by 2002:a24:9f82:: with SMTP id c124-v6mr7880466ite.32.1540816487515;
 Mon, 29 Oct 2018 05:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181026144344.27778-1-jagan@amarulasolutions.com> <20181029091508.gyhn2m5fnbucvb34@flea>
In-Reply-To: <20181029091508.gyhn2m5fnbucvb34@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 29 Oct 2018 18:04:35 +0530
Message-ID: <CAMty3ZAvv58MF1itMOq+x7x4KgVQTOssHgpCkXb8n0u+vxbHdQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] drm/sun4i: Allwinner A64 MIPI-DSI support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
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

On Mon, Oct 29, 2018 at 2:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 26, 2018 at 08:13:19PM +0530, Jagan Teki wrote:
> > This series fixed the issues related to work DSI on 2-lane panel
> > which is reported on previous version[1].
> >
> > Few comments from previous version still in discussion, but I just
> > send this version just to group all working changes together.
> > anyway I will fix in this in next version if any.
> >
> > PLL_MIPI min rate is still weird, I tried many possible dclock rate
> > from panel driver to satisfy manual suggested min rate 500MHz but
> > none working so eventually moved 300MHz. any inputs on this area
> > are welcome.
> >
> > All these changes are tested in 2-lane, 4-lane MIPI-DSI panels.
> >
> > If anyone wants to test, use this repo [2] with WIP-A64-DSI branch.
>
> A changelog would be nice here, and usually you shouldn't send a new
> version while there is ongoing discussion on the previous version.

True, I have few patches that fixes 2-lane device, I just grouped all
of these working-set together for further communication. mentioned the
same thing above.
