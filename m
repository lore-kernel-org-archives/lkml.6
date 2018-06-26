Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37811C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4683208CE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4683208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeFZVJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:09:37 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43828 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFZVJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:09:35 -0400
Received: by mail-yb0-f195.google.com with SMTP id g3-v6so5164912ybf.10;
        Tue, 26 Jun 2018 14:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxLSnY86HrcXgLhCNyFgwB752TxCF/6UFa3sJMY61Mg=;
        b=H9f1d4H3LUe3jivwMzabiDIub4f+dJhIRiNwLyS8Jab8xL9LVkt7RxPtaHeQkVO0oL
         62dq29ApY9uoZUkjk0ASI6PwUcUwBtwHwACa9s0sMaA/O4LcWFtiBTDrRhCzmuKOF6Pf
         Y0uFHEjN4xhdYhNwX3vfWF//jWRbWG84g8Pe2YV9Apkcmnzh85gBJncocpT1JxQfmOaZ
         HY4R7UGFRSx0RyQVlZgo4/o4yWFC22+2Q3B3boLJot8J46w3lGGKffbq2hQ1cWJOplTz
         RuG/D6qZaHvLYPD20Dh0XNKd0ujXX3zBp6R8YEjVSnXfQwB2fRRNmLKRue2+RnqiyRwx
         Ww1A==
X-Gm-Message-State: APt69E0ikZ7YMV3qC+frAwciKMMQ1W7qU+XuYPtVibLxX3MLCfvR3r9O
        NNckVtjANDYiewHS1lxQggNRF4A=
X-Google-Smtp-Source: ADUXVKIBcDTaaLcEGFxc5WzMkQTSJDh8FsKYkR2eTeVRLuj3QgR4mXsvtYHhMcC1AEszic+Yi/8Ywg==
X-Received: by 2002:a5b:484:: with SMTP id n4-v6mr1646180ybp.347.1530047374386;
        Tue, 26 Jun 2018 14:09:34 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id k64-v6sm1379151ywb.7.2018.06.26.14.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:09:33 -0700 (PDT)
Date:   Tue, 26 Jun 2018 15:09:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: mailbox: Add support for secure proxy
 threads
Message-ID: <20180626210932.GA16131@rob-hp-laptop>
References: <20180619194337.31522-1-nm@ti.com>
 <20180619194337.31522-6-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194337.31522-6-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:43:36PM -0500, Nishanth Menon wrote:
> Secure Proxy is another communication scheme in Texas Instrument's
> devices intended to provide an unique communication path from various
> processors in the System on Chip(SoC) to a central System Controller.
> 
> Secure proxy is, in effect, an evolution of current generation Message
> Manager hardware block found in K2G devices. However the following
> changes have taken place:
> 
> Secure Proxy instance exposes "threads" or "proxies" which is
> primary representation of "a" communication channel. Each thread is
> preconfigured by System controller configuration based on SoC usage
> requirements. Secure proxy by itself represents a single "queue" of
> communication but allows the proxies to be independently operated.
> 
> Each Secure proxy thread can uniquely have their own error and threshold
> interrupts allowing for more fine control of IRQ handling.
> 
> Provide an hardware description of the same for device tree
> representation.
> 
> See AM65x Technical Reference Manual (SPRUID7, April 2018)
> for further details: http://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Changes since RFC:
>  * DT binding have been seperated into it's own file following Rob's feedback.
> 
> RFC: https://patchwork.kernel.org/patch/10447695/
> 
>  .../bindings/mailbox/ti,secure-proxy.txt           | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
> new file mode 100644
> index 000000000000..ea2ccc607b35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
> @@ -0,0 +1,50 @@
> +Texas Instruments' Secure Proxy
> +========================================
> +
> +The Texas Instruments' secure proxy is a mailbox controller that has
> +configurable queues selectable at SoC(System on Chip) integration. The
> +Message manager is broken up into different address regions that are
> +called "threads" or "proxies" - each instance is unidirectional and is
> +instantiated at SoC integration level by system controller to indicate
> +receive or transmit path.
> +
> +Message Manager Device Node:
> +===========================
> +Required properties:
> +--------------------
> +- compatible:		Shall be "ti,am654-secure-proxy"
> +- reg-names 		target_data - Map the proxy data region
> +			rt - Map the realtime status region
> +			scfg - Map the configuration region
> +- reg:			Contains the register map per reg-names.
> +- #mbox-cells		Shall be 1 and shall refer to the transfer path
> +			called thread.
> +- interrupt-names:	Contains interrupt names matching the rx transfer path
> +			for a given SoC. Receive interrupts shall be of the
> +			format: "rx_<PID>".
> +- interrupts:		Contains the interrupt information corresponding to
> +			interrupt-names property.
> +
> +Example(AM654):
> +------------
> +
> +	secure_proxy: secure_proxy@32c00000 {

mailbox@...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
