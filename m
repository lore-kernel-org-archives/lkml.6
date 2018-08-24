Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08C3208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnzRVpvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08C3208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeHXTrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeHXTrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:47:39 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF272208B7;
        Fri, 24 Aug 2018 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535127140;
        bh=TS4T9oIMmMbal9EPMmy+cF4LHDRPnEILI2VI5MtdhLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnzRVpvQooW2C3KNLHle1eW2rgSsv044QV4gxM/1zgqe9CN+isbwYbOzpNb+FRhuc
         yZqYi/xamdVYlmFzeZ0ykP3WkL6tneux4skh1/yEbIse72uKotdsivlU++70fLzFnv
         foAyPVuJw2NlPpw+SoHgeJ2ZbMNzwHUYrORoEY0g=
Date:   Fri, 24 Aug 2018 11:12:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: Re: [PATCH 0/4] Add support to register platform service IRQ
Message-ID: <20180824161219.GA141098@bhelgaas-glaptop.roam.corp.google.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <BL0PR02MB48498C30DD4082D3215B5444A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR02MB48498C30DD4082D3215B5444A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 12:16:20PM +0000, Bharat Kumar Gogada wrote:
> > Subject: [PATCH 0/4] Add support to register platform service IRQ
> > 
> > Some platforms have dedicated IRQ lines for PCIe services like AER/PME etc.
> > The root complex on these platform will use these seperate IRQ lines to
> > report AER/PME etc., interrupts and will not generate MSI/MSI-X/INTx
> > interrupts for these services.
> > These patches will add new method for these kind of platforms to register
> > the platform IRQ number with respective PCIe services.
> > 
> > Bharat Kumar Gogada (4):
> >   PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
> >   PCI: Add pci_check_platform_service_irqs
> >   PCI/portdrv: Check platform supported service IRQ's
> >   PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
> > 
> >  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
> >  drivers/pci/pcie/portdrv_core.c          |   19 +++++++++++++++++--
> >  include/linux/pci.h                      |   25 +++++++++++++++++++++++++
> >  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> Hi Bjorn,
> Can you comment on this series.

I'm taking a breather during the merge window.  As soon as -rc1 comes
out (probably Sunday), I'll start processing the patches in the queue.

Bjorn
