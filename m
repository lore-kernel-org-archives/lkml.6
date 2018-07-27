Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDAAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C462064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMDwxxeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C462064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbeG0Pcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:32:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46665 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbeG0Pcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:32:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id l16-v6so3612236lfc.13;
        Fri, 27 Jul 2018 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZR9K0sfpSvV8pGr+2uKwP6+zKLnzOqLxlIY5hvTUV8=;
        b=JMDwxxeLZNsni5Eg7+Ve1NxHiVZvgs7mLSK2LoDEpW2qZASSzPpzZeny8kuNLPNLy/
         79oHM3WfaKQ1iHfyDnsgHcRQX6nOKIifBn34VlvAKWXYDFYDieP+R1uKlWaiSDognJcD
         XJLscgrWO/+j8trwmt2nbMqZoerIBOZCD0p6EtmEJH6xFN4EZltsjjrIZ9Pf9NNZ4X8N
         XnGB3C5IHLrKVBkVG3F88dpBnlueadh6UDWJpCLi40NZQiafMLSS22UlAE2SL2CTUMg6
         49YXb8kJaV6OPoN5eIAqaReSMtsQNg9AGAGHP0cP/LZYVGuRoZ6MhyjkeG81G9za+DaH
         AKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZR9K0sfpSvV8pGr+2uKwP6+zKLnzOqLxlIY5hvTUV8=;
        b=c/xTt6X75qERCEBQBB+0jfg9l/Uq267PsxdXVRSLUgT2c7l54nTmT5NHF6p6epQH2c
         eOCCu7sA1YZuJWCfcDNWDkuD+iNUCKyKzIGnSZwNoS00x5NEE8Uqy7RmnqlhxXLTi9PU
         ZCuyXdh17t32QFE+9XdMD9ILuGaZW2RGMYElYHHkWIoiTA/LOWaR0G5+gNXzEquct+b8
         OYmcU5toSSZ7CzduTBxHA5waTp+Q9UPaUop6kkPVJCq5cq9jF+ve9rbE5n4+waX1M/Gn
         z0kbBwFJ9tdcWycbxIx+XJ03FqU2B5zTbRapsFwQ2wveINBsRO7+uL56SH2oAa9TUlQ3
         WY1Q==
X-Gm-Message-State: AOUpUlGnM3uQWIUflnjTTyY2cnGKUECD9hkwAGll8fHGz3jzeFI+y4xF
        xi8FEFiQZr0FCHQnyvNSlYY=
X-Google-Smtp-Source: AAOMgpfSXUYcrkgO3u2oZcBfGZDz1r8KBhYTKs4EgPFYzeu29Xg9OIPFo664wN0I/yf4k3X8fLaGJw==
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr3992048lfd.17.1532700624607;
        Fri, 27 Jul 2018 07:10:24 -0700 (PDT)
Received: from dimapc.localnet ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id d24-v6sm556904lfl.53.2018.07.27.07.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:10:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date:   Fri, 27 Jul 2018 17:10:22 +0300
Message-ID: <4164951.xGHfcFJ9uZ@dimapc>
In-Reply-To: <20180727090328.GH28088@arm.com>
References: <20180726231624.21084-1-digetx@gmail.com> <20180727082512.lpvmeuvxnw3mpeym@8bytes.org> <20180727090328.GH28088@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
> On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
> > On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> > > The proposed solution adds a new option to the base device driver
> > > structure that allows device drivers to explicitly convey to the drivers
> > > core that the implicit IOMMU backing for devices must not happen.
> > 
> > Why is IOMMU mapping a problem for the Tegra GPU driver?
> > 
> > If we add something like this then it should not be the choice of the
> > device driver, but of the user and/or the firmware.
> 
> Agreed, and it would still need somebody to configure an identity domain so
> that transactions aren't aborted immediately. We currently allow the
> identity domain to be used by default via a command-line option, so I guess
> we'd need a way for firmware to request that on a per-device basis.

The IOMMU mapping itself is not a problem, the problem is the management of 
the IOMMU. For Tegra we don't want anything to intrude into the IOMMU 
activities because:

1) GPU HW require additional configuration for the IOMMU usage and dumb 
mapping of the allocations simply doesn't work.

2) Older Tegra generations have a limited resource and capabilities in regards 
to IOMMU usage, allocating IOMMU domain per-device is just impossible for  
example.

3) HW performs context switches and so particular allocations have to be 
assigned to a particular contexts IOMMU domain.

Some of the above is due to a SW driver model (and its work-in-progress 
status), other is due to a HW model. So essentially we need a way for a driver 
to tell the core not to mess with IOMMU stuff of drivers device behind the 
drivers back.

I'm not sure what you guys are meaning by the "firmware", could you elaborate 
please? Do you mean the Open Firmware and hence the devicetree or what?



