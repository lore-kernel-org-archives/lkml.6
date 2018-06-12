Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F372FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B349B2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B349B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934647AbeFLVy3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:54:29 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44318 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeFLVy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:54:26 -0400
Received: by mail-yb0-f195.google.com with SMTP id w74-v6so180643ybe.11;
        Tue, 12 Jun 2018 14:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLNOp8tnl1mR65j8sBzLUifofbVgFydodAw0lKVijTM=;
        b=oYUD87gNjPaeCc52USJ3fBFX+PDc8ISN64GMZDHo+ULJAKdzp6BIAL1Ta86wtyU2r6
         Fng3V4enjbBv6vKfo2xqf38z6My5JAydyFAhI235MyETHDKD8Dwlk3HmAA/cny0UTkcf
         +hCctjYTiEkU2HDlz0A7c7SPps+UB/xcdOsw0b3ZfQZM7KPgXhnzl2T+50qLaZA5MKX9
         YNPA98RUACvauMZ2dYVJdFhHNtxvqscU+vC552TB056y+dOaNGPtw/mqcN4DA0PNnNca
         Ft7U+ha0Xh72OQIFH0Rzwn/xalDIpx1F+0AgYLIROcv7NrcjjUHpIOjEtnKFGlk41WQW
         0sJg==
X-Gm-Message-State: APt69E2v/lcZvcvjbaac9vDwKI6SOxt3w6ebDTzAfwl1oKCZon1MCFHU
        QGh6EKEWh0J2FqvTi0klKA==
X-Google-Smtp-Source: ADUXVKIxRVSZ0JvG88ik+pj/849q54R/4BhnOjx56C6oduvxiJzss+DWXPf/2UKwi3ocMK4LK9v60w==
X-Received: by 2002:a25:d953:: with SMTP id q80-v6mr1101177ybg.428.1528840465696;
        Tue, 12 Jun 2018 14:54:25 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id o206-v6sm483949ywb.30.2018.06.12.14.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:54:25 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:54:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: clk: at91: Document all the PMC
 compatibles
Message-ID: <20180612215422.GA7376@rob-hp-laptop>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
 <20180607084107.4461-3-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607084107.4461-3-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 10:41:05AM +0200, Alexandre Belloni wrote:
> Add missing PMC compatibles to the list of available compatibles.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

