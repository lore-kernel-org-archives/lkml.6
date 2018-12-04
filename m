Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59297C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C76B20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C76B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeLDVoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:44:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43125 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDVoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:44:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so15675673oie.10;
        Tue, 04 Dec 2018 13:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MpgTRb+D63QUVhJMZMDqBPxHVh5TUjHZ5juGrlmw48I=;
        b=ObgCW+/9jW7YSY3vuAYCF6CRE6uT3yznwvVTduUvK6R3S/cSQSV0c/JMenrfBwbA81
         dUX1Tv77G/dW6dXIEmvNUtWZmkJF0pxiQNmMmSqiSv6FzZin/THyLQB3LRBrOdJpeenK
         1uRkinjEJTWWDoSa2r0mVx61cEMvyezRKlv1erqIlj+Om6xF6AXsogjsG1mOdFNb/jmg
         sB1ZjGRz4P7bNZtjzumtSa2j/C0ZEiGKVtHh6k1roD+qJlePTOPKYZRi4yb2XXjWDGiI
         9IPeKSRYK9GJtjfgiQ/ph5TJ2P2TpOdNCIy8kJLZqsK0KzNUJ3o4NlJSQ/7d4P3izwkr
         l7ig==
X-Gm-Message-State: AA+aEWaL3dmGZ7ihl09cFv+9B7J654h518VFNjG+EUexchbW8lMFlOM3
        B9gkXeLe45dTqVnL5w6sqT996J8=
X-Google-Smtp-Source: AFSGD/XN61evsfdgQKeMoyFourhsOzHmpuUu6MUaHUTeSHX6Sy+E27P49b71xDttUGTxr9wqO6PLmw==
X-Received: by 2002:aca:220b:: with SMTP id b11mr12783595oic.87.1543959855879;
        Tue, 04 Dec 2018 13:44:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u136sm7013346oie.38.2018.12.04.13.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 13:44:15 -0800 (PST)
Date:   Tue, 4 Dec 2018 15:44:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: phy: add binding for Freescale i.MX8MQ
 USB3 PHY
Message-ID: <20181204214414.GA9313@bogus>
References: <20181115141247.15221-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115141247.15221-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 15:12:46 +0100, Lucas Stach wrote:
> This adds the binding for the USB3 PHY found on the i.MX8M SoC.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  .../bindings/phy/fsl,imx8mq-usb-phy.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
