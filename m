Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63928C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C7520673
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 13:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C7520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbeLBNqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 08:46:50 -0500
Received: from hermes.aosc.io ([199.195.250.187]:55630 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbeLBNqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 08:46:50 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4F0D911ED4A;
        Sun,  2 Dec 2018 13:46:42 +0000 (UTC)
Message-ID: <41099855eb644a004ebf67059232a53146b278c1.camel@aosc.io>
Subject: Re: [PATCH 1/2] dt-bindings: gpu: add bus clock for Mali Midgard
 GPUs
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Sun, 02 Dec 2018 21:46:37 +0800
In-Reply-To: <20181127074249.15204-1-icenowy@aosc.io>
References: <20181127074249.15204-1-icenowy@aosc.io>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-11-27二的 15:42 +0800，Icenowy Zheng写道：
> Some SoCs adds a bus clock gate to the Mali Midgard GPU.
> 
> Add the binding for the bus clock.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Could anyone have a check on this patchset?

> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 6
> ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-
> midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-
> midgard.txt
> index 18a2cde2e5f3..02f870cd60e6 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -31,6 +31,12 @@ Optional properties:
>  
>  - clocks : Phandle to clock for the Mali Midgard device.
>  
> +- clock-names : Specify the names of the clocks specified in clocks
> +  when multiple clocks are present.
> +    * bus: bus clock for the GPU
> +    * core: clock driving the GPU itself (When only one clock is
> present,
> +      assume it's this clock.)
> +
>  - mali-supply : Phandle to regulator for the Mali device. Refer to
>    Documentation/devicetree/bindings/regulator/regulator.txt for
> details.
>  

