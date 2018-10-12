Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE2C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C520865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJMDMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:12:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44503 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeJMDMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:12:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id u74-v6so10712275oia.11;
        Fri, 12 Oct 2018 12:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeMOM3Os2VgCMwR9udzQTzy0cRJf2D/iJ1mH6VpTitc=;
        b=eYJgiBFbi0+iencSfgo94lr98NLfkdBZGjOpHbuX/bMMZx6qTOeGXpcsbIKGC1OBa9
         afW3qFX4TaUDE1HcmYjimAiA8qRHtGnULzQzIs4Cfa2Fn4EgG3cf1o4oPLn1c3p5Gb3p
         ZG0tMllG+emAOPQbh1beHuOVn9hKS8v61c5sn7SdHnghkfzs01UTpTIpkNJeNs/9Hl2m
         s5oSInm8KnmNfexIujA/j6+EpKI5L3GEGrenMXlBs7R2nMCR08+Wag4YGXDuCn0VsKB9
         cs+EwXqiZqjOHNpRB7p/DdNoCGkj9ywvrA1x5uezZvg+vkpd2oBO6V/jqFPMkbv7zScQ
         daQw==
X-Gm-Message-State: ABuFfoikc9ENfxBAl8arAHnFTK9LKAsuW09LMpFf5mO4yLgII5ElPJ9w
        k+oOGk8jI/IvJXqKPXr1fA==
X-Google-Smtp-Source: ACcGV63JcSB0F3jWcGwQv3U4ASyOfYf8i7sJTaj3YqaS4okGyOpaWrBmW485uisootnS2wuPouA30Q==
X-Received: by 2002:aca:f5d3:: with SMTP id t202-v6mr4073492oih.29.1539373100139;
        Fri, 12 Oct 2018 12:38:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n63-v6sm564298oia.52.2018.10.12.12.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 12:38:19 -0700 (PDT)
Date:   Fri, 12 Oct 2018 14:38:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2 1/5] dt-bindings: usb: xhci-tegra: Add power-domain
 details
Message-ID: <20181012193818.GA4502@bogus>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
 <1538143910-24400-2-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538143910-24400-2-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 15:11:46 +0100, Jon Hunter wrote:
> Add details for power-domains to the Tegra xHCI bindings so that
> generic power-domains can be used for inconjunction with the xHCI
> driver.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
