Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DCAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065BD21534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065BD21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeHOXJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:09:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39742 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeHOXJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:09:23 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so2027123iok.6;
        Wed, 15 Aug 2018 13:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nX2SVJgzmFf+A+sK7rkCobQRu27xjFlZ2LrFxhrQpY0=;
        b=K1sfPZsLt/Viv2w6fNaztmJhyApSd5p5MKEDLwPiFBg9+OtVqWUREP51u3bXyhFciD
         c2mwkfVWeljTigfpBKLNrNzspMqkghcgFFiRPf+ehzSVHalqpg18SmUeOWMh1O/qJ/SH
         GoLslDCh7TW6obr3/i4WsSkYKDuRGKB7oOAWnYdcxaoEXM1lekeAOzfBovgtQ/nRBmd3
         +gG50M7VXvxwatdeKNIB1V3fnAR542H72APtAhsuwfYhP/Vm/K1c7g9tabexnDDio5Nt
         cMaIrVXITExFB0+b+PReB22Qd5ijfxIkJ3LTAr4ow+3npgqW2J6fnLy4Ujo9/kfDNL0O
         GXbw==
X-Gm-Message-State: AOUpUlHRH10G18+LRvK4/7Zw17ORO5fCP04hxbGezlK3gTGcWsmIzLNK
        7mYR1W9wVRcigoychRyWEA==
X-Google-Smtp-Source: AA+uWPxocSMqYmaMdeM9DtKqgMpkmqYj1LHZ5s7FpRB/MerObXlfnZkwMpgEtzJuWGNN97EdR0JTiw==
X-Received: by 2002:a6b:e618:: with SMTP id g24-v6mr22476349ioh.42.1534364144516;
        Wed, 15 Aug 2018 13:15:44 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m13-v6sm1410352itm.40.2018.08.15.13.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:15:44 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:15:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774a1
 support
Message-ID: <20180815201543.GA32632@rob-hp-laptop>
References: <1534250008-15680-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534250008-15680-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:33:28 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
