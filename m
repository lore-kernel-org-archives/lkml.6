Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30F7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49520895
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 16:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C49520895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbeHOTEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 15:04:55 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36010 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHOTEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 15:04:54 -0400
Received: by mail-io0-f195.google.com with SMTP id m4-v6so1424468iop.3;
        Wed, 15 Aug 2018 09:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ILHDgdHg7rcID1XCIoej2crakmqE9H+ETT0/2eKCIQ=;
        b=TN98wIgZpjj0KAH+xoCr1iLr1FRdDcVtPMO/wkIBKlK1jvi9LitCEC+GD4T1lFhEFm
         20/paBLhv7Q8/r8wmfI1seWZxVI9AYL/+FT2unmLBFr313f229OdLjzGanoDTHaPD5RE
         sXqY1c7emKN9QCQUuSwjZGC/bq6UTXXg/7TMf8lxHszvnLoXnkACduVCVSJpe1xcu3ke
         SlLp32sTzAOtG1DNb+OggTxg2nwIFwP5tPBP713Xl+DYrkWBLo6U6rkhMkfgrT4nS0HL
         hh35bLe6mWQkFPvw3iT9P7AxJRJEovmQfyevY8gOJ5wyjYEiH1ae+Ar8hp7kMm/UWOr7
         Z/xw==
X-Gm-Message-State: AOUpUlFqRJQCl5BvGSlVZofALeRQ4pDdrlSu1RatXOFY8oTAe0FAOo9L
        BkolZaPbk6GyHGJgfxb9oQ==
X-Google-Smtp-Source: AA+uWPxuZrIat9EoBRDBw034EG1XPqeGmdCm1dkHR4Qi9nahb6DQ0TUnTRYu1AyhIYZD9+qN3no2FA==
X-Received: by 2002:a6b:15c2:: with SMTP id 185-v6mr19808381iov.161.1534349528721;
        Wed, 15 Aug 2018 09:12:08 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f12-v6sm4100279iog.32.2018.08.15.09.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:12:08 -0700 (PDT)
Date:   Wed, 15 Aug 2018 10:12:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Message-ID: <20180815161207.GA21034@rob-hp-laptop>
References: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:32:15 +0100, Fabrizio Castro wrote:
> Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
> with this driver, therefore document RZ/G2M specific bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

I'm assuming subsystem maintainers will take this series of Renesas 
patches. They are bindings only, but you all update them frequently so 
we don't want any conflicts.

Reviewed-by: Rob Herring <robh@kernel.org>
