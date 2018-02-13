Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935500AbeBMOvj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:51:39 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35830 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935258AbeBMOvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:51:37 -0500
X-Google-Smtp-Source: AH8x227V30LY9znJvwqxqYe3QandbpAjdx9taW4cpEGQnKEvd8NrAJSXD0AizFAGzr2+0iLBViPaIA==
Message-ID: <1518533493.2883.35.camel@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson-axg: Add AO Clock and Reset controller
 driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2018 15:51:33 +0100
In-Reply-To: <1518449571.2883.30.camel@baylibre.com>
References: <20180209070026.193879-1-yixun.lan@amlogic.com>
         <20180209070026.193879-3-yixun.lan@amlogic.com>
         <1518449571.2883.30.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-12 at 16:32 +0100, Jerome Brunet wrote:
> On Fri, 2018-02-09 at 15:00 +0800, Yixun Lan wrote:
> > Adds a Clock and Reset controller driver for the Always-On part
> > of the Amlogic Meson-AXG SoC.
> > 
> > Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >   drivers/clk/meson/Makefile    |   2 +-
> >   drivers/clk/meson/axg-aoclk.c | 236 ++++++++++++++++++++++++++++++++++++++++++
> >   drivers/clk/meson/axg-aoclk.h |  25 +++++
> >   3 files changed, 262 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/clk/meson/axg-aoclk.c
> >   create mode 100644 drivers/clk/meson/axg-aoclk.h

Yixun,

Actually, looking at this driver further, except for some of the data, the
driver is exactly the same as gxbb-aoclk. There is no reason to duplicate all
this code.

I'd prefer if you'd factor all this in a dedicated driver.
This philosophy is more or less the same as meson's pinctrl drivers, which all
provides their own data and bindings but share the driver code.

Regards
Jerome
