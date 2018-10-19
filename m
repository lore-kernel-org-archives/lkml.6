Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B5C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE1F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2buUePrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE1F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeJSIN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:13:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:13:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J09QeT192711;
        Fri, 19 Oct 2018 00:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=J3CXmdJeTtscTIZf05xkMgsYlzr90ggvXnv2vLm5hFI=;
 b=2buUePrhXldM4hFcBMMwPo4XAf05ZJZ90qmKyWeOiEjT9t050xKMUPqnlRDWLfMCfJD3
 SnUkCIi52kRr8NEKZBCmlaDEDCvHTGJB/5FuGzA4odDhOBu4bWaTL4q5/c8mREKpp2Lb
 wq8pmljoFXM3mEc/e7mc/ucAP+lcIW4IVnHTKnywYo9kbaCwBFpOp6zw0Vu4OssIyEOA
 wMaILgZCCK0P1lIQGaQgbUwafYhEO0EiP9bHzFFTbx6iGtkiavajqsFHBgCkTQObdrum
 hkVOjsnri7jnQ2OuWESEV6o8cYO7vUGPR2+3vemG4JyguF3OsR4/g6bPM8htPj6GJWMg yA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38nqhe61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:09:37 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9J09alb031589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:09:36 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9J09ZIF007843;
        Fri, 19 Oct 2018 00:09:35 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:09:35 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 1C9F66A0136; Thu, 18 Oct 2018 20:09:34 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:09:34 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] swiotlb: remove a pointless comment
Message-ID: <20181019000934.GB1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-2-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:02:37AM +0200, Christoph Hellwig wrote:
> This comments describes an aspect of the map_sg interface that isn't
> even exploited by swiotlb.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  kernel/dma/swiotlb.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4f8a6dbf0b60..9062b14bc7f4 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -925,12 +925,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
>   * appropriate dma address and length.  They are obtained via
>   * sg_dma_{address,length}(SG).
>   *
> - * NOTE: An implementation may be able to use a smaller number of
> - *       DMA address/length pairs than there are SG table elements.
> - *       (for example via virtual mapping capabilities)
> - *       The routine returns the number of addr/length pairs actually
> - *       used, at most nents.
> - *
>   * Device ownership issues as mentioned above for swiotlb_map_page are the
>   * same here.
>   */
> -- 
> 2.19.0
> 
