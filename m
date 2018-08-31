Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B7020835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VKXAcaap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B7020835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeHaEjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:39:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58068 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaEjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r2u6C5H5gt7H2PYT9/h3MCtMUld5pHUi8pcD5GOXdWY=; b=VKXAcaapVZ/zPKwWcyiWih9NV
        p2rSuKyeEy+BwdH44gKgLQYwtpHRITSmr2sGpNwnqdJrYYsXvCKp8cvLlqi8QMJfhDwkwiCEPP84t
        kQKxbVeO0InyZBILWCc3nzC9rsfvtdwBbFJAENoiuDavFZHV5g/vQFKrkvRBnjEy7iYg2nNR6bPpC
        3AGQGJFQWxxhSwKGeVpjPEp5UFJmFcVVFH/N2AYh/sD5Zbq2/RaEp6jABrw80xDXoJpP/GwWkXtq5
        15bvUai5Q/m/8T9BasDmQTHWoElHd72GAo3ewxX7fKh2IyFEr36mSGiLkds/B1rTepZ/Gi3e12yN6
        dlnIb7phw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvXOU-0005HT-QM; Fri, 31 Aug 2018 00:34:34 +0000
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <382af881-0ae1-0274-4628-0137071125b1@infradead.org>
Date:   Thu, 30 Aug 2018 17:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a few comments below...

On 08/30/2018 11:53 AM, Logan Gunthorpe wrote:
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/driver-api/pci/index.rst  |   1 +
>  Documentation/driver-api/pci/p2pdma.rst | 170 ++++++++++++++++++++++++++++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/driver-api/pci/p2pdma.rst

> diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
> new file mode 100644
> index 000000000000..ac857450d53f
> --- /dev/null
> +++ b/Documentation/driver-api/pci/p2pdma.rst
> @@ -0,0 +1,170 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +PCI Peer-to-Peer DMA Support
> +============================
> +
> +The PCI bus has pretty decent support for performing DMA transfers
> +between two devices on the bus. This type of transaction is henceforth
> +called Peer-to-Peer (or P2P). However, there are a number of issues that
> +make P2P transactions tricky to do in a perfectly safe way.
> +
> +One of the biggest issues is that PCI doesn't require forwarding
> +transactions between hierarchy domains, and in PCIe, each Root Port
> +defines a separate hierarchy domain. To make things worse, there is no
> +simple way to determine if a given Root Complex supports this or not.
> +(See PCIe r4.0, sec 1.3.1). Therefore, as of this writing, the kernel
> +only supports doing P2P when the endpoints involved are all behind the
> +same PCI bridge, as such devices are all in the same PCI hierarchy
> +domain, and the spec guarantees that all transacations within the

                                            transactions

> +hierarchy will be routable, but it does not require routing
> +between hierarchies.
> +
> +The second issue is that to make use of existing interfaces in Linux,
> +memory that is used for P2P transactions needs to be backed by struct
> +pages. However, PCI BARs are not typically cache coherent so there are
> +a few corner case gotchas with these pages so developers need to
> +be careful about what they do with them.
> +
> +
> +Driver Writer's Guide
> +=====================
> +
> +In a given P2P implementation there may be three or more different
> +types of kernel drivers in play:
> +
> +* Provider - A driver which provides or publishes P2P resources like
> +  memory or doorbell registers to other drivers.
> +* Client - A driver which makes use of a resource by setting up a
> +  DMA transaction to or from it.
> +* Orchestrator - A driver which orchestrates the flow of data between
> +  clients and providers

Might as well end that last one with a period since the other 2 are.

> +
> +In many cases there could be overlap between these three types (i.e.,
> +it may be typical for a driver to be both a provider and a client).
> +

[snip]

> +
> +Orchestrator Drivers
> +--------------------
> +
> +The first task an orchestrator driver must do is compile a list of
> +all client devices that will be involved in a given transaction. For
> +example, the NVMe Target driver creates a list including all NVMe
> +devices and the RNIC in use. The list is stored as an anonymous struct
> +list_head which must be initialized with the usual INIT_LIST_HEAD.
> +The following functions may then be used to add to, remove from and free
> +the list of clients with the functions :c:func:`pci_p2pdma_add_client()`,
> +:c:func:`pci_p2pdma_remove_client()` and
> +:c:func:`pci_p2pdma_client_list_free()`.
> +
> +With the client list in hand, the orchestrator may then call> +:c:func:`pci_p2pmem_find()` to obtain a published P2P memory provider
> +that is supported (behind the same root port) as all the clients. If more
> +than one provider is supported, the one nearest to all the clients will
> +be chosen first. If there are more than one provider is an equal distance
> +away, the one returned will be chosen at random. This function returns the PCI

random or just arbitrarily?

> +device to use for the provider with a reference taken and therefore
> +when it's no longer needed it should be returned with pci_dev_put().


thanks,
-- 
~Randy
