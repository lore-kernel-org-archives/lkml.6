Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B3CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643D424053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643D424053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754295AbeGEQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:55:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753827AbeGEQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:55:29 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BB772CB7;
        Thu,  5 Jul 2018 16:55:28 +0000 (UTC)
Date:   Thu, 5 Jul 2018 18:55:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4] nvme-pci: initialize queue memory before interrupts
Message-ID: <20180705165526.GA4349@kroah.com>
References: <20180613171320.GB28828@kroah.com>
 <20180619172306.atcqdzb2tdk3ivvt@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619172306.atcqdzb2tdk3ivvt@xylophone.i.decadent.org.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 06:23:06PM +0100, Ben Hutchings wrote:
> From: Keith Busch <keith.busch@intel.com>
> 
> commit 161b8be2bd6abad250d4b3f674bdd5480f15beeb upstream.
> 
> A spurious interrupt before the nvme driver has initialized the completion
> queue may inadvertently cause the driver to believe it has a completion
> to process. This may result in a NULL dereference since the nvmeq's tags
> are not set at this point.
> 
> The patch initializes the host's CQ memory so that a spurious interrupt
> isn't mistaken for a real completion.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [bwh: Backported to 4.4: adjust context]
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Now applied, thanks.

greg k-h
