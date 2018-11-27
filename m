Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FB8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFB7208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFB7208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeK0MgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:36:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35344 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeK0MgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:36:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id v6so17868446oif.2;
        Mon, 26 Nov 2018 17:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CyutGOBv/HX0ejVt1t3AHmgKWfoukgRIR+73rn5zSUE=;
        b=bRnhzJhAeq0Hj9TeFIBpYw/bMey9FYE68gErdAimqlkfJHAvo7jG85JBUAVqp9b018
         wI/8LBMkEUYKAdYaoTqN7Sg9i3iYtnuqHJAOPe8eng4l4j6rN/8vwcGICe7zo71P2dDF
         BejAeTq1k1PKE+07Uqj1ouhRcNcliWI7JvmGbKatxwD1ojnEGb1KJapiGpLn3eqcyalh
         9kmyUKxs83UL00MLqqdo1SUiTH/FUuxF3BKUDRIGQfqkNWbMMFCqy7CqUi+U/kM1iZMO
         NAEMFDVHaAayYYZ5tHz6AgZGKNgkpYirOBLLq1OK2U4C1TEUwbbMeaBZtWnSKae5oBol
         yMww==
X-Gm-Message-State: AGRZ1gIQArRS3z1FS1I94iK12C9vH4yX4oVPBDN9fOIQPchPML/9s0TP
        b4Ss6CPHe+v7RamEYwx9EQ==
X-Google-Smtp-Source: AJdET5d07feOwUQdm0X/davg+u3wKcp3yzl72GJybkFD0mBk42IZNDhGYTOckIMJneYpJM9ViLqboA==
X-Received: by 2002:aca:d4c9:: with SMTP id l192mr17459996oig.307.1543282815171;
        Mon, 26 Nov 2018 17:40:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm1861097otl.62.2018.11.26.17.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:40:14 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:40:13 -0600
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
Subject: Re: [RFC PATCH v4 15/17] dt-bindings: watchdog: Add Allwinner ARMv5
 F1C100s wdt
Message-ID: <20181127014013.GA25898@bogus>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
 <29723ab4d09399185b8807a3f20bb2551b940f2f.1543131714.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29723ab4d09399185b8807a3f20bb2551b940f2f.1543131714.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2018 10:43:18 +0300, Mesih Kilinc wrote:
> Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
> Add definition for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
