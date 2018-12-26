Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44685C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D8D2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545817266;
	bh=VRSuGMaJdiZ8mJUMAX6PiltUM+ng5u18DzQwmIBjMdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QEf7zpKRoUx48IyZ6P37XoXtBlTTfcCJTwQQQ2tUAhUJxMnRseq813dDy6cR+e5X0
	 BAHQraNUzLn3AT6INhonx4yP5V9LBGnATs4efDNoWXTqQIArB/TuP3xRX7Yas+v5/5
	 AdNG5thSL1Ok/U5ouhNLvdWcDkQF6pN+e2B5CagY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeLZJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 04:41:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38040 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLZJlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 04:41:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id e12so13685347otl.5;
        Wed, 26 Dec 2018 01:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6roPUlqZukNjUn+vTLumDEM5JfDPHlUVWhkfIJYdmRQ=;
        b=q+pgxEJhvewiI2QtZe61zXpI3eS30WdcXIzfQ1DrtY4/G4y6IpUMHPBOKS2lkLfM2L
         XDNOsaC4adRzGimHAixgDpi5sUwDy/2+IPEuwn6cI8rWiHALBO7gK+folJQbcEb0MPCk
         MusB0NldbcY/GCpoaslFruZOGDGBrgEFzKX5DESjNF/G4+qW7Ys81CBFlqC+hAcTZogl
         dVi91l3qnkxH6nqqVJfD5yyQhUG+94ah25RzHc2UhIcaT1Tuzrocq6haJiVvTZtXFJJs
         yAjteWMLq1Tpaib2YTTIJlbOAemHeHkHqUeuEpY3p8MnJy3icLwiW4nNMPlmZroZe2+l
         jKIA==
X-Gm-Message-State: AJcUukdvpcPFR1IMuzFyvT4eA2+K+XUCizaQrwELwr+EfzC6pGW9vff1
        qK4rYXrDKWxhMvmehfiFvxLbV55uql1IP+WW4Kq2gw==
X-Google-Smtp-Source: ALg8bN5gs8WwFMM30Z9RYDakbUrugp1GkWZCxyhD6rrL/1/ykhZs8C4JrDSR0aGp0wtsbt54zuuJ0Kb5OTIs3zIzQZc=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr13482354otg.139.1545817263203;
 Wed, 26 Dec 2018 01:41:03 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-10-okaya@kernel.org>
In-Reply-To: <20181223232521.11320-10-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Dec 2018 10:40:48 +0100
Message-ID: <CAJZ5v0jFXvGJH_V9gJ8c3T5x80yYHQmk=0WfJi=vvkSJ_aShwg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] mmc: add PCI dependency into IOSF_MBI
To:     okaya@kernel.org
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, faiz_abbas@ti.com,
        chunyan.zhang@unisoc.com, Jisheng.Zhang@synaptics.com,
        ludovic.barre@st.com, Arnd Bergmann <arnd@arndb.de>,
        alex.smith@imgtec.com, chris.brandt@renesas.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 12:26 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> Select IOSF_MBI only when PCI is set.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..4c5f037b246d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -117,7 +117,7 @@ config MMC_RICOH_MMC
>  config MMC_SDHCI_ACPI
>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>         depends on MMC_SDHCI && ACPI

It should depend on PCI as well, shouldn't it?

As it stands with the patch applied, randconfig can still select it if
PCI is unset AFAICS, can't it?

> -       select IOSF_MBI if X86
> +       select IOSF_MBI if (X86 && PCI)
>         help
>           This selects support for ACPI enumerated SDHCI controllers,
>           identified by ACPI Compatibility ID PNP0D40 or specific
> --
