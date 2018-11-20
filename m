Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B6C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD96420831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD96420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeKTSfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:35:48 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36863 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTSfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:35:47 -0500
Received: by mail-vk1-f194.google.com with SMTP id u62so211608vkb.3;
        Tue, 20 Nov 2018 00:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/NzGAtWOo6r/kd1EgAzjZ9E9JLoC9aZ9LqLBnKlFzg=;
        b=OtwHoSS+QCFqTKYc+rwjtkagw08bD3wJdtKo4ofXbXSVjpwesaKxYnjlcbNAYQY1Xq
         i/7hJ+6380wT4YIn0W7UnvkpPifbXOJznecWnGBAb9xQmwEE8jVumnvrRPLnRy0GXbmz
         nEhSRO6UVM4C4TpIheVsjl4mA4tVWI0ceLUP8Gptwjgep3GRpouPOGrrYC//lstOsYL2
         KdOb1hudY3ngBb/KkUFltwa88kIT3R8h9D0Q5JcHORymwgpCRSLbtiObWqIOpK+4S2df
         vgobXSzSB1UfcyWJqg4u5J/J9eNr+UKC1qw7vAYUhvigeWcknkCgl+1w6sxZFxcIgRwF
         7SOA==
X-Gm-Message-State: AA+aEWYWVrolLwvbu5ZXIPp0yAjFNvZ9F2wwbWMiDIQ+gcZkOOt2ODMq
        yCxiEKUCRH03HXmjjA/i/fxJMbo/RZR7Dvq4yD4=
X-Google-Smtp-Source: AFSGD/U8VN9UdaZSHhL5BxzLUzpooSMVvpYt2G0Fj6oI/537vpc5yNbgXwodxx9a7LGTKgo/YooHYoHzU37sEVOeAHM=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr411358vkd.74.1542701278174;
 Tue, 20 Nov 2018 00:07:58 -0800 (PST)
MIME-Version: 1.0
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw> <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Nov 2018 09:07:44 +0100
Message-ID: <CAMuHMdXhx2iudXaPQto-c1kYAYdKc1T9vMr5yYNqONJwoNmRCw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC
 controller bindings
To:     masonccyang@mxic.com.tw
Cc:     Mark Brown <broonie@kernel.org>, Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Mon, Nov 19, 2018 at 11:02 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Document the bindings used by the Renesas R-Car D3 RPC controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,33 @@
> +Renesas R-Car D3 RPC controller Device Tree Bindings

R-Car Gen3

> +----------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "renesas,rpc-r8a77995"

Please use "renesas,r8a77995-rpc".

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area
> +- reg-names: should contain "rpc_regs" and "dirmap"
> +- interrupts: interrupt line connected to the RPC SPI controller
> +- clock-names: should contain "clk_rpc"
> +- clocks: should contain 1 entries for the CPG Module 917 clocks

... for the module's clock

> +
> +Example:
> +
> +       rpc: spi@ee200000 {
> +               compatible = "renesas,rpc-r8a77995";
> +               reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
> +               reg-names = "rpc_regs", "dirmap";
> +               clocks = <&cpg CPG_MOD 917>;
> +               clock-names = "clk_rpc";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

power-domains?
resets?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
