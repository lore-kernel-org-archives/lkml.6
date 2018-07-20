Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E08ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB9F2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeGTKJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:09:48 -0400
Received: from mout.perfora.net ([74.208.4.197]:44537 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbeGTKJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:09:47 -0400
Received: from localhost.localdomain ([89.217.215.226]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MezRn-1fMRmF149Z-00Oa3I;
 Fri, 20 Jul 2018 11:21:06 +0200
Message-ID: <1532078447.19673.8.camel@ziswiler.com>
Subject: Re: [PATCH] ASoC: wm9712: fix replace codec to component
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-mips@linux-mips.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Burton <paul.burton@mips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, Donglin Peng <dolinux.peng@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Fri, 20 Jul 2018 11:20:47 +0200
In-Reply-To: <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
References: <20180720075148.14648-1-marcel@ziswiler.com>
         <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:onunNaexXgGZawMVxD2fW8hPkHh4cO9Cg1yWbodhs51c600RaZq
 wyk0sT4cSVy3YJ0M3f4WzppRf/hMK5T8CfGNbmNZrUncJCNr6AZ+1b4dFyz+cZJtX5bhqKz
 Exu7ktyVhMy4dEFD4QA02bu3tRUwtKfY9iSt+gJAdx7xaI8pprNY5gLkYbKYEwebM99bPz9
 EZgjCaRO4u8Lh2cViCJOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pEE3KBkYACo=:bvNhs15X8y4LQ9Ram2ca1E
 6jdb4tG6+O/68mKLJqF0or2WqML2rIXxYxZL7ZJ8EXLyNCvaRwlpjrfVRX0/jHD4tUEYnrdCM
 NPhhaZava5/afY34O5HVa2QtkjC5YBCza1zQ2UDmZrPc7NRNaqMJ9LlIbZb+7f3Gw6oGM6o4R
 M4nP2gGXCXjnjHPvgbS7S0YhGiAFCwm0jCJXUqMmnOzq1zCwPv/D/IYny2LcaN4YJpRz1d9mT
 E35wapSwkcJbFcinmI+q3xYqqc7v+LO7S5mO1OcKpiHcH3IZ1lYwSZW1PJulJ+LJbTmVe+gOK
 5KQH/nfCWIO9FT5UkmUcCUmqRxFWlGOADR+MrPaOneuZj8JEia2V9N0mAErIwGj5FZrLw0/2k
 oqwQBf7izzeTv1sTx1TBsK9T/co92PsvpXBbcq9zPcEBPsVorW3D9C24+Y3H7hAMR2N0T6zRg
 VzABrMMkTajI9NlM1DxLiwu61vkqBOWQohvZsoSCR9MjoG8DH5VZmi3Df1LaMRqruIYwPI81s
 Qh3mpqy52p5OUcEeDtpNWMAx1wqx8mQ83g433M2Pmz/J9VqbhQQpj07Rj5CwDhrXZLGTVAqIx
 FCGX/Kg+0rcMovBz2IUNGN6DLsCXgK/FLHjsDvVl1QGObgX4fw2GBtLTWSAFm3mPF23TdE7o9
 +bEBb3FXKxADqPFCOe8VnWbtw0HY9+YhMr7m3e+tCmJfAkh1XAUwa6FTdTfyyTzO7oO8YbcT4
 egCewQvmnhlM3WOR
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuninori

On Fri, 2018-07-20 at 08:30 +0000, Kuninori Morimoto wrote:
> Hi Marcel
> 
> > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > 
> > Since commit 143b44845d87 ("ASoC: wm9712: replace codec to
> > component")
> > "wm9712-codec" got renamed to "wm9712-component", however, this
> > change
> > never got propagated down to the actual board/platform drivers.
> > E.g. on
> > Colibri T20 this lead to the following spew upon boot with
> > sound/touch
> > being broken:
> 
> Oops, my bad...
> The platform_driver name is not important,
> how about simply rename back it to "wm9712-codec" ?

Sure, that's your call. After all it was now broken for almost half a
year (;-p). Should I cook that up as well or are you gona do it?

> Best regards
> ---
> Kuninori Morimoto

Cheers

Marcel
