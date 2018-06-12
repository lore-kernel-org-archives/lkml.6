Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7F068C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E090208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E090208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934219AbeFLVj2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:39:28 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35381 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeFLVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:39:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id v131-v6so173387ywg.2;
        Tue, 12 Jun 2018 14:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dsore9fvyk5l0sd8PJp39GRh5hfi7yl00SGYJvam2vI=;
        b=HVGEI/edmFymrXWV18+SYkIUQg6OUWs/GrSZOqyGnpBSAwU2pR1RzvCilCPrFEKwOe
         Rl9g6oiVIEvq5OJ6DFwnI7ZXoyxpnUo5jDl5go6F+7YaJztgkoChtIFr3qoKQgqbJD8U
         BHWNx1pzQCALRzYrJ+xnJwuJKHjIZRJUt7gd2dPtiDOzHWyc1c75MvFOIjbBSc+2Hqcd
         WxW+SoYKcRxpCYO3WL9q4YWmrmYNjODqCtvHEO6BWp1Ug/m582Gb/PiUmV6G2Zxc7mQD
         HUTnr7JmW5eUiytd/O9VNq2uzhTY8cZZl5Y+VNB/tCdBU9HCH9tGB777/yaMLcyk1ynV
         EIrg==
X-Gm-Message-State: APt69E0YWV4VVJZD11vOJ9PbVjYsICckOysJA+bPMgakhU1fz91chwsH
        D4FwX/Rb51+G0Y8fqNbytw==
X-Google-Smtp-Source: ADUXVKLxXSjUO1BZP9R7XIsQh2k9ckiL0fUjouWPj7vps2+nvAKGfx8IMTT3edryqsuGFZEdJj/PIA==
X-Received: by 2002:a0d:f884:: with SMTP id i126-v6mr1108404ywf.245.1528839564666;
        Tue, 12 Jun 2018 14:39:24 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n19-v6sm1050201ywh.55.2018.06.12.14.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:39:23 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:39:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] Documentation: dt: keystone: ti-sci: Add
 optional host-id parameter
Message-ID: <20180612213922.GA26791@rob-hp-laptop>
References: <20180605062640.3356-1-nm@ti.com>
 <20180605062640.3356-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605062640.3356-2-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 01:26:38AM -0500, Nishanth Menon wrote:
> Texas Instrument's System Control Interface (TISCI) permits the
> ability for Operating Systems to running in virtual machines to be

...for OSs running in virtual...

> able to independently communicate with the firmware without the need
> going through an hypervisor.
> 
> The "host-id" in effect is the hardware representation of the
> host (example: VMs locked to a core) as identified to the System
> Controller.

So the hypervisor will fill in host-id's for each VM instance?

> 
> This is introduced as an optional parameter to maintain consistency
> with legacy device tree blobs.
> 
> We call this with a vendor prefix to prevent any possible confusion
> with SCSI ID (m68k) kernel option.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> index 31f5f9a104cc..b56a02c10ae6 100644
> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> @@ -45,11 +45,15 @@ Optional Properties:
>  	debug_messages - Map the Debug message region
>  - reg:  register space corresponding to the debug_messages
>  - ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
> +- ti,host-id: Integer value corresponding to the host ID assigned by Firmware
> +	for identification of host processing entities such as virtual
> +	machines
>  
>  Example (K2G):
>  -------------
>  	pmmc: pmmc {
>  		compatible = "ti,k2g-sci";
> +		ti,host-id = <2>;
>  		mbox-names = "rx", "tx";
>  		mboxes= <&msgmgr &msgmgr_proxy_pmmc_rx>,
>  			<&msgmgr &msgmgr_proxy_pmmc_tx>;
> -- 
> 2.15.1
> 
