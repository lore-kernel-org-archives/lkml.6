Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932588AbeD0JnY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:43:24 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21350 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeD0JnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:43:22 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w3R9h86N027065
X-Nifty-SrcIP: [209.85.213.49]
X-Google-Smtp-Source: AB8JxZq67aHV8xDtTMVHrCQ2HhlvHYLXRlzKxMygmc8t5h1kY063Ud2wHWKkzgMu2YwWpLJ8M6CJREFgioz+pEE+omQ=
MIME-Version: 1.0
In-Reply-To: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Apr 2018 18:42:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
Message-ID: <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier: fix USB clock line for LD20
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp,

2018-04-12 11:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> For LD20, the bit 5 of the offset 0x200c turned out to be a USB3
> reset.  The hardware document says it is the GIO reset despite LD20
> has no GIO bus, confusingly.
>
> Also, fix confusing comments for PXs3.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Can you take a look at this, please?




>  drivers/reset/reset-uniphier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index 360e06b..ac18f2f 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -110,7 +110,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
>         UNIPHIER_RESETX(4, 0x200c, 2),          /* eMMC */
>         UNIPHIER_RESETX(6, 0x200c, 6),          /* Ether */
>         UNIPHIER_RESETX(8, 0x200c, 8),          /* STDMAC (HSC) */
> -       UNIPHIER_RESETX(12, 0x200c, 5),         /* GIO (PCIe, USB3) */
> +       UNIPHIER_RESETX(14, 0x200c, 5),         /* USB30 */
>         UNIPHIER_RESETX(16, 0x200c, 12),        /* USB30-PHY0 */
>         UNIPHIER_RESETX(17, 0x200c, 13),        /* USB30-PHY1 */
>         UNIPHIER_RESETX(18, 0x200c, 14),        /* USB30-PHY2 */
> @@ -127,8 +127,8 @@ static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
>         UNIPHIER_RESETX(6, 0x200c, 9),          /* Ether0 */
>         UNIPHIER_RESETX(7, 0x200c, 10),         /* Ether1 */
>         UNIPHIER_RESETX(8, 0x200c, 12),         /* STDMAC */
> -       UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link (GIO0) */
> -       UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link (GIO1) */
> +       UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link */
> +       UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link */
>         UNIPHIER_RESETX(16, 0x200c, 16),        /* USB30-PHY0 */
>         UNIPHIER_RESETX(17, 0x200c, 18),        /* USB30-PHY1 */
>         UNIPHIER_RESETX(18, 0x200c, 20),        /* USB30-PHY2 */
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
