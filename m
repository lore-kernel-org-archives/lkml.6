Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2821EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39A62154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vjdfK774"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39A62154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeHBWzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeHBWzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:55:21 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FE6215E5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Aug 2018 21:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533243749;
        bh=scTAeqhZUouX6gsn9zqR1xxJqYbgHQP0pD+FlHvv4Mo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vjdfK774oFdtL0l1TRJ1xtqQ7MC+vb7lRr8/UCrmDq/g+qe65mFwhVhnGwly35QAX
         C288LoaBIEBWy65oYTT0i42jVZUgobcmZIiyppKZ4BZEruJU92lQ9cBNkUOnr3hEgu
         M55D+0ptjsIq/rf+sEvTHA8rhbbCwa3QEgq3Qhbw=
Received: by mail-wm0-f52.google.com with SMTP id y9-v6so4087364wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 14:02:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlFxQBIMhs86BY45rLTlDVyFMp4W70L0J2huZpZdl8y1BcolMcpM
        8oFA/uyYlakqDBQyu4bwLOR6dAtch68aQ11VJAPbLw==
X-Google-Smtp-Source: AAOMgpcfgXx9MhuIgAzNwK840dlf3Srmi13SR6UxPN+9dWuY5mNk5pPj3whJQnnO4JkCjhO+xjJhIxdD+p38kfMvPcs=
X-Received: by 2002:a1c:c241:: with SMTP id s62-v6mr3143327wmf.146.1533243747674;
 Thu, 02 Aug 2018 14:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180731161340.13000-1-georgi.djakov@linaro.org> <20180731161340.13000-3-georgi.djakov@linaro.org>
In-Reply-To: <20180731161340.13000-3-georgi.djakov@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Aug 2018 15:02:16 -0600
X-Gmail-Original-Message-ID: <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
Message-ID: <CABGGisxq+hf91R18pnZ=VZ9f99GssWWPhpPCjNAROJmKg5-udA@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] dt-bindings: Introduce interconnect provider bindings
To:     georgi.djakov@linaro.org, maxime.ripard@bootlin.com
Cc:     linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>, khilman@baylibre.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        skannan@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> This binding is intended to represent the interconnect hardware present
> in some of the modern SoCs. Currently it consists only of a binding for
> the interconnect hardware devices (provider).

If you want the bindings reviewed, then you need to send them to the
DT list. CC'ing me is pointless, I get CC'ed too many things to read.

The consumer and producer binding should be a single patch. One is not
useful without the other.

There is also a patch series from Maxime Ripard that's addressing the
same general area. See "dt-bindings: Add a dma-parent property". We
don't need multiple ways to address describing the device to memory
paths, so you all had better work out a common solution.

Rob

>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..6e2b2971b094
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,33 @@
> +Interconnect Provider Device Tree Bindings
> +=========================================
> +
> +The purpose of this document is to define a common set of generic interconnect
> +providers/consumers properties.
> +
> +
> += interconnect providers =
> +
> +The interconnect provider binding is intended to represent the interconnect
> +controllers in the system. Each provider registers a set of interconnect
> +nodes, which expose the interconnect related capabilities of the interconnect
> +to consumer drivers. These capabilities can be throughput, latency, priority
> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
> +depending on the use case. Interconnect providers can also be interconnect
> +consumers, such as in the case where two network-on-chip fabrics interface
> +directly
> +
> +Required properties:
> +- compatible : contains the interconnect provider compatible string
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +                       encode the interconnect node id
> +
> +Example:
> +
> +               snoc: snoc@580000 {
> +                       compatible = "qcom,msm8916-snoc";
> +                       #interconnect-cells = <1>;
> +                       reg = <0x580000 0x14000>;
> +                       clock-names = "bus_clk", "bus_a_clk";
> +                       clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +                                <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +               };
