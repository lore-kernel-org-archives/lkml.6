Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3525C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F3A2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oWwvB3MR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F3A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeJSIPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:15:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeJSIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:15:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9J09Doe187966;
        Fri, 19 Oct 2018 00:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UnJjS5R5V1hyIrDeWTJsCM093lhLpgRzJdYs71lDsJY=;
 b=oWwvB3MR7ql3aNbKpbE/SE264T8ZjV31RzAos59I31NMPH/ggAIX1m2HkejpBA8TW5Ev
 OkbGzqNDcsYB0LBfHkLrr7N5Wz8DDcVhaJvWvnv7DlUBNs8V9ody13b+1gUJ2I4ohJ7i
 p5YS/Pisu2uTbty3BgOZw9iLe1AFSxAZSFUd0+OzlOqWolmQAZAO5hxwE1eo6Y7KyQ5s
 KmLJ2gZ2p1YBp11W5fAovsOyEXBo+Qz9SWZYvVlJaMToJojmz+jglIh3rU9amBIBNdke
 sqLq+ZlSVVJ1He/hxToOd/8YEi7BIRVkuazI7H5FfMHqDXB4q/uWVRMlFEk7L6ataGeY Fw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n384uhngn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:12:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9J0C4GK024867
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 00:12:04 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9J0C4d3027755;
        Fri, 19 Oct 2018 00:12:04 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 17:12:03 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id D894D6A0136; Thu, 18 Oct 2018 20:12:02 -0400 (EDT)
Date:   Thu, 18 Oct 2018 20:12:02 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] swiotlb: mark is_swiotlb_buffer static
Message-ID: <20181019001202.GC1251@char.us.oracle.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-3-hch@lst.de>
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

On Mon, Oct 08, 2018 at 10:02:38AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  include/linux/swiotlb.h | 1 -
>  kernel/dma/swiotlb.c    | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 965be92c33b5..7ef541ce8f34 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
>  #endif
>  
>  extern void swiotlb_print_info(void);
> -extern int is_swiotlb_buffer(phys_addr_t paddr);
>  extern void swiotlb_set_max_segment(unsigned int);
>  
>  extern const struct dma_map_ops swiotlb_dma_ops;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9062b14bc7f4..26d3af52956f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
>  	max_segment = 0;
>  }
>  
> -int is_swiotlb_buffer(phys_addr_t paddr)
> +static int is_swiotlb_buffer(phys_addr_t paddr)
>  {
>  	return paddr >= io_tlb_start && paddr < io_tlb_end;
>  }
> -- 
> 2.19.0
> 
