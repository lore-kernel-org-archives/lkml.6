Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA8E2689C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA8E2689C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeFZVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:12:57 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35111 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeFZVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:12:55 -0400
Received: by mail-pg0-f65.google.com with SMTP id i7-v6so8167361pgp.2;
        Tue, 26 Jun 2018 14:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhFAFfVfMsfBbMOO7hKGZid1eiJEwaO3MlIjGk84Yic=;
        b=dLSs8nNQiMbCL5TWk9wdOjRdWmoe22RV4XUMCWILeZSjdljRATf9ODDhEW5F4rcmcm
         arO06lakBnkU4y9sP4UBybz0hsrEZtBRyQHbNCciJt+RvV2uELUKKt6ez3GbuZKY8p4X
         dXrwJfF9yASAKK7l+YMdb4e7NChLHwUpGxFK4uXwRb3l+K677Eu3rDvKg0nC/1t6HbR0
         +NRSmwAky+8+sibPxkmiptc6pn7p35KydlAlH/ryomQFKHLWSrcFFyn6NvyWZAxwXwoK
         B1mmsTuoJlw/kRTeQfv2PcFASTbMDddp8t94vPg/E13V6SqYRGKmi1THL7O9lx2V2YRg
         FZOA==
X-Gm-Message-State: APt69E1GCxDqKpr8Hdk2sPf5XQ730JxIfA53EzE2Ia6jpqFFCi6c9iCn
        stO2KUA/pzciQE4uaAO3kQ==
X-Google-Smtp-Source: ADUXVKLeHlm1kw//fDH7GCt5U+aioS3Vpoy6Ztl9USBt6behkldEc6SEtByezK14Wsa+EOeyKNfnUQ==
X-Received: by 2002:a65:65ca:: with SMTP id y10-v6mr2708022pgv.359.1530047574809;
        Tue, 26 Jun 2018 14:12:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m1-v6sm3576905pfh.155.2018.06.26.14.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:12:54 -0700 (PDT)
Date:   Tue, 26 Jun 2018 15:12:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250_omap: Add compatible for
 AM654 UART controller
Message-ID: <20180626211253.GA21853@rob-hp-laptop>
References: <20180619194450.6353-1-nm@ti.com>
 <20180619194450.6353-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619194450.6353-2-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:44:49PM -0500, Nishanth Menon wrote:
> AM654 uses a UART controller that is only partially compatible with
> existing 8250 UART. UART DMA integration is substantially different
> and even a match against standard 8250 or omap4 would result in
> non-working UART once DMA is enabled by default.
> 
> Introduce a specific compatible to help build up the differences in
> follow on patches.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Acked-by: Rob Herring <robh@kernel.org>
