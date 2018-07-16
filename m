Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C51ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CBE208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CBE208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeGPQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:27:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35976 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeGPQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:27:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id r16-v6so75775918oie.3;
        Mon, 16 Jul 2018 08:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jBz9YIhaw41xr3ayLJOkvYzwFQGIs59UD3dZsB5x2c=;
        b=JeHm84gixKbLPvbjzwugQTyAY/Qa9jocZUSZqO5Tbugg9IfyQOZvoXrb60wjGo9VOj
         8c1axmBxGmuafLeaAppkvfZKORH6YST7vcaJNeeRt5PVwcb1RpiAHzcs/YFccMFK/9Tb
         S8Z7jR37FaU56+BU6oM40pXFl8H9mAre6W8GnndHJWpGM/Km/lA+CHAbg26XRSMuTADv
         j3wKytyYE4E8a+eIxuLZTEUuZvFwBeGFac/SAHD2Wr5LVVyIrgp2AJqdVhEaXFEBfVXH
         QicXzfIGD11igsDa5kXIKqBvG2JQEKD1UdXlzs2UFgrsHp7OGnK4Emfcou2Um2lcea7l
         X9gw==
X-Gm-Message-State: AOUpUlFU44XEju4muw5FWNth4zNa3ZJjhYzJIuvIjrjVRhmkYvifGxQH
        s/UME9Ma45qQ6ZcNk8hBwg==
X-Google-Smtp-Source: AAOMgpeL9968Co1H3kiiKQsUrkjCumrVfD/USgqMT4e0pfksLPHCFmXW4W+kiTykGWkVOiUWO8p77w==
X-Received: by 2002:aca:3045:: with SMTP id w66-v6mr19607826oiw.61.1531756780985;
        Mon, 16 Jul 2018 08:59:40 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n6-v6sm24202717oib.27.2018.07.16.08.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:59:40 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:59:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, tj@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, thierry.reding@gmail.com,
        icenowy@aosc.io
Subject: Re: [PATCH v3 7/9] dt-bindings: ata: ahci-platform: document
 port-supply
Message-ID: <20180716155938.GA6947@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-8-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531479786-4911-8-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:03:04AM +0000, Corentin Labbe wrote:
> This patch document the new optional port-supply
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> index 47652521a6ed..40a636b9851e 100644
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> @@ -31,6 +31,7 @@ Optional properties:
>  - dma-coherent      : Present if dma operations are coherent
>  - clocks            : a list of phandle + clock specifier pairs
>  - target-supply     : regulator for SATA target power
> +- port-supply       : regulator for SATA port

Humm, I'm pretty sure that's what target-supply was supposed to be. If 
anything, need to clearly define what is what.

How does this work with multiple ports?

>  - phys              : reference to the SATA PHY node
>  - phy-names         : must be "sata-phy"
>  - ahci-supply       : regulator for AHCI controller

Also, please group all the supplies together.

> @@ -51,6 +52,7 @@ Sub-nodes required properties:
>  And at least one of the following properties:
>  - phys		    : reference to the SATA PHY node
>  - target-supply     : regulator for SATA target power
> +- port-supply       : regulator for SATA port
>  
>  Examples:
>          sata@ffe08000 {
> -- 
> 2.16.4
> 
