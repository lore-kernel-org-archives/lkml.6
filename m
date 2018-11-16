Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26DC43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45602087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45602087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbeKQJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:33:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44682 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeKQJdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:33:45 -0500
Received: by mail-oi1-f195.google.com with SMTP id p82-v6so20985107oih.11;
        Fri, 16 Nov 2018 15:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/Ewd+i9E4r+yJpjtKbq5KdVSi7EUUy0zOQB+rnH0Mo=;
        b=ZiM3k/wNWhmWDHnqBqGekgYfCzLWhQudL5D2aenw0HZ4sEcFHN0AXpmFGy7jhCUC6z
         d2yep1ABdruCGkG+dIYAa1gGUd0ex3/pmB1vAVA0GnAjSVhLbxItz1INGm3i6GalQ54/
         El0ZCL2Jv26QPn2qo3FTOgnlWT0PXKyobiXYmw2kt6nC+GGpFffM2RJ3Tgc/IrmONKUW
         O4eprK9FK7xjd4ZLVn1B+ZGLrWVkl4ADaz+7khM49wg7ASEhSN4W6u5s7EldwDpi4gx0
         TnAA26q9ghdE6/6epxhm5/Vy9QEmpcevK4infao1ZR/Yg5sylihwq42lLfXKudaw/OvW
         4phA==
X-Gm-Message-State: AGRZ1gJ+Vq/U8MWXPT23ueCr6A/moSHXYR59kHXVMAFgvmYF0m9kURFy
        /M79dVJjOAM+v7c90YMOLQ==
X-Google-Smtp-Source: AJdET5czTvEVKQfxASXjwz9y39BthD0phD7qY1oGiiHVom5fsewdt3Lw+sEgZnYbEZnCQLFe4Yq/iQ==
X-Received: by 2002:a54:478f:: with SMTP id o15mr2194485oic.42.1542410364848;
        Fri, 16 Nov 2018 15:19:24 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id o28sm11796482otd.5.2018.11.16.15.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 15:19:24 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:19:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 17/26] dt-bindings: sun6i-dsi: Add VCC-DSI supply
 property
Message-ID: <20181116231916.GA1222@bogus>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-18-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113111633.20189-18-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 16:46:24 +0530, Jagan Teki wrote:
> Most of the Allwinner MIPI DSI controllers are supply with
> VCC-DSI pin. which need to supply for some of the boards to
> trigger the power.
> 
> So, document the supply property so-that the required board
> can eable it via device tree.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
