Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB6FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3859B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JM5pPTsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3859B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbeG3Qm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:42:28 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35408 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbeG3Qm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:42:28 -0400
Received: by mail-it0-f67.google.com with SMTP id q20-v6so147136ith.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KGwl0djGWAmhw3kP3Vf17wqvYa2T7EECjh07qIQ8WvE=;
        b=JM5pPTsJsf5xe2AoUNvnJU7Owejabtwai+3PNEvaMiDSAKjMkzeV07G/nLJbGtkb7k
         EatnB7AJ1ndmVyJlI1tS4e15E2bq18f9X7Zf0YYjctbnWTNLt7ojzBOJvZ4AMbk6hJz6
         yMT22LPv98gcsod+t2Xhs+G3PTWhsapnNGcWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KGwl0djGWAmhw3kP3Vf17wqvYa2T7EECjh07qIQ8WvE=;
        b=D6TFZMrqhrPx6inmCevOKEvUynQi3pDBIqo3o8UtZ4oM17IV7dwxQCSF1GSHE1ToxZ
         IAFcy8HyLV6FEAWyLSJjalbPjJe0y3h0pbmzx8nyKaJroVbuWFz3Yhdc0MO+7wn1Y/EE
         qVe8+4idBcq1jkr/k8lj0EcjwJHliTkOJLpMdfeFLhpom8Dz0LGlSpMYSEsEW6j9DbQR
         7A6OgqXAp3TvDtCyuS0Pzq2OjKR2bViZEJb9FGNpipEjPJ08AbY0scDXBMxJZZ0Z+G0s
         ZnUPScuPl2fedXBUJPloQ0G8P9h35eoH+bnr9kKPl86oDdoQsfFLRLQdxy21UOC5S+hd
         VW3Q==
X-Gm-Message-State: AOUpUlGsrRC0mFj46v2bSlAPKWI8yYjdd8ULEgaLFTUiDQrW49Op/eIY
        0jzAWSZF7fzbtrhj3fw7ADYst8lb7nOQicJoXN1hNw==
X-Google-Smtp-Source: AAOMgpdAXxObaCDYLUVvEKoej4duh7GtJ7VHbkXHUD1g4eWBZSHyjaJunZLrO47nF4hYjw9GmwSo1eHst1f+4YX6Jn0=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr15362787itc.38.1532963223276;
 Mon, 30 Jul 2018 08:07:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:07:02
 -0700 (PDT)
In-Reply-To: <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com> <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Jul 2018 17:07:02 +0200
Message-ID: <CAPDyKFpK=UnwdNtb3XcgcRBJZeE0X5osM-tk8E85TCs3CeDq7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 July 2018 at 05:28, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
> MFD glue") said, these MMC controllers use the IP from Panasonic.
>
> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
> The common driver code was split and expanded as 'tmio-mmc-core', then
> it become historical misnomer since 'tmio' is not the name of this IP.
>
> I pointed out this [1], and suggested to re-organize the names in the
> form of:
>
>   <IP-name>.c            (common code for this IP)
>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>   <IP-name>_sdhi.c       (Renesas SDHI)
>   <IP-name>_uniphier.c   (Socionext UniPhier)
>
> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
> are prefixed with 'MN'.
>
> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>
> In the discussion with Wolfram Sang, my suggestion was rejected
> because it implied drastic function renaming, which is too invasive.
>
> Ulf Hansson was still happy with file renaming to clarify the
> relationship between variants.  So, the accepted solution was:
>
>  - Make 'tmio_mmc' the _right_ core name
>  - Align all variant files with the same prefix.
>  - Do not rename functions
>
> This commit renames files as follows:
>
>   tmio_mmc_core.c              -> tmio_mmc.c
>   tmio_mmc.c                   -> tmio_mmc_original.c
>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
>
> Also rename CONFIG options to match to the file names:
>
>   MMC_TMIO_CORE          -> MMC_TMIO
>   MMC_TMIO               -> MMC_TMIO_ORIGINAL
>   MMC_SDHI               -> MMC_TMIO_SDHI
>   MMC_SDHI_SYS_DMAC      -> MMC_TMIO_SDHI_SYS_DMAC
>   MMC_SDHI_INTERNAL_DMAC -> MMC_TMIO_SDHI_INTERNAL_DMAC
>
> I touched eseries_pxa_defconfig and pxa_defconfig in this commit
> because they are inactive, but renaming of CONFIG options generally
> takes some development cycles.  Old names will be kept until the
> migration is completed, like Renesas folks did when they renamed
> ARCH_SHMOBILE_MULTI to ARCH_RENESAS.
>
> [1] https://www.spinics.net/lists/linux-mmc/msg46952.html
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I am awaiting some feedback from Wolfram before applying.

> ---
>
>  MAINTAINERS                                        |    1 -
>  arch/arm/configs/eseries_pxa_defconfig             |    2 +-
>  arch/arm/configs/pxa_defconfig                     |    2 +-
>  drivers/mmc/host/Kconfig                           |   25 +-
>  drivers/mmc/host/Makefile                          |    8 +-
>  drivers/mmc/host/tmio_mmc.c                        | 1415 ++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc_core.c                   | 1394 -------------------
>  drivers/mmc/host/tmio_mmc_original.c               |  167 +++

I think there should be another way to format the patch to get better diffstat.

I guess it depends a bit on what version of git you are using, but
trying the -M option may help.


>  .../host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c}  |    2 +-
>  .../mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h}   |    0
>  ...ternal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} |    2 +-
>  ...as_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} |    2 +-
>  12 files changed, 1518 insertions(+), 1502 deletions(-)
>  delete mode 100644 drivers/mmc/host/tmio_mmc_core.c
>  create mode 100644 drivers/mmc/host/tmio_mmc_original.c
>  rename drivers/mmc/host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c} (99%)
>  rename drivers/mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h} (100%)
>  rename drivers/mmc/host/{renesas_sdhi_internal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} (99%)
>  rename drivers/mmc/host/{renesas_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} (99%)
>

[...]

Kind regards
Uffe
