Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 794E0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2595520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3J9Dt5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2595520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935984AbeFMPmP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:42:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37308 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935833AbeFMPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:42:12 -0400
Received: by mail-it0-f65.google.com with SMTP id l6-v6so4493799iti.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0xAIbz2tG9tDDH2LH/Ed8U/z75Tx/lFVkcKnqYSPoMQ=;
        b=k3J9Dt5PkMjniE43ArhDhXZc2N9TEl5ESA2QD1h8Ds7xkjNSnjrrQyPxOiOt63vP+T
         PgVl2DUyz2bIZ4RpHLkC6d9GKR5R1ZjEEB7nbI6ZzE+imqSlT+UcPuWeOAoP+7TNHIv8
         0cim1shFI0RVaXxFdudQuJgzv8vmTynty5aB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0xAIbz2tG9tDDH2LH/Ed8U/z75Tx/lFVkcKnqYSPoMQ=;
        b=n0R86pDSgxyL5ZVQO6wZayks3Cy4mGvK06scViLh/86Nsk2LRLy7mRvEzvPp6Gh4FH
         LJfdacvjfKmA9s0lkCtZuFgmVEHQr/fp1ERB8A/2l7CAziq62vOP/BvbSU4JmjLA8B6G
         9fA/yDuUItPMJWObQr6dnO5GsoEregwgij9xwa2EgukoN1HukI+awadiqQqNM1rxczbn
         b+pqJbCdwok+UXy/Q3koXqyWspAwSA8ToHzDQYHYygO1w/l3q1Z2KVWb+Jp6xVfo5eyP
         z2bLiGQRkOVVOceQzE0PPkYfAgbEGX9WX/sUxlBtk/oOiPlbwK9cTz4AhEDPzVb8lXaH
         yg/A==
X-Gm-Message-State: APt69E1bNmeK2OBUp+gxzD1k8uFHhekhwJIgSWeQqfcdzKAYpxZAnSEI
        0NEauQ3fGR5xuYNZoOqFFmf0hJ5Mh7eKeczuvYs06g==
X-Google-Smtp-Source: ADUXVKIdfOKqoT+OCCmc3HavkQDIdAfdxO4le7orqtzNJLBgEli9QyDV+3YYDOkIACvrlA5RHL+mfFzp2d0Zo+AnBh0=
X-Received: by 2002:a24:3105:: with SMTP id y5-v6mr5186791ity.138.1528904532209;
 Wed, 13 Jun 2018 08:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:42:11
 -0700 (PDT)
In-Reply-To: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Jun 2018 17:42:11 +0200
Message-ID: <CAKv+Gu-LkJBa+QKwROqWApfKHjZ8huDYPi9FanU2AhKECv=dog@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] efi/fb: Simplify fixup code to prefer struct resource
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
> Get rid of base and size variables in favor of a struct resource.
> The conditional for checking window can be replaced with
> resource_contains().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/video/fbdev/efifb.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 46a4484..6daac8d 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -426,17 +426,20 @@ static void record_efifb_bar_resource(struct pci_dev *dev, int idx, u64 offset)
>
>  static void efifb_fixup_resources(struct pci_dev *dev)
>  {
> -       u64 base = screen_info.lfb_base;
> -       u64 size = screen_info.lfb_size;
> +       struct resource screen_res = {
> +               .start = screen_info.lfb_base,
> +               .end = screen_info.lfb_base + screen_info.lfb_size - 1,
> +               .flags = IORESOURCE_MEM,
> +       };
>         int i;
>
>         if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
>                 return;
>
>         if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -               base |= (u64)screen_info.ext_lfb_base << 32;
> +               screen_res.start |= (u64)screen_info.ext_lfb_base << 32;
>
> -       if (!base)
> +       if (!screen_res.start)
>                 return;
>
>         for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
> @@ -445,8 +448,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>                 if (!(res->flags & IORESOURCE_MEM))
>                         continue;
>
> -               if (res->start <= base && res->end >= base + size - 1) {
> -                       record_efifb_bar_resource(dev, i, base - res->start);
> +               if (resource_contains(res, &screen_res)) {
> +                       u64 win_offset =  screen_res.start - res->start;
> +
> +                       record_efifb_bar_resource(dev, i, win_offset);
>                         break;
>                 }
>         }
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
