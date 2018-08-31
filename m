Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D99CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42ED520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ED520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeHaUem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:34:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47200 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeHaUel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:34:41 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fvmFO-0004ir-Rq; Fri, 31 Aug 2018 10:26:11 -0600
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-2-logang@deltatee.com>
 <20180831171906.00002751@huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a1f6e2d9-8b7d-10ae-5963-50b447cacb44@deltatee.com>
Date:   Fri, 31 Aug 2018 10:26:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831171906.00002751@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/08/18 10:19 AM, Jonathan Cameron wrote:
> This feels like a somewhat simplistic starting point rather than a
> generally correct estimate to use.  Should we be taking the bandwidth of
> those links into account for example, or any discoverable latencies?
> Not all PCIe switches are alike - particularly when it comes to P2P.

I don't think this is necessary. There won't typically be a ton of
choice in terms of devices to use and if there is, the hardware will
probably be fairly homogenous. For example, it would be unusual to have
an NVMe drive on a x4 and another one on an x8. Or mixing say Gen3
switches with Gen4 would also be very strange. In weird unusual cases
like this where the user specifically wants to use a faster device they
can specify the specific device in the configfs interface.

I think the latency would probably be proportional to the distance which
is what we are already using.

> I guess that can be a topic for future development if it turns out people
> have horrible mixed systems.

Yup!

Logan
