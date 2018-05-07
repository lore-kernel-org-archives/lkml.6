Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbeEGXKT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:10:19 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54218 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752726AbeEGXKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:10:17 -0400
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-2-logang@deltatee.com>
 <20180507230034.GE161390@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <092f3da9-764e-2ece-b3a8-a9b3ab3c49a8@deltatee.com>
Date: Mon, 7 May 2018 17:09:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507230034.GE161390@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: christian.koenig@amd.com, alex.williamson@redhat.com, benh@kernel.crashing.org, jglisse@redhat.com, dan.j.williams@intel.com, maxg@mellanox.com, jgg@mellanox.com, bhelgaas@google.com, sagi@grimberg.me, keith.busch@intel.com, axboe@kernel.dk, hch@lst.de, sbates@raithlin.com, linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 01/14] PCI/P2PDMA: Support peer-to-peer memory
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review. I'll apply all of these for the changes for next
version of the set.
>> +/*
>> + * If a device is behind a switch, we try to find the upstream bridge
>> + * port of the switch. This requires two calls to pci_upstream_bridge():
>> + * one for the upstream port on the switch, one on the upstream port
>> + * for the next level in the hierarchy. Because of this, devices connected
>> + * to the root port will be rejected.
>> + */
>> +static struct pci_dev *get_upstream_bridge_port(struct pci_dev *pdev)
> 
> This function doesn't seem to be used anymore.  Thanks for all your hard
> work to get rid of it!

Oops, I thought I had gotten rid of it entirely, but I guess I messed it
up a bit and it gets removed in patch 4. I'll fix it for v5.

Logan
