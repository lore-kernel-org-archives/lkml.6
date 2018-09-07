Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D784C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD55620861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsfV7mIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD55620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIGPXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:23:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33475 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbeIGPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:23:48 -0400
Received: by mail-it0-f66.google.com with SMTP id j198-v6so22507599ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HIm926GvTLNI1YtEYht5Y2Bhr82Sga1WnTWGIac+3t8=;
        b=dsfV7mILJkG1WWiCS+AlUAaH7YkTNwndEsue3FcAk3P2yvcBGKNp5gbqJPPpVbsseM
         o4X5s4kBvwsPPhaGIPBwSioeT4kHNdWteoMoJtOwD+lMAcOrQCT//BBFOstiTrGjDsZI
         /bAbedBoXgt7i9FEnZT8Dw2bDbgbPG+IFcxFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HIm926GvTLNI1YtEYht5Y2Bhr82Sga1WnTWGIac+3t8=;
        b=TH3yVHsJ7x7NB473+ZMJm1si7Q95mznhToMiJWnjuKKWvqAg7QtsEEl3sgACHP5Fpw
         Nk38BKaLQNKt3OsouGeX/C7XMitVftxvjUFjS5DEPE5uGXQWF35kfM8ORLgLw+jgOeBk
         D1SIbt4WyQkHlyOWdZZo08khSNMGJnM4EYcIcFfFU2+vPL5lFh4DvHShDSdGtyIsMI1L
         cgOaLvW7ME37jyThrnRuR3pCNTivrga3sl0V/FuHVuSdpokREx+TtSNTeJkeQphthbIO
         pEMEVvaIEKgwjE/bzYwJeQWji4dss94mN+3trc5n6rWp1UJxBnnxw9M8Bk6/VbHJp1vr
         jg2A==
X-Gm-Message-State: APzg51CB7GIWJD+gOLQ0ZkRx/YPTLSDPrPapUsYJeKtQwmny0xdOirnB
        k67HK+kyUdCm/DZvcCwyShS4W6DxgtGz4Hwd114CkQ==
X-Google-Smtp-Source: ANB0VdbZn67z0K5d2Y/Jeod8NqeB3NSB9kWD2IQ69aRTCtVYiSmgd3wmtZgX9ZJ4XJaHpk5intxvgv7Fm13pj7jIEf0=
X-Received: by 2002:a02:1515:: with SMTP id j21-v6mr6203117jad.2.1536317005902;
 Fri, 07 Sep 2018 03:43:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 03:43:25 -0700 (PDT)
In-Reply-To: <20180906182927.22318-1-grant.likely@arm.com>
References: <20180906182927.22318-1-grant.likely@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Sep 2018 12:43:25 +0200
Message-ID: <CAKv+Gu_k5Yr-aRhE6atrtGQOVpw60XfevVdUb8BvH1G3mfoU+Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] efi_stub: update documentation on dtb= parameter
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>, nd <nd@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 September 2018 at 20:29, Grant Likely <grant.likely@arm.com> wrote:
> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Reviewed-by: Alexander Graf <agraf@suse.de>
> Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
> Acked-by: Olof Johansson <olof@lixom.net>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>
> Resending because original post included Arm corporate disclaimer.
>
>  Documentation/efi-stub.txt | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/efi-stub.txt b/Documentation/efi-stub.txt
> index 41df801f9a50..833edb0d0bc4 100644
> --- a/Documentation/efi-stub.txt
> +++ b/Documentation/efi-stub.txt
> @@ -83,7 +83,18 @@ is passed to bzImage.efi.
>  The "dtb=" option
>  -----------------
>
> -For the ARM and arm64 architectures, we also need to be able to provide a
> -device tree to the kernel. This is done with the "dtb=" command line option,
> -and is processed in the same manner as the "initrd=" option that is
> +For the ARM and arm64 architectures, a device tree must be provided to
> +the kernel. Normally firmware shall supply the device tree via the
> +EFI CONFIGURATION TABLE. However, the "dtb=" command line option can
> +be used to override the firmware supplied device tree, or to supply
> +one when firmware is unable to.
> +
> +Please note: Firmware adds runtime configuration information to the
> +device tree before booting the kernel. If dtb= is used to override
> +the device tree, then any runtime data provided by firmware will be
> +lost. The dtb= option should only be used either as a debug tool, or
> +as a last resort when a device tree is not provided in the EFI
> +CONFIGURATION TABLE.
> +
> +"dtb=" is processed in the same manner as the "initrd=" option that is
>  described above.
> --
> 2.11.0
>
