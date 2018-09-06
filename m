Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505C5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DAA20861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w/czHqeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DAA20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeIFFQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbeIFFQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:16:05 -0400
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4AC82086C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Sep 2018 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536194602;
        bh=w8kUUAnmV58kQf7B7pTNmPrDU1fK+tzpRlvHYRVHCbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w/czHqebmzF4KXeOEyVlKo3ipEq8hVZ5VyYNrOOcDNyQ+eauhl2M5V5I9DC7ADTsd
         WwK5AaciO5ni6OXzDP6vsSxVLZj0Wfv0O3n60Zd8IaQ3gdgKjsqxNfNxGN+lVgLHD4
         7lPHuJf+DuC4SHdS0Nd40LZINWNfctO78dDPTwO8=
Received: by mail-wm0-f45.google.com with SMTP id j25-v6so15248139wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:43:22 -0700 (PDT)
X-Gm-Message-State: APzg51Du06Z3aeu4HEDORZXtweSSRF1Qjgq4nKAwxgflDxAbj+XTzcZ/
        zsEN41AW0GBBI1hUss0L6EOeBsshk0iC4XPiNH0yIQ==
X-Google-Smtp-Source: ANB0VdZQ2/5mCBMBFJaOWd9noBnSFzckJ6ujfYrqNJw4+hSI9yeXzw9/EoKS0E/KAJZgmen7k4BeheUKc+0miEgwksI=
X-Received: by 2002:a1c:780c:: with SMTP id t12-v6mr457102wmc.133.1536194601132;
 Wed, 05 Sep 2018 17:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <62dae1828ade759584bbf1507fe4a9e69d247a50.1536138304.git.ren_guo@c-sky.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 19:43:10 -0500
X-Gmail-Original-Message-ID: <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
Message-ID: <CABGGiswB5OUU7JDP+-s3s8ONkXZY2AAvSijQedsNtZ6p8LqZeA@mail.gmail.com>
Subject: Re: [PATCH V3 21/26] dt-bindings: interrupt-controller: C-SKY APB intc
To:     ren_guo@c-sky.com
Cc:     linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 7:10 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../interrupt-controller/csky,apb-intc.txt         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> new file mode 100644
> index 0000000..faa482c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
> @@ -0,0 +1,45 @@
> +==============================
> +C-SKY APB Interrupt Controller
> +==============================
> +
> +C-SKY APB Interrupt Controller is a simple soc interrupt controller
> +on the apb bus and we only use it as root irq controller.
> +
> + - csky,apb-intc is used in a lot of csky fpgas and socs, it support 64 irq nums.
> + - csky,dual-apb-intc consists of 2 apb-intc and 128 irq nums supported.

Can't this be described in DT as 2 csky,apb-intc nodes?

> + - csky,gx6605s-intc is gx6605s soc internal irq interrupt controller, 64 irq nums.
> +
> +=============================
> +intc node bindings definition
> +=============================
> +
> +        Description: Describes APB interrupt controller
> +
> +        PROPERTIES
> +
> +        - compatible
> +                Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,apb-intc"
> +                                   "csky,dual-apb-intc"
> +                                   "csky,gx6605s-intc"
> +        - interrupt-cells

#interrupt-cells

> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be <1>

No edge or level configuration?

> +       - reg
> +               Usage: required
> +               Value type: <u32 u32>
> +                Definition: <phyaddr size> in soc from cpu view
> +        - interrupt-controller:
> +                Usage: required
> +
> +Examples:
> +---------
> +
> +       intc: interrupt-controller {

Needs a unit-address.

> +               compatible = "csky,apb-intc";
> +               #interrupt-cells = <1>;
> +               reg = <0x00500000 0x400>;
> +               interrupt-controller;
> +       };
> --
> 2.7.4
>
