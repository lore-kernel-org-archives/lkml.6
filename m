Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95EE20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9uzx2fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95EE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeKIQPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727366AbeKIQPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:15:36 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1B1220825;
        Fri,  9 Nov 2018 06:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541745389;
        bh=F45gB81GD0qjQYm/jpP5dtWMh5M/68gRQXx0K2j0NIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9uzx2fAk/4gsU3ok1lW3QB/HSLqfeZLsnJW8I1q4cKPY8L98xkURNeOVOwBz4c0L
         TId8t66alRLGm1Xm67Xgci/aNGyPEnWg9+spmUJQeIafFbih4zkcqpI78er1Evl6IT
         FdM6Htq2ciuSJxkq5EEmcKcQ4xI38iKQk3yh0m9Q=
Date:   Fri, 9 Nov 2018 12:06:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable some qcom remoteproc configs
Message-ID: <20181109063621.GM12092@vkoul-mobl>
References: <20181109061631.8245-1-vkoul@kernel.org>
 <20181109061631.8245-2-vkoul@kernel.org>
 <20181109062727.GB10915@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109062727.GB10915@tuxbook-pro>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 22:27, Bjorn Andersson wrote:
> On Thu 08 Nov 22:16 PST 2018, Vinod Koul wrote:
> 
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Enable remoteproc configs to boot the remoteprocs on QC chipsets. These
> > are common configs and not specific to a specific SoC so should be enabled
> > across the board.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/configs/defconfig | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index b02da2e7a39a..b38d92c96c81 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -614,9 +614,15 @@ CONFIG_TEGRA_IOMMU_SMMU=y
> >  CONFIG_ARM_SMMU=y
> >  CONFIG_ARM_SMMU_V3=y
> >  CONFIG_QCOM_IOMMU=y
> > +CONFIG_REMOTEPROC=m
> > +CONFIG_QCOM_ADSP_PIL=m
> 
> This is now CONFIG_QCOM_Q6V5_PAS
> 
> > +CONFIG_QCOM_Q6V5_PIL=m
> 
> and CONFIG_QCOM_Q6V5_MSS

Sure I will update this

-- 
~Vinod
