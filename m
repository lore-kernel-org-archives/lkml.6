Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1673C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66A120841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66A120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeGaWai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:30:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52939 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbeGaWai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:30:38 -0400
Received: by mail-it0-f66.google.com with SMTP id d9-v6so6520942itf.2;
        Tue, 31 Jul 2018 13:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KxghcjWyrS/AVSqdOccFwA991RWrPEOtyw0nAZ1lEc=;
        b=BTiZ68foIq/XoMNnziTyYlr5+uSGsGq1VxCZnr7Ts2uCdnePC3fLQRVbozFAIXI5R9
         2mz7VyDYCtffBu/5EO3S5upi+b0q4F0OiPCob3anOy+nrz+1xK0XiuWQsGyNa7Bt343w
         GqoGfB2NFDod1AQQuXR3bh2i5CkUn95U50zdNxk+mYxJJdqg4+Rw3NNgQsQ3/NSXuKVO
         LK5MQ+38N85tAXRx//X4HJip/gf2ZDoCfsx+5JopinUnCteFycjU/V9ur6EVYWWTBC7p
         YEZWf1eC22W9xCnRvlWmjKREN4Hrb6UnmumEkKnGjWfDbLQlH1zCkPL3BHy4ht48LqEV
         gabA==
X-Gm-Message-State: AOUpUlEUDNRzCEg3i9MP0LqMok9uDXXzaSD46AZ0A8LJfabDYrLXxhnN
        v3UWSS1rn2QXrqf3fOAlhg==
X-Google-Smtp-Source: AAOMgpc24zMcIxa1Y3rZ3Fc4AuQmdWYqZkaaBRNegCO6K3cW1bgajTrFgM49RwBfFw6ZdPwGYxF9/w==
X-Received: by 2002:a02:97a1:: with SMTP id s30-v6mr20736989jaj.89.1533070109843;
        Tue, 31 Jul 2018 13:48:29 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id d10-v6sm4630880ioc.76.2018.07.31.13.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:48:29 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:48:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 5/7] dt-bindings: net: Add clock handle to Broadcom
 iProc mdio mux
Message-ID: <20180731204828.GA12431@rob-hp-laptop>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532726613-6483-6-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:23:31PM -0700, Arun Parameswaran wrote:
> Add clock phandle, of the core clock driving the mdio block, as an
> optional property to the Broadcom iProc mdio mux.
> 
> The clock, when specified, will be used to setup the rate adjust registers
> in the mdio to derrive the mdio's operating frequency.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
