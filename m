Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D2AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8FF2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="rZABMMDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8FF2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbeG0JqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:46:02 -0400
Received: from 8bytes.org ([81.169.241.247]:33166 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbeG0JqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:46:02 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2595525A; Fri, 27 Jul 2018 10:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532679914; bh=lfcxpOZdhkEgGJHUYs2LGreSEDxoS6TGO2txPpbpusY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZABMMDyoaIA4Xe9UmPGWavmK8kK83tBJ4x21B/6C8Z0uOrBZwpYdDWXAe5/Xc5lt
         o4chJHeo1Bz6hhoTJJ27hNI3b20YGEAZujKBCxJ39qDtbkfhA3Q7a5zO1fXr9+ifiA
         gjLnWYDNp2VwxLUYlmpKYCB4LBOokOPJfNkZn93DAUPDyd++atohnfRBLAtTr4PdmM
         lQeUcAPKpNIO282q4ahv+RWAr9ehW5WVYssggLIJ0/74ZJy+/5ESoPD0JuAYBkUaHz
         P7FACIWf0hHs72lx3zkwPkBt/fttIlDPwRb7sLilOd1MElFMFWACN2SP2e9wZvsWhr
         RMUNKS5pAyFJw==
Date:   Fri, 27 Jul 2018 10:25:13 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
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
        Will Deacon <will.deacon@arm.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Message-ID: <20180727082512.lpvmeuvxnw3mpeym@8bytes.org>
References: <20180726231624.21084-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
> The proposed solution adds a new option to the base device driver
> structure that allows device drivers to explicitly convey to the drivers
> core that the implicit IOMMU backing for devices must not happen.

Why is IOMMU mapping a problem for the Tegra GPU driver?

If we add something like this then it should not be the choice of the
device driver, but of the user and/or the firmware.


	Joerg

