Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CFE215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CFE215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeI1BBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:01:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43939 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1BBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:01:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id s69-v6so3060162oie.10;
        Thu, 27 Sep 2018 11:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2GMxYCbXDVfdpxmkx1s2jae9T5rVoEHKYZvO2N+Z7o=;
        b=swzUsQat6KPsCC0CywscTO2MPNwBdGDVmRGxVrqZnhsX5ihTLSfDKay5/zzwOdEkg2
         mkk8MO9l0qHmtwgfsQC/VIs0EaZrMJAsB0QVoVxjC51f+NiyXOBF/aqifZt1d07/oBSH
         PRwlMpc81KJ0yn7kminv1G+NrPLvlmPmu7ym8OEvSmC8UnFPV1VZbFQLmTgPz1NjJCs/
         fnF5c+hQTrO0enTXjkXFMSamZ0A23WvUgNIeUP9MbCiJdBEOEJwXRvGBI9jbmLA0rbtg
         bXsQKpGObg24AazftKtXYzGZ193ekXBAa/Q8l0+Tp7xj+M0mjP+TRJYIzZIoVu0NcVdZ
         imoQ==
X-Gm-Message-State: ABuFfojKv/tvXphhIxB0s72eWn5dh3AVr5vesqRzCR8Rv/htksitugMR
        rhk3zpSqAftNSOo3Y+XKZw==
X-Google-Smtp-Source: ACcGV60Bi4CBzCeGhC7txf/pehnOQFztfS2DvO8y3DZQZXmxRtvF138k3Z7t4FeSBGiuIJHCr0ktWw==
X-Received: by 2002:aca:aa4f:: with SMTP id t76-v6mr4024707oie.253.1538073683197;
        Thu, 27 Sep 2018 11:41:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o125-v6sm1020795oig.44.2018.09.27.11.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:41:22 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:41:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/20] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Message-ID: <20180927184121.GA2459@bogus>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-7-digetx@gmail.com>
 <20180924095530.GA21032@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924095530.GA21032@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:55:30AM +0200, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:39AM +0300, Dmitry Osipenko wrote:
> > Splitting GART and Memory Controller wasn't a good decision that was made
> > back in the day. Given that the GART driver wasn't ever been used by
> > anything in the kernel, we decided that it will be better to correct the
> > mistakes of the past and merge two bindings into a single one. As a result
> > there is a DT ABI change for the Memory Controller that allows not to
> > break newer kernels using older DT and not to break older kernels using
> > newer DT, that is done by changing the 'compatible' of the node to
> > 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> > property also puts the tegra20-mc binding in line with the bindings of the
> > later Tegra generations.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
> >  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
> >  2 files changed, 19 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> > deleted file mode 100644
> > index 099d9362ebc1..000000000000
> > --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra20-gart.txt
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -NVIDIA Tegra 20 GART
> > -
> > -Required properties:
> > -- compatible: "nvidia,tegra20-gart"
> > -- reg: Two pairs of cells specifying the physical address and size of
> > -  the memory controller registers and the GART aperture respectively.
> > -
> > -Example:
> > -
> > -	gart {
> > -		compatible = "nvidia,tegra20-gart";
> > -		reg = <0x7000f024 0x00000018	/* controller registers */
> > -		       0x58000000 0x02000000>;	/* GART aperture */
> > -	};
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> > index 7d60a50a4fa1..e55328237df4 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> > +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
> > @@ -1,26 +1,37 @@
> >  NVIDIA Tegra20 MC(Memory Controller)
> >  
> >  Required properties:
> > -- compatible : "nvidia,tegra20-mc"
> > -- reg : Should contain 2 register ranges(address and length); see the
> > -  example below. Note that the MC registers are interleaved with the
> > -  GART registers, and hence must be represented as multiple ranges.
> > +- compatible : "nvidia,tegra20-mc-gart"
> > +- reg : Should contain 2 register ranges: physical base address and length of
> > +  the controller's registers and the GART aperture respectively.
> 
> Couldn't we have achieved the same thing by adding a reg-names property
> instead of using a different compatible string? After all we only change
> what information the DT provides, but the device is still a "tegra20-mc"
> device.

Yes, if we were adding a reg field, but we're changing what the 2 reg 
fields contain, so I think a new compatible is best.

Rob
