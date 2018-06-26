Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E6DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73523DBE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D73523DBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeFZVdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:33:24 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44307 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeFZVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:33:23 -0400
Received: by mail-yb0-f193.google.com with SMTP id a2-v6so6595719ybe.11;
        Tue, 26 Jun 2018 14:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qcx6zpfu662/VdbG/ZESbkRFtJsqRNhfy/Uevqt1tKo=;
        b=D1emLHx93jqcU81evVCruKnQ7rASlgAolBUh4Qq1YVCkw08qTjoyv47mHo1r95bmFr
         NtHmfeS3aVPb8AXz2R9bK3vrf07m4SGzrtlRaOuCP+aGIqzAVZvhwL5E6nWSSUj6BiFR
         nIFRkScFMEVK/PbFANmJnyYuP3RvZKV9igSCuyEh93EGl9oUDlJfZcG3+QRnd6ZHtgTk
         jN4fBo42zlrrypiR3GbSkAVQ40ciJcduuGJSfP8NWL2IANhbxfIjCfjA+iXRYFUnRbV7
         g3cV89sGSLLPmASbkHBliZIQQpdFJoOduzVGiAm/jrzR5THs2hVcSHCAvefE9vvXeRBy
         N6jQ==
X-Gm-Message-State: APt69E3pgUT/MdhnLCb+FPJhJQY5wpffW8eIjhDp384l8rDomWLu/O0f
        PbdYHIrxMgcbIKdZlPyAew==
X-Google-Smtp-Source: ADUXVKJLLgPhRDSJv0dBGMCegOAYM2zS+wYD7P3nxIOZTH6k9X9wfJeyguU01qcqRWbJgs0ivam+CQ==
X-Received: by 2002:a25:ef04:: with SMTP id g4-v6mr1661511ybd.126.1530048801348;
        Tue, 26 Jun 2018 14:33:21 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d190-v6sm1766887ywh.105.2018.06.26.14.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:33:20 -0700 (PDT)
Date:   Tue, 26 Jun 2018 15:33:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: w1: document sub-node bindings for
 DS2760
Message-ID: <20180626213319.GA22766@rob-hp-laptop>
References: <20180619212744.794-1-daniel@zonque.org>
 <20180619212744.794-2-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619212744.794-2-daniel@zonque.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:27:41PM +0200, Daniel Mack wrote:
> This patch add a generic w1 bindings document that merely describes how
> slave deviceses are grouped under master nodes. It also adds a specific
> binding for the ds2760 battery monitor.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../devicetree/bindings/w1/w1-ds2760.txt        |  9 +++++++++
>  .../devicetree/bindings/w1/w1-gpio.txt          |  6 ++++++
>  Documentation/devicetree/bindings/w1/w1.txt     | 17 +++++++++++++++++
>  3 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/w1/w1-ds2760.txt
>  create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> 
> diff --git a/Documentation/devicetree/bindings/w1/w1-ds2760.txt b/Documentation/devicetree/bindings/w1/w1-ds2760.txt
> new file mode 100644
> index 000000000000..86a0f4c573eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/w1-ds2760.txt
> @@ -0,0 +1,9 @@
> +Devicetree bindings for Maxim DS2760
> +====================================
> +
> +The ds2760 is a w1 slave device and must hence have its sub-node in DT
> +under a w1 bus master node.
> +
> +Required properties:
> +- compatible: must be "maxim,ds2760-w1"
> +
> diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> index 6e09c35d9f1a..a3e0e964b260 100644
> --- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
> +++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> @@ -13,10 +13,16 @@ Optional properties:
>   - linux,open-drain: if specified, the data pin is considered in
>  		     open-drain mode.
>  
> +Also refer to the generic w1.txt document.
> +
>  Examples:
>  
>  	onewire@0 {
>  		compatible = "w1-gpio";
>  		gpios = <&gpio 126 0>, <&gpio 105 0>;
> +
> +		slave@0 {

A unit-address should have a corresponding reg property. Also, the node 
name should reflect the class of device.

You don't really need the unit address here, but for multiple slaves you 
would. I'm not sure what you'd use here since the only id/address is 
the serial number which is unknown except for the family code. If you 
have 2 identical devices with some different DT properties, how would 
you match? I don't see a way other than putting the serial number (or 
some portion of it) in DT.

I'm not sure how common multiple slaves are. Perhaps just support a 
single slave for now.

Rob
