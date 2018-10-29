Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F80BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FA62075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 02:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FA62075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbeJ2Lay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:30:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50312 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729055AbeJ2Lay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:30:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=wei.guo.simon@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TBnbo-o_1540780949;
Received: from localhost(mailfrom:wei.guo.simon@linux.alibaba.com fp:SMTPD_---0TBnbo-o_1540780949)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Oct 2018 10:42:29 +0800
Date:   Mon, 29 Oct 2018 10:42:28 +0800
From:   Simon Guo <wei.guo.simon@linux.alibaba.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     qixuan.wu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Can VFIO pin only a specific region of guest mem when use pass
 through devices?
Message-ID: <20181029024228.GA4279@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using network device pass through mode with qemu x86(-device vfio-pci,host=0000:xx:yy.z)
and ¡°intel_iommu=on¡± in host kernel command line, and it shows the whole guest memory
were pinned(vfio_pin_pages()), viewed by the ¡°top¡± RES memory output. I understand it is due
to device can DMA to any guest memory address and it cannot be swapped.

However can we just pin a rang of address space allowed by iommu group of that device,
instead of pin whole address space? I do notice some code like vtd_host_dma_iommu().
Maybe there is already some way to enable that?

Sorry if I missed some basics. I googled some but no luck to find the answer yet. Please
let me know if any discussion already raised on that.

Any other suggestion will also be appreciated. For example, can we modify the guest network
card driver to allocate only from a specific memory region(zone), and qemu advises guest
kernel to only pin that memory region(zone) accordingly?

Thanks,
- Simon
