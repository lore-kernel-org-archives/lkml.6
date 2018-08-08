Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F919C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF3C208B2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZFipu7ZQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q9/b5O9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF3C208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeHHCgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:36:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:36:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4914760B15; Wed,  8 Aug 2018 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533687570;
        bh=F1B+uqwTK57+pAEjaaErwGGtUQvzb8P2PoBQko3xaes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFipu7ZQ7K0b75YfZj6FN/llNZ5Q4aTPx2y3FMsx/2irxdRRopWqw0s9sR+E//hhy
         wHxeD4ZIgVWlTKirnnbRJx6VMxlgwSnJf7/sAXvjilp0V8v+n7QJsyNBszJzNQn0Bk
         T79dO9jirx6lRWDLwJxW0ok+muokwBmv3oYQPN+w=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38AEA601D3;
        Wed,  8 Aug 2018 00:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533687569;
        bh=F1B+uqwTK57+pAEjaaErwGGtUQvzb8P2PoBQko3xaes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9/b5O9Ch449pdgSIDMpSB35ivBNhk2f4RBYOiERxxPOHWwSgzdyZFR7//uU63vo4
         4n3TNnsb9qzaYyw4Ach45cBISsISzYu8BrbFg2z7ynIkJRxeYfQttDgAyBdZMXx4H+
         GVuc6R2Iq8YsPFUeIVjvIfYsz/JneOkrwJLwy/CE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38AEA601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Tue, 7 Aug 2018 19:19:27 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Message-ID: <20180808001927.GA20752@codeaurora.org>
References: <20180719125635.824-1-hch@lst.de>
 <20180719125635.824-2-hch@lst.de>
 <20180725032948.GG12771@codeaurora.org>
 <20180725043927.GA10827@lst.de>
 <20180731152229.GA956@lst.de>
 <20180807070136.GA32634@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807070136.GA32634@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:01:36AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 05:22:29PM +0200, Christoph Hellwig wrote:
> > On Wed, Jul 25, 2018 at 06:39:27AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 24, 2018 at 10:29:48PM -0500, Richard Kuo wrote:
> > > > Patch series looks good.  Definitely appreciate the cleanup.
> > > > 
> > > > I can take it through my tree, or if not:
> > > > 
> > > > Acked-by: Richard Kuo <rkuo@codeaurora.org>
> > > 
> > > Please take it through your tree, thanks!
> > 
> > I haven't seen it in linux-next yet, do you still plan to take it?
> > 
> > Otherwise I'll merge it in the dma-mapping tree.
> 
> Given that I haven't seen this in linux-next nor haven't heard back
> from you I assume you are on your well deserved summer vacation.
> 
> If I don't hear back until tomorrow night I'll merge it through the
> dma-mapping tree, so that I have it in linux-next before heading out
> to my summer vacation.

I am here, and I have the patch queued up but it's waiting for approval
before I get to push it out through my tree.

That said, I am perfectly fine with this going through a different tree
if expedience is needed.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
