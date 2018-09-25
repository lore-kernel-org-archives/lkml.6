Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43674C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D302086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D302086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeIZAK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:10:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46095 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIZAK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:10:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id q4-v6so12234417otf.13;
        Tue, 25 Sep 2018 11:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CryCIdF8wiMzWKTVK6UEJG5qR/Y5GOIEOK2GqzmS97U=;
        b=G7FosuM0o+fMrX4L35Si7I/qUW75AsZc1Dk5QZrlfm/PXIIQ5S5h+n8imp/I7tbAT9
         9F5sz8psaohr1BX/LbbsFhBPx1lU61cZxAEus5uVQOW219JJmz++MrQD/fgZ4xvFwgKp
         gj9gBn5wGqmYUSPvrFALgL+dtLWFdNefvs8W9Mi5lwA7zOxAgz4dUPqgJ0lokHM2F5b7
         jPOnymqs3pscbqXiatQhNGRsQWNA7QxXyXr931AbtjBunMGRssCfBGw2vzpEqLaZ/vVd
         WKe11rulUND+zZRmuILV+hTBhfF9OeWOsJk3yeeIeaWFQ+evyG/zDLcb3Z8LU+X9kHAS
         rXUQ==
X-Gm-Message-State: ABuFfoiIa8bQJFX1hSKNT6bbHNE3qXvVMC7dSzqeVGvFibJDrxWUfx1T
        g03pSMkF9IcMXuT3FplqYQ==
X-Google-Smtp-Source: ACcGV63lip23nmR/gw5pHf7RLDPQhFXhdrAJvlUkrnEASBcu393b1GdsuOk7afiJeyEf2wnOoSeqSg==
X-Received: by 2002:a9d:3ac:: with SMTP id f41-v6mr1605790otf.389.1537898537554;
        Tue, 25 Sep 2018 11:02:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x77-v6sm986588oix.42.2018.09.25.11.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:02:16 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:02:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Message-ID: <20180925180215.GA12435@bogus>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831140151.13972-3-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> This binding is intended to represent the relations between the interconnect
> controllers (providers) and consumer device nodes. It will allow creating links
> between consumers and interconnect paths (exposed by interconnect providers).

As I mentioned in person, I want to see other SoC families using this 
before accepting. They don't have to be ready for upstream, but WIP 
patches or even just a "yes, this works for us and we're going to use 
this binding on X".

Also, I think the QCom GPU use of this should be fully sorted out. Or 
more generically how this fits into OPP binding which seems to be never 
ending extended...

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> new file mode 100644
> index 000000000000..5cb7d3c8d44d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> @@ -0,0 +1,60 @@
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

missing '.'

> +
> +Required properties:
> +- compatible : contains the interconnect provider compatible string
> +- #interconnect-cells : number of cells in a interconnect specifier needed to
> +			encode the interconnect node id
> +
> +Example:
> +
> +		snoc: snoc@580000 {
> +			compatible = "qcom,msm8916-snoc";
> +			#interconnect-cells = <1>;
> +			reg = <0x580000 0x14000>;
> +			clock-names = "bus_clk", "bus_a_clk";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +		};
> +
> +
> += interconnect consumers =
> +
> +The interconnect consumers are device nodes which dynamically express their
> +bandwidth requirements along interconnect paths they are connected to. There
> +can be multiple interconnect providers on a SoC and the consumer may consume
> +multiple paths from different providers depending on use case and the
> +components it has to interact with.
> +
> +Required properties:
> +interconnects : Pairs of phandles and interconnect provider specifier to denote
> +	        the edge source and destination ports of the interconnect path.
> +
> +Optional properties:
> +interconnect-names : List of interconnect path name strings sorted in the same
> +		     order as the interconnects property. Consumers drivers will use
> +		     interconnect-names to match interconnect paths with interconnect
> +		     specifiers.

specifier pairs.

> +
> +Example:
> +
> +	sdhci@7864000 {
> +		...
> +		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
> +		interconnect-names = "ddr";
> +	};
