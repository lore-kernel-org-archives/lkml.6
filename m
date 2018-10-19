Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BEEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A20420869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuWMGrna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A20420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeJTExw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbeJTExw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:53:52 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C79621476;
        Fri, 19 Oct 2018 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539981969;
        bh=KtDel/ZHHd/BUBoAB/LL1/KWAd74w36v51PrmtIIIkQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WuWMGrnamerbaMAFKKjF3L3lr7D8zYx2dPs/2wGFeFiJYGnGTjLA1WOZGvUDVDNUo
         JPawMAhj8HLSBakxdn+u9v69VV7Q8N/bloz+On5928sNtzTcbOl18dqWzRWH0DQ8RT
         F1rQgY4WRDZnfO6w12R/OZSpVVe0V4SSWYI1XTgs=
Received: by mail-qt1-f171.google.com with SMTP id j46-v6so39853483qtc.9;
        Fri, 19 Oct 2018 13:46:09 -0700 (PDT)
X-Gm-Message-State: ABuFfogpk2ijc2GljJQvpEX62ZvqpGWcWRxEd89SOZJDEOOKlRSo3Q/I
        WX0lSWjJzlkb/CyJguVzBoPznYEZVtWYdeNJ8g==
X-Google-Smtp-Source: ACcGV63TcOLG9K6e2N45hwpngnZqwcDEdM85U4M6pmMhrdKiUOfyhqlKL2qMID1pi37TOo9/Z/5XJXfkWIVxZsfsiRU=
X-Received: by 2002:ac8:2d33:: with SMTP id n48-v6mr33372959qta.38.1539981968661;
 Fri, 19 Oct 2018 13:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181019184827.12351-1-paul.walmsley@sifive.com> <20181019184827.12351-2-paul.walmsley@sifive.com>
In-Reply-To: <20181019184827.12351-2-paul.walmsley@sifive.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 19 Oct 2018 15:45:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
Message-ID: <CAL_JsqJBSqaxnETdJg1Mdp+H2ay+WKT0JaxLe6D4Fwo_99qUkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: add documentation for the
 SiFive UART driver
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 1:48 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Add DT binding documentation for the Linux driver for the SiFive
> asynchronous serial IP block.  Nothing too exotic.
>
> Cc: linux-serial@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> new file mode 100644
> index 000000000000..8982338512f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> @@ -0,0 +1,21 @@
> +SiFive asynchronous serial interface (UART)
> +
> +Required properties:
> +
> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"

I assume once again, the last '0' is a version? As I mentioned for the
intc and now the pwm block bindings, if you are going to do version
numbers please document the versioning scheme. Palmer mentioned the
compatible string is part of the IP block repository? Where does the
number come from? What's the next version? Major vs. minor versions?
ECO fixes? Is the version s/w readable? How do you ensure it gets
updated? All that should be addressed.

Otherwise, don't do version numbers because we have no visibility to
what they mean.

> +- reg: address and length of the register space
> +- interrupt-parent: should contain a phandle pointing to the SoC interrupt
> +    controller device node that the UART interrupts are connected to

Don't need to document interrupt-parent here.

> +- interrupts: Should contain the UART interrupt identifier
> +- clocks: Should contain a clock identifier for the UART's parent clock
> +
> +
> +Example:
> +
> +uart0: serial@10010000 {
> +       compatible = "sifive,uart0";
> +       interrupt-parent = <&plic0>;
> +       interrupts = <80>;
> +       reg = <0x0 0x10010000 0x0 0x1000>;
> +       clocks = <&prci PRCI_CLK_TLCLK>;
> +};
> --
> 2.19.1
>
