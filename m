Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8085AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6B421B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="KDLdSrsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfBKPyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:54:49 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42745 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbfBKOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:31 -0500
Received: by mail-yw1-f66.google.com with SMTP id v201so4242058ywa.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/ImNS1yXJLm8G3VHIxKbSUM3pE9Dqal6VICgbppRIs=;
        b=KDLdSrsfximhw41hAPhk6l1dJQ6PE9+Ap/MBf3SRToOREXKCmGwFVexwAWO6utq42S
         2pbX2rTrcef7aQvMnkc30kczQp82MQYBQmWxxYgpCgaIGLJRvkMCVK/hd+GiNnVahPA1
         J4bAV4xCVWfxMCUiBuACnPU6DCOoicXR0Ku2NS6nItZxsWgDyZKfLVZ+bxE6eJQAsXJj
         CDBFrB7aDHXe6/5AqlPOTqJusn8sHOKoCUuRhh3nd4DfDopSh18XW4NHdr0fDl3moFUo
         5AN3Wx1Qmhd8zLf0e/px9+1GbNMfihyfib09qb68YUEaEKE9gS2fust0ZomqVa5bfpqw
         5t6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/ImNS1yXJLm8G3VHIxKbSUM3pE9Dqal6VICgbppRIs=;
        b=ToYEmHEUOBONu8GP+xo7QBxzV1Dezz1W/2gqVm++/r3P3aIDhnLNh3rTWEGU36VGAR
         i5LXOugfB4IrL0mNoBJSgB++23dTl6BN/7qRrQdoH/1SZr8sQnVTk4Ki7vGzcM64gAcZ
         ojznrkktUeO3b3oCjfH3YGFYCruYBCv9GlGD70OuEazaqtWKZg+UB3xhEOXzZllCnrwO
         vqvzmLqg0rZXNVz7PUKogGou35qpiCdXThYVc3Jvwszo6ZgGJVqBmAayQEMdslTYYp2o
         Cf8oOQgs+Ii6AeRNrwXO8KT+Qd/FB6rPU76UhUlGkMaCTM5ggvBRSACkRCDXkwlHm9u7
         bmJA==
X-Gm-Message-State: AHQUAuaBdn9kag7GG7pX8xJzYlhyeLPIn0svcBQvTSUbhYXiG4Iqzmg5
        XUSYbOUzgTz8TBZ0x/v1IiFLJw==
X-Google-Smtp-Source: AHgI3IaVpuZykSjrQDBJ4YzxY5sy0agnazgLo+sAmR1TggdPJjmKvuGkmVgxLfF9Ux7BzZVui5MI+g==
X-Received: by 2002:a81:6604:: with SMTP id a4mr130258ywc.510.1549895730478;
        Mon, 11 Feb 2019 06:35:30 -0800 (PST)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id j69sm3561847ywa.41.2019.02.11.06.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 06:35:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 09:35:28 -0500
From:   Jon Mason <jdmason@kudzu.us>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
Message-ID: <20190211143527.GB13951@kudzu.us>
References: <20190119001001.13087-1-logang@deltatee.com>
 <34680d2e-ec3f-7cb4-4f42-2398fc14dd5e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34680d2e-ec3f-7cb4-4f42-2398fc14dd5e@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:25:20PM -0700, Dave Jiang wrote:
> 
> 
> On 1/18/19 5:10 PM, Logan Gunthorpe wrote:
> > Presently, when ntb_transport is used with DMA and the IOMMU turned on,
> > it fails with errors from the IOMMU such as:
> > 
> >   DMAR: DRHD: handling fault status reg 202
> >   DMAR: [DMA Write] Request device [00:04.0] fault addr
> > 	381fc0340000 [fault reason 05] PTE Write access is not set
> > 
> > This is because ntb_transport does not map the BAR space with the IOMMU.
> > 
> > To fix this, we map the entire MW region for each QP after we assign
> > the DMA channel. This prevents needing an extra DMA map in the fast
> > path.
> > 
> > Link: https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Jon Mason <jdmason@kudzu.us>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Allen Hubbe <allenbh@gmail.com>
> 
> Nice! I actually never encountered this on the Intel NTB with IOMMU on.
> It also could be that the Intel BIOS already took care of it for all
> embedded device BARs on the uncore. Nevertheless it's needed. Thanks!
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Added to the ntb branch, thanks!

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 3bfdb4562408..526b65afc16a 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -144,7 +144,9 @@ struct ntb_transport_qp {
> >  	struct list_head tx_free_q;
> >  	spinlock_t ntb_tx_free_q_lock;
> >  	void __iomem *tx_mw;
> > -	dma_addr_t tx_mw_phys;
> > +	phys_addr_t tx_mw_phys;
> > +	size_t tx_mw_size;
> > +	dma_addr_t tx_mw_dma_addr;
> >  	unsigned int tx_index;
> >  	unsigned int tx_max_entry;
> >  	unsigned int tx_max_frame;
> > @@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	tx_size = (unsigned int)mw_size / num_qps_mw;
> >  	qp_offset = tx_size * (qp_num / mw_count);
> >  
> > +	qp->tx_mw_size = tx_size;
> >  	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> >  	if (!qp->tx_mw)
> >  		return -EINVAL;
> > @@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >  	dma_cookie_t cookie;
> >  
> >  	device = chan->device;
> > -	dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index;
> > +	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
> >  	buff_off = (size_t)buf & ~PAGE_MASK;
> >  	dest_off = (size_t)dest & ~PAGE_MASK;
> >  
> > @@ -1863,6 +1866,18 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  		qp->rx_dma_chan = NULL;
> >  	}
> >  
> > +	if (qp->tx_dma_chan) {
> > +		qp->tx_mw_dma_addr =
> > +			dma_map_resource(qp->tx_dma_chan->device->dev,
> > +					 qp->tx_mw_phys, qp->tx_mw_size,
> > +					 DMA_FROM_DEVICE, 0);
> > +		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
> > +				      qp->tx_mw_dma_addr)) {
> > +			qp->tx_mw_dma_addr = 0;
> > +			goto err1;
> > +		}
> > +	}
> > +
> >  	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
> >  		qp->tx_dma_chan ? "DMA" : "CPU");
> >  
> > @@ -1904,6 +1919,10 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  	qp->rx_alloc_entry = 0;
> >  	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
> >  		kfree(entry);
> > +	if (qp->tx_mw_dma_addr)
> > +		dma_unmap_resource(qp->tx_dma_chan->device->dev,
> > +				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> > +				   DMA_FROM_DEVICE, 0);
> >  	if (qp->tx_dma_chan)
> >  		dma_release_channel(qp->tx_dma_chan);
> >  	if (qp->rx_dma_chan)
> > @@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >  		 */
> >  		dma_sync_wait(chan, qp->last_cookie);
> >  		dmaengine_terminate_all(chan);
> > +
> > +		dma_unmap_resource(chan->device->dev,
> > +				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> > +				   DMA_FROM_DEVICE, 0);
> > +
> >  		dma_release_channel(chan);
> >  	}
> >  
> > 
