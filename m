Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A9AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ACB21990
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F4r9MlPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ACB21990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754640AbeGCIJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:09:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39337 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeGCIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:09:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so1210746wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RrtC/gmxAAgsSbzgsRsXolaAMkqQurGCbeiw5KffbU=;
        b=F4r9MlPspgbW9QqccecbK4KaLhXPM4uUpH6YXAxdW2U36lvDubFM+1Ewz9jXlfSB/P
         FDc7O9aZLSDO5R5vA4SLz97L4U6t5utixYHiSSVBCe6Js2uNYBqSGHCXvka4qSPYv0mJ
         jp4Fmc6Q6Lb8OHfbfTAVjAlR3EDhOULECPyvjupd1jofxl++qo+9W/YElUh+uKQYZ1M3
         4yLY40xUaAZ65uSIk3fpWYihBriPkxJrY7/+sp+2lgYHX1uEPlOPzX7B4325hlVCNU1M
         9EX/lzk8LDwTbmrtOdllG3/4L6kmrUQJd9S1I2FrOF7ivfZmksK77zlm+zaQycITip+e
         B/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RrtC/gmxAAgsSbzgsRsXolaAMkqQurGCbeiw5KffbU=;
        b=MOufFZFX9SE7MbwHBs0GQYMRT7tQCRdpZC2YiDi06mVum3fWphq9gp0PpNngrQZYZp
         WZskRw5wQyq/fRlO02Ed5yUqhILVt0WSW8aoDfcG8m9uSyxS+Fve2KMSnxeK7IbdmRUR
         EawCX9t757rSPVeB5Ruu8w4wNPu35XBOLkEnvvDY95TWqTVYIxs7wlG5ozQffkcM5VSU
         FL8btLOhP6Ao03+7cjdNvdjVwKHJKXdlOg7FSw0YV+T3rQ5nETpoCePldOG+Sc2ypudK
         cDR/bmgUPfPOovp1f4aeGRDm/GQ1wggUeI4fTRJ2wKEus0JJAEW+nONlAg007MBXvhsH
         oRJA==
X-Gm-Message-State: APt69E2yJT2tggF5j1pBfUCKU6JhhNoLKHvVkOgCG/fTWjJmiJycHOFy
        pXnU1srW48SQXHEU59nbQsUObw==
X-Google-Smtp-Source: AAOMgpc7fT+5xY0wear87uf4lxngWce7BfbBJxAHJXMk5OfuYwOgoMH24vQBv2wjJi/U7vVPYH3knA==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr8745624wmf.8.1530605375240;
        Tue, 03 Jul 2018 01:09:35 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i6-v6sm517209wrr.2.2018.07.03.01.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 01:09:34 -0700 (PDT)
Message-ID: <1530605373.2900.158.camel@baylibre.com>
Subject: Re: [PATCH 2/3] clk: meson: add sub EMMC clock dt-bindings IDs
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 03 Jul 2018 10:09:33 +0200
In-Reply-To: <4b88c509-27ea-2605-023b-de208921e157@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
         <20180703145716.31860-3-yixun.lan@amlogic.com>
         <20180703092107.51497a8f@bbrezillon>
         <4b88c509-27ea-2605-023b-de208921e157@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 15:36 +0800, Yixun Lan wrote:
> Hi Broris
> 
>  thanks for your quick response, and see my comments below
> 
> On 07/03/18 15:21, Boris Brezillon wrote:
> > On Tue, 3 Jul 2018 14:57:15 +0000
> > Yixun Lan <yixun.lan@amlogic.com> wrote:
> > 
> > > Add two clock bindings IDs which provided by the EMMC clock controller,
> > > These two clocks will be used by EMMC or NAND driver.
> > > 
> > > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > > ---
> > >  include/dt-bindings/clock/emmc-clkc.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >  create mode 100644 include/dt-bindings/clock/emmc-clkc.h
> > > 
> > > diff --git a/include/dt-bindings/clock/emmc-clkc.h b/include/dt-bindings/clock/emmc-clkc.h
> > > new file mode 100644
> > > index 000000000000..d9972c400e58
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/emmc-clkc.h
> > > @@ -0,0 +1,14 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> > > +/*
> > > + * Meson EMMC sub clock tree IDs
> > > + *
> > > + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
> > > + */
> > > +
> > > +#ifndef __EMMC_CLKC_H
> > > +#define __EMMC_CLKC_H
> > > +
> > > +#define CLKID_EMMC_C_MUX				0
> > 
> > Looks like the MUX clk is the parent of the DIV one, and I guess the clk
> > driver is able to select the best parent+div pair for a requested rate.
> > Do you really need to expose the MUX to users?
> > 
> 
> Yes, It's true, the mux is parent of the div clock.
> 
> while testing for the NAND driver, I find it's kind of loose about the
> parent of the clock, so selecting the div (and let CCF decide freely) is
> actually works fine
> 
> but for the EMMC driver, especially when running at high clock, it's
> kind of picky about the parent of the clock, 

It would be nice to get an explanation about this behavior.
it seems that even of the rate provided by CLKID_SD_EMMC_X_CLK0 (main clock
controller) is correct, the eMMC cannot reliably tune with it.

Could you elaborate on this ?

> so the driver may want to
> manually choose the parent of the mux clock (example fclk_div2 here).
> That's why I'm exporting this clock ID.

ATM the EMMC driver will not use this provider. If this is the only reason, it
could be done later.

Is the NAND driver "picky" as well ?

> 
> 
> > > +#define CLKID_EMMC_C_DIV				1
> > > +
> > > +#endif
> > 
> > .
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

