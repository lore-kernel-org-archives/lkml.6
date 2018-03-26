Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeCZPqv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:46:51 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58706 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeCZPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:46:49 -0400
To: Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Wehage <Eric.Wehage@huawei.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
 <20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c717eb06-1e83-f0f3-4d6c-15531aa808e0@deltatee.com>
Date: Mon, 26 Mar 2018 09:46:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: Eric.Wehage@huawei.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org, Jonathan.Cameron@huawei.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/03/18 08:01 AM, Bjorn Helgaas wrote:
> On Mon, Mar 26, 2018 at 12:11:38PM +0100, Jonathan Cameron wrote:
>> On Tue, 13 Mar 2018 10:43:55 -0600
>> Logan Gunthorpe <logang@deltatee.com> wrote:
>>> It turns out that root ports that support P2P are far less common than 
>>> anyone thought. So it will likely have to be a white list.
>>
>> This came as a bit of a surprise to our PCIe architect.
>>
>> His follow up was whether it was worth raising an ECR for the PCIe spec
>> to add a capability bit to allow this to be discovered.  This might
>> long term avoid the need to maintain the white list for new devices.
>>
>> So is it worth having a long term solution for making this discoverable?
> 
> It was surprising to me that there's no architected way to discover
> this.  It seems like such an obvious thing that I guess I assumed the
> omission was intentional, i.e., maybe there's something that makes it
> impractical, but it would be worth at least asking somebody in the
> SIG.  It seems like for root ports in the same root complex, at least,
> there could be a bit somewhere in the root port or the RCRB (which
> Linux doesn't support yet).

Yes, I agree. It would be a good long term solution to have this bit in
the spec. That would avoid us needing to create a white list for new
hardware. However, I expect it would be years before we can rely on it
so someone may yet implement that white list.

Logan
