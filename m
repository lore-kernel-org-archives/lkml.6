Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1371BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDA820664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbeJ2SCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeJ2SCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:02:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB97086647;
        Mon, 29 Oct 2018 09:14:58 +0000 (UTC)
Received: from [10.72.12.201] (ovpn-12-201.pek2.redhat.com [10.72.12.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5792660C65;
        Mon, 29 Oct 2018 09:14:49 +0000 (UTC)
Subject: Re: Can VFIO pin only a specific region of guest mem when use pass
 through devices?
To:     Simon Guo <wei.guo.simon@linux.alibaba.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     qixuan.wu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
References: <20181029024228.GA4279@simonLocalRHEL7.x64>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e4be89df-2bf9-76a2-497f-c6ba3256c95a@redhat.com>
Date:   Mon, 29 Oct 2018 17:14:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181029024228.GA4279@simonLocalRHEL7.x64>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 29 Oct 2018 09:14:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/29 ÉÏÎç10:42, Simon Guo wrote:
> Hi,
>
> I am using network device pass through mode with qemu x86(-device vfio-pci,host=0000:xx:yy.z)
> and ¡°intel_iommu=on¡± in host kernel command line, and it shows the whole guest memory
> were pinned(vfio_pin_pages()), viewed by the ¡°top¡± RES memory output. I understand it is due
> to device can DMA to any guest memory address and it cannot be swapped.
>
> However can we just pin a rang of address space allowed by iommu group of that device,
> instead of pin whole address space? I do notice some code like vtd_host_dma_iommu().
> Maybe there is already some way to enable that?
>
> Sorry if I missed some basics. I googled some but no luck to find the answer yet. Please
> let me know if any discussion already raised on that.
>
> Any other suggestion will also be appreciated. For example, can we modify the guest network
> card driver to allocate only from a specific memory region(zone), and qemu advises guest
> kernel to only pin that memory region(zone) accordingly?
>
> Thanks,
> - Simon


One possible method is to enable IOMMU of VM.

Peter (cced) may know more.

Thanks

