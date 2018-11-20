Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D42C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B977F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoXC0kWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B977F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeKUBTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:19:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33432 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeKUBTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:19:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAKEhqHn161269;
        Tue, 20 Nov 2018 14:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=O1WGBOqujV4t0MJM3uCoAt6text/TbUo8RLfeEkbOAg=;
 b=OoXC0kWhO8MtzD/w87HtcoHTghYpgRuAKtpbuxvMhGzhgx4bCBjpYhMTiyrMiVxdGEdj
 Z+910as3ly5Wq3V69ULMgpcH2BD4X+QF/r4JPp18B+b18HeY2ZZz+ddVhBGsjKmpt/aY
 wn9C55+9UihAo7tOhyqOXK97xALVVC1466ef/zQ8K5hcPVL8qYO0Ue/LTZf/cea6bzJR
 IPFgPrpCAdXG41i+zcPy8diF68wuC6/wVJWsX6peH5HkV/Bin0iCF374k9RqPrNm91aE
 ak2tL0a4YIKGaUOuuZ2D6Z40jbbX5agB0KAhfP23KrZ6PDXoiqcEFmUjZQGN0yd855As rQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ntaxq4b1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 14:49:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAKEnKn0002939
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Nov 2018 14:49:20 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAKEnJe9007473;
        Tue, 20 Nov 2018 14:49:19 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Nov 2018 06:49:19 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 368C56A00D4; Tue, 20 Nov 2018 09:49:18 -0500 (EST)
Date:   Tue, 20 Nov 2018 09:49:18 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
Message-ID: <20181120144918.GH10917@char.us.oracle.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811200133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:09:52PM +0000, Robin Murphy wrote:
> With the overflow buffer removed, we no longer have a unique address
> which is guaranteed not to be a valid DMA target to use as an error
> token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
> an unlikely DMA target, but unfortunately there are already SWIOTLB
> users with DMA-able memory at physical address 0 which now gets falsely
> treated as a mapping failure and leads to all manner of misbehaviour.
> 
> The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
> commonly-used all-bits-set value, since the last single byte of memory
> is by far the least-likely-valid DMA target.

Are all the callers checking for DIRECT_MAPPING_ERROR or is it more of
a comparison (as in if (!ret)) ?


> 
> Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")]
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/dma-direct.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index bd73e7a91410..9de9c7ab39d6 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -5,7 +5,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/mem_encrypt.h>
>  
> -#define DIRECT_MAPPING_ERROR		0
> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0
>  
>  #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>  #include <asm/dma-direct.h>
> -- 
> 2.19.1.dirty
> 
