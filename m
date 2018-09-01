Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30FEC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B052083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B052083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeIAMfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:35:14 -0400
Received: from verein.lst.de ([213.95.11.211]:56595 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbeIAMfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:35:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D010668D00; Sat,  1 Sep 2018 10:27:03 +0200 (CEST)
Date:   Sat, 1 Sep 2018 10:27:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 01/13] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180901082703.GA670@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com> <20180830185352.3369-2-logang@deltatee.com> <2711b3a7-f582-0dda-8ac2-530be7bda1bb@amd.com> <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <439181bb-6cd6-0ab2-bca6-fc820845166e@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 09:48:40AM -0600, Logan Gunthorpe wrote:
> Pretty easy. P2P detection is pretty much just pci_p2pdma_distance() ,
> which has nothing to do with the ZONE_DEVICE support.
> 
> (And the distance function makes use of a number of static functions
> which could be combined into a simpler interface, should we need it.)

I'd ѕay lets get things merged as-is, so that we can review the
non-ZONE_DEVICE users.  I'm a little curious how that is going to work,
so having it as a full series would be useful.
