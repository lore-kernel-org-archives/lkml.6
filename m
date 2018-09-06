Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7EE2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPtf+iGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7EE2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIFFSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 01:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeIFFSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 01:18:08 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105EF20869
        for <linux-kernel@vger.kernel.org>; Thu,  6 Sep 2018 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536194725;
        bh=tmi7tUwbTuglFSDc+paxPWYyLHwVb72GNy9bUempHn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lPtf+iGIY3l7jwMbdZ9yO6RCSyq7ECccUWUTPR7yIbR2g7mNfo9se1Xejyx/1dnMa
         T4Gmb/0bC/F+bCAkREs720E2YUDHRAnn2xL4IY5f13WP9A9iAeEkGVV0EV6GyV+oN+
         9bfbYzMhja28nS1ChOfSNX2a49HvK7t/MNycK3BI=
Received: by mail-wr1-f41.google.com with SMTP id n2-v6so9470039wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:45:24 -0700 (PDT)
X-Gm-Message-State: APzg51C1eLDgNdYrPh2M6vDVqMZDtihy5frmLRa9/oRE/s+is2yMa0eS
        VWXGIIoE3LhfduFFSJkMZlNn0oU7LG7kH3+oBLM3vg==
X-Google-Smtp-Source: ANB0VdbAid2WtIQxFTuVbmNuLtgagQn2mgrEwjSund9OcrMEa7YNq3+xHbb4SrHv14bctk9itIrGgSS7oDLJy6DMCCI=
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr183743wrv.194.1536194723562;
 Wed, 05 Sep 2018 17:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
In-Reply-To: <a82f72fd77a6c06d23e6d08acc9df2a816d6235d.1536138304.git.ren_guo@c-sky.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 19:45:12 -0500
X-Gmail-Original-Message-ID: <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
Message-ID: <CABGGiszOxskc_V1E8A4i34OWSUdOSVX-QSRrgG+NjTbashND_g@mail.gmail.com>
Subject: Re: [PATCH V3 22/26] dt-bindings: interrupt-controller: C-SKY SMP intc
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

On Wed, Sep 5, 2018 at 7:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> new file mode 100644
> index 0000000..49d1658
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> @@ -0,0 +1,40 @@
> +===========================================
> +C-SKY Multi-processors Interrupt Controller
> +===========================================
> +
> +C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
> +SMP soc, and it also could be used in non-SMP system.

How is it accessed? No mmio registers?

> +
> +Interrupt number definition:
> +
> +  0-15  : software irq, and we use 15 as our IPI_IRQ.
> + 16-31  : private  irq, and we use 16 as the co-processor timer.
> + 31-1024: common irq for soc ip.
> +
> +=============================
> +intc node bindings definition
> +=============================
> +
> +       Description: Describes SMP interrupt controller
> +
> +       PROPERTIES
> +
> +        - compatible
> +               Usage: required
> +                Value type: <string>
> +                Definition: must be "csky,mpintc"
> +        - interrupt-cells
> +                Usage: required
> +                Value type: <u32>
> +                Definition: must be <1>
> +        - interrupt-controller:
> +                Usage: required
> +
> +Examples:
> +---------
> +
> +       intc: interrupt-controller {
> +               compatible = "csky,mpintc";
> +               #interrupt-cells = <1>;
> +               interrupt-controller;
> +       };
> --
> 2.7.4
>
