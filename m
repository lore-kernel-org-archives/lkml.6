Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0303C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDC12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDC12086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934091AbeFLVLe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:11:34 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34157 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932985AbeFLVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:11:32 -0400
Received: by mail-yb0-f194.google.com with SMTP id n23-v6so155676ybg.1;
        Tue, 12 Jun 2018 14:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKjmOrF1I5tEXYeQ8mRJFZFQ+FuLPhLDVAYGPcUR3sM=;
        b=dhVOmrxJo5yyUUMSSDtbiFF6uzUmPr7G1WWBUzHjsIr2jYgIm7E6MxmHQDqaequx7U
         8YC+tY7j2MK1rBgHNS/HJ72hsdX0A8xD8W3HhXiSTX2PAN8v/lvACbnrhUr0jVu+La7g
         IQj1fnpk2CSUCYrEuh4qTCHwIsy0+rbj38JH5LzARB3Gry55GH+zACuxCUFMAmYVQZMs
         hVTEUWrFdx6GvuAZcsvYzYetU7P8OAi6ssBzCKT/x4orb4SpPuA7uAa4Yk0aWxNCqJZF
         nRuQ3BKpBxwyKxVNtUE3vz/sQW/HVP2pOwdjOrNlakUIUd4MDkTaXSp1NI9ot0s5Cl/E
         kBcg==
X-Gm-Message-State: APt69E0y3GDOrUVjy2XN0JOnnadML88vwJS8sxNyqQaUB93ypHjA5zvr
        f/+nROOwcFpWLf0lt71s1g==
X-Google-Smtp-Source: ADUXVKJMM1rMQcgl12Rphl4WekVE2N457+0ogkfN7i3gePaVULchBTRQCALY9HzllCLkaxpp1L4eKQ==
X-Received: by 2002:a25:add0:: with SMTP id d16-v6mr1031773ybe.378.1528837891707;
        Tue, 12 Jun 2018 14:11:31 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q7-v6sm396912ywa.57.2018.06.12.14.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:11:30 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:11:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Suman Anna <s-anna@ti.com>
Subject: Re: [RFC PATCH 5/8] dt-bindings: mailbox: ti,message-manager: Add
 support for secure proxy threads
Message-ID: <20180612211128.GA22038@rob-hp-laptop>
References: <20180605061629.4759-1-nm@ti.com>
 <20180605061629.4759-6-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605061629.4759-6-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 01:16:26AM -0500, Nishanth Menon wrote:
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
>  .../bindings/mailbox/ti,message-manager.txt        | 58 +++++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> index ebf0e3710cee..de796e90cac6 100644
> --- a/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> +++ b/Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
> @@ -7,22 +7,40 @@ manager is broken up into queues in different address regions that are called
>  "proxies" - each instance is unidirectional and is instantiated at SoC
>  integration level to indicate receive or transmit path.
>  
> +This can also be used to describe Texas Instrument's Secure Proxy
> +controller that allows for individually configurable "threads" or
> +"proxies" which allow for independent communication scheme.

There seems to be very little re-use here. I think I would make this 
its own doc.

Rob
