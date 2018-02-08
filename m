Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeBHIHF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 03:07:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54166 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeBHIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 03:07:03 -0500
X-Google-Smtp-Source: AH8x225QBiVnvkUEHBMdEAHp6h1vHHPlEa5MAs5ahO+KiJaXBSlL6bPkhZpUveCbGMsA8IfM0CpT1g==
Message-ID: <1518077220.15707.3.camel@baylibre.com>
Subject: Re: [PATCH 05/19] clk: meson: add regmap clocks
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org
Date: Thu, 08 Feb 2018 09:07:00 +0100
In-Reply-To: <0bd2c95c-dab3-9796-1267-472e6a00a403@amlogic.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
         <20180131180945.18025-6-jbrunet@baylibre.com>
         <0bd2c95c-dab3-9796-1267-472e6a00a403@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 15:33 +0800, Yixun Lan wrote:
> > +/**
> > + * struct clk_regmap_mux_data - regmap backed multiplexer clock specific data
> > + *
> > + * @hw:              handle between common and hardware-specific interfaces
> > + * @offset:  offset of theregister controlling multiplexer
> > + * @table:   array of parent indexed register values
> > + * @shift:   shift to multiplexer bit field
> > + * @width:   width of mutliplexer bit field
> 
>       ~~~~~~ this is wrong, please update to keep it sync with the
> struct definition

Indeed, it is.
This is just a copy/paste of the mux documentation provided in
include/linux/clk-provider.h ... which is also inaccurate.

Thanks for pointing it out

> 
> > + * @flags:   hardware-specific flags
> > + *
> > + * Flags:
> > + * Same as clk_divider except CLK_MUX_HIWORD_MASK which is ignored
> > + */
> > +struct clk_regmap_mux_data {
> > +     unsigned int    offset;
> > +     u32             *table;
> > +     u32             mask;
> 
>                         ~~~~~ here
> > +     u8              shift;
> > +     u8              flags;
> > +};
> > +
