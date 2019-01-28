Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B48BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2F521736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lb4ct89m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfA1IAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:00:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfA1IAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NZGdrPgxkJ3GKEpUKB51umaHqCnKmWqhveXsvbsgygE=; b=lb4ct89mtlycA0t57CSkOi98e
        /sgvI17cMHXbXpKrtNNaK1bDe16f5eRmPss/pUIPstxyUrfN2hYE219fXt0h1MbhKYw4g+OFelpMs
        CU7Ac5KvxyKipxsqdwVNH7f+I79ezGtQa6fegSiy5tmtEAx+3AGZ6h+zY97rYlfI4IkwIQ0MbL3rJ
        OCPGs1nSNeP/NI0tIlWGgrVLsi0UF+KAWidO2n17dhGmZSlDzFwuk48bqZsblF1DucIt4PxL/rZin
        1GIvHY3EM1FKuM0pU+k/hQfxcW7wFqv2DZn+GwD7lTTQlT3+QuUg0o2c0xw+PypRpO/iowaoaSNcp
        CzMgGbltA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go1qH-00088W-7X; Mon, 28 Jan 2019 08:00:29 +0000
Date:   Mon, 28 Jan 2019 00:00:29 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Andy Duan <fugang.duan@nxp.com>
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Message-ID: <20190128080028.GA18476@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
 <20190123071232.GA20526@infradead.org>
 <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
 <20190123211405.GA4971@infradead.org>
 <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 09:45:26AM +0000, Peng Fan wrote:
> Just have a question, 
> 
> Since vmalloc_to_page is ok for cma area, no need to take cma and per device
> cma into consideration right? 

The CMA area itself it a physical memory region.  If it is a non-highmem
region you can call virt_to_page on the virtual addresses for it.  If
it is in highmem it doesn't even have a kernel virtual address by
default.

> we only need to implement a piece code to handle per device specific region
> using RESERVEDMEM_OF_DECLARE, just like:
> RESERVEDMEM_OF_DECLARE(rpmsg-dma, "rpmsg-dma-pool", 
> rmem_rpmsg_dma_setup);
> And implement the device_init call back and build a map between page and phys.
> Then in rpmsg driver, scatter list could use page structure, no need vmalloc_to_page
> for per device dma.
> 
> Is this the right way?

I think this should work fine.  If you have the cycles for it I'd
actually love to be able to have generic CMA DT glue for non DMA API
driver allocations, as there obviously is a need for it.  So basically
the same as above, just added to kernel/cma.c as a generic API.
