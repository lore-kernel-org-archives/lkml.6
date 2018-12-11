Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBE82081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciaQPK30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBE82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLKKPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:15:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40442 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:15:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so6427015pgp.7;
        Tue, 11 Dec 2018 02:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W9v4/JOJJhfuhTRGY6/yqsEFzrHxGZ2fNvJam328RWg=;
        b=ciaQPK30WtNNc9Z3amj0dqmVIJhxWsqAuRH4oroXdffoQlK8fFYD/vNaXeK2s0/2wp
         I+7SL57fi6atd/WFd6JKIXDOt+cXelJWzmzzyU8FMu7BsPQpa28i18rXSLOUzIdxlSb8
         x4L1EivZ+LPnzhIGFpI1LFcNFZyfSLAjEESbTDriIT5jIwMC5XZJptFJIJvRugDk7/y0
         hUT46pgKbScfTIN6Rf6TQ+MMaVcNyOB1lOq9gh18qip4nqc/uuDSelmRsidqqN0pd1So
         tJl3DRPnT2x/G+2blYNhJXZcPdu+r2XryoKEmSVdpYc4dlOcC64kzJcy2FMeShqHdURD
         wdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W9v4/JOJJhfuhTRGY6/yqsEFzrHxGZ2fNvJam328RWg=;
        b=RCp7tbFquBO5pwr/pY6rvtmSEOAogOamEK2+Mc+qJH6d14jp98kmg0ZGDFebvvSfbD
         P6OhginmTha8PNghAsJVNNgaEyBtAPqJ/DHQ9qLFRnw9p177Kk5MdDLVFXKQfpBDz/Ha
         Enga/D+TpkGDPgPPQc2Lq26mqjt6sLklNgAU2IJvVmYUqtfcjX1/CN1HzSv2/qQGeufa
         TML/n9RD9Z9JQcOwBv8bMtVLrqTEfcT2VIsM8svoK4OqMmS7f9qqtbx439bMl0mVc1kU
         aWDJImGqukyMiXDxlpZz5j/yJx6vKeJR/0X043RDUjOHsRgxtQB1BdpX6oew/XztCYJU
         xQCA==
X-Gm-Message-State: AA+aEWbktp6l9SqTej+auaV7++mXyRCdPkwymfLoYD0RoJb6k6qZsqna
        1flbnH2zzGu5OLTR5zIknGDeiZvbO1SL7HIwKvNkqkyJ
X-Google-Smtp-Source: AFSGD/XjGLgAjWBnlWA2JPZtcbY+XE0/aPXBL6wMAF7G1dV+v9w0Ry9Y7tDU586fZbZxF7L88qlaWGKUbaBHDgmVUJg=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr13899514pgh.265.1544523313114;
 Tue, 11 Dec 2018 02:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20181204092004.5033-1-hdegoede@redhat.com>
In-Reply-To: <20181204092004.5033-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Dec 2018 12:15:01 +0200
Message-ID: <CAHp75VfHQSih1Jr-yj29MZ7s-ZoOtZ66G_eKs2d43NVM9QuF3w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Mediacom
 Flexbook Edge 11
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:20 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add a DMI match for the Mediacom Flexbook Edge 11, this is the same hw
> as the Trekstor Primebook C11, so we use the same settings.
>

Pushed, thanks!

> Reported-by: rmbg <alexofrichardmilitiabg@hotmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 0faf3fd895e3..ac20797af9b1 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -686,6 +686,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_VERSION, "jumperx.T87.KFBNEEA"),
>                 },
>         },
> +       {
> +               /* Mediacom Flexbook Edge 11 (same hw as TS Primebook C11) */
> +               .driver_data = (void *)&trekstor_primebook_c11_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MEDIACOM"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
> +               },
> +       },
>         {
>                 /* Onda oBook 20 Plus */
>                 .driver_data = (void *)&onda_obook_20_plus_data,
> --
> 2.19.2
>


-- 
With Best Regards,
Andy Shevchenko
