Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CCEC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BBA20824
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KICerZX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BBA20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJXTrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:47:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41411 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJXTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:47:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id i10-v6so925182oik.8;
        Wed, 24 Oct 2018 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRC71pANbsJQSJfop+JZfv2+94f2yTZ/DJjk/ocHqlk=;
        b=KICerZX64BfGVkLNaG4V+C973XAKHnIn6eYw6kFJcnYQ5y42ekMYX9ykUZJ+1FJbqH
         Unj2Jjze3rLFPwNKRYTgPaJrKI5BHl9L2qYMUdx5D5JxeWmGmzojOA2bsGCVJUuMOlu8
         RZCCQ0fdIByj83OYjxzLn9fQ4lqqlrERu6w3UBWtgAOdoBPT6ymhh0FAYWA75EuniEpp
         zdxLbaRXzRkmeKeS07D9/+JGdfEbKqzHZ8sTqGfF3DVZK+UVOTIa+OznMVSQhIjHw+hY
         VAVa1o9zOlGcOoAl4+Iat5mWmVe/SUu0ekIQggQ9wxkrMrhx5O6eK/KxrKwnDForOcjB
         cUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRC71pANbsJQSJfop+JZfv2+94f2yTZ/DJjk/ocHqlk=;
        b=l6LVU2m2+hWvZq+2ZO6MEZAtEomGj9Y/0Ar7qcdULasdaj2aWSUKHNRFOkzGlq8FwI
         oQd1+n0Ew4o+EfALOcVe5kra4+ihZE3Pm2amHX95NhAdS2iLYknFihNF0WBLLRH83MbL
         41DMsUsoZmW2RkCAYpzErVCkEY3aESPeK/Qmy9EGbtwwLMbFi+5Mvm2IBz7kr/+mWefy
         qCsMcTIRp38cxU9bKUJnpjqFwyOkir6geCxm4ZAFheqiAYtbNzSG1YXB4JmFHdcu7f1t
         JCMmbAfBcT02yOSXuw+aVGc6fem74J/8ZEA284BWSoic5rVAgd5VWX/xSLoKbrn9lix+
         YcFg==
X-Gm-Message-State: AGRZ1gKqcxNLoUGo07E6XXafwzw3/grhLrBHEqB+zCTBuHRE4czh/AXI
        q3x2hQaBRbl1ozMoV8xSmnxp8deGaDjbpxljFDg=
X-Google-Smtp-Source: AJdET5eAzQ4rQETEe9kNu9oClvlIV/1HkrORrJXGKZu+BSbLK7dALvArRxVrJXOWebhWy9cH7WSd6t8rNz+4go4872k=
X-Received: by 2002:aca:c7c9:: with SMTP id x192-v6mr1107091oif.43.1540379996413;
 Wed, 24 Oct 2018 04:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181024111213.2724-1-qiangqing.zhang@nxp.com> <20181024111213.2724-4-qiangqing.zhang@nxp.com>
In-Reply-To: <20181024111213.2724-4-qiangqing.zhang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 Oct 2018 08:19:53 -0300
Message-ID: <CAOMZO5Cm2U4dR982vYTmb5zfdjfXbQ95B+mDt2Fp8D-QtvT6FA@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] ARM: dts: sabreauto: Add flexcan support
To:     qiangqing.zhang@nxp.com
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joakim,

On Wed, Oct 24, 2018 at 8:15 AM Joakim Zhang <qiangqing.zhang@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
> new file mode 100644
> index 000000000000..963e0b559d60
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-sabreauto-flexcan1.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

You can remove this paragraph as you are using SPDX tag.

> +++ b/arch/arm/boot/dts/imx6q-sabreauto-flexcan1.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

Ditto.

> +&can1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flexcan1>;
> +       pinctrl-assert-gpios = <&max7310_b 3 GPIO_ACTIVE_HIGH>; /* TX */

This property does not exist in upstream.
