Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0B3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071E21A33
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7071E21A33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeHHTRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:17:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHTRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:17:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04DA518A;
        Wed,  8 Aug 2018 09:57:05 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC263F5D4;
        Wed,  8 Aug 2018 09:57:03 -0700 (PDT)
Date:   Wed, 8 Aug 2018 17:57:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] pci-dra7xx: Enable errata i870 workaround for RC
 mode
Message-ID: <20180808165700.GB486@e107981-ln.cambridge.arm.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724173150.2701-1-vigneshr@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:01:46PM +0530, Vignesh R wrote:
> Make workaround for errata i870 applicable in Host mode as
> well(previously it was enabled only for EP mode) as per errata
> documentation: http://www.ti.com/lit/er/sprz450/sprz450.pdf
> 
> Tested on DRA72 EVM
> 
> Tony,
> 
> If you are okay with the series, could you pick this via omap tree?
> All ACKs are in place and Lorenzo is okay with PCIe bits to go along with
> rest of DTS changes.

I think we have missed the v4.19 merge window by now - please let me
know if I can drop this series from the PCI patch queue.

Thanks,
Lorenzo

> Regards
> Vignesh
> 
> 
> Changes since v2:
> Reorder patch 2 to appear at the last.
> Collect all the ACKs
> 
> Changes since v1:
> Drop IRQ handling rework (will be sent out separately)
> 
> v2: https://patchwork.ozlabs.org/cover/935454/
> v1: https://lkml.org/lkml/2017/12/1/59
> 
> 
> Vignesh R (4):
>   dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host
>     mode
>   ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
>   ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
>   pci: dwc: pci-dra7xx: Enable errata i870 for both EP and RC mode
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |  5 +++++
>  arch/arm/boot/dts/dra7.dtsi                      |  4 +++-
>  drivers/pci/controller/dwc/pci-dra7xx.c          | 12 ++++++------
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> -- 
> 2.18.0
> 
