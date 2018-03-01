Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162884AbeCAXUR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:20:17 -0500
Received: from ale.deltatee.com ([207.54.116.67]:39570 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162811AbeCAXUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:20:15 -0500
To: benh@au1.ibm.com, Dan Williams <dan.j.williams@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com>
 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
 <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
 <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
 <1519945204.4592.45.camel@au1.ibm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>
Date: Thu, 1 Mar 2018 16:19:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519945204.4592.45.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, maxg@mellanox.com, bhelgaas@google.com, jgg@mellanox.com, jglisse@redhat.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org, alex.williamson@redhat.com, oliveroh@au1.ibm.com, keith.busch@intel.com, axboe@kernel.dk, dan.j.williams@intel.com, benh@au1.ibm.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/18 04:00 PM, Benjamin Herrenschmidt wrote:
> We use only 52 in practice but yes.
> 
>>   That's 64PB. If you use need
>> a sparse vmemmap for the entire space it will take 16TB which leaves you
>> with 63.98PB of address space left. (Similar calculations for other
>> numbers of address bits.)
> 
> We only have 52 bits of virtual space for the kernel with the radix
> MMU.

Ok, assuming you only have 52 bits of physical address space: the sparse 
vmemmap takes 1TB and you're left with 3.9PB of address space for other 
things. So, again, why doesn't that work? Is my math wrong?

Logan
