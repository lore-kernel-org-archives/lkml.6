Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BE0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A0925DA6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A0925DA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeGBNcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:32:50 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40591 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeGBNcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:32:46 -0400
Received: by mail-ua0-f195.google.com with SMTP id j17-v6so10055008uap.7;
        Mon, 02 Jul 2018 06:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LStrlzSrZhqKOAoi+lTr24WW4llQJPqpKFqLdezPjMg=;
        b=OtT8i3inDuxcmh1aDLGiSw8UP8cmSo3dodky+Xy45cOAiA9UGgz+NMVfap3fPh6WwH
         gkiCCgyS+r1ijJP1hoKqVaamh/bJPU2M9PNfhZ1eJrg74sNMe6gka4ti7+D9qVRZBbuv
         tZ0PImiJXf5qaZymtSU2Q/isErP5eg0h5OpbaXxhHwpM9Npg2VOmpb/4UNGHfCrPJ/jp
         u5YGsw/6yJtG2XCftqRtX7sGimIhOWfD0gwemokryGUxcRK0jYECNhndtm1Dix9I4YjO
         lh7qZw3CBfPzi8lPk0EcyHT64052HW27ge46014LHeOdDBAy9OQk2j/kmKHtj8VtJVlC
         qEdg==
X-Gm-Message-State: APt69E06KUsDvZit2gWI6jaxPrM8tFxTsEaWJSMeYeC36wotunxOMkch
        +flxesLjvah5+DxVcg+oA8j+MsDBdm44n2+jiS8=
X-Google-Smtp-Source: AAOMgpfflNqlTgpkZ/oY/F8s4QNv+4v09N47+MiH8GVmtP0LW2lT3k8PdvUwaGB4JAcJES7Fy7O14I1Cnbm47wHMEiM=
X-Received: by 2002:ab0:25d6:: with SMTP id y22-v6mr16901330uan.33.1530538365479;
 Mon, 02 Jul 2018 06:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <1528310612-10158-1-git-send-email-clabbe@baylibre.com> <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Jul 2018 15:32:34 +0200
Message-ID: <CAMuHMdU709R3woOAvw7EH4=zGiBtezg0YeEer-4wG7pqo2SZBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, Jul 2, 2018 at 3:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 6 June 2018 at 20:43, Corentin Labbe <clabbe@baylibre.com> wrote:
> > This patch fix the following build failure on m68k:
> > ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>
> Thanks, applied for next!

Please drop this patch, I posted proper fixes for this general issue in series
"[PATCH 0/3] Legacy clock drivers: Normalize clk API"
(https://lkml.org/lkml/2018/6/11/122).

All fixes above are already in next-20180702.
Thanks!

> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 0581c199c996..77d6ba090436 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -666,7 +666,7 @@ config MMC_CAVIUM_THUNDERX
> >
> >  config MMC_DW
> >         tristate "Synopsys DesignWare Memory Card Interface"
> > -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> > +       depends on COMMON_CLK && (ARC || ARM || ARM64 || MIPS || COMPILE_TEST)
> >         help
> >           This selects support for the Synopsys DesignWare Mobile Storage IP
> >           block, this provides host support for SD and MMC interfaces, in both

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
