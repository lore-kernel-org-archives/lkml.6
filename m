Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A815FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6022086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNctyP5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6022086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeK0SSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbeK0SSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:18:02 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C48921104;
        Tue, 27 Nov 2018 07:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543303265;
        bh=1F28aIS+1vD0g4RixfeDhO3ZV6pSBzptwIjaQ3mb/zg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fNctyP5AYxtKvELH7vzxqPv1zGyygcVCCatFiOMflsnhv/0BWH5vDsmwamh006nU+
         xR1DGdfbTeWDt8+Cb7IWC/GzVMM/7utIDHvlm93VNmpdw1Z8DLSIc2tryjWAP+Ra5k
         uFI+rDYQF6p/cZwICWp2ZVJdNe5FrWpqLpLnyvUU=
Received: by mail-wm1-f52.google.com with SMTP id 125so20718175wmh.0;
        Mon, 26 Nov 2018 23:21:05 -0800 (PST)
X-Gm-Message-State: AA+aEWaLmxbJKKeMzOa3eF9lFGMGGzrNJsSZ0MdQmypLfejl+rm2OD0A
        x1E+BfDOgmFL04hB/DKl/URkLkt7Wsi6oJlnv0s=
X-Google-Smtp-Source: AFSGD/VoCXDFGqC3dMIgzdecR2KwkyU4PcwGvPbiVCHb0Y8/VM/Lr9aeir7fRLwPQ18h2Hb7nl+jyZ/ZfwUyesBzkYk=
X-Received: by 2002:a1c:2c56:: with SMTP id s83mr740345wms.48.1543303263662;
 Mon, 26 Nov 2018 23:21:03 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 26 Nov 2018 23:20:53 -0800
X-Gmail-Original-Message-ID: <CAGp9LzqF7odHdOk85Z=iVG2ecuDcKXwod=9r0Kh2CDeZWZiK=g@mail.gmail.com>
Message-ID: <CAGp9LzqF7odHdOk85Z=iVG2ecuDcKXwod=9r0Kh2CDeZWZiK=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mt7621: report failure of devm_kasprintf()
To:     hofrat@osadl.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        sergio.paracuellos@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Mc Guire <hofrat@osadl.org> =E6=96=BC 2018=E5=B9=B411=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:13=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> kasprintf() may return NULL on failure of internal allocation thus the
> assigned  label  is not safe if not explicitly checked. On error
> mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> (unlikely) failure case should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Sean Wang <sean.wang@kernel.org>

> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> ---
>
> V2: The dev_err() for the unlikely case of the devm_kasprintf()
>     failing was removed on request from Bartosz Golaszewski
>     <bgolaszewski@baylibre.com>
>
> Problem located with experimental coccinelle script
>
> Patch was compile tested with: omega2p_defconfig, SOC_MT7621=3Dy,
> GPIOLIB=3Dy, GPIO_MT7621=3Dy
>
> Patch is against 4.20-rc3 (localversion-next is next-20181121)
>
>  drivers/gpio/gpio-mt7621.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> index d72af6f..1ec95bc 100644
> --- a/drivers/gpio/gpio-mt7621.c
> +++ b/drivers/gpio/gpio-mt7621.c
> @@ -244,6 +244,8 @@ mediatek_gpio_bank_probe(struct device *dev,
>         rg->chip.of_xlate =3D mediatek_gpio_xlate;
>         rg->chip.label =3D devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
>                                         dev_name(dev), bank);
> +       if (!rg->chip.label)
> +               return -ENOMEM;
>
>         ret =3D devm_gpiochip_add_data(dev, &rg->chip, mtk);
>         if (ret < 0) {
> --
> 2.1.4
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
