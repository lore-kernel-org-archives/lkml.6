Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82110C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C44208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ehxEc7ms";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YuTYvNUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C44208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeG0S0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:26:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbeG0S0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:26:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 934E260B7B; Fri, 27 Jul 2018 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532711011;
        bh=O6CF6PiUBWf+GCGJdWZ2kxRd3DFfjiQ2BT6DD3lbyXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehxEc7msGB+9q6Q/aN/FlIZMX3icG0CIlrQKyp2E0ILVjvIjbPBhbGBOGseXBFVWW
         rT+HeMtfaqQ7MsM/JIQmPB8iOP2OJtxnFHFMZTkCp37A9N+iYU3XN1KWhnLu5aQWf4
         MYAvF+Vys24Jp3X9Rb6VDJp3kOBhFQJtiNx1iVKg=
Received: from jcrouse-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C280C60328;
        Fri, 27 Jul 2018 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532711010;
        bh=O6CF6PiUBWf+GCGJdWZ2kxRd3DFfjiQ2BT6DD3lbyXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YuTYvNUxIiHk1IyANfCa5XwnH9xJOdElfOyHWOu0P8zejTVFsWLHwY+xIS4l2/szG
         v7m3BzOWPsO4HuFTtx6wSd+Ek1aoBriB0UtUC+4n3JZag47w5lbzeROsblD0XKADnL
         NTtfszIQEzcp92NP4V52ZoQbg5vfA/KDEMaJ9T9Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C280C60328
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Fri, 27 Jul 2018 11:03:26 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org,
        Mikko Perttunen <cyndis@kapsi.fi>,
        nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-tegra@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Message-ID: <20180727170326.GA21283@jcrouse-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>,
        nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-tegra@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180726231624.21084-1-digetx@gmail.com>
 <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
 <20180727090328.GH28088@arm.com>
 <4164951.xGHfcFJ9uZ@dimapc>
 <daadd395-dcb7-9505-f171-0fcc28570301@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daadd395-dcb7-9505-f171-0fcc28570301@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 05:02:37PM +0100, Robin Murphy wrote:
> On 27/07/18 15:10, Dmitry Osipenko wrote:
> >On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
> >>On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
> >>>On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> >>>>The proposed solution adds a new option to the base device driver
> >>>>structure that allows device drivers to explicitly convey to the drivers
> >>>>core that the implicit IOMMU backing for devices must not happen.
> >>>
> >>>Why is IOMMU mapping a problem for the Tegra GPU driver?
> >>>
> >>>If we add something like this then it should not be the choice of the
> >>>device driver, but of the user and/or the firmware.
> >>
> >>Agreed, and it would still need somebody to configure an identity domain so
> >>that transactions aren't aborted immediately. We currently allow the
> >>identity domain to be used by default via a command-line option, so I guess
> >>we'd need a way for firmware to request that on a per-device basis.
> >
> >The IOMMU mapping itself is not a problem, the problem is the management of
> >the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
> >activities because:
> >
> >1) GPU HW require additional configuration for the IOMMU usage and dumb
> >mapping of the allocations simply doesn't work.
> 
> Generally, that's already handled by the DRM drivers allocating
> their own unmanaged domains. The only problem we really need to
> solve in that regard is that currently the device DMA ops don't get
> updated when moving away from the managed domain. That's been OK for
> the VFIO case where the device is bound to a different driver which
> we know won't make any explicit DMA API calls, but for the more
> general case of IOMMU-aware drivers we could certainly do with a bit
> of cooperation between the IOMMU API, DMA API, and arch code to
> update the DMA ops dynamically to cope with intermediate subsystems
> making DMA API calls on behalf of devices they don't know the
> intimate details of.
> 
> >2) Older Tegra generations have a limited resource and capabilities in regards
> >to IOMMU usage, allocating IOMMU domain per-device is just impossible for
> >example.
> >
> >3) HW performs context switches and so particular allocations have to be
> >assigned to a particular contexts IOMMU domain.
> 
> I understand Qualcomm SoCs have a similar thing too, and AFAICS that
> case just doesn't fit into the current API model at all. We need the
> IOMMU driver to somehow know about the specific details of which
> devices have magic associations with specific contexts, and we
> almost certainly need a more expressive interface than
> iommu_domain_alloc() to have any hope of reliable results.

This is correct for Qualcomm GPUs - The GPU hardware context switching 
requires a specific context and there are some restrictions around
secure contexts as well.

We don't really care if the DMA attaches to a context just as long as it
doesn't attach to the one(s) we care about. Perhaps a "valid context" mask would
work in from the DT or the device struct to give the subsystems a clue as to
which domains they were allowed to use. I recognize that there isn't a
one-size-fits-all solution to this problem so I'm open to different ideas.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
