Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934542AbeCHPHs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:07:48 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:46235 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934258AbeCHPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:07:46 -0500
X-Google-Smtp-Source: AG47ELtwXZcyKDzqf2yB7l/uM3gRvBDqSc09pf+XaDYTAXaSAlbFqvad+qR6DGLTe3M/wDhRLWGa2sfNP6qdUgO2Di8=
MIME-Version: 1.0
In-Reply-To: <20180308140851.GA25601@botnar.kaiser.cx>
References: <1520373735-13699-1-git-send-email-martin@kaiser.cx>
 <CAOMZO5A7W4rbPbZB8ERs518obrg+6F6mDeojkwJaGComFAJB0A@mail.gmail.com> <20180308140851.GA25601@botnar.kaiser.cx>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 8 Mar 2018 12:07:45 -0300
Message-ID: <CAOMZO5BdBWExt9FvPrfUG74Y62e4EUs6cqFyfVs5JuUtym00hQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx25: set correct parents for ssi ipg clocks
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Thu, Mar 8, 2018 at 11:08 AM, Martin Kaiser <martin@kaiser.cx> wrote:
> Hi Fabio,
>
> Thus wrote Fabio Estevam (festevam@gmail.com):
>
>> I get audio working from SSI1, but I guess this is due to the fact
>> that the bootloader enables the SSI clock:
>
>> I have the following in U-Boot:
>
>> /* Enable the clocks */
>> DATA 4 0x53f8000c 0x1fffffff
>> DATA 4 0x53f80010 0xffffffff
>> DATA 4 0x53f80014 0xfdfff
>
> I'm using the same initial settings.
>
> Nevertheless, ssi1_ipg_per is disbled after loading the kernel.
>
> Digging into this a bit more, it turned out that without my patch,
> clk_disable_unused() recognizes ssi1_ipg_per as unused and disables it.
>
> If my patch is applied and ssi1_ipg_per is declared as parent of
> ssi1_ipg, clk_disable_unused() will not disable it and fsl_ssi_startup()
> will enable both ssi1_ipg_per and ssi1_ipg before playing sound.

I can get audio to work fine without your patch on a mx25pdk.

In the other i.MX clock drivers we have this same pattern:

clks[IMX6SL_CLK_SSI1_IPG]     = imx_clk_gate2_shared("ssi1_ipg",     "ipg",

It is not clear to me what is the real issue this patch is trying to fix.

Thanks
