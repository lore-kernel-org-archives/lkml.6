Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC6BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83B5218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBgO6UYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeLTPgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:36:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeLTPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aL191S3jRkuZn8xjEd4p6auxHNg7qsuIaEjoOzuvztQ=; b=OBgO6UYPjHPKU1wkC8UBZ5NRoU
        1kp92d3/H7z1P9vbNE+JMe7whAWbD07o926aGPklwb+grm7zV5WtKYBmVjVzxGoKf+CU06tUSymyz
        f8qqC+ooRaj3OEw4Lr9AgmB8jVvUBEDK3/RH4Jg7gFnItx81nRRazxl47CQk7eNN9WnztDUTILIV6
        BV26XjULGAMBMwQDFCu9MVS13dWTpWV6Wff0hdxdPxpETjyYiqO6lOq0nPNQYqBuS1OMRgRNC57vb
        gK5mIOc8nj/H8lskDZGtD/H39X7JbJiI3kcXBaGzX1hNxVpZVJBDITnwIFvkVMDrtz5ktSUqhmhDh
        rXxTQPIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga0NS-0008Ce-4Y; Thu, 20 Dec 2018 15:36:46 +0000
Date:   Thu, 20 Dec 2018 07:36:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel.vetter@intel.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
Message-ID: <20181220153646.GA22997@infradead.org>
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 08:20:22PM +0100, Noralf Trønnes wrote:
> > +	if (!dma_map_sg(dev->dev, xen_obj->sgt->sgl, xen_obj->sgt->nents,
> > +			DMA_BIDIRECTIONAL)) {
> 
> 
> Are you using the DMA streaming API as a way to flush the caches?

This looks rather broken.  Please send the whole patch series to
the iommu list for proper review.

> Does this mean that GFP_USER isn't making the buffer coherent?

How could GFP_USER make memory coherent in any way?
