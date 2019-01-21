Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3CCC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F3220823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548081099;
	bh=JH6+KT8TwGxCsGpkVkDYy5iPvOD+fFt6vVU0pmlcjRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tI3+zDwkbrreddWK2ZVgv7Ecd/19LplJmBYEOHnjSHmez/iTLODwS06r3npasVX8r
	 UQDWKchLAReeePJFUNXV+yQlk9iGWIkHbGHsE5KRBeM4v+IoExk4j33ySusenyckCl
	 UqSz+G53Tltjd5gctMUwmoXdeWqdhw7ur62bYj18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfAUObh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:31:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34813 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfAUObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:31:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so15651371otk.1;
        Mon, 21 Jan 2019 06:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0tsNiR/XMMG4rzOHtEqnlKAF1vDgS6H8svcE9mZOOv4=;
        b=EIy54/PBzDqkyJ9hxhvdGHqPRTABMVbuktheeslnh5lrj8cheePH5GWrtoGXVJYvOR
         MOZskRBZVf1A3LtBfTDJWePbi+/uh1dDn8gWZFiWTlGHdnTT4blTB8IpoMRsOrb0B1pv
         EtcGLEwa1h0OdN1DuZu9C6WLZSA3QcqAIkyUVnSGIlJ1DqWpRLtxPOIO56sCmtrJ4/k0
         6RhQRC3yyl6iRl7/9t5emUoxFwzqdHAyXPcpE6n8hGWRaTaQ34fkAfXCTWuyhTrwTaPg
         8VitfOfNzGUF7c5PBS/vYBvmIrwsWZEc16Qh3iDjZs6FYHT1g5yRZ7AC5BGFcjFeteC6
         Nn5w==
X-Gm-Message-State: AJcUukcaWQsd9Jjw0RM2sjxuxRYOD2Ii7WHYUqw3TX1VkvCaY0NwySAi
        xP5f9nSMp9U6qDrKQB2ExQ==
X-Google-Smtp-Source: ALg8bN41RXM2eAJR+1iCjsIDc5nxE1kVofHBrwUARMhKPqGw/XRUAPeQnV9dHMJAOdoCdq3Dqigb9Q==
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr18543771otq.146.1548081096140;
        Mon, 21 Jan 2019 06:31:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 21sm6618768oie.24.2019.01.21.06.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 06:31:35 -0800 (PST)
Date:   Mon, 21 Jan 2019 08:31:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, mark.rutland@arm.com,
        mperttunen@nvidia.com, chunyan.zhang@unisoc.com,
        jonathanh@nvidia.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V9 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Message-ID: <20190121143134.GA18401@bogus>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
 <20190121104333.GD16756@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121104333.GD16756@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:43:33AM +0100, Thierry Reding wrote:
> On Tue, Jan 15, 2019 at 11:03:50AM -0800, Sowjanya Komatineni wrote:
> > Add supports-cqe optional property for Tegra SDMMC.
> > 
> > Tegra186 and Tegra194 supports HW Command queue only
> > on SDMMC4 controller. This property is used to identify
> > command queue support controller in the tegra sdhci driver.
> > 
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > index 32b4b4e41923..fb14c2c8d7ee 100644
> > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > @@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
> >  - nvidia,default-trim : Specify the default outbound clock trimmer
> >    value.
> >  - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > +- supports-cqe : The presence of this property indicates that the
> > +  corresponding controller supports HW command queue feature.
> > +  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
> > +  controller supports HW Command Queue with eMMC device.
> 
> Hi Rob,
> 
> are you okay with the property name for this. I'm wondering if it should
> have a vendor prefix or not, but I suspect that something like this may
> be needed for other vendors as well, so not having a vendor prefix could
> be warranted in this case.

Seems likely. Please document with common MMC properties in that case.

Rob
