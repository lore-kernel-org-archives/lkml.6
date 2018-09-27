Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8839EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD31215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD31215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeI1BBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:01:21 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37057 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1BBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:01:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id e17-v6so2200447oib.4;
        Thu, 27 Sep 2018 11:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hed8RYzjJfUODh0Htzkg07eyIXwRSP5IwZH2p1T0Itc=;
        b=J4Bo9fyc7fE4izReMzgd8yn+L6Z0WWlMEFo/9crj2IfN9wFBBZRqdyNOt4fcdzaWAd
         BxdscVsM3f0cJw47SpQw5HcxaY+qo5WSVjOGvoSK92LhMs2IYDzIYAc8ApMJMN6eOqBm
         2PIzN5hfBiAZlVvvW1mye4vJgJX/qxolLOuZthAbVBt0/Sz0doxt9oE1U+15uWGQWa3s
         22QjFH5hYG6V3Pn3m4CTHfSjkhAWQQPxHYB3HwyB+IzG/oOqsMS4ObqpQu84ZLUcXUBR
         s6k2vQ60ZW2gljq+eldgTiizjKROyyanvKrxwX66uYzP9Lrzp4Iy7JBCweLGXm981oss
         qvHA==
X-Gm-Message-State: ABuFfojZPiNnJ4WNHwLlUin5rbkdvpbQlh9VpSF1QLa3qzUqLDV/PDc8
        rY+sQGHGnxJxnY83q/eUiiFybb/dy+Ca
X-Google-Smtp-Source: ACcGV62IykZTAsYnegdu51GNt3Fcl0RZ5nHZJVlYcq0vtMfOxZsL9KvDIZOljdhw40iXmPIhwPMg1g==
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr4046529oiy.219.1538073704276;
        Thu, 27 Sep 2018 11:41:44 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l49-v6sm1035835otd.60.2018.09.27.11.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:41:43 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:41:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/20] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Message-ID: <20180927184143.GA24866@bogus>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-7-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2018 03:41:39 +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver wasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. As a result
> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT and not to break older kernels using
> newer DT, that is done by changing the 'compatible' of the node to
> 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> property also puts the tegra20-mc binding in line with the bindings of the
> later Tegra generations.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
>  2 files changed, 19 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
