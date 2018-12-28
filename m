Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E913BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935F4217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546039950;
	bh=rY9Qy/zZXR6fyS2P7tY9OohqyPtBJWdGOJErloIDWa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LLBvW/fO5vSGbvb876qiO41/Y/qBmPlY1FAZz7nomQsK4JM7GOUpXkBUUNDYZEVFM
	 WfODlwopJ0VJpPyBulEj80BQ3wd4JmuPBRp8p8zMRNfxo7kkW4q0ZmykPS3wRWnON3
	 RTKTTU49sNJrKkEg7ZiU+r17855Tku1Fr78msFMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeL1Xc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:32:29 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:38220 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeL1Xc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:32:29 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so28604658ith.3;
        Fri, 28 Dec 2018 15:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDHG4WxsQ4XcgMtdWfJAeEhz4qeg/bC5OHWrj6fBTQ4=;
        b=QIRiDYvdCRB2a7S1ZfN4VaSfJh4Pqov8rOfD8sIWWIr51QZ6s6BNgY9FdzujyO39wu
         d5A+ZSEJ0Pt1PzDCxf0+ElF6CayKUUm9PjumqAL+NPqo34Urg1DWmDkQ6w+ulOtteDfU
         nIcxZmiOXiMaEAHnevOcrMmMhjfjoUvXfaRnmXfof/7HrK1SM6sYp7QJyVjv0OKLeZjO
         SemNwx54xymCURSTL3UDXt2zDwa490mF6Qrsu7D1OFkEp2cUAU1K075iU29/n0yd4Q4n
         0ELUIKasUtzcsHtxbjWT8//kkng94OiXuBFb7jZC6AoznfLQvjdC/H0skY95CDVr2MZq
         +9Bg==
X-Gm-Message-State: AA+aEWb64GvPVWf8Qu+nETaNvtfK/4Kx6kiQ/8y0asKN1R2+/uIc4tAG
        dxYIJWQmBtyVY4TSa1YdgYnr4ck=
X-Google-Smtp-Source: ALg8bN6z03ibk7/wIHYgokFtoipKXTDtOTPpHFbT3hE5X6kN/QXKAkjKhQf4ozc2gpaP4JQTwhqQHA==
X-Received: by 2002:a05:660c:741:: with SMTP id a1mr17915815itl.100.1546039948287;
        Fri, 28 Dec 2018 15:32:28 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id w16sm17487750ita.38.2018.12.28.15.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 15:32:27 -0800 (PST)
Date:   Fri, 28 Dec 2018 17:32:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Message-ID: <20181228233226.GA11728@bogus>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 04:30:01PM +0000, Viorel Suman wrote:
> This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> The Audio Mixer is a on-chip functional module that allows mixing of
> two audio streams into a single audio stream.
> 
> Audio Mixer datasheet is available here:
> https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++

This should be a separate patch.

>  sound/soc/fsl/Kconfig                              |   7 +
>  sound/soc/fsl/Makefile                             |   3 +
>  sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
>  sound/soc/fsl/fsl_amix.h                           | 101 ++++
>  5 files changed, 710 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,amix.txt
>  create mode 100644 sound/soc/fsl/fsl_amix.c
>  create mode 100644 sound/soc/fsl/fsl_amix.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> new file mode 100644
> index 0000000..049144f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> @@ -0,0 +1,45 @@
> +NXP Audio Mixer (AMIX).
> +
> +The Audio Mixer is a on-chip functional module that allows mixing of two
> +audio streams into a single audio stream. Audio Mixer has two input serial
> +audio interfaces. These are driven by two Synchronous Audio interface
> +modules (SAI). Each input serial interface carries 8 audio channels in its
> +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> +from two interfaces into a single sample. Before mixing, audio samples of
> +two inputs can be attenuated based on configuration. The output of the
> +Audio Mixer is also a serial audio interface. Like input interfaces it has
> +the same TDM frame format. This output is used to drive the serial DAC TDM
> +interface of audio codec and also sent to the external pins along with the
> +receive path of normal audio SAI module for readback by the CPU.
> +
> +The output of Audio mixer can be selected from any of the three streams
> + - serial audio input 1
> + - serial audio input 2
> + - Mixed audio
> +
> +Mixing operation is independent of audio sample rate but the two audio
> +input streams must have same audio sample rate with same number of channels
> +in TDM frame to be eligible for mixing.
> +
> +Device driver required properties:
> +=================================
> +  - compatible		: Compatible list, contains "fsl,imx8qm-amix"
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - clocks		: Must contain an entry for each entry in clock-names.
> +
> +  - clock-names		: Must include the "ipg" for register access.

Humm, no audio related clocks? 

> +
> +  - power-domains	: Must contain the phandle to the AMIX power domain node
> +
> +Device driver configuration example:
> +======================================
> +  amix: amix@59840000 {
> +    compatible = "fsl,imx8qm-amix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_amix>;
> +  };
> +
