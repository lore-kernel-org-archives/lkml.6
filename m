Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1467C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990EB208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDofsL8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990EB208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbeG0Sjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:39:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43240 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbeG0Sjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:39:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so5049830ljg.10;
        Fri, 27 Jul 2018 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1iOSRr+SAjUtcLrgNS4UsOOkUWfNVdneyfHciKZksA=;
        b=VDofsL8DuRADOK9c6/+sha7pMHCDnkr63fTb884ooIxyKYHMD7zmhv59dFb1UjrBK7
         Jmeu3JPvRlHtweYBtD9GOY6yYlCwR7KddtXfs1ua3ot8G3nBpzBetENDAItYSXYiQPiJ
         E3nCN15qmkHzetyZlXgj8ANOXxDJs93ioN35QQT5yc4K1ff42q0LmujwMGBVskG+c/FA
         4TQ8yUCYfTQWJPIWzeYys3MoN5F5Qv6N/0M7yTbVgIZubLkpPYdXWmc5VpjfTS4KxuJx
         Vbg2+uTlNLCNYeFwWARg22ZgjPO+d0PwKEsQ4ApiFTYT6wQJWKrO8fSGSPxWbUXmG8/B
         KT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1iOSRr+SAjUtcLrgNS4UsOOkUWfNVdneyfHciKZksA=;
        b=A64jKFlmUVATBLeMIiP6h+oU8mG1SRZZZK2vyHgUO29SWLfh9VoMTEHvAJU2KQLYAg
         Z0hFmte6iiqWg4no7n5Ukl0rKAHxZ9lCG7Jjvr7uHx1AAh0Qxm/PHAwHTmBWsLEMXxCg
         smYeCPO6ckTmD0dgreIEF1MVuBNnjd2M1HdO85RSWtCdDfhhgc+rqebRq+h6d0S8y8Aa
         g0yK6i/WF7cD3iWtem0NqL/OzPJDxkYk65X17mPBZV3PlrLLYX43PwS3DJtGfFVdDKcm
         nKohwlHDoYebxIqi3Qo5XxZ32ZP1NacvSYWDtHHk87KhFu5hO3DLxpz69TBEqqZjWVoL
         RM0g==
X-Gm-Message-State: AOUpUlFm+AOwPRY35YdJI0Pnw9mA3YylOCAJl76u75qWpof9o7xi1SEQ
        lJptpS/T5pAocH6pZUZuJcY=
X-Google-Smtp-Source: AAOMgpf/39owCAR7x2Jkz02so4yeS1tkP7btUEcftcg4y5wI5KlpG5GhZqDJN3NbYI8/9GZlT69c+Q==
X-Received: by 2002:a2e:9e17:: with SMTP id e23-v6mr5420331ljk.14.1532711815097;
        Fri, 27 Jul 2018 10:16:55 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 97-v6sm611550lfw.13.2018.07.27.10.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:16:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>,
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
Date:   Fri, 27 Jul 2018 20:16:53 +0300
Message-ID: <2402373.RyBdR7VSnO@dimapc>
In-Reply-To: <20180727170326.GA21283@jcrouse-lnx.qualcomm.com>
References: <20180726231624.21084-1-digetx@gmail.com> <daadd395-dcb7-9505-f171-0fcc28570301@arm.com> <20180727170326.GA21283@jcrouse-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 July 2018 20:03:26 MSK Jordan Crouse wrote:
> On Fri, Jul 27, 2018 at 05:02:37PM +0100, Robin Murphy wrote:
> > On 27/07/18 15:10, Dmitry Osipenko wrote:
> > >On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
> > >>On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
> > >>>On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> > >>>>The proposed solution adds a new option to the base device driver
> > >>>>structure that allows device drivers to explicitly convey to the
> > >>>>drivers
> > >>>>core that the implicit IOMMU backing for devices must not happen.
> > >>>
> > >>>Why is IOMMU mapping a problem for the Tegra GPU driver?
> > >>>
> > >>>If we add something like this then it should not be the choice of the
> > >>>device driver, but of the user and/or the firmware.
> > >>
> > >>Agreed, and it would still need somebody to configure an identity domain
> > >>so
> > >>that transactions aren't aborted immediately. We currently allow the
> > >>identity domain to be used by default via a command-line option, so I
> > >>guess
> > >>we'd need a way for firmware to request that on a per-device basis.
> > >
> > >The IOMMU mapping itself is not a problem, the problem is the management
> > >of
> > >the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
> > >activities because:
> > >
> > >1) GPU HW require additional configuration for the IOMMU usage and dumb
> > >mapping of the allocations simply doesn't work.
> > 
> > Generally, that's already handled by the DRM drivers allocating
> > their own unmanaged domains. The only problem we really need to
> > solve in that regard is that currently the device DMA ops don't get
> > updated when moving away from the managed domain. That's been OK for
> > the VFIO case where the device is bound to a different driver which
> > we know won't make any explicit DMA API calls, but for the more
> > general case of IOMMU-aware drivers we could certainly do with a bit
> > of cooperation between the IOMMU API, DMA API, and arch code to
> > update the DMA ops dynamically to cope with intermediate subsystems
> > making DMA API calls on behalf of devices they don't know the
> > intimate details of.
> > 
> > >2) Older Tegra generations have a limited resource and capabilities in
> > >regards to IOMMU usage, allocating IOMMU domain per-device is just
> > >impossible for example.
> > >
> > >3) HW performs context switches and so particular allocations have to be
> > >assigned to a particular contexts IOMMU domain.
> > 
> > I understand Qualcomm SoCs have a similar thing too, and AFAICS that
> > case just doesn't fit into the current API model at all. We need the
> > IOMMU driver to somehow know about the specific details of which
> > devices have magic associations with specific contexts, and we
> > almost certainly need a more expressive interface than
> > iommu_domain_alloc() to have any hope of reliable results.
> 
> This is correct for Qualcomm GPUs - The GPU hardware context switching
> requires a specific context and there are some restrictions around
> secure contexts as well.
> 
> We don't really care if the DMA attaches to a context just as long as it
> doesn't attach to the one(s) we care about. Perhaps a "valid context" mask
> would work in from the DT or the device struct to give the subsystems a
> clue as to which domains they were allowed to use. I recognize that there
> isn't a one-size-fits-all solution to this problem so I'm open to different
> ideas.

Designating whether implicit IOMMU backing is appropriate for a device via 
device-tree property sounds a bit awkward because that will be a kinda 
software description (of a custom Linux driver model), while device-tree is 
supposed to describe HW.

What about to grant IOMMU drivers with ability to decide whether the implicit 
backing for a device is appropriate? Like this:

bool implicit_iommu_for_dma_is_allowed(struct device *dev)
{
	const struct iommu_ops *ops = dev->bus->iommu_ops;
	struct iommu_group *group;

	group = iommu_group_get(dev);
	if (!group)
		return NULL;

	iommu_group_put(group);

	if (!ops->implicit_iommu_for_dma_is_allowed)
		return true;

	return ops->implicit_iommu_for_dma_is_allowed(dev);
}

Then arch_setup_dma_ops() could have a clue whether implicit IOMMU backing for 
a device is appropriate.



