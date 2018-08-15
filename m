Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2097FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D3121534
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D3121534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeHOXJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:09:00 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46174 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeHOXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:09:00 -0400
Received: by mail-io0-f196.google.com with SMTP id x5-v6so2000786iop.13;
        Wed, 15 Aug 2018 13:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OLz0OlrSq8ZhXun5jugmgvFHYLqyfFqPM17qNfxRsdc=;
        b=XxK2FBT55Cq5oow56R/aFEaunHza/55nG5oyIMTOy7RL6RA5vo870Hzx0uaNM9wQcC
         ZXiQSBGfwqz69ZFFuv3Qi+6ba/Bilst8IsIfSAtj4AAjof7QBRp+7YPMXnXWM1oMPzZ5
         cwZEhKKU7M+WOrzfWLwtEJcOrTQMd/WSWhNiR+mO0TxyzLYIYc3TDKX3d0XB4T3a0xrQ
         k5p7ofkzCO6MVVDYyBakg7OcD6wJcq+Zf/JMO/b4mbHG8UNwX04Y7uz3YiJSljTUYr6B
         74MToHjs7fNZAmplYo32hQadab628r95bn8a1wQbturN7bqmmkDu/mlZDZIB7Mph7+90
         sYMg==
X-Gm-Message-State: APzg51ByC58VZMEKGVz7vEFVWzeoOmHc1QuiJbc8761uWESQ6qY5CfHa
        X4S8IknOf8B7v85RuqR5hQ==
X-Google-Smtp-Source: ANB0Vdbq6dmhcMov4OX4fQlQy6/J+0V4UZpBcnBMv1vDp4a6Lzbi7susw4hrQjDqV1PWryhWvaqJEA==
X-Received: by 2002:a6b:e508:: with SMTP id y8-v6mr1414383ioc.285.1534364121740;
        Wed, 15 Aug 2018 13:15:21 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id g6-v6sm969998iom.48.2018.08.15.13.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:15:21 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:15:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: sh_mobile: Add r8a774a1 support
Message-ID: <20180815201520.GA32035@rob-hp-laptop>
References: <1534249988-15635-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249988-15635-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:33:08 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
