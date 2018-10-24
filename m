Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C261C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48E720834
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="efWK+m0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48E720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeJXWDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:03:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeJXWDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:03:53 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7957120834;
        Wed, 24 Oct 2018 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540388143;
        bh=5emZ9J66/F1lP3p/Mk/Hq2DE0MkGkgOYW3dNirbEsDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=efWK+m0IELpG/KGk2jsPNRU1RkGNHAB1LUFs4sVgWEBqK2JCy36TDYTg7RgTtdJFM
         iK8AfNMDnWKQA0g5fVwu3hwFloRRnmHPKv/smmZe04kMgz4+ySzyLjFox1lNtinVvR
         K5KQQVTDDGLERWPMhBLNmsHxidC3Fk8KOoBxp7OE=
Received: by mail-qt1-f178.google.com with SMTP id a10-v6so5711866qtp.2;
        Wed, 24 Oct 2018 06:35:43 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL8JfMGoPasF/pYCBVND82x3XRUHpkZXtLO8aZvjiK3ZKgUxfJR
        FEUwc9/BbOfz/fuPa0JkbDCdMXw0t9a6BS5++Q==
X-Google-Smtp-Source: AJdET5cuhkje0TfVkjCknF5cYuJLempAWBISflkyADnut1oiBRZfjnSpcG76/ZSkscTIgbj9heeGqtY9/SaXCbQd3LQ=
X-Received: by 2002:a0c:e004:: with SMTP id j4mr2466453qvk.90.1540388142648;
 Wed, 24 Oct 2018 06:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1540401136-78500-1-git-send-email-peng.hao2@zte.com.cn> <1540401136-78500-4-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540401136-78500-4-git-send-email-peng.hao2@zte.com.cn>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Oct 2018 08:35:31 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Bj2A8z=_vTr+sz4HGCSC8zN7VQkWL1inJYQ56JSkPNg@mail.gmail.com>
Message-ID: <CAL_Jsq+Bj2A8z=_vTr+sz4HGCSC8zN7VQkWL1inJYQ56JSkPNg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] misc/pvpanic : pvpanic: add document for
 pvpanic-mmio DT
To:     peng.hao2@zte.com.cn
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, hutao@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc DT list for bindings.

On Wed, Oct 24, 2018 at 4:01 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>

Commit message?

"dt-bindings: misc: ..." for the subject.

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  .../devicetree/bindings/arm/pvpanic-mmio.txt       | 29 ++++++++++++++++++++++

As Mark said, not ARM specific. So please move to bindings/misc/ and
use the compatible string for the name (qemu,pvpanic-mmio.txt).

>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/pvpanic-mmio.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/pvpanic-mmio.txt b/Documentation/devicetree/bindings/arm/pvpanic-mmio.txt
> new file mode 100644
> index 0000000..a6bdacd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/pvpanic-mmio.txt
> @@ -0,0 +1,29 @@
> +* QEMU PVPANIC MMIO Configuration bindings for ARM

Drop the "for ARM"

> +
> +QEMU's emulation / virtualization targets provide the following PVPANIC
> +MMIO Configuration interface on the "virt" machine.
> +type:
> +
> +- a read-write, 16-bit wide data register.
> +
> +QEMU exposes the data register to guests as memory mapped registers.

I have to wonder why we need a QEMU specific way to signal a panic.
What about every real platform that panics? What are they supposed to
do? Shouldn't this be a PSCI call so we can have something not per
platform?

> +
> +Required properties:
> +
> +- compatible: "qemu,pvpanic-mmio".
> +- reg: the MMIO region used by the device.
> +  * Bytes 0x0  Write panic event to the reg when guest OS panics.
> +  * Bytes 0x1  Reserved.
> +
> +Example:
> +
> +/ {
> +        #size-cells = <0x2>;
> +        #address-cells = <0x2>;
> +
> +        pvpanic-mmio@9060000 {
> +                compatible = "qemu,pvpanic-mmio";
> +                reg = <0x0 0x9060000 0x0 0x2>;
> +        };
> +};
> +
> --
> 1.8.3.1
>
