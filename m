Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50953C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DBC20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DBC20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeHaQ1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:27:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45059 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeHaQ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id z125-v6so1224613qkb.12;
        Fri, 31 Aug 2018 05:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPmzcmLs58JkHILMSVG6osCwWpfyobvtVOvgT1sHsGg=;
        b=jFC8akOOv2TLHyIQpQChprMDtcUWEVqr1pL0IIjoNWTyidgNi+A9DXr2w7iGnZFiEY
         2coyQmWB3Y2cRarktAIA8CxrkRNaqIBwmKWLEDmNqYj4C+3Owg56GFgxoH0R2ComCTB2
         nGRzPfCTLrnHrZNk3XYWHF6fgNVU63SlPLCmhVcWYDCf0OzgQEsxOkNrfEd1bcm3/yDj
         Npg1yWz72QO7xtAsM1klhZgyOO13ZnlFoaZyabbM1JMLY9js2ofefarMTs3rUmqykC2T
         Df2Z26M0Wb5mIgfU18lfHD8iCCEaJzMl+6tLpIuksosm41Sjn1fs1AW6VVXwvWSlUNkJ
         fNgQ==
X-Gm-Message-State: APzg51B9OXTl3kINXmImSaq0QTva6TvsLp04X9uJ+Nre2D0xnb1DnfuC
        AHB2By0Lzvp1JQDUTX1ZRw==
X-Google-Smtp-Source: ANB0VdYY+LtEwSAtDUuMfL/KfGjwbPFb8319Rh2jQS8ZbO3Z3kp4uMZF+mdpsAAUPvODBCV3o8eevg==
X-Received: by 2002:a37:3492:: with SMTP id b140-v6mr14108411qka.355.1535717999649;
        Fri, 31 Aug 2018 05:19:59 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id k126-v6sm5303867qkb.91.2018.08.31.05.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:19:59 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:19:57 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: rcar-gen3-phy-usb3: Add r8a774a1 support
Message-ID: <20180831121957.GA25474@bogus>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535097375-5561-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 08:56:11 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
