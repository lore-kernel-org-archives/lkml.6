Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0879C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0D208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jub9YHHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA0D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388332AbeG0SIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbeG0SIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:08:34 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C54208AF;
        Fri, 27 Jul 2018 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532709952;
        bh=xBmdWbgRafuYPkzcDJ19YoVIUtBw5sjssMlLLymCsy0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Jub9YHHxH6/+K1vlCUnYbFhLl6Jmnpy4eSNibxx0jYzadgrw5Iv5NCDI6e59GfXJY
         zMPTYpqkTXkEB/xjz4rVABym/14TeHDGmr9SbXc5S1h2HRBhEiqeeVXePUDMRjR2tj
         /fUsbkfKDik/6SDAGaFpRn/7bI8R3NvOnkwQVWIk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        yixun.lan@amlogic.com, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
 <20180712211244.11428-3-yixun.lan@amlogic.com>
 <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
 <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
 <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
Message-ID: <153270995155.48062.4302847978258086624@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
Date:   Fri, 27 Jul 2018 09:45:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-07-27 09:41:40)
> Quoting Yixun Lan (2018-07-27 07:52:23)
> > HI Stephen:
> > =

> > On 07/26/2018 11:20 PM, Stephen Boyd wrote:
> > > Quoting Yixun Lan (2018-07-12 14:12:44)
> > >> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-cl=
kc.c
> > >> new file mode 100644
> > >> index 000000000000..36c4c7cd69a6
> > >> --- /dev/null
> > >> +++ b/drivers/clk/meson/mmc-clkc.c
> > >> @@ -0,0 +1,367 @@
> > >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > >> +/*
> > >> + * Amlogic Meson MMC Sub Clock Controller Driver
> > >> + *
> > >> + * Copyright (c) 2017 Baylibre SAS.
> > >> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> > >> + *
> > >> + * Copyright (c) 2018 Amlogic, inc.
> > >> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> > >> + */
> > >> +
> > >> +#include <linux/clk.h>
> > > =

> > > Is this include used?
> > > =

> > this is needed by clk_get_rate()
> > see drivers/clk/meson/mmc-clkc.c:204
> =

> Hmm ok. That's unfortunate.

You should be able to read the hardware to figure out the clk frequency?
This may be a sign that the phase clk_ops are bad and should be passing
in the frequency of the parent clk to the op so that phase can be
calculated. Jerome?

