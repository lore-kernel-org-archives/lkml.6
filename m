Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D219BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9325620864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9325620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965136AbeFNOvX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:51:23 -0400
Received: from verein.lst.de ([213.95.11.211]:46807 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965089AbeFNOvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:51:21 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3A29768BF4; Thu, 14 Jun 2018 16:59:42 +0200 (CEST)
Date:   Thu, 14 Jun 2018 16:59:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
        linux-pci-owner@vger.kernel.org
Subject: Re: Requirement to get BAR pci_bus_address in user space
Message-ID: <20180614145942.GA4885@lst.de>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com> <20180614102001.GA20836@lst.de> <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com> <92a9eeced36f863458ca2fd029f17a20@codeaurora.org> <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com> <20180614085015.3f39b367@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614085015.3f39b367@w520.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 08:50:15AM -0600, Alex Williamson wrote:
> I don't understand the CQ vs CMB, but I think I gather that there's some
> sort of buffer that's allocated from within the devices MMIO BAR and
> some programming of the device needs to reference that buffer.
> Wouldn't you therefore use the vfio type1 IOMMU MAP_DMA ioctl to map
> the BAR into the IOVA address space and you can then use the IOVA +
> offset into the BAR for the device to reference the buffer?  It seems
> this is the same way we'd setup a peer-to-peer mapping, but we're using
> it for the device to reference itself effectively.  Thanks,

That's exactly what I meant..
