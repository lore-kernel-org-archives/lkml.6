Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85AAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A046620645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A046620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeIFAj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:39:59 -0400
Received: from verein.lst.de ([213.95.11.211]:47098 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeIFAj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:39:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E280468D40; Wed,  5 Sep 2018 22:11:52 +0200 (CEST)
Date:   Wed, 5 Sep 2018 22:11:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
Message-ID: <20180905201152.GA1893@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com> <20180830185352.3369-8-logang@deltatee.com> <b5ab8fa3-34ac-3117-fa0d-5206c3939435@kernel.dk> <20180901082812.GB670@lst.de> <5f79c012-c6e1-56bb-62fd-0689181fb2c9@deltatee.com> <59b28977-8f2a-6228-2050-03fae6bdbedd@kernel.dk> <1b4283da-44df-4a02-3167-e295243cef78@deltatee.com> <09258b9b-3aed-9890-b31a-bd70a133966c@kernel.dk> <20180905195647.GA1626@lst.de> <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc1b3cf-2fd9-fa61-9cfb-b0e4d84e5d94@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:54:31PM -0600, Jens Axboe wrote:
> On 9/5/18 1:56 PM, Christoph Hellwig wrote:
> > On Wed, Sep 05, 2018 at 01:45:04PM -0600, Jens Axboe wrote:
> >> The point is that the caller doesn't necessarily know where the bio
> >> will end up, hence the caller can't fully check if the whole stack
> >> supports P2P.
> > 
> > The caller must necessarily know where the bio will end up, as for P2P
> > support we need to query if the bio target is P2P capable vs the
> > source of the P2P memory.
> 
> Then what's the point of having the check at all?

Just an additional little safe guard.  If you think it isn't worth
it I guess we can just drop it for now.
