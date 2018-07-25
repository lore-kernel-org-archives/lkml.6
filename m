Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BCEC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D848F20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D848F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbeGYUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:19:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54815 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbeGYUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:19:20 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so10239313itb.4;
        Wed, 25 Jul 2018 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLkOjKFAsB/Kd7L/84C6cQds0WNLqyJ990WIB2yJkRY=;
        b=i1HqrRfaWjiZ7s51av7wT0E5YH+fH1Pnhl53IL933p3x23v+2YSM6v285nEjc9Bc0q
         6R/Vid66DC+3XxuhoqsSyo5uitPiTZdXkHH+cFNUI+IXkklOzP4LxsXeZae04oMA1J4R
         dGWBjGcGDSS4IlSmcIN/UJA5ucpUCh5GXCAKsXBp+lESZdFpCawlCFGpUzZjhHcSVyKb
         xI3u6ZMV3TnZT4Ju0ltLKFiwxefbGzL6QQJZz2rsez+f9GmtsMkKwe+xIyiiw7MMdzqO
         krBMJ6coHc4KhqnmOsgzb0Rf+FJ3/LTl8FSdmkAv42E+Uu9Zfpp3cAWsHFIQdsYxEEcR
         UJCw==
X-Gm-Message-State: AOUpUlFH91hoW/xA3SY3leVX/Czim2LIQGT0IbU4LaiHNY5ZC5vnmg3D
        AZE1RQio9ZZlr01/UqmTQw==
X-Google-Smtp-Source: AAOMgpdIasY3uvKjnCadcoyn4L3gtZfopv2PtQgrPCw011lT5wPhMjjlWwI8dpv+T70OZB6Pt7mNPg==
X-Received: by 2002:a24:c106:: with SMTP id e6-v6mr7324812itg.126.1532545580440;
        Wed, 25 Jul 2018 12:06:20 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b90-v6sm4603146itd.18.2018.07.25.12.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:06:19 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:06:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 14/15] ASoC: meson: add axg sound card DT binding
 documentation
Message-ID: <20180725190619.GA20234@rob-hp-laptop>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
 <20180717153643.8806-18-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717153643.8806-18-jbrunet@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 05:36:41PM +0200, Jerome Brunet wrote:
> Add the DT binding documentation for axg sound card

I see Mark already applied, but...

> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-sound-card.txt      | 124 +++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
> new file mode 100644
> index 000000000000..39e005da0407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
> @@ -0,0 +1,124 @@
> +Amlogic AXG sound card:
> +
> +Required properties:
> +
> +- compatible: "amlogic,axg-sound-card"
> +- amlogic,name : User specified audio sound card name, one string

Just using "model" for new bindings.

> +
> +Optional properties:
> +
> +- amlogic,aux-devs : List of phandles pointing to auxiliary devices
> +- amlogic,widgets : Please refer to widgets.txt.
> +- amlogic,routing : A list of the connections between audio components.

audio-routing IIRC

> +
> +Subnodes:
> +
> +- amlogic,dai-link: Container for dai-link level properties and the
> +		    CODEC sub-nodes. There should be at least one (and
> +		    probably) subnode of this type.

Just 'dai-link'

> +
> +Required dai-link properties:
> +
> +- sound-dai: phandle and port of the CPU DAI.
> +
> +Required TDM Backend dai-link properties:
> +- dai-format : CPU/CODEC common audio format
> +
> +Optional TDM Backend dai-link properties:
> +- dai-tdm-slot-rx-mask-{0,1,2,3}: Receive direction slot masks
> +- dai-tdm-slot-tx-mask-{0,1,2,3}: Transmit direction slot masks
> +				  When omitted, mask is assumed to have to no
> +				  slots. A valid must have at one slot, so at
> +				  least one these mask should be provided with
> +				  an enabled slot.
> +- dai-tdm-slot-num : Please refer to tdm-slot.txt.
> +		     If omitted, slot number is set to accommodate the largest
> +		     mask provided.
> +- dai-tdm-slot-width : Please refer to tdm-slot.txt. default to 32 if omitted.
> +- mclk-fs : Multiplication factor between stream rate and mclk
> +
> +Backend dai-link subnodes:
> +
> +- codec: dai-link representing backend links should have at least one subnode.
> +	 One subnode for each codec of the dai-link.
> +	 dai-link representing frontend links have no codec, therefore have no
> +	 subnodes
> +
> +Required codec subnodes properties:
> +
> +- sound-dai: phandle and port of the CODEC DAI.
> +
> +Optional codec subnodes properties:
> +
> +- dai-tdm-slot-tx-mask : Please refer to tdm-slot.txt.
> +- dai-tdm-slot-rx-mask : Please refer to tdm-slot.txt.
> +
> +Example:
> +
> +sound {
> +	compatible = "amlogic,axg-sound-card";
> +	amlogic,name = "AXG-S420";
> +	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
> +	amlogic,widgets = "Line", "Lineout",
> +			  "Line", "Linein",
> +			  "Speaker", "Speaker1 Left",
> +			  "Speaker", "Speaker1 Right";
> +			  "Speaker", "Speaker2 Left",
> +			  "Speaker", "Speaker2 Right";
> +	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
> +			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
> +			  "TDM_C Playback", "TDMOUT_C OUT",
> +			  "TDMIN_A IN 2", "TDM_C Capture",
> +			  "TDMIN_A IN 5", "TDM_C Loopback",
> +			  "TODDR_A IN 0", "TDMIN_A OUT",
> +			  "Lineout", "Lineout AOUTL",
> +			  "Lineout", "Lineout AOUTR",
> +			  "Speaker1 Left", "SPK1 OUT_A",
> +			  "Speaker2 Left", "SPK2 OUT_A",
> +			  "Speaker1 Right", "SPK1 OUT_B",
> +			  "Speaker2 Right", "SPK2 OUT_B",
> +			  "Linein AINL", "Linein",
> +			  "Linein AINR", "Linein";
> +
> +	amlogic,dai-link@0 {
> +		sound-dai = <&frddr_a>;
> +	};
> +
> +	amlogic,dai-link@1 {
> +		sound-dai = <&toddr_a>;
> +	};
> +
> +	amlogic,dai-link@2 {
> +		sound-dai = <&tdmif_c>;
> +		dai-format = "i2s";
> +		dai-tdm-slot-tx-mask-2 = <1 1>;
> +		dai-tdm-slot-tx-mask-3 = <1 1>;
> +		dai-tdm-slot-rx-mask-1 = <1 1>;
> +		mclk-fs = <256>;
> +
> +		codec@0 {
> +			sound-dai = <&lineout>;
> +		};
> +
> +		codec@1 {
> +			sound-dai = <&speaker_amp1>;
> +		};
> +
> +		codec@2 {
> +			sound-dai = <&speaker_amp2>;
> +		};
> +
> +		codec@3 {
> +			sound-dai = <&linein>;
> +		};
> +
> +	};
> +
> +	amlogic,dai-link@4 {
> +		sound-dai = <&spdifout>;
> +
> +		codec {
> +			sound-dai = <&spdif_dit>;
> +		};
> +	};
> +};
> -- 
> 2.14.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
