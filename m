Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6996C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F382086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F382086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeK0MeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:34:01 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38554 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0MeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:34:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so17848141oii.5;
        Mon, 26 Nov 2018 17:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BMc9cpWveOFda18aIxdlYsKIrgCT3wrmCLmbsPuzadE=;
        b=ZFBjV7l/g+2YVp9i+fV0mW70DlCv3t5p/vATpogtV5t+WZf1J6hfKfzRR8v7cNrU0V
         4oj5BHBbwiuroAJIo/gmP6ooE7moz4E+u7Q/ZLiQJbUfZUNcfiTBgAU1Bm8RrSqLn57O
         W7k0T/fHTXesA4rGPNm5mItsuTcjBFVkxn3IDattRfv1nmHO+/x/OxG0JdIyrCyfbNqR
         znLk8+/qFS9JmGkLExuFswHdO6CjaUGudazs/XNTTlPD7YDNzx+CiS5vZ3/akKiJVKaO
         mILSEW+qFTGBH85ZoFte7/t9kL4X/t2g4s+Iet+5Asdd3YiAIlb1HZEGvlPFZtgq1CZv
         h+IQ==
X-Gm-Message-State: AA+aEWZE67iJmnfHr+C5MsZVtGeTPCrYEVmMZlJ0mjQ7nMsUerld/h1v
        fuQ6T+rxjt3nBH/vx0wzWw==
X-Google-Smtp-Source: AFSGD/XCvmSIhBP+hmm3vLSdSj1O/xI2HGN6TgRRliXfWP2jv5HYfWpgRIDw4OynT77b4BMrip+eIA==
X-Received: by 2002:aca:da84:: with SMTP id r126mr2672553oig.219.1543282672757;
        Mon, 26 Nov 2018 17:37:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x4sm668719oix.32.2018.11.26.17.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:37:51 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:37:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH v4 08/17] dt-bindings: timer: Add Allwinner suniv
 timer
Message-ID: <20181127013751.GA22301@bogus>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <48e7ce4d5e4c87a857cacbd01c427540c6bec002.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e7ce4d5e4c87a857cacbd01c427540c6bec002.1543131714.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018 10:43:11 +0300, Mesih Kilinc wrote:
> Add compatible string for Allwinner suniv timer which is similar to
> sun4i timer.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
