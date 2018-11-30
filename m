Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E847AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD34720868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eea+h0pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD34720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLAHY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:24:28 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36598 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAHY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:24:28 -0500
Received: by mail-yw1-f66.google.com with SMTP id y194so2802796ywg.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3S5Pic8NtYPq/wIop2r0+pCeXOwXoxVoxdyrK4c+4g=;
        b=eea+h0pdrQuuYivxgDW6Jqa0Llin2+c3V9nerXwEXt71y3Tig4Wkg8sTPwSDDIczaF
         /C+DKanFBlAsxyPOMtanmXp81NsatwXN5cJrmRqEj3kwo0W/Ym6PLdauAge/9OovqOd5
         gV2RhBd9vMOywPfFqIADk0fKXBXL9hgrqN1wMlzRS04Uh2Z6K0GjQC7qf9CO3WOwIQGV
         hTlKnTW5AvUN6YRLv8LXI+PVJQ6sFurQ6GUnGRwRuSSDvmqw9602EhsiXJ053eZLHzDl
         biDnQqnYWmpsmJIBIaJtfuHxqToUYTlQoqQ9RP43pq4b8co57qrRIG0oVFHa2pa7RKpR
         I3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3S5Pic8NtYPq/wIop2r0+pCeXOwXoxVoxdyrK4c+4g=;
        b=AA5LfRIr6DsFiKR1gbtB6xWjMAoGy7vu7qTkasirN+vPk7BfZ7VfcQ3OXFGlVeWp9I
         ajj4AlGmNoQrNA4bWapfaHrc2n/R/soS8fFQlKSyiB5ByRUiAZO4X2Y5YwcPlWkEhdf1
         S8jF6/qIjLBg8dd/vuJOxC/BDG4YBfQKXjQvAfA3STCZnIBxv3xdqjBPF8k7aeN1keez
         a5I245bO81hbX7T7+emvZWA4ClZ8gEzny5GM7dzJkiuXLRqsMp2vUbDlY5FjcvmUho0K
         w0RGxUx9EEnV0t4rC5PsD2U0s+/Kdc+5bUYzesgK7oe7Yx47W+c0qyVjuDQ92DSq+6MO
         8T6Q==
X-Gm-Message-State: AA+aEWbU0V0gepE4g4SCmzr7rfd57v+3Mu3o5alBrulOpBVetgci263P
        7s8lPeQGhn7raXnBESo0Tc7zovA12YUybnGEKB8=
X-Google-Smtp-Source: AFSGD/XjhFZNzJQv1MxsfoZqLJFmmZQTAmmDbkMG7BoeL7hHdhjZLNmnTOUYP9B7ooY8NmjHfiKISTSed69MAQaxvN0=
X-Received: by 2002:a81:e30b:: with SMTP id q11mr7265961ywl.490.1543608841666;
 Fri, 30 Nov 2018 12:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-4-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20181130192737.15053-4-jarkko.sakkinen@linux.intel.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Fri, 30 Nov 2018 18:13:50 -0200
Message-ID: <CA+ToGPHBNg7k3uT8yrgWuPgD113Sd44TZamYd7j=f_X2idej6Q@mail.gmail.com>
Subject: Re: [PATCH RFC 03/15] drm/nouveau: replace **** with a hug
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, bskeggs@redhat.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 5:30 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c        | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> index 9cc10e438b3d..55a0060881ea 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> @@ -446,7 +446,7 @@ init_ram_restrict(struct nvbios_init *init)
>  {
>         /* This appears to be the behaviour of the VBIOS parser, and *is*
>          * important to cache the NV_PEXTDEV_BOOT0 on later chipsets to
> -        * avoid fucking up the memory controller (somehow) by reading it
> +        * avoid hugging up the memory controller (somehow) by reading it
>          * on every INIT_RAM_RESTRICT_ZM_GROUP opcode.
>          *
>          * Preserving the non-caching behaviour on earlier chipsets just
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> index 3737bd27f74e..ee364c71cc2e 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
> @@ -46,7 +46,7 @@
>  #define NV_PPWR_INTR_EN_SET_SUBINTR                                  0x00000800
>  #define NV_PPWR_INTR_EN_SET_WATCHDOG                                 0x00000002
>  #define NV_PPWR_INTR_EN_CLR                                              0x0014
> -#define NV_PPWR_INTR_EN_CLR_MASK                    /* fuck i hate envyas */ -1
> +#define NV_PPWR_INTR_EN_CLR_MASK                    /* hug i hate envyas */ -1

Can you also capitalize the "i" please?

Thanks,
Diego
