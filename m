Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE10C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29302084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbeLQJUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:20:08 -0500
Received: from 8bytes.org ([81.169.241.247]:54470 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbeLQJUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:20:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 093AF730; Mon, 17 Dec 2018 10:20:06 +0100 (CET)
Date:   Mon, 17 Dec 2018 10:20:04 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK Hu <ck.hu@mediatek.com>, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Check for v7s-incapable
 systems"
Message-ID: <20181217092004.3s2nwcuwus3wdljs@8bytes.org>
References: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 05:19:48PM +0800, Yong Wu wrote:
> This reverts commit 82db33dc5e49fb625262d81125625d07a0d6184e.
> 
> After the commit 29859aeb8a6e ("iommu/io-pgtable-arm-v7s: Abort
> allocation when table address overflows the PTE"), v7s will return fail
> if the page table allocation isn't expected. this PHYS_OFFSET check
> is unnecessary now.
> 
> And this check may lead to fail. For example, If CONFIG_RANDOMIZE_BASE
> is enabled, the "memstart_addr" will be updated randomly, then the
> PHYS_OFFSET may be random.
> 
> Reported-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied to iommu/fixes, thanks.
