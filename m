Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966269AbeCHOLG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:11:06 -0500
Received: from botnar.kaiser.cx ([176.28.20.183]:54842 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966174AbeCHOLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:11:04 -0500
Date: Thu, 8 Mar 2018 15:08:51 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx25: set correct parents for ssi ipg clocks
Message-ID: <20180308140851.GA25601@botnar.kaiser.cx>
References: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
 <CAOMZO5A7W4rbPbZB8ERs518obrg+6F6mDeojkwJaGComFAJB0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5A7W4rbPbZB8ERs518obrg+6F6mDeojkwJaGComFAJB0A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Thus wrote Fabio Estevam (festevam@gmail.com):

> I get audio working from SSI1, but I guess this is due to the fact
> that the bootloader enables the SSI clock:

> I have the following in U-Boot:

> /* Enable the clocks */
> DATA 4 0x53f8000c 0x1fffffff
> DATA 4 0x53f80010 0xffffffff
> DATA 4 0x53f80014 0xfdfff

I'm using the same initial settings.

Nevertheless, ssi1_ipg_per is disbled after loading the kernel.

Digging into this a bit more, it turned out that without my patch,
clk_disable_unused() recognizes ssi1_ipg_per as unused and disables it.

If my patch is applied and ssi1_ipg_per is declared as parent of
ssi1_ipg, clk_disable_unused() will not disable it and fsl_ssi_startup()
will enable both ssi1_ipg_per and ssi1_ipg before playing sound.

Best regards,
Martin
