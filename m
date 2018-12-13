Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB7C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B750B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="b5689v4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B750B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeLMBD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:03:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44451 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:03:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so189527qkh.11;
        Wed, 12 Dec 2018 17:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQnSjrIxTixXwLTStkoYLZJT914baaGl9zND4iaAbc0=;
        b=b5689v4l7oJV3KVYE9at/KddQJFus/+9BLl2yZfFfmtabSB07o3GKXcpb46LVH5bGG
         xd5HphM88IhhlKgqkWmVMKTnAN9R3NUCdomcxHi4ODvgxmp4XAjt2rPGBI4+sOSGoCrq
         CeLmVXCNJHB2LPoLLtbXfLboNlLfWi5dP8yy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQnSjrIxTixXwLTStkoYLZJT914baaGl9zND4iaAbc0=;
        b=qdwagqzUelEo2zHrxUaceqDsALnZRvxPvU8/9eWVKIHSs3+V8Su3eFMDCSYkZptM+0
         SEQ4M64MFwl3fjwWTrNDaVMrPKsK7Db0eUQgiFJhAMhW3dsh/gj19fKABGqM7TnQVgUA
         1NfkOKLVdlHiTTrWt7KFm6S/dyzwhtZh3MpjcMk1bMIG78hv4rWfDQ4fkxxizZPFXWBb
         rWmWU3OmQ4yb3dCQPOOcL+O7gzHYqqId3sSAl/8r73fFPfjLldlPVaXUfYyt9K8/ESbd
         1hFGXMnaBt+JR5AnA6YgVpxLUT9D8HqfX2Hywc6aRlkzmeRvZayeKnqhQQeEGdVWhbCB
         bXzg==
X-Gm-Message-State: AA+aEWZ9oKqZTAmrTFuurhUiAZczNDEuDkbel3RlqAhR3NUUnCy/1hKH
        Nl+Ep/sHDAgBP6BA0046i5z5Xd2+GQbIUuR/loAjYFxUN8U=
X-Google-Smtp-Source: AFSGD/VCefxwXHN5No6O2mLto7MBnUhABIT6+dIL9Ok0vAnGUnMqbCJmeZY4LWnj3iMZOgniWVBpyn5o5gg5NZVr1dM=
X-Received: by 2002:a37:a391:: with SMTP id m139mr185981qke.11.1544663035966;
 Wed, 12 Dec 2018 17:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20181212210352.1717617-1-vijaykhemka@fb.com>
In-Reply-To: <20181212210352.1717617-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Dec 2018 11:33:44 +1030
Message-ID: <CACPK8Xea5Q1c9ygvT+WtbwJN9p2Nn-bLo8Ea6U4KuFvFZXvkNg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ARM: dts: aspeed: Add KCS & lpc ctrl for Facebook
To:     vijaykhemka@fb.com, Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 07:34, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device and lpc ctrl device to enable LPC clock in Facebook
> Tiogapass device tree.

As we're going to re-spin, it's a good idea to have the KCS and LPC
changes in separate patches. I will take the KCS one straight away,
but the LPC one might need more work (see my comments below).

>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  .../dts/aspeed-bmc-facebook-tiogapass.dts     | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> index d9d7f208788a..9544fa2c1822 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> @@ -21,6 +21,18 @@
>         memory@80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               flash_memory: region@98000000 {
> +                       no-map;
> +                       reg = <0x98000000 0x04000000>; /* 64M */
> +               };

Are you using this to expose some RAM over LPC? If not, we don't want this here.

It is a flaw in the design of the driver that the reserved memory
region is required. We should change the driver to make it optional.

As a workaround, we could add this patch to the tiogapass device tree
but make it smaller so you're not losing 64MB of RAM.

> +       };
> +
>         iio-hwmon {
>                 compatible = "iio-hwmon";
>                 oemname0 = "MB_P3V3";
> @@ -62,6 +74,12 @@
>         };
>  };
>
> +&lpc_ctrl {
> +       status = "okay";
> +       memory-region = <&flash_memory>;
> +       flash = <&spi1>;
> +};
> +
>  &uart1 {
>         // Host Console
>         status = "okay";
> @@ -75,6 +93,18 @@
>         status = "okay";
>  };
>
> +&kcs2 {
> +       // BMC KCS channel 2
> +       status = "okay";
> +       kcs_addr = <0xca8>;
> +};
> +
> +&kcs3 {
> +       // BMC KCS channel 3
> +       status = "okay";
> +       kcs_addr = <0xca2>;
> +};
> +
>  &mac0 {
>         status = "okay";
>
> --
> 2.17.1
>
