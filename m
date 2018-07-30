Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB6B13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B6320881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OIwR42BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B6320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeG3Kb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:31:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33831 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeG3Kb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:31:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so11945941wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5KJ/aAr7CPxobSoh4m3nwI9irEo3EPh75UQqwwcRZ0=;
        b=OIwR42BHKfC6ukVke7Vb3Pb0oc1EHQAWEKUUjF0+7TkuXpg5FgwxBDcFqL/2BHSwix
         yFfsA3QoVLb65dy7Bkk3Hv5YDlfwm2r1Meq2YmrPbaF/wWSc1gPhYy9ylPQDJHHM3WhA
         1XD3gmCm3UJlcGgnIdZM1OTw7BHaaU1TWvlL9AY5eHVYAAqvfAG57p6Ejv+PHi9gB+kh
         /uFmLVtY1b2A8kp3JFxXQscjmi7ZnQaObDy9ibhGnEl7+pGIYPNRUBBny+5rJsSo+4O1
         Ry8FLhvhy0Z65DFiHB2h0AvYbimRHHpCvXHi4Tob+F4j1IHrNLvEhR5FXyCW9sKx9F9P
         EtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5KJ/aAr7CPxobSoh4m3nwI9irEo3EPh75UQqwwcRZ0=;
        b=RrHKcT9VORpPOhnVR+VpaqrlpmeJO51Bjef9ELeOPEqv6SZU9czeqeoZezFZ+uY4E9
         HjkCp2thRjcWqNzVv4P3i05op454GtqYHwcgRdeWoX0lqDVpJ8YEDdx7ahIAHyZn/ENR
         H+Kpk3ilOe7TqSFTuaObjVUJTceOxQwv9c+HppuIiY5AWn/PMl1KRk7hDzbhy4Qb4/iS
         SYn5bhoGWkBCKzkPd6Xn9aeUPwQTMYNuoSuWjdq09e43nKAunIRHNCwE3eVpyIf7YB19
         rpGosCCAZhC9+GpHVoLqXd7dlBSyrO+RNKYIju7bXvFt9LRZEgR5cKar80Exe8GUAALl
         7HzQ==
X-Gm-Message-State: AOUpUlFbASx+YXJFCAcC+cZ16T1mGCNs1CZdIjhKV/J2Gf0mRexx5Fab
        NIc+Ch3dLK/bQWST+LZ35U0L1w==
X-Google-Smtp-Source: AAOMgpfSgKKUo4EdvexOB7PZufUBEPaWwEB3hp5hVXnWw5tHOwjrZi/CuuSKgOx2MbIZvMZ/G/rJFw==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr17275740wrg.203.1532941049017;
        Mon, 30 Jul 2018 01:57:29 -0700 (PDT)
Received: from boomer (uluru.liltaz.com. [163.172.81.188])
        by smtp.gmail.com with ESMTPSA id r12-v6sm7561237wmh.0.2018.07.30.01.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 01:57:28 -0700 (PDT)
Message-ID: <e89f28253070abae5dc755800feee500cc3396ce.camel@baylibre.com>
Subject: Re: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>
Cc:     Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jian Hu <jian.hu@amlogic.com>
Date:   Mon, 30 Jul 2018 10:57:26 +0200
In-Reply-To: <153270995155.48062.4302847978258086624@swboyd.mtv.corp.google.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
         <20180712211244.11428-3-yixun.lan@amlogic.com>
         <153261840298.48062.2497103873681297587@swboyd.mtv.corp.google.com>
         <f52d2511-bab7-2c39-cea7-8702e27d2ef8@amlogic.com>
         <153270970080.48062.18399022907046343950@swboyd.mtv.corp.google.com>
         <153270995155.48062.4302847978258086624@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-27 at 09:45 -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2018-07-27 09:41:40)
> > Quoting Yixun Lan (2018-07-27 07:52:23)
> > > HI Stephen:
> > > 
> > > On 07/26/2018 11:20 PM, Stephen Boyd wrote:
> > > > Quoting Yixun Lan (2018-07-12 14:12:44)
> > > > > diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
> > > > > new file mode 100644
> > > > > index 000000000000..36c4c7cd69a6
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/meson/mmc-clkc.c
> > > > > @@ -0,0 +1,367 @@
> > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > +/*
> > > > > + * Amlogic Meson MMC Sub Clock Controller Driver
> > > > > + *
> > > > > + * Copyright (c) 2017 Baylibre SAS.
> > > > > + * Author: Jerome Brunet <jbrunet@baylibre.com>
> > > > > + *
> > > > > + * Copyright (c) 2018 Amlogic, inc.
> > > > > + * Author: Yixun Lan <yixun.lan@amlogic.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > 
> > > > Is this include used?
> > > > 
> > > 
> > > this is needed by clk_get_rate()
> > > see drivers/clk/meson/mmc-clkc.c:204
> > 
> > Hmm ok. That's unfortunate.
> 
> You should be able to read the hardware to figure out the clk frequency?
> This may be a sign that the phase clk_ops are bad and should be passing
> in the frequency of the parent clk to the op so that phase can be
> calculated. Jerome?
> 

It could be a away to do it but:
a) if we modify the API, we would need to update every clock driver using it.
   There is not that many users of the phase API but still, it is annoying
b) This particular driver need the parent rate, other might need something else
I guess. (parent phase ??, duty cycle ??) 

I think the real problem here it that you are using the consumer API. You should
be using the provider API like clk_hw_get_rate. Look at the clk-divider.c which
use clk_hw_round_rate() on the parent clock. 

Clock drivers should deal with 'struct clk_hw', not 'struct clk'. I think it was
mentioned in the past that the 'clk' within 'struct clk_hw' might be removed
someday.

Yixun, please don't put your clock driver within the controller driver. Please
implement your 'phase-delay' clock in its own file and export the ops, like
every other clock in the amlogic directory. Also, please review your list of
'#define', some of them are unnecessary copy/paste from the MMC driver.

Regards

Jerome





