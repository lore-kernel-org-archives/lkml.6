Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D0C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3184724058
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cHuNls6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3184724058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeGFLWC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:22:02 -0400
Received: from 8bytes.org ([81.169.241.247]:53264 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbeGFLWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:22:00 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5644A298; Fri,  6 Jul 2018 13:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1530876119; bh=EeVmoE5GJaCl53aNbzAijMp/q2Fy6Vo0/4PVotGpQiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHuNls6O9xRjuuAvJEF+LJjgGnu/fJLH8ZmnBoQ+3E6EI1JE8fjLhn+KyLSGjvXKo
         TgNg7erBsq1DLjH8IIpah8YHUZbdV397SJ5bGBMPzP8hYOdYxzU/ijhQ8t1xpwt0fo
         hnnaVRdvpiekForILErr6fulj4KjvFYYImXv3BulhueExpq/W7EpauWGMxz726ZVZn
         OkOQ6Vo15TQJl9ngpLtKbQdjSMHy/FVO2fTOnyZoTZLRq9weXKuKgHiSB/3vT9FGWK
         O0JsCoQB03T3MoShuEXl3b9d7cQPJ9Pu5BOxJCYYV8V+VdJVofjPCyyH353FmsZxcV
         3H7mPXGKi0j2w==
Date:   Fri, 6 Jul 2018 13:21:54 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/1] iommu/amd: make sure TLB to be flushed before IOVA
 freed
Message-ID: <20180706112154.hslaptjtlsj5whgy@8bytes.org>
References: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528251526-11408-1-git-send-email-thunder.leizhen@huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:18:46AM +0800, Zhen Lei wrote:
> Although the mapping has already been removed in the page table, it maybe
> still exist in TLB. Suppose the freed IOVAs is reused by others before the
> flush operation completed, the new user can not correctly access to its
> meomory.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

