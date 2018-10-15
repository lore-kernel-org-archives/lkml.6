Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14FFC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBEC20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBEC20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJPC5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:57:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40341 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJPC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:57:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id w67so20014558ota.7;
        Mon, 15 Oct 2018 12:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FyiiAQG5553w91hmHOv6yDLVNWZpML790i7jf7hHId0=;
        b=O2kzug06U7v3SlvCIigDjodjYuA75a3t0ZOJ7W/d2Eb7Hk8ruuoO+qTGdKO0h/EurU
         U5iebutg7ZZmxZXa+LRKB/41VNrbf9R2lKoqOS5RrWA0cdFgjkIeKzKVNXLYkHcILAtg
         G+FVcTfqpEqm3WemkNSwe2DJ1cnSsYx7MabBf4MPy6OI0yjTdnfes9Xky5vaPraCZk2c
         Bzl8xsiRZx8ZQ9D7QQdWvsMlIWGYY4spblPSymNHOzEJJW4pnYIwRHeoiNhYmsK69yNC
         cvgCk/p3S5D4e9D0YVzch9gFzj3UrTP/U7eMPyYZHLOQm3MhnlVMjW+rJUzqWf9sqGYL
         NewQ==
X-Gm-Message-State: ABuFfohehRPHMc6BOjsTVI44UUAk4zTQZycxDQ3HYaCTovWk//anqtry
        Foq8dam5lJdob0CczT2tfUFtop4=
X-Google-Smtp-Source: ACcGV61AvpgfIKywSDWQdh9t5MV5mDUDrHXJUXSrdllg1ttJ4b2wGrSkNWKrkhszS+6RpPo6JV9YRg==
X-Received: by 2002:a9d:11ab:: with SMTP id v40mr11580664otf.194.1539630674291;
        Mon, 15 Oct 2018 12:11:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t11sm3696995oti.21.2018.10.15.12.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:11:13 -0700 (PDT)
Date:   Mon, 15 Oct 2018 14:11:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 2/3] dt-bindings: cadence-quadspi: Add new compatible for
 AM654 SoC
Message-ID: <20181015191112.GA6923@bogus>
References: <20181003165603.2579-1-vigneshr@ti.com>
 <20181003165603.2579-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003165603.2579-3-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 22:26:02 +0530, Vignesh R wrote:
> AM654 SoC has Cadence Octal SPI controller, which is similar to Cadence
> QSPI controller but supports Octal IO(x8 data lines) and Double Data
> Rate(DDR) mode. Add new compatible to support OSPI controller on TI's
> AM654 SoCs.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
