Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 542EDC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A724208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="beKGcUOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A724208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964847AbeFMPpv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:45:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33283 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964821AbeFMPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:45:49 -0400
Received: by mail-io0-f196.google.com with SMTP id d185-v6so3941505ioe.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WEawFZyDR19XfTU9gjRS8ft8Jn0so43fW4xZT66Xv0c=;
        b=beKGcUOd1DZ0CQqcoEloeevFNNL8LFBlv8yD55fmNYITyl4VBOikLNKe3Pmpmc1ZBr
         UXxqgTsnnYK431Tz03knjKzcBY8oPntwG5+51+DumzZwY8lMiWdQNnN4bN6JGidZREuq
         hiFhIGNmco8Voe8H/fb10W/1iCO2C5gqa6gKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WEawFZyDR19XfTU9gjRS8ft8Jn0so43fW4xZT66Xv0c=;
        b=gB3GGfsSzgwZbOcEuuEb+NSO3/TD2Q6zSS3ahFx4itDqfS9EXg8ATARLeuo22xTe/W
         /ibOKAeGZBKLazlxsWt2MAkImIH2RQz6+KESpK17RDCXglpPZ8Qyj4nfQ+jKogEU931f
         29lJqDTJbMGyrmTMozwcEj1pLIXHQlZeiedjTbwtQuhFPgxbL2vypaQuEorfk02soLNo
         1M3NBHiyiQ6WFHxvzahGxuVqTyyBzKhkuAP/74fe7f9x6BoH07pUwn39NzBNwfkjUAIE
         R0CuPWSItm7rmWraqsjmvFK7KzPF6w7as0Ay42o6rSggp1jQbjCBKAGz1vS5lgu4iC9J
         cdnA==
X-Gm-Message-State: APt69E3Mj0rrG1vLmFup31ZpGOBWivl0vGPCEqoZOSinxSwoIZtSMMwh
        5xRxxEOawHj7A3TiAD7W5xd6Quo6Lvy1ZcbuDjlmeQ==
X-Google-Smtp-Source: ADUXVKImiDiwTRKzB2V+A4Rzg/JwGYyIa5kgoTsSRKWSu/9PoFcSum4Wpj9euMp9UnTaiMy2cKADDtAmCoP0Vmlvg/s=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr5160663ioc.173.1528904748779;
 Wed, 13 Jun 2018 08:45:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:45:48
 -0700 (PDT)
In-Reply-To: <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org> <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Jun 2018 17:45:48 +0200
Message-ID: <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.
>
> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
>
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength=3200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Bartlomiej, could you please take these via the fbdev tree for v4.19?
Peter already gave his ack but Sinan dropped it (presumably because of
the split in v2)

Sinan, does this need to go to -stable? I.e., has it ever worked before?



> ---
>  drivers/video/fbdev/efifb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 6daac8d..429cc85 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>                 .end = screen_info.lfb_base + screen_info.lfb_size - 1,
>                 .flags = IORESOURCE_MEM,
>         };
> +       struct pci_bus_region region;
>         int i;
>
>         if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> @@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>         if (!screen_res.start)
>                 return;
>
> +       region.start = screen_res.start;
> +       region.end = screen_res.end;
> +       pcibios_bus_to_resource(dev->bus, &screen_res, &region);
> +
>         for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>                 struct resource *res = &dev->resource[i];
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
