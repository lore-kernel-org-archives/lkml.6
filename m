Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CDD245D3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CDD245D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935059AbeFYUSj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:18:39 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32775 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934023AbeFYUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:18:37 -0400
Received: by mail-yb0-f196.google.com with SMTP id e84-v6so5683869ybb.0;
        Mon, 25 Jun 2018 13:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyBV0gbLp1e3fGbg6DE+VJx+DrZA0MWTsxoIIhHChzI=;
        b=F3FWT+BQmGLLHBA7PlpbL9939mYWHXn/xFCZ9DzJoD0b02ArpUZymzDPOw8UR+2TmG
         zzVcKg+7+1BB9zEbjBnc9Lg+xDWvXKgR84W+lAqYhfTth1QhcEKZb4JerGIxgraOZVMw
         eBFE4kZWjdGnz+mIjKZ9/oF1Ytq1vPQ5EzCbTmFzOlIR4C6NRNCChpSVAuEXtoWBldBx
         29sDzCuikd9MNA4ZeApE8hVaxPvXq6/xKvR0BkRlZUcUgXwy5J6/rUKRwwuro23n1pCI
         xS5XFRL0L5Hmi9exa/AVHhlfe9jOOJiSHJbGzeov980Xm+1bpF6O1TorKULZCEzilwBL
         hX1Q==
X-Gm-Message-State: APt69E3OSphtr02xbjNsCh/G7nTL9wlAqA/bKNa44AK0KoDmX8tncmk2
        IVPLpW4drPKdsk4MKBDz7g==
X-Google-Smtp-Source: ADUXVKJPnF54P9K74jADNgQhQI2ojuQ+hjQtL3Zx47AolBGrXsvZ+qbwuruhpoQHoKmsj/F8F2/y7w==
X-Received: by 2002:a25:8b8f:: with SMTP id j15-v6mr6818140ybl.174.1529957916739;
        Mon, 25 Jun 2018 13:18:36 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id j187-v6sm3818990ywd.51.2018.06.25.13.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 13:18:35 -0700 (PDT)
Date:   Mon, 25 Jun 2018 14:18:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/7] dt-bindings: add binding for the Allwinner A64
 DE2 bus
Message-ID: <20180625201834.GA14276@rob-hp-laptop>
References: <20180622124540.56203-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622124540.56203-1-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 08:45:35PM +0800, Icenowy Zheng wrote:
> All the sub-blocks of Allwinner A64 DE2 needs the SRAM C on A64 SoC to
> be claimed, otherwise the whole DE2 space is inaccessible.
> 
> Add a device tree binding of the DE2 part as a sub-bus.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> No changes since v1.
> 
>  .../bindings/bus/sun50i-de2-bus.txt           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/sun50i-de2-bus.txt

Reviewed-by: Rob Herring <robh@kernel.org>
