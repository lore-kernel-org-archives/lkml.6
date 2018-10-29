Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BCDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B068D205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="b1cmsvRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B068D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeJ3BGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:06:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45802 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeJ3BGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:06:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id i185-v6so3586541ywa.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uuvv4KbWEcHka5r4P5bFlludWOvRK7kQkTjszpNysi4=;
        b=b1cmsvRGIzQYAgNNO4vJzXtmOnhkEfihfj4HqyaQdwm0dEJ5Ckmq0sEozxG/82CcEG
         e8IPCtZozwWzBY1P7/Z2pAvHhkBdB42Xzo7gsk0rNL3aevzuRe0WKWk8DB2XPW5l2JIn
         hHEKSr99KpOxqA48pSNxA1R8vgQrPUYZVjtcuVOzLQS6iyq35a6zV0aXXMZ05j3KzK6u
         LkumFIq2OX/hmPucbboSvIVblYfUidojx3dvik+HgSOAtx1UEtmrgYV58aKaUXX3ndhc
         T91sbfdnwXBB+KPwrdi8H7TJ83nuQUYaSMcI/ERdJ3Ks0e1UDEdrjjxBCkUoXPJqDL18
         cPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uuvv4KbWEcHka5r4P5bFlludWOvRK7kQkTjszpNysi4=;
        b=YXDfcBTzjKEAkNUfY4JhA7nBZDyIW75OhqggmOR3x8rIpB6j9Iid1gqQzVSBgcoGvq
         0xdDHT393+bkjceCvqDnTQjG98J5+K5BPCkHWEdXaDRqhpilsCILK50blypUNRbThLsf
         VPeyU3yoFmC8tzaF8RwNNlSXV9VThu65az8WdE4BWzkKgzAl3Ge51AwGB7iqAf91Nb6F
         7mypIIbdn4Uf1xjG9KRAdZc8/F+d2vjf/xEHQ+gAvS7uwyX6hnJXUiTvE1ViO1Op4c5C
         SFI9oaLOoYffc/bVDVH7cclZKNrvF9t8/5NJ1oJKinpLpBnUnVWGfD9dcAfLdtZvaPfV
         TKnQ==
X-Gm-Message-State: AGRZ1gIezQoTfjbPI+o2H7iDkhynbtG2TS2Xrf6lSDmQ/ysLAyKkJtgp
        /fd1RbQ8rd8scgh2wdQHCsiCiQ==
X-Google-Smtp-Source: AJdET5dwwHUEdmq6eA1ccZTnTH6iDm9/QGfV+yVC8MaDbTbAZSaBFxkuJ1BzPeN4dHWEwfksO3pBXA==
X-Received: by 2002:a81:61c1:: with SMTP id v184-v6mr2102102ywb.173.1540829812860;
        Mon, 29 Oct 2018 09:16:52 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id g21-v6sm1525986ywk.5.2018.10.29.09.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 09:16:51 -0700 (PDT)
Date:   Mon, 29 Oct 2018 12:16:51 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: drm/panel: simple: Add no-hpd
 property
Message-ID: <20181029161651.GW154160@art_vandelay>
References: <20181025222134.174583-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025222134.174583-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 03:21:29PM -0700, Douglas Anderson wrote:
> Some eDP panels that are designed to be always connected to a board
> use their HPD signal to signal that they've finished powering on and
> they're ready to be talked to.
> 
> However, for various reasons it's possible that the HPD signal from
> the panel isn't actually hooked up.  In the case where the HPD isn't
> hooked up you can look at the timing diagram on the panel datasheet
> and insert a delay for the maximum amount of time that the HPD might
> take to come up.
> 
> Let's add a property in the device tree for this concept.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for the series, Doug, I've applied it all to drm-misc-next-fixes for
4.20.

Sean

> Reviewed-by: Sean Paul <sean@poorly.run>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/display/panel/simple-panel.txt         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> index 45a457ad38f0..b2b872c710f2 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -11,6 +11,9 @@ Optional properties:
>  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
>  - enable-gpios: GPIO pin to enable or disable the panel
>  - backlight: phandle of the backlight device attached to the panel
> +- no-hpd: This panel is supposed to communicate that it's ready via HPD
> +  (hot plug detect) signal, but the signal isn't hooked up so we should
> +  hardcode the max delay from the panel spec when powering up the panel.
>  
>  Example:
>  
> -- 
> 2.19.1.568.g152ad8e336-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
