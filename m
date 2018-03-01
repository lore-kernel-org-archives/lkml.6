Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163555AbeCAXwm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:52:42 -0500
Received: from ale.deltatee.com ([207.54.116.67]:39860 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163339AbeCAXwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:52:40 -0500
To: Keith Busch <keith.busch@intel.com>,
        Stephen Bates <sbates@raithlin.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
 <40d69074-31a8-d06a-ade9-90de7712c553@deltatee.com>
 <5649098f-b775-815b-8b9a-f34628873ff4@grimberg.me>
 <20180301184249.GI19007@ziepe.ca>
 <edaf476a-cfe9-0598-1aa5-14802a9a1477@deltatee.com>
 <20180301224540.GL19007@ziepe.ca>
 <77591162-4CCD-446E-A27C-1CDB4996ACB7@raithlin.com>
 <20180301234930.GG14799@localhost.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <34dc518d-b566-3e2a-8ad9-65d4f5d08a44@deltatee.com>
Date: Thu, 1 Mar 2018 16:52:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301234930.GG14799@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: swise@opengridcomputing.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, bhelgaas@google.com, axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sagi@grimberg.me, jgg@ziepe.ca, sbates@raithlin.com, keith.busch@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/18 04:49 PM, Keith Busch wrote:
> On Thu, Mar 01, 2018 at 11:00:51PM +0000, Stephen  Bates wrote:
>>
>> P2P is about offloading the memory and PCI subsystem of the host CPU
>> and this is achieved no matter which p2p_dev is used.
> 
> Even within a device, memory attributes for its various regions may not be
> the same. There's a meaningful difference between writing to an NVMe CMB
> vs PMR, and a single device could have both. We don't want to lump these
> all together without knowing which region you're allocating from, right?

Yes, PMRs are a whole other beast. I have no idea what anyone is going 
to actually do with those yet. But no one is proposing to publish them 
as p2pmem with this code.

Logan
