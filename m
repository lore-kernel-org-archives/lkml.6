Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A9CC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E85216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CR+3G8ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E85216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeHHLA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:00:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40061 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeHHLA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:00:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15-v6so1248835wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HPaJrDBKJC62V9rM3h386axEs/ADjPFxHCFqh4cwxI=;
        b=CR+3G8ic5Ze8KFB5imLEjLshiorA9xiy1Lsjh55J9XsiZ1rripnDRqrh4vPBJoqciC
         AwvA/skS3sMGOCDcNoj+PyUwKKRUvF/gHpGFhnFPxwTUzpjZ2VQijotVSWf5RBSPIiD2
         KVUnjM5z5lBB7Dlutr1Dwtibg1j0ZQ+pZdnhKNEcXOCOWkoCW9MS5sao2UIkTEKnJS3v
         APCR6tVGrZEtWGx3L8WRQ7h8OT3Rh0ZT2fi7ycJ12Z0somf1uDtr/T9crp++N9OmpfyB
         9pEWutiacp+qRbvk5dj1P8U/yPJAN82+1gVN35AS15TtEtl3FsnwzZe6oNmkVb82ag3l
         XAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HPaJrDBKJC62V9rM3h386axEs/ADjPFxHCFqh4cwxI=;
        b=m0c4e4YrJ4G/TqkSFM67P8wnKt/bQzVyvGnqrGMMtW8acpYwMwEEeZQNeR6IAdNDw7
         Pdb6uZFJL3PhxgwpSanuAtzkgAVRWFSKTyjSKU6ISmphAlGLXlQ0FY4vRny+Hp5ybsfT
         si3n4q9R5CmWIZQ02ddctNnzhyDkwx7ya0AUzj5K95TlOAPSbwR7ruW9cUj1oW84I2qU
         r3+FpZoJSe1xGMiYLTgEJC692uz4hORo33MdL0vQZl3SfAEp0/tXp8ogy2LQJUbkrS2w
         j3ItXanMyIt/Nmxccubp4qYscJKvXp6aVszWRZJ+ar3D6O+XvzgAojM7ic/sDPATxUSu
         Wc2g==
X-Gm-Message-State: AOUpUlGQAbGGjbNR6PU8ceq1rlB/CjZh4P2S0x3Tw/8p22dQLAXffVb5
        +m2uKAntsaklgdARN3/Wu6G1aA==
X-Google-Smtp-Source: AA+uWPzNHZOGCkloKUelV2w3o6jK4fVKOqZyXqXZCI/9/SnuZTkFtWk+8ev7C7kx2EM8/M18zmcEmw==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr1295698wrm.94.1533717706218;
        Wed, 08 Aug 2018 01:41:46 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i125-v6sm6838586wmd.23.2018.08.08.01.41.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 01:41:45 -0700 (PDT)
Message-ID: <3221c65f87f8fd3541e0188186cb0259327cb671.camel@baylibre.com>
Subject: Re: [PATCH v2 3/4] ARM64: dts: meson-gx: add dmcbus and canvas
 nodes.
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 08 Aug 2018 10:41:44 +0200
In-Reply-To: <20180807220011.24436-4-maxi.jourdan@wanadoo.fr>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
         <20180807220011.24436-4-maxi.jourdan@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-08 at 00:00 +0200, Maxime Jourdan wrote:
> Wrap the canvas node in a syscon node.
> 
> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index b8dc4dbb391b..c98198662ae2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -423,6 +423,23 @@
>  			};
>  		};
>  
> +		dmcbus: bus@c8838000 {
> +			compatible = "simple-bus";
> +			reg = <0x0 0xc8838000 0x0 0x1000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
> +
> +			sysctrl_DMC: system-controller@0 {
> +				compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
> +				reg = <0x0 0x0 0x0 0x1000>;
> +
> +				canvas: canvas-provider@0 {
> +					compatible = "amlogic,canvas";

If there is only one canvas provider under "sysctrl_DMC" and it has no reg
property , you should not put a unit-address (@0) here. (same for the
documentation patch)

You may have seen unit-address without a reg property used elsewhere (ASoC
simple-card, my recent axg-sound-card), when there is multiple node with the
same node-name (ex: dai-link).

As Martin pointed out, the DT spec says we should not use unit-address unless
there is a reg property. We did not get Rob's view on this and we might have to
update this later on. In your case, unless I missed something, you should
definitely not have it

nitpick regarding the node-name (canvas-provider). If appropriate, we should try
to stick to one of the generic names proposed in the spec. I wonder if the
canvas provider could be viewed as a "memory" or "memory-controller"

So, what about this ? Just a proposition, feel free to comment ;)

	sysctrl_DMC: system-controller@0 {							compatib
le = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";> 		reg =
<0x0 0x0 0x0 0x1000>;
	
		canvas: memory-controller {
			compatible = "amlogic,canvas";
		}

[...]


> +				};
> +			};
> +		};
> +
>  		hiubus: bus@c883c000 {
>  			compatible = "simple-bus";
>  			reg = <0x0 0xc883c000 0x0 0x2000>;


