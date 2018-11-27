Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F4AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA27208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDxqnkS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA27208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbeK0U6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730329AbeK0U6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:58:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B33C20873;
        Tue, 27 Nov 2018 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543312872;
        bh=FmH+mZejRlzaifx07pYG0O0SyC4aiIqCiFch8yE6S4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDxqnkS2PIOZhpYvoLtkzY0mR2C8kaizRpkAh/fHCX95AQfgdHuR20yivBBqYntI6
         G2/X7CVWQI2bhyIbBljemfSaKKp/yQHZbsMUKv9T55Aoj+bBzMb0Al0sFBlzWVHv8b
         0LLfhOkhHShj8HO6vNH7EDOPIo6tlh+gL/gtvlUc=
Date:   Tue, 27 Nov 2018 11:01:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 005/118] nvme-pci: fix conflicting p2p resource adds
Message-ID: <20181127100110.GC21989@kroah.com>
References: <20181126105059.832485122@linuxfoundation.org>
 <20181126105100.053276084@linuxfoundation.org>
 <22aec0ec-4da1-fcbc-3318-ec7709888769@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22aec0ec-4da1-fcbc-3318-ec7709888769@deltatee.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:23:40PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2018-11-26 3:49 a.m., Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> This commit is fixing a bug in the p2pdma code which was merged for
> 4.20. I'm not sure it would actually fix anything in the stable kernels.
> On the other hand, based on my understanding, it shouldn't hurt anything
> either.

Thanks for letting me know, I've dropped it from both 4.14.y and 4.19.y.

greg k-h
