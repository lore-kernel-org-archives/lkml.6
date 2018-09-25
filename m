Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C1C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FA120877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="QA1+CI5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FA120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeIYOZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:25:13 -0400
Received: from 8bytes.org ([81.169.241.247]:32808 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbeIYOZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:25:12 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 097512A9; Tue, 25 Sep 2018 10:18:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537863529; bh=Jt3wbIDOLrQC4pXYtPwzIlFNRZWYnH1dWxw75jYJsoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QA1+CI5i4j/n8jhnHJ93K6BHIV9GSAvuW+mPuBUnNNe1JcqnVXE6DylnpeE0DTX1v
         vKq/Q+2213NEirJfgI184FiXVmfBu/36RG8bGKES+j0sLannOM5v319vFj44kVGuVx
         uSUkWYWB9f9Vhh+bVDTXCqUOGkgll3jCb6x5aJ4VLiSKusxroxkpG0qYo2LsPQ9td0
         JhednhfM90ys+aAuXnUZpGZVPVL2dZNfl2Vtw52YhBa5PNZ9NnbfRYD2DRvA54Zaz5
         E/7J/OvWvEIaKjApOF4bBLPB8N3QPXVDp41A1Owwik02wETT6DfQqqR+Ir4ceK6wEe
         DO+YdQTZgbeXQ==
Date:   Tue, 25 Sep 2018 10:18:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com,
        gklkml16@gmail.com
Subject: Re: [PATCH v4] iommu/iova: Optimise attempts to allocate iova from
 32bit address range
Message-ID: <20180925081848.fh32go4nwvtmfjn2@8bytes.org>
References: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:57:36AM +0530, Ganapatrao Kulkarni wrote:
>  drivers/iommu/iova.c | 22 +++++++++++++++-------
>  include/linux/iova.h |  1 +
>  2 files changed, 16 insertions(+), 7 deletions(-)

Applied, thanks.
