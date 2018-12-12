Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99C1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B0420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B0420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeLLNkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:40:31 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2207 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbeLLNkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:40:31 -0500
X-UUID: 266bcfeb30f8439e944a70b85054d0f4-20181212
X-UUID: 266bcfeb30f8439e944a70b85054d0f4-20181212
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 615991378; Wed, 12 Dec 2018 21:40:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 12 Dec
 2018 21:40:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 21:40:20 +0800
Message-ID: <1544622020.7367.2.camel@mhfsdcap03>
Subject: Re: [PATCH 6/9] iommu/mediatek: Use helper functions to access
 dev->iommu_fwspec
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Date:   Wed, 12 Dec 2018 21:40:20 +0800
In-Reply-To: <20181211121910.5604-7-joro@8bytes.org>
References: <20181211121910.5604-1-joro@8bytes.org>
         <20181211121910.5604-7-joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 13:19 +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
> 
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/mtk_iommu.c    | 21 ++++++++++++---------
>  drivers/iommu/mtk_iommu_v1.c | 28 ++++++++++++++++------------
>  2 files changed, 28 insertions(+), 21 deletions(-)

Tested-by: Yong Wu <yong.wu@mediatek.com>


