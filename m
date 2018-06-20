Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A637DC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618D120846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618D120846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754644AbeFTSXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:23:32 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45165 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeFTSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:23:28 -0400
Received: by mail-yb0-f194.google.com with SMTP id x6-v6so191728ybl.12;
        Wed, 20 Jun 2018 11:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNajXdI9YtjRREA+kQLTCYd2lqa+198XVBxRP7mReTY=;
        b=n/J4m7pCJIrKmVjjFSSVRKywGOw/e7MvD88N5QshSBvWy1xIbIJNg6I9h3/eDUMtfc
         tx45BbVCWOrh97AykJnk5vD7uL+zBsMtS9D0HopN6dYqQGOvuanqk+xEDfiJJgyCqaEU
         eo9PUm1im1oiV3y9eMcYN+cnwVBaY2N9q5mbnTw2Xqi17Ofulf2x3Lpp8IlCjf3kbheD
         AdL4rcloIKfdB1cSXn1WWswDWBufjwoErwjoIbuV8Gg8aXGHnlHaVnMoISBzzrV6Cf0d
         /2FEKuKvSQlkmmFdMyCnU+AagXfpOvnHOQGfBcu2KrLKDuT9NoD3D9G74lXLLyrgz3E0
         1Jqw==
X-Gm-Message-State: APt69E3QXyq7n3jiPpuX04R1so6ZtecrQdh+3skF5v8RpcA1Pmui9EpY
        VK9Hx0Ke78cJthdeQzlVNg==
X-Google-Smtp-Source: ADUXVKIHNr4rHejr3Ht5rKZPx7eRECpGpqDA4QqMoF2xuRYCd91Wyc9ljN68FUyizo3G/5JI0qCJ2w==
X-Received: by 2002:a25:5082:: with SMTP id e124-v6mr10717566ybb.349.1529519007508;
        Wed, 20 Jun 2018 11:23:27 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id s4-v6sm1063256ywa.9.2018.06.20.11.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:23:26 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:23:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] dt: bindings: tegra20-emc: Document clock property
Message-ID: <20180620182325.GA3826@rob-hp-laptop>
References: <20180617145539.4758-1-digetx@gmail.com>
 <20180617145539.4758-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617145539.4758-3-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 05:55:33PM +0300, Dmitry Osipenko wrote:
> Embedded memory controller has a corresponding clock, document the clock
> property.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
