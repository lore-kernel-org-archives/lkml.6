Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B454CC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E6E2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E6E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeKQJ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:29:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37615 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728839AbeKQJ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:29:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id 40so22857772oth.4;
        Fri, 16 Nov 2018 15:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ekKnk2QPBKe/u2m6bBUIbm93tkC8+DeVZLdzjhyzX6k=;
        b=plz12EKFsM2oya+nbXIYJwaB+HD9tHdeUQDXfMCHCRzjC9IlUWPQsXTtu8GGdT/zp2
         LD+O0GGC0fYyrGUTn44YvN6inQnpJV+Es1EMpeHVL2sKpNU4uofW1UyAZMynLVkL98Qw
         hbpCil9Ugym/o9UJmtOwYDEoL2YG4E9s0Vb+XNk0T/fSWE4p4iLVjplftKmFNhsnGxdk
         2e9V9RmyhTH/I8rS4R/q7EBf7WpQSxJfglEcMwgxyjntJpRmwggjsFNot91G83wfYJ7p
         eMtTl1HqG/2xe1ADh6rf6ZbbMq04lY7xtW1HZInUfii2zYoGlOIihTL41MTGz8lPK7Fs
         N3IA==
X-Gm-Message-State: AGRZ1gKo7Qr7iy4M/1Z9o7OUBFvXk5z9w4r+vO1yWzcPcouLihm64g9L
        siZmSkfQ0HRUfkdcCqVJWQ==
X-Google-Smtp-Source: AJdET5d8sDA5XUglC80x0t5R0BkyeTUJ+eqi4v1rbMybEDUhXjZ6xEHhXbsoePavbZwx0GD4OlxSMg==
X-Received: by 2002:a9d:4c88:: with SMTP id m8mr7871225otf.360.1542410124329;
        Fri, 16 Nov 2018 15:15:24 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id j23sm4510622oih.22.2018.11.16.15.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 15:15:23 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:15:22 -0600
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
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
Message-ID: <20181116231522.GA18006@bogus>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116125449.23581-9-matthias.bgg@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> On SoCs with no publical available HW or no working graphic stack
> we change the devicetree binding for the mmsys clock part. This
> way we don't need to register a platform device explicitly in the
> drm driver. Instead we can create a mmsys child which invokes the
> clock driver.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 21 ++++++++++++-------
>  .../display/mediatek/mediatek,disp.txt        |  4 ++++
>  2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index 4468345f8b1a..d4e205981363 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -1,4 +1,4 @@
> -Mediatek mmsys controller
> +Mediatek mmsys clock controller
>  ============================
>  
>  The Mediatek mmsys controller provides various clocks to the system.
> @@ -6,18 +6,25 @@ The Mediatek mmsys controller provides various clocks to the system.
>  Required Properties:
>  
>  - compatible: Should be one of:
> -	- "mediatek,mt2712-mmsys", "syscon"
> -	- "mediatek,mt6797-mmsys", "syscon"
> +	- "mediatek,mt2712-mmsys-clk", "syscon"
> +	- "mediatek,mt6797-mmsys-clk", "syscon"

Doesn't match the example.

>  - #clock-cells: Must be 1
>  
> -The mmsys controller uses the common clk binding from
> +The mmsys clock controller uses the common clk binding from
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
>  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +It is a child of the mmsys block, see binding at:
> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>  
>  Example:
>  
> -mmsys: clock-controller@14000000 {
> -	compatible = "mediatek,mt8173-mmsys", "syscon";
> +mmsys: syscon@14000000 {
> +	compatible = "mediatek,mt2712-mmsys", "syscon", "simple-mfd";
>  	reg = <0 0x14000000 0 0x1000>;
> -	#clock-cells = <1>;
> +
> +	mmsys_clk: clock-controller@14000000 {
> +		compatible = "mediatek,mt2712-mmsys-clk";
> +		#clock-cells = <1>;

This goes against the general direction of not defining separate nodes 
for providers with no resources.

Why do you need this and what does it buy if you have to continue to 
support the existing chips?

Rob
