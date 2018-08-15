Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663AAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE3C2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE3C2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeHOXIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:08:22 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40706 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeHOXIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:08:22 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so2017499iob.7;
        Wed, 15 Aug 2018 13:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=itbcwbg2ZR6TIU1QnB2VO8Tv2QQiGBW6/Qbkjf/tsls=;
        b=jnAGqs5exWrhxHuMtCc6RLd083Yocz69CguSREwPKGASQLY2YrkJlT0h/XqCLjnlnl
         FTGjuvRl5HFY3QVGzO6kbNNCMwwj3lPqcPFNQiVwYDTG5EX7UaIi4/n5gD3dIAYkthT+
         ykLQaLyKz5DVyc66924KivMX0+Q3LupK9WbEmWTSTlpZlT8zwpRR9ssuPAE0z7OHeq9R
         hKpdcgxbvpETSg0O34+EkR0jyisZRfotZ7mJaVlV7qHAwSpZriicHqerowHAkghGpopL
         L9GCvBEXeG/2ewuPys5jFde/kd96hBH6uRdKmc2zo7VexpBp3CCDerVU9IbzslPDq6II
         YCfQ==
X-Gm-Message-State: AOUpUlFOsH5zM7vLxQqrZo/Ja2DMEknljizpYhcFk3dnS8PlZZiH4uMX
        70eVqxN6vnjPtUWnjky5BbWwLFo=
X-Google-Smtp-Source: AA+uWPwm0dsXCXGZFO6gMwWZ4PDLmAha5EHgTPEKLsTEepmV2FX2f9OieURPEZJfi4qzLWBrFprFdA==
X-Received: by 2002:a6b:b5ca:: with SMTP id e193-v6mr24574304iof.153.1534364083500;
        Wed, 15 Aug 2018 13:14:43 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 137-v6sm1371253itl.39.2018.08.15.13.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:14:42 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:14:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: rcar: Add r8a774a1 support
Message-ID: <20180815201442.GA31058@rob-hp-laptop>
References: <1534249975-15588-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249975-15588-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:32:55 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) I2C compatibility with the relevant driver
> dt-bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
