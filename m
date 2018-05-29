Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755210AbeE2HrF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:47:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45155 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755176AbeE2HrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:47:02 -0400
X-Google-Smtp-Source: ADUXVKKGdRNewDltD4gNYd3y7x/vboxzZ6CIIuhNEinB/lYDSOnXg1ZsFj44nWUwOPJ42jvU431dZA==
Date: Tue, 29 May 2018 08:46:59 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 6/6] mfd: da9063: Add DA9063L support
Message-ID: <20180529074659.GC4790@dell>
References: <20180523114230.10109-1-marek.vasut+renesas@gmail.com>
 <20180523114230.10109-6-marek.vasut+renesas@gmail.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A47F0@SW-EX-MBX02.diasemi.com>
 <6ED8E3B22081A4459DAC7699F3695FB701941A4866@SW-EX-MBX02.diasemi.com>
 <3d81a469-e54f-953d-7600-7ddf3d026ca1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d81a469-e54f-953d-7600-7ddf3d026ca1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Marek Vasut wrote:
> On 05/24/2018 02:32 PM, Steve Twiss wrote:
> > On 24 May 2018 @ 12:49 Steve Twiss wrote:

[...]

> > static const struct regmap_irq da9063l_irqs[] = {
> > 	/* DA9063 event A register */
> > 	[DA9063L_IRQ_ONKEY] = {
> > 		.reg_offset = DA9063_REG_EVENT_A_OFFSET,
> > 		.mask = DA9063_M_ONKEY,
> > 	},

[...]

> > 	[DA9063L_IRQ_GPI15] = {
> > 		.reg_offset = DA9063_REG_EVENT_D_OFFSET,
> > 		.mask = DA9063_M_GPI15,
> > 	},
> > };
> 
> We can probably do the same trick with the regmaps and irqmaps as with
> the rest, that is, reorder them and register only a smaller portion ?

Please also consider using REGMAP_IRQ_REG().

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
