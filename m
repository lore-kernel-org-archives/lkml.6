Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644DCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B2620883
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KTxhmuOX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KTxhmuOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B2620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeGYEj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:39:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeGYEj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:39:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E86B260B62; Wed, 25 Jul 2018 03:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532489390;
        bh=IK0gPKQ/dW1M+CNv0yfWCs4m7A4BaTgHR+y2d/zDsb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTxhmuOXhCjBpwxQI/ST++zlJX7ifBnPJCRqqo3T7Q3nr8O2gKRm36Wgec6GObEbq
         QiM6YNbTyz4aqZASMiyneVvRIlMLXhXrxUBjBBwliCL9+ntk88tWOGIN5ny6jeNLjP
         5H2pHJdo0xdEaTjtbHB0FJf7eTce334Lbb9VCeTQ=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4FFA605A4;
        Wed, 25 Jul 2018 03:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532489390;
        bh=IK0gPKQ/dW1M+CNv0yfWCs4m7A4BaTgHR+y2d/zDsb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTxhmuOXhCjBpwxQI/ST++zlJX7ifBnPJCRqqo3T7Q3nr8O2gKRm36Wgec6GObEbq
         QiM6YNbTyz4aqZASMiyneVvRIlMLXhXrxUBjBBwliCL9+ntk88tWOGIN5ny6jeNLjP
         5H2pHJdo0xdEaTjtbHB0FJf7eTce334Lbb9VCeTQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4FFA605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Tue, 24 Jul 2018 22:29:48 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-hexagon@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Message-ID: <20180725032948.GG12771@codeaurora.org>
References: <20180719125635.824-1-hch@lst.de>
 <20180719125635.824-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719125635.824-2-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 05:56:33AM -0700, Christoph Hellwig wrote:
> hexagon does all the required cache maintainance at dma map time, and none
> at unmap time.  It thus has to implement sync_single_for_device to match
> the map cace for buffer reuse, but there is no point in doing another
> invalidation in the sync_single_cpu_case, which in terms of cache
> maintainance is equivalent to the unmap case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/hexagon/kernel/dma.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Patch series looks good.  Definitely appreciate the cleanup.

I can take it through my tree, or if not:

Acked-by: Richard Kuo <rkuo@codeaurora.org>

Thanks!

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
