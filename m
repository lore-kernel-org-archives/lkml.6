Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B94C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD0E20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD0E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeIZDWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:22:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45451 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbeIZDWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:22:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id d63-v6so2732767oic.12;
        Tue, 25 Sep 2018 14:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NNQkC+N5u/Vvyw4gCpFPx10zNS/j8aX83CP2yallE2o=;
        b=mV6ZlDBeUwPBuBWrEUu9QwnNRlQuuoN4tCA6pB/mWCtySzegS19dv/pprNuUoocZHs
         hRrFhAy565VCvCO6GGUDHSNDG8oDDYRyU1wUPdWP6WnK5kj7rgCTWPX5hAmxw2AhOMKv
         Nb1eeNu9McbFRgo+xkWDz6NXUsiBMxRkGFVCOIhFGEvWtrnB2AU4kIXG9g85Hh3jIhdq
         6/ZX0RxKs1kNUE3P3pQbq3bmcPq/VCgh3z2wYKQETIqhJwT34wz8efxS488mQThQEPhD
         xfU5IUm2xrZVK5wiH/BDq0fp7iABHoJxFzKM4RYMPIWqEmM4tNDHNZ96EQf/FuCMJzRD
         Zp6Q==
X-Gm-Message-State: ABuFfojM4f57UhszavySRapuNULBNDWsSYiQ0UgRKwvTjR1CE8+XasBe
        xCe44AEugWxH26OTuKY0Hg==
X-Google-Smtp-Source: ACcGV62SidQdPcrPIRBKtrqvmKZGKQb/kaRxljLHaMlzajn0y9XXOXo6VgvG8pB2qm+T62/Fq4wzMQ==
X-Received: by 2002:aca:a5b:: with SMTP id 88-v6mr1936oik.324.1537909991117;
        Tue, 25 Sep 2018 14:13:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x23-v6sm1005079oie.0.2018.09.25.14.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:13:10 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:13:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Jonathan Liu <net147@gmail.com>
Subject: Re: [PATCH v2 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
Message-ID: <20180925211309.GA12535@bogus>
References: <20180907041948.19913-1-wens@csie.org>
 <20180907041948.19913-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907041948.19913-5-wens@csie.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 12:19:46 +0800, Chen-Yu Tsai wrote:
> This panel is marketed as Banana Pi 7" LCD display. On the back is
> a sticker denoting the model name S070WV20-CT16.
> 
> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
> However the panel only does 262k colors.
> 
> Depending on the variant, the PCB attached to the panel module either
> supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> itself.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 12 +++++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
