Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D03E2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D03E2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbeKQJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:20:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39730 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:20:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id g27so22834617oth.6;
        Fri, 16 Nov 2018 15:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2fHHKh0zewETzt5GWsoCBIxpALbyej+4GgrZPMpi6Y=;
        b=ITQs0Pl45JFdmqKVGVf9c4lA4C1dgccu/2yubsov/xlO9lgFrM275HqUuADAjd2Rpu
         727YxUQkj3MXm+EgTeIV8SXrZ0uxmg4MDGDFylwOZKalQnHLUyrGIlwuW98/ZquYVoNd
         oXqbUb1zk/0PIP4eofKpRBuTlbiRnYjykn+t3x9ejQIkWV3Of8DC+oJoNNpNSFVxkONk
         pPndcu7oDvpDPkhlNwIPm3RdRgTHhB5AzIXTkjG2YPySwrxiNWhdJjhBwW5uswFrtMO/
         +tig3z3P5AZjyWdwKPygk+PofG7xwuLXrc07+6po8u4p2YoBJ83EMO7S6UxEz1ue6O6A
         yCDA==
X-Gm-Message-State: AGRZ1gJjP1U62Jk84uoDwNmfVvUnLTyz/cYxV+mDRNZyC5IkTNo9/pb8
        Vu6mBc9vtV+T8n1d1Y+YjQ==
X-Google-Smtp-Source: AJdET5dUbEiEqreGsROMIMFZy5pnT7bUofdQMJEVkXqCmXxQvrSJzySrkyTAYcq6EcJKp5l41QNK0g==
X-Received: by 2002:a9d:30d1:: with SMTP id r17mr7129364otg.87.1542409571857;
        Fri, 16 Nov 2018 15:06:11 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id p203sm13434290oic.49.2018.11.16.15.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 15:06:11 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:06:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     mark.rutland@arm.com, ck.hu@mediatek.com, p.zabel@pengutronix.de,
        airlied@linux.ie, mturquette@baylibre.com, sboyd@codeaurora.org,
        ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        sean.wang@kernel.org, rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v5 06/12] drm/mediatek: update dt-bindings
Message-ID: <20181116230609.GA9744@bogus>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-7-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116125449.23581-7-matthias.bgg@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 01:54:43PM +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>

The subject is pretty vague...

> 
> Add mmsys bindings description.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../display/mediatek/mediatek,disp.txt        | 30 +++++++++++--------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 8469de510001..4b008d992398 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -27,20 +27,24 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>  
>  Required properties (all function blocks):
>  - compatible: "mediatek,<chip>-disp-<function>", one of
> -	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
> -	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
> -	"mediatek,<chip>-disp-wdma"  - write DMA
> -	"mediatek,<chip>-disp-color" - color processor
> -	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
> -	"mediatek,<chip>-disp-gamma" - gamma correction
> -	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
> -	"mediatek,<chip>-disp-split" - split stream to two encoders
> -	"mediatek,<chip>-disp-ufoe"  - data compression engine
> -	"mediatek,<chip>-dsi"        - DSI controller, see mediatek,dsi.txt
> -	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
> -	"mediatek,<chip>-disp-mutex" - display mutex
> -	"mediatek,<chip>-disp-od"    - overdrive
> +	"mediatek,<chip>-disp-ovl"		- overlay (4 layers, blending, csc)
> +	"mediatek,<chip>-disp-rdma"		- read DMA / line buffer
> +	"mediatek,<chip>-disp-wdma"		- write DMA
> +	"mediatek,<chip>-disp-color"		- color processor
> +	"mediatek,<chip>-disp-aal"		- adaptive ambient light controller
> +	"mediatek,<chip>-disp-gamma"		- gamma correction
> +	"mediatek,<chip>-disp-merge"		- merge streams from two RDMA sources
> +	"mediatek,<chip>-disp-split"		- split stream to two encoders
> +	"mediatek,<chip>-disp-ufoe"		- data compression engine
> +	"mediatek,<chip>-dsi"			- DSI controller, see mediatek,dsi.txt
> +	"mediatek,<chip>-dpi"			- DPI controller, see mediatek,dpi.txt
> +	"mediatek,<chip>-disp-mutex"		- display mutex
> +	"mediatek,<chip>-disp-od"		- overdrive
> +	"mediatek,<chip>-mmsys", "syscon"	- provide clocks and components management

A lot of reformatting for a 1 line change. It's fine if you want to 
leave this as one patch, but make the commit msg clear what's really 
changing here.

>    the supported chips are mt2701, mt2712 and mt8173.
> +  For mt7623, compatible must be:
> +	"mediatek,mt7623-<component>" , "mediatek,mt2701-<component>"
> +
>  - reg: Physical base address and length of the function block register space
>  - interrupts: The interrupt signal from the function block (required, except for
>    merge and split function blocks).
> -- 
> 2.19.1
> 
