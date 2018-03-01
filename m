Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162150AbeCAVpa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:45:30 -0500
Received: from ale.deltatee.com ([207.54.116.67]:38942 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161731AbeCAVp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:45:28 -0500
To: Dan Williams <dan.j.williams@intel.com>, benh@au1.ibm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com>
 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
Date: Thu, 1 Mar 2018 14:45:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: oliveroh@au1.ibm.com, alex.williamson@redhat.com, jglisse@redhat.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, benh@au1.ibm.com, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/18 02:37 PM, Dan Williams wrote:
> Ah ok, I'd need to look at the details. I had been assuming that
> sparse-vmemmap could handle such a situation, but that could indeed be
> a broken assumption.

It handles it fine for many situations. But when you try to map 
something that is at the end of the physical address space then the 
spares-vmemmap needs virtual address space that's the size of the 
physical address space divided by PAGE_SIZE which may be a little bit 
too large...

Logan
