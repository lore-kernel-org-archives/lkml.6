Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AA520818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AA520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438067AbeKWCnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:43:21 -0500
Received: from 8bytes.org ([81.169.241.247]:48990 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732369AbeKWCnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:43:21 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6D887435; Thu, 22 Nov 2018 17:03:22 +0100 (CET)
Date:   Thu, 22 Nov 2018 17:03:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: use memunmap to free memremap
Message-ID: <20181122160318.gmncgapsrwcwy6hy@8bytes.org>
References: <1542794027-93141-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542794027-93141-1-git-send-email-bianpan2016@163.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 05:53:47PM +0800, Pan Bian wrote:
> memunmap() should be used to free the return of memremap(), not
> iounmap().
> 
> Fixes: dfddb969edf0("iommu/vt-d: Switch from ioremap_cache to memremap")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/iommu/intel-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

