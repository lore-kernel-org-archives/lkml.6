Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D29C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="MLadpXzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D29C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJZCtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:49:03 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38560 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeJZCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:49:03 -0400
Received: by mail-yb1-f195.google.com with SMTP id v92-v6so4086776ybi.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zjL5I9aGOHDTwkatgCVbcie6gKdYigmRcMl+3giZKcE=;
        b=MLadpXzWw0eZkTgBFZnR33DO3CT1qRccSYZEZj2NmSi5yg5vIIzkzG2hOohf++4nVj
         s7YDemIkJi31WwwfBwHXYKDSrG4cSVzJHrIIkWvAxEyVPikINUG57cYexCNICxhnHggD
         8YkWcXwDOqmcfMx+64f2JwM5MSBY0HSUwJuQNFeetan24xKMekDs2p9R63kFvVuZypv6
         G2iTqe+U0HJywXuu/vi42HtQGwCEMeRqQDVPOtmAoHOSp74YL9L1e4LpeGJmu4VQUjcZ
         JIfNGJy2sPb5JkmRZ8RzZ+8j274wpU3QEZPs60X36OSRYvjf5y/XF7YxfcSl1oFchI98
         EblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zjL5I9aGOHDTwkatgCVbcie6gKdYigmRcMl+3giZKcE=;
        b=Cg5oMMpEbZNvPIXjM1Us+dkT4TL+NRcnqMAEwktv1ihqR4+bYz3jbY/aUPWmlPAAXe
         8GN08LscGvvOodJbStZ8A7j8yQC02UJdMVGPZ8Rd+epYKpFkeOkvRQmhUPxSt6fZrQ8c
         JxqIj300smZrOh72bMbMUcaRRgjdOYpoEWEbEg0fthXyEbcL9I5vDLihqj+hOJq1zCC3
         yjYBKbVcYKjHnTuSS7HWhNdyclQG1wlDrC8JsVUqBVP1J9IQTEm/h2ggqe1sZcMWUi7P
         cf1AJlYrUdkXjeUhpFAbqNMIaSofjoYpgqw4X3hBjhJK+Qbxd69uJR4WQ+dF7xWBe2pI
         hiXQ==
X-Gm-Message-State: AGRZ1gJGyc7tJSZeYK0E2LkDWRkUaZ5EDtpjM7sdsEp6qpJj3l4fjMwE
        0WY/nztW6++DJpd9WQFQNUefDw==
X-Google-Smtp-Source: AJdET5fX0clxwfsWIn1mWwOdyBHuyWVM3ghjPwq9Mq3wgUMOiNKFhbBXwNE9eCK5P0S07agJlpKnRA==
X-Received: by 2002:a25:a509:: with SMTP id h9-v6mr362623ybi.312.1540491312053;
        Thu, 25 Oct 2018 11:15:12 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id b19-v6sm3584046ywh.29.2018.10.25.11.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 11:15:11 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:15:10 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ryandcase@chromium.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 6/6] dt-bindings: drm/panel: simple: Innolux TV123WAM is
 actually P120ZDG-BF1
Message-ID: <20181025181510.GN154160@art_vandelay>
References: <20181022204639.8558-1-dianders@chromium.org>
 <20181022204639.8558-6-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-6-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:46:39PM -0700, Douglas Anderson wrote:
> As far as I can tell the bindings that were added in commit
> 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel
> bindings") weren't actually for Innolux TV123WAM but were actually for
> Innolux P120ZDG-BF1.
> 
> As far as I can tell the Innolux TV123WAM isn't a real panel and but
> it's a mosh between the TI TV123WAM and the Innolux P120ZDG-BF1.
> Let's unmosh.
> 
> Here's my evidence:
> 
> * Searching for TV123WAM on the Internet turns up a TI panel.  While
>   it's possible that an Innolux panel has the same model number as the
>   TI Panel, it seems a little doubtful.  Looking up the datasheet from
>   the TI Panel shows that it's 1920 x 1280 and 259.2 mm x 172.8 mm.
> 
> * As far as I know, the patch adding the Innolux Panel was supposed to
>   be for the board that's sitting in front of me as I type this
>   (support for that board is not yet upstream).  On the back of that
>   panel I see Innolux P120ZDZ-EZ1 rev B1.
> 
> * Someone pointed me at a datasheet that's supposed to be for the
>   panel in front of me (sorry, I can't share the datasheet).  That
>   datasheet has the string "p120zdg-bf1"
> 
> * If I search for "P120ZDG-BF1" on the Internet I get hits for panels
>   that are 2160x1440.  They don't have datasheets, but the fact that
>   the resolution matches is a good sign.
> 
> While we doing the rename, also mention that no-hpd can be used with
> this panel.  See the previous patch in this series ("drm/panel:
> simple: Add "no-hpd" delay for Innolux TV123WAM").
> 
> Fixes: 9c04400f7ea6 ("dt-bindings: drm/panel: Document Innolux TV123WAM panel bindings")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>
> ---
> 
>  .../{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt}     | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/display/panel/{innolux,tv123wam.txt => innolux,p120zdg-bf1.txt} (70%)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
> similarity index 70%
> rename from Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
> rename to Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt

Same concerns here, you might consider leaving a breadcrumb here to point to
p120zdg-bf1 (noting that the old compatible string will continue to work).

Again, if robh is Ok with wiping innolux,tv123wam from existance, please ignore
:)

Sean

> index a9b35265fa13..513f03466aba 100644
> --- a/Documentation/devicetree/bindings/display/panel/innolux,tv123wam.txt
> +++ b/Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.txt
> @@ -1,20 +1,22 @@
> -Innolux TV123WAM 12.3 inch eDP 2K display panel
> +Innolux P120ZDG-BF1 12.02 inch eDP 2K display panel
>  
>  This binding is compatible with the simple-panel binding, which is specified
>  in simple-panel.txt in this directory.
>  
>  Required properties:
> -- compatible: should be "innolux,tv123wam"
> +- compatible: should be "innolux,p120zdg-bf1"
>  - power-supply: regulator to provide the supply voltage
>  
>  Optional properties:
>  - enable-gpios: GPIO pin to enable or disable the panel
>  - backlight: phandle of the backlight device attached to the panel
> +- no-hpd: If HPD isn't hooked up; add this property.
>  
>  Example:
>  	panel_edp: panel-edp {
> -		compatible = "innolux,tv123wam";
> +		compatible = "innolux,p120zdg-bf1";
>  		enable-gpios = <&msmgpio 31 GPIO_ACTIVE_LOW>;
>  		power-supply = <&pm8916_l2>;
>  		backlight = <&backlight>;
> +		no-hpd;
>  	};
> -- 
> 2.19.1.568.g152ad8e336-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
