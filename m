Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B772EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BDB2087B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BDB2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeH2E7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:59:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39957 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeH2E7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:59:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id l202-v6so6245079oig.7;
        Tue, 28 Aug 2018 18:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3h3BiNEvt4Q2twhoM/9frSw0r+9PQiqf0YCxrrnID9A=;
        b=JpyG9QoMTXicPZaG2UBmvIAIgcoAujXSZ1GbCDAMXyfjeBeOPCxBRXeXEGVVlNy5v9
         E1GTEJN0Q9PVjRQTXEZWll+xaQ0J7wBJxLnt3xdz0LISgTLOcuh0oeQl/erXytacbd4K
         cusY6BCWyhac9jTwAMgSa8DeF9rROPEBrAQJadpB7fwmnkOT2NA8i6MBTjogx98/SRsb
         Zi3T7omh4K6P/qJRkqot92Jf9YOLR1YLUQ2QG6NSgtNvRvl924RXMlMBEwZ6zSl0Jfew
         k0hLzLvQxEPum92YJbH78YKjZ8CXPc0R4yHiv1E2o8TM7zvC7wBj2ewhjHeOmxVqQvnm
         99IA==
X-Gm-Message-State: APzg51BCtNMEme02DY122QENoh74zx4+ChGzX2fmqJpBrGCmTUbg+eQH
        p4ahQgJgKcI/Ojyix63yghSsAYTqZQ==
X-Google-Smtp-Source: ANB0VdbPiz7cp6xa+nm9eI9dBNFSnVi/T6P7yxjqtj7xZpbV/6Nv553TN81py+ZJJQBPZtDVZDwXOw==
X-Received: by 2002:aca:4342:: with SMTP id q63-v6mr571244oia.309.1535504701639;
        Tue, 28 Aug 2018 18:05:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j16-v6sm1387516oib.42.2018.08.28.18.05.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 18:05:00 -0700 (PDT)
Date:   Tue, 28 Aug 2018 20:05:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, andrew@lunn.ch,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v2 2/3] dt-bindings: net: dsa: Document B53 SRAB
 interrupts and registers
Message-ID: <20180829010500.GA28253@bogus>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
 <20180828175420.7992-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828175420.7992-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 10:54:19AM -0700, Florian Fainelli wrote:
> Document the Broadcom roboswitch Switch Register Access Block interrupt
> lines and additional register base addresses for port mux configuration
> and SGMII status/configuration registers.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/net/dsa/b53.txt       | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/b53.txt b/Documentation/devicetree/bindings/net/dsa/b53.txt
> index 1811e1972a7a..5f1029e853b8 100644
> --- a/Documentation/devicetree/bindings/net/dsa/b53.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/b53.txt
> @@ -46,6 +46,29 @@ Required properties:
>        "brcm,bcm6328-switch"
>        "brcm,bcm6368-switch" and the mandatory "brcm,bcm63xx-switch"
>  
> +Required properties for BCM585xx/586xx/88312 SoCs:
> +
> + - reg: a total of 3 register base addresses, the first one must be the
> +   Switch Register Access block base, the second is the port 5/4 mux
> +   configuration register and the third one is the SGMII configuration
> +   and status register base address.
> +
> + - interrupts: a total of 13 interrupts must be specified, in the following
> +   order: port 0-5, 7-8 link status change, then the integrated PHY interrupt,
> +   then the timestamping interrupt and the sleep timer interrupts for ports
> +   5,7,8.

Bulleted lists would be easier to read.

> +
> +Optional properties for BCM585xx/586xx/88312 SoCs:
> +
> +  - reg-names: a total of 3 names matching the 3 base register address, must
> +    be "srab", "mux_config" and "sgmii_config";

Here too, one per line please.

> +
> +  - interrupt-names: a total of 13 names matching the 13 interrupts specified
> +    must be: "link_state_p0", "link_state_p1", "link_state_p2",
> +    "link_state_p3", "link_state_p4", "link_state_p5", "link_state_p7",
> +    "link_state_p8", "phy", "ts", "imp_sleep_timer_p5", "imp_sleep_timer_p7",
> +    "imp_sleep_timer_p8"
> +
>  See Documentation/devicetree/bindings/net/dsa/dsa.txt for a list of additional
>  required and optional properties.
>  
> -- 
> 2.17.1
> 
