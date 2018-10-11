Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9C3C67837
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A9D2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A9D2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbeJLFiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 01:38:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34146 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeJLFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 01:38:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id v69-v6so8378920oif.1;
        Thu, 11 Oct 2018 15:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m72Rob7hQ1jxDb7gzj9zWe1slNizevBswPot9YrW/+k=;
        b=CgDwj4jVlB8aMUrZZjU/55nR0/n0gOlk82bsidDHfYm8T7fbapDFjx3uz1PxwQyVIc
         mDIarKMw03JvpQrKYz4Y6g6X5sdHkSwF20Q2jk5XkVvLA0psEHGmSq1CiJ91WE4OpR91
         myYCfjObrwecAXIVsUGTqWos/oV45Cp/SGDJ0IeP63EYbgRVRskxn+5Kv0393AV6ji61
         Xijy2rVSfbeI7VajQMEoYhUOvO9rbISKjiWMZLjIeZwOAHCrKFkeNc0iyhGSPqhx7W6p
         usfu156ANxfjLU8qfvBHXkI0+I3oU45LQ/Ktx+/g807C7/2M/CR5lj2HdwKTxEQGK3DK
         K6NA==
X-Gm-Message-State: ABuFfojVqZCMeXDHB5oyKgLeCyOdq4fIhCo1bSF+WQDupITPqZd9xog6
        6uEHpf+83DAmPcccAImE6v0d1i0=
X-Google-Smtp-Source: ACcGV633kPp3nAmcXYeHZYP+47k0XzXlubmqCeVmA66VWRERcUZF/Nh/osGVG0J7LDCaLJ9nDnX9fQ==
X-Received: by 2002:aca:6c3:: with SMTP id 186-v6mr1995312oig.158.1539295727146;
        Thu, 11 Oct 2018 15:08:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x15sm9699437oth.24.2018.10.11.15.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:08:46 -0700 (PDT)
Date:   Thu, 11 Oct 2018 17:08:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, leoyang.li@nxp.com, mark.rutland@arm.com,
        shawnguo@kernel.org, dan.j.williams@intel.com, zw@zh-kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/7] dt-bindings: fsl-qdma: Add NXP Layerscpae qDMA
 controller bindings
Message-ID: <20181011220845.GA20860@bogus>
References: <20181011094655.45707-1-peng.ma@nxp.com>
 <20181011094655.45707-7-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094655.45707-7-peng.ma@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:46:55PM +0800, Peng Ma wrote:
> Document the devicetree bindings for NXP Layerscape qDMA controller
> which could be found on NXP QorIQ Layerscape SoCs.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>

What happened to the version from Wen He that was on v7 and that I 
already gave my Reviewed-by on?

> ---
>  Documentation/devicetree/bindings/dma/fsl-qdma.txt |   53 ++++++++++++++++++++
>  1 files changed, 53 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-qdma.txt

