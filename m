Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EEFC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829212083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 829212083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJZECm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:02:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42096 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeJZECm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:02:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id h4-v6so5605539oih.9;
        Thu, 25 Oct 2018 12:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBlzpDj+JwD1pQVghrGadZpELwqQvp10voAshxmT/7g=;
        b=nB/zP4QNCnKBQ4RExOMZaxlH5/mqi8eLUpr8tLzf+vXzHVm2Jl6OwDaihvIePQCR0x
         Tu2fqafcCyd1OlGxWwp/4Pc+8WfgfUtlw1xRtjSDbwBLapWeDwItEB8UGmw2EPw8WL0m
         Ikz1mKGLO8ZPY82Hvxv0I0iIlp6riAdGhBiDhh/KgimaeGON7ku1bkPSFpTCYhBjncJJ
         bPOqMMEN4z1HpfWHbC91gsrIdbYfwN7jI9I1ZCqnsULz95Iv9Sciol2uJCGWEja2u79s
         EJpuMxgNfm94ej2UHWkBh0rVjbbKruzsyRglg2dCRHu9j1zv4Cqfm1ifycVbWgr/X7Pe
         5f1A==
X-Gm-Message-State: AGRZ1gIAE8h4+cm2YOAuX3dZsfv5yaPqGKSXwyM13LDh1/C1Wi/AGggT
        7PtnenhZ7i+c0ytknKF2zg==
X-Google-Smtp-Source: AJdET5dqg5UAZSb7pulMTHV53B5EWLoAjMYV6PL+RkQWbFHUJBS950/seUHo2fHAr0Fcmy06nACTWA==
X-Received: by 2002:aca:75d4:: with SMTP id q203-v6mr353973oic.334.1540495716988;
        Thu, 25 Oct 2018 12:28:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r143-v6sm1780767oie.27.2018.10.25.12.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:28:36 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:28:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        jsanka@codeaurora.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/6] dt-bindings: drm/panel: simple: Add no-hpd property
Message-ID: <20181025192835.GA30136@bogus>
References: <20181022204639.8558-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022204639.8558-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 01:46:34PM -0700, Douglas Anderson wrote:
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
> ---
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

If we have this here, then we should also have hpd-gpios defined here as 
where we describe a connection we should also describe no connection.

Now, hpd-gpios is a bit of a mess being defined in both connector nodes 
and bridge (HDMI/DP) nodes. I think that is just history pre-dating 
connector nodes. Connector nodes are now the preferred place. Connector 
nodes and panel nodes are essentially the same thing (the endpoint of 
display pipeline).

That being said, this patch is fine as is.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
