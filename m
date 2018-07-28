Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D62C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F8920894
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 11:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGwKqp/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F8920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeG1NHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 09:07:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44528 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeG1NHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 09:07:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so5205696lfb.11;
        Sat, 28 Jul 2018 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7fOJKJ+nTlJx4O+DfMfiAaUxltqsau7ka6DNI/cXIQI=;
        b=hGwKqp/tTFpgLpW4zRj1SXjkJuZd/jj93EFJXZTlt0Yxu/tsC4uFhaJUrlUh3eewjm
         L8xIdwTQ5UYPgdAl5IDUCvpZd6viihk4gOu5kJ2JO7mpdRzxpmyeuu8HLE0rFu0FoTz5
         Lgm9lEjJr4y5h1PEMKpsZKWc4ESdvScQf726EOGGOh1aZcQW8uf9jyYsw82AvdFaBUUh
         Rq6qt+DtrUYakgU3ODcWuOqwCkePWAw4Qcx+GcjI8BfTZ5wFeo2ozQgtyIKeBXze0h+3
         E1ssUTyJ+213wzvpH5ec7cQy/J2+01fRxVtCIDAV7awDJj4nBSzFtNfaEx3aD4f/N/vd
         TVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7fOJKJ+nTlJx4O+DfMfiAaUxltqsau7ka6DNI/cXIQI=;
        b=SfRWK1l7YpcVUDw5ju/aSenyI0tGZcMGBsf65XfcaYpTlBmxgWZE1m4icRRCizxsmG
         iYj4CH4GGbcFu1iQUFsCU/yMe9k/Zg4FXtaD199k6oDzN9guRTEqquiUtbJMUU5ZxaWV
         Ge90Yr2l481cn0pO6uBZNQ3GuM22ZGe9ObFm7u5iZdiAff+nzRaNR9cpZggePyNSoLTy
         /9eRXc/v+OtBoG7tPGPsHTKbFSM6JMSiqfdpJE/Z3R1TdVaWecqur5Lm/uxjniNz1H6q
         SnZSOKyC0SnLpCF+z2VR26HzkTq9TUr3Fvz0JIuGaVeiPmYMrXbw+qXUjSOFLHPnzIrY
         dpqA==
X-Gm-Message-State: AOUpUlFl0Q2zNdwc6j9vgQtVigZplyR4Qw/v4HlWPQbYXFXUkpDuf0p/
        bWNwqQzLYyQuPq5WdAnULtA=
X-Google-Smtp-Source: AAOMgpfSYsjwLPddISPbJe/oIks568nPcCcMDZImN8ZZalYbt8tiI1QrbHM9ue0SoBJa2BBSxMuSBA==
X-Received: by 2002:a19:e119:: with SMTP id y25-v6mr6671779lfg.3.1532778062420;
        Sat, 28 Jul 2018 04:41:02 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q19-v6sm1094733lje.29.2018.07.28.04.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 04:41:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
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
Date:   Sat, 28 Jul 2018 14:40:57 +0300
Message-ID: <1710693.gjqKbZupki@dimapc>
In-Reply-To: <2402373.RyBdR7VSnO@dimapc>
References: <20180726231624.21084-1-digetx@gmail.com> <20180727170326.GA21283@jcrouse-lnx.qualcomm.com> <2402373.RyBdR7VSnO@dimapc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 July 2018 20:16:53 MSK Dmitry Osipenko wrote:
> On Friday, 27 July 2018 20:03:26 MSK Jordan Crouse wrote:
> > On Fri, Jul 27, 2018 at 05:02:37PM +0100, Robin Murphy wrote:
> > > On 27/07/18 15:10, Dmitry Osipenko wrote:
> > > >On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
> > > >>On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
> > > >>>On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> > > >>>>The proposed solution adds a new option to the base device driver
> > > >>>>structure that allows device drivers to explicitly convey to the
> > > >>>>drivers
> > > >>>>core that the implicit IOMMU backing for devices must not happen.
> > > >>>
> > > >>>Why is IOMMU mapping a problem for the Tegra GPU driver?
> > > >>>
> > > >>>If we add something like this then it should not be the choice of the
> > > >>>device driver, but of the user and/or the firmware.
> > > >>
> > > >>Agreed, and it would still need somebody to configure an identity
> > > >>domain
> > > >>so
> > > >>that transactions aren't aborted immediately. We currently allow the
> > > >>identity domain to be used by default via a command-line option, so I
> > > >>guess
> > > >>we'd need a way for firmware to request that on a per-device basis.
> > > >
> > > >The IOMMU mapping itself is not a problem, the problem is the
> > > >management
> > > >of
> > > >the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
> > > >activities because:
> > > >
> > > >1) GPU HW require additional configuration for the IOMMU usage and dumb
> > > >mapping of the allocations simply doesn't work.
> > > 
> > > Generally, that's already handled by the DRM drivers allocating
> > > their own unmanaged domains. The only problem we really need to
> > > solve in that regard is that currently the device DMA ops don't get
> > > updated when moving away from the managed domain. That's been OK for
> > > the VFIO case where the device is bound to a different driver which
> > > we know won't make any explicit DMA API calls, but for the more
> > > general case of IOMMU-aware drivers we could certainly do with a bit
> > > of cooperation between the IOMMU API, DMA API, and arch code to
> > > update the DMA ops dynamically to cope with intermediate subsystems
> > > making DMA API calls on behalf of devices they don't know the
> > > intimate details of.
> > > 
> > > >2) Older Tegra generations have a limited resource and capabilities in
> > > >regards to IOMMU usage, allocating IOMMU domain per-device is just
> > > >impossible for example.
> > > >
> > > >3) HW performs context switches and so particular allocations have to
> > > >be
> > > >assigned to a particular contexts IOMMU domain.
> > > 
> > > I understand Qualcomm SoCs have a similar thing too, and AFAICS that
> > > case just doesn't fit into the current API model at all. We need the
> > > IOMMU driver to somehow know about the specific details of which
> > > devices have magic associations with specific contexts, and we
> > > almost certainly need a more expressive interface than
> > > iommu_domain_alloc() to have any hope of reliable results.
> > 
> > This is correct for Qualcomm GPUs - The GPU hardware context switching
> > requires a specific context and there are some restrictions around
> > secure contexts as well.
> > 
> > We don't really care if the DMA attaches to a context just as long as it
> > doesn't attach to the one(s) we care about. Perhaps a "valid context" mask
> > would work in from the DT or the device struct to give the subsystems a
> > clue as to which domains they were allowed to use. I recognize that there
> > isn't a one-size-fits-all solution to this problem so I'm open to
> > different
> > ideas.
> 
> Designating whether implicit IOMMU backing is appropriate for a device via
[snip]

[I've noticed that this should've been an answer to different message in the 
thread..]

As of the domain type, I don't think that any domain requirements should be 
defined via the DT, that should be purely internal to the kernel drivers. 
Maybe iommu_domain_alloc() could get an additional argument, like some 
platform-specific domain descriptor.

Anyway a custom IOMMU domain type requirements should be a different topic for 
discussion, at least for now (AFAIK) there is no need for that on Tegra and I 
can't suggest anything really constructive about it. Though maybe Mikko could 
give a comment from the Tegra perspective about whether custom domain type 
requirements could be ever needed on Tegra, what those requirements are and 
how it could be implemented.



