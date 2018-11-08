Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06139ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C854D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKHXrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:47:19 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36208 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHXrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:47:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id o125so26634854qkf.3;
        Thu, 08 Nov 2018 06:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3h+/TmjXAwBioDeAEfts2CcghM88XUbwzj81+sRc5Y=;
        b=TDB17Z6cm6JPxNwtn9M41egje/LRvtfSdd95/MaG1P3WEpdxQT3vn1lMc4Z8LanpQb
         MGAZg/nuUd1C3q60TG+vIYnCO5a74dN9BelvtxHvYS265arm9cOGyQeH3nIUW+2nx9z1
         k5hWjICBB1rkKwgEqAHpfoz25Q13vO9bHbgbq10MPf0awtdoxlCADk1MAQXG5mVt/cyz
         BwYmQiecwX1FcvTVXf8srrjV7ivkc/Nh5a86ZiagDRglJjTIlFBF9O15N68kIPEvK2XN
         XoVyJTKw/7Mf5pwkaiPR4Xbd6KWEo3AEDRMTVT4UWJMfVCiIssHJxmT6Wtt7BiA8RF80
         tJFw==
X-Gm-Message-State: AGRZ1gJ566l5WjKRSR3L53+eFgtykZj1gMEFUC8Ryt8s7MZ1VKYncuuN
        m38poDQI+pE8OfEy/KQXdONilr4THCfno8kodfo=
X-Google-Smtp-Source: AJdET5eHHLLnJptRavWaJ39Hbe5nq0PLvlR/imHnLzWAYTCXdWIvCtxWyCWHFbeI4kNg4F8S8JWqeCYeQL+gya/Yfss=
X-Received: by 2002:a37:324a:: with SMTP id y71mr4304902qky.291.1541686298291;
 Thu, 08 Nov 2018 06:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com> <20181104155501.14767-6-TheSven73@googlemail.com>
In-Reply-To: <20181104155501.14767-6-TheSven73@googlemail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 15:11:22 +0100
Message-ID: <CAK8P3a1ZUaxJzfzYoqAK+_ZBazHzF6nG1V2aiZSoiQr6nDhiSQ@mail.gmail.com>
Subject: Re: [PATCH anybus v3 5/6] dt-bindings: anybuss-host: document
 devicetree binding
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 4:55 PM <thesven73@gmail.com> wrote:


> ---
>  .../bindings/bus/arcx,anybuss-host.txt        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
>
> diff --git a/Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt b/Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
> new file mode 100644
> index 000000000000..5c28e4e09bb2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/arcx,anybuss-host.txt
> @@ -0,0 +1,36 @@
> +* Arcx Anybus-S host
> +
> +This host communicates with the SoC over a parallel bus. It is
> +expected that its Device Tree node is specified as the child of a node
> +corresponding to the parallel bus used for communication.
> +
> +Required properties:
> +
> +  - compatible : The following string:
> +        "arcx,anybuss-host"
> +
> +  - reg : bus memory area where the Anybus-S host dpram is located.
> +
> +  - interrupts : interrupt connected to the Anybus-S host interrupt line.
> +       Generic interrupt client node bindings are described in
> +               interrupt-controller/interrupts.txt
> +
> +  - resets : the reset line associated with the Anybus-S host.
> +
> +Example of usage:
> +
> +This example places the Anybus-S host on top of the i.MX WEIM parallel bus, see:
> +Documentation/devicetree/bindings/bus/imx-weim.txt

To allow describing connected devices, I think we need a #address-cells
and #size-cells property here, with fixed values. If a device is attached by
a single 32-bit integer, then

 #address-cells = <1>;
 #size-cells = <0>;

should be enough, otherwise you might need additional address cells.
Actually listing the device(s) can be optional, but we do need the
adress in order
to let the bus code associate a device_node pointer with the child
device structure to let a driver read the properties.

       Arnd
