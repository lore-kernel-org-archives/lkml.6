Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76844C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C506205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C506205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeK0HME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:12:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45852 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeK0HME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:12:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id b141so17091971oii.12;
        Mon, 26 Nov 2018 12:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJqT5DgqK4ueMKz7tkQIEWHTq6M/XndBis6a7nMEaQk=;
        b=AJC8K4W46spct79TL/XMdHiJp7RJn/XUA7fWl3UoJYXgmDWQbjKLA+jpxKQ4AuQgAz
         JL/daa6zG10jsQRI9HBB/2Kjo6DfnG96W/8XyzCJVLogjReVMftBJngbg8lLUWwS3OBJ
         mODRgL16umnLHcPDm9tTa4eVLsSzLv8XNFd4Jrp+1bHNdEiMIES/7I+RHi73JHE5sFmt
         N0kyxdJJ5Mz0ygmBu+9e7h2hJWXofyxppU44qP4OMDhIZjVTijb+9jqGafTJUmAs4ON+
         ER/C57Z7ZBm7Yf5cjl4p/mKikJpZX9UQycl7a0PGFg1zFuQcJizSv0g9a3dAFPwe4s2z
         8Yew==
X-Gm-Message-State: AGRZ1gLwj1fTHc+Uq4kIrwAOD/SIgSSPH1XazNa4PH4wDisdCRzFqJZU
        EgWT+LyNryOs7JxrTKBDAg==
X-Google-Smtp-Source: AJdET5eMh82SPt+r48J46sRTwjPRMS/Zx68lY4PASlDqO51iPxGAwxb9NVYQQljKEMGKigniEGqlrA==
X-Received: by 2002:aca:cd14:: with SMTP id d20mr16645959oig.179.1543263407797;
        Mon, 26 Nov 2018 12:16:47 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w4sm400072otm.46.2018.11.26.12.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:16:47 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:16:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        broonie@kernel.org, linus.walleij@linaro.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 3/8] clk: lochnagar: Add initial binding documentation
Message-ID: <20181126201645.GA2094@bogus>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
 <20181120141631.18949-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120141631.18949-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:16:26PM +0000, Charles Keepax wrote:
> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/clock/cirrus,lochnagar.txt | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
> new file mode 100644
> index 000000000000..c1b5478d5432
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
> @@ -0,0 +1,89 @@
> +Cirrus Logic Lochnagar Audio Development Board
> +
> +Lochnagar is an evaluation and development board for Cirrus Logic
> +Smart CODEC and Amp devices. It allows the connection of most Cirrus
> +Logic devices on mini-cards, as well as allowing connection of
> +various application processor systems to provide a full evaluation
> +platform.  Audio system topology, clocking and power can all be
> +controlled through the Lochnagar, allowing the device under test
> +to be used in a variety of possible use cases.
> +
> +This binding document describes the binding for the clock portion of
> +the driver.
> +
> +Also see these documents for generic binding information:
> +  [1] Clock : ../clock/clock-bindings.txt
> +
> +And these for relevant defines:
> +  [2] include/dt-bindings/clock/lochnagar.h
> +
> +This binding must be part of the Lochnagar MFD binding:
> +  [3] ../mfd/cirrus,lochnagar.txt
> +
> +Required properties:
> +
> +  - compatible : One of the following strings:
> +                 "cirrus,lochnagar1-clk"
> +                 "cirrus,lochnagar2-clk"

What's the 1 vs. 2?

> +
> +  - #clock-cells : Must be 1. The first cell indicates the clock
> +    number, see [2] for available clocks and [1].
> +
> +Optional properties:
> +
> +  - clocks : Must contain an entry for each clock in clock-names.
> +  - clock-names : May contain entries for each of the following
> +    clocks:
> +     - ln-cdc-clkout : Output clock from CODEC card.
> +     - ln-dsp-clkout : Output clock from DSP card.
> +     - ln-gf-mclk1,ln-gf-mclk2,ln-gf-mclk3,ln-gf-mclk4 : Optional
> +       input audio clocks from host system.
> +     - ln-psia1-mclk, ln-psia2-mclk : Optional input audio clocks from
> +       external connector.
> +     - ln-spdif-clkout : Optional input audio clock from SPDIF.
> +     - ln-adat-clkout : Optional input audio clock from ADAT.
> +     - ln-pmic-32k : On board fixed regulator.

regulator?

> +     - ln-clk-12m : On board fixed regulator.
> +     - ln-clk-11m : On board fixed regulator.
> +     - ln-clk-24m : On board fixed regulator.
> +     - ln-clk-22m : On board fixed regulator.
> +     - ln-usb-clk-24m : On board fixed regulator.
> +     - ln-usb-clk-12m : On board fixed regulator.
> +
> +  - assigned-clocks : A list of Lochnagar clocks to be reparented, see
> +    [2] for available clocks.
> +  - assigned-clock-parents : Parents to be assigned to the clocks
> +    listed in "assigned-clocks".
> +
> +Optional sub-nodes:
> +
> +  - fixed-clock nodes may be registered for the following on board clocks:
> +     - ln-pmic-32k : 32768 kHz
> +     - ln-clk-12m : 12288000 kHz
> +     - ln-clk-11m : 11298600 kHz
> +     - ln-clk-24m : 24576000 kHz
> +     - ln-clk-22m : 22579200 kHz
> +     - ln-usb-clk-24m : 24576000 kHz
> +     - ln-usb-clk-12m : 12288000 kHz
> +
> +Example:
> +
> +lochnagar-clk {
> +	compatible = "cirrus,lochnagar2-clk";
> +
> +	#clock-cells = <1>;
> +
> +	clocks = <&clk-audio>, <&clk_pmic>;
> +	clock-names = "ln-gf-mclk2", "ln-pmic-32k";
> +
> +	assigned-clocks = <&lochnagar-clk LOCHNAGAR_CDC_MCLK1>,
> +			  <&lochnagar-clk LOCHNAGAR_CDC_MCLK2>;
> +	assigned-clock-parents = <&clk-audio>,
> +				 <&clk-pmic>;
> +
> +	clk-pmic: clk-pmic {

This isn't really any relationship to the parent and I think shouldn't 
be a sub-node.

> +		compatible = "fixed-clock";
> +		clock-cells = <0>;
> +		clock-frequency = <32768>;
> +	};
> +};
> -- 
> 2.11.0
> 
