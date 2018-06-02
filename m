Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeFBMAm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 08:00:42 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:24103 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFBMAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 08:00:38 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w52C0Sax015867
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: ADUXVKLM5Zg+Naz+V+1iRF0cFeP3X44T9MwCqz7gr0nr1thHb74DU+cKotuqEnh1rW7Xb1R5LjsvMyYl0/Y6gI5xgiU=
MIME-Version: 1.0
In-Reply-To: <20180530090946.1635-7-suzuki.katsuhiro@socionext.com>
References: <20180530090946.1635-1-suzuki.katsuhiro@socionext.com> <20180530090946.1635-7-suzuki.katsuhiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 2 Jun 2018 20:59:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8JT8+MAuH+eYUJ3Xa4r07=ecJS0E=SX-tgmV7db_FKw@mail.gmail.com>
Message-ID: <CAK7LNAS8JT8+MAuH+eYUJ3Xa4r07=ecJS0E=SX-tgmV7db_FKw@mail.gmail.com>
Subject: Re: [PATCH 6/8] media: uniphier: add common module of DVB adapter drivers
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-30 18:09 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds common module for UniPhier DVB adapter drivers
> that equipments tuners and demod that connected by I2C and
> UniPhier demux.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  drivers/media/platform/uniphier/Makefile      |  5 ++
>  drivers/media/platform/uniphier/hsc-core.c    |  8 ---
>  .../platform/uniphier/uniphier-adapter.c      | 54 +++++++++++++++++++
>  .../platform/uniphier/uniphier-adapter.h      | 42 +++++++++++++++
>  4 files changed, 101 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/media/platform/uniphier/uniphier-adapter.c
>  create mode 100644 drivers/media/platform/uniphier/uniphier-adapter.h
>
> diff --git a/drivers/media/platform/uniphier/Makefile b/drivers/media/platform/uniphier/Makefile
> index 0622f04d9e68..9e75ad081b77 100644
> --- a/drivers/media/platform/uniphier/Makefile
> +++ b/drivers/media/platform/uniphier/Makefile
> @@ -3,3 +3,8 @@ uniphier-dvb-y += hsc-core.o hsc-ucode.o hsc-css.o hsc-ts.o hsc-dma.o
>  uniphier-dvb-$(CONFIG_DVB_UNIPHIER_LD11) += hsc-ld11.o
>
>  obj-$(CONFIG_DVB_UNIPHIER) += uniphier-dvb.o
> +
> +ccflags-y += -Idrivers/media/dvb-frontends/
> +ccflags-y += -Idrivers/media/tuners/


Please add $(srctree)/ like

ccflags-y += -I$(srctree)/drivers/media/dvb-frontends/
ccflags-y += -I$(srctree)/drivers/media/tuners/


Currently, it works $(srctree)/,
but I really want to rip off the build system hack.





-- 
Best Regards
Masahiro Yamada
