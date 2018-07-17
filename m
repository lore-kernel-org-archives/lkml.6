Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45318ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sVQtISzH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZsjuopUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D697C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbeGQWym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:54:42 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:32818 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeGQWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:54:42 -0400
Received: by mail-ua0-f196.google.com with SMTP id i4-v6so1707016uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hD5CH1IWBFTh7urbsfaAhBZIEtaCLp1PeomeNx1jtwY=;
        b=sVQtISzHEgMyGyXMcO2mY/LtRqwn/t1G3BKnX9ZbZNJmuYPvdgkLM4xkiGZcWhvSsl
         rt+k+8AUb2F2yF+MVzIoMjxsQP7UGk8nfecq+vo2rAWaPp79kN9fhd3bGZYiJQaQys6S
         4K6cYZPMmgX9CoPf/ZNdaRX2u4rKdip9q8TaTaV+DWNN14nD0/Yg7Iilql1E8kcUXmHZ
         Hr3tbTtHeo3QqdtixfGsm83sRnORp/Kyh3Anf5savoP3bsuee3U4aj4SEQkXVL9JtoWc
         6mDGR9G2zG17jtMYQWFA2PNUXAYmORS+yoncEO+HIzs4cxxpjkoZdWrBv7CFEhsMWSlT
         ACZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hD5CH1IWBFTh7urbsfaAhBZIEtaCLp1PeomeNx1jtwY=;
        b=ZsjuopUneWyYX2c7lqvfkPY9vXYeVeVFV/JSibhS3sSI9+46HoQdcfB+L4dQhWIMWH
         CFnbbVDYhVKWCvBOyGZ06eAJbESIuWkxgzwA1LhMMkYhy4Adpsf8V7ej0Q8uOMCwo6hE
         QY4v2D00kcxTk2OLV4MNfeOjnkjcl3+1HD+Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hD5CH1IWBFTh7urbsfaAhBZIEtaCLp1PeomeNx1jtwY=;
        b=tHhhaWT9kQmlWXBFOit3T6xS/eYt41rrMm6n+3swl/BTnM2r5NR9IEo9Jl3k9sM/g4
         ATdMIPRvpOJB7snt9YIMUutRdlObzULMwq4w5k4UTgfVSh92WzVh4+qbnTBASUgDJAwx
         rAnYwemu40GX/x8788MKYRV5D3PQM3SM/J2R2pGZfsH4nu4FAAkV5Z3xN+XCIo2NTgxh
         VOi76cxSwHTfW7yx/g76oVPh0Wz8gAzU2vZmdnfGI3N3B1Xq9yumXmJ/p2l7CUl59zRX
         ahkJQikqTt3ZjvSCl+2qXkjt0ncj7Cu0r+voUrUrDd8P4O6JTIlN4OS55g67KST9NlvK
         8fBg==
X-Gm-Message-State: AOUpUlGi3YycJaGKRiFAFbANmMdG8FDiADIL6IHKHv01kLQSmaFYYVUF
        ngwlx3xKhJbrwOKqk8ELkGUi82mdqR6XhuMw9tlVqQ==
X-Google-Smtp-Source: AAOMgpfMq7mqPlBaLLdbs7VU09nWiMSGB6ofMN18SdE01yBhREYnSQQGodYJdMgjxdkemFYHQhOu/JM4nlZGGYUdn58=
X-Received: by 2002:ab0:4364:: with SMTP id k91-v6mr2357034uak.46.1531865996679;
 Tue, 17 Jul 2018 15:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 15:19:55 -0700 (PDT)
In-Reply-To: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Jul 2018 15:19:55 -0700
X-Google-Sender-Auth: eXUhOp8uphtV88cFlT2gDmI-h3Q
Message-ID: <CAD=FV=W1LA3XFDDhD7wZOWF2wLoGA1xTbKkXJDj0t_BE13J0BA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 2:46 PM, Girish Mahadevan <girishm@codeaurora.org> wrote:
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++++++++
>  err.txt                                            | 27 ----------------
>  2 files changed, 36 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
>  delete mode 100644 err.txt
>
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> new file mode 100644
> index 0000000..3baa893
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
> @@ -0,0 +1,36 @@
> +QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)
> +
> +QSPI [Quad Serial Peripheral Interface] allows single dual and quad read/write
> +access to slaves. QTI's QSPI controller implements the QSPI protocol to interface
> +with slaves like NOR Flash devices.
> +
> +Required properties:
> +- compatible:  Should contain:
> +               "qcom,qspi-v1"
> +- reg:         Contains the base register location and length
> +- interrupts:  Interrupt number used by the controller.
> +- clocks:      Contains the core and AHB clock names.
> +- clock-names: "core" for core clock and "iface" for AHB clock.
> +- spi-max-frequency:   Maximum SPI core clock frequency in Hz.
> +
> +SPI slave nodes must be children of the SPI master node and can contain
> +properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +Example:
> +
> +       qspi: qspi@7418000 {
> +               compatible = "qcom,qspi-v1";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x7418000 0x600>;
> +               interrupts = <0 459 0>;

Please use a more proper interrupts example, AKA:
    interrupts = <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>;


> +               clock-names = "iface", "core";
> +               clocks = <&clock_gcc clk_gcc_qspi_ahb_clk>,
> +                        <&clock_gcc clk_gcc_qspi_ser_clk>;

In upstream I believe that the clock #defines are usually in ALL CAPS.
Maybe good to use that in your example.  In the clock patches I'm
hoping to send up for SDM845, for instance, this will be:

clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
    <&gcc GCC_QSPI_CORE_CLK>;


> +
> +               device@0 {
> +                       compatible = "dummy_device";
> +                       reg = <x>; /* CS for the device */
> +                       spi-max-frequency = <f>; /* Max supported frequency of the slave (Hz) */

Since you are a Quad SPI controller, maybe you'd want your example to
include how to enable that?  AKA:

spi-tx-bus-width = <4>;
spi-rx-bus-width = <4>;


-Doug
