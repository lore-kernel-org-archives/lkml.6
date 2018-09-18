Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24B7ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE4220693
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CEZkdp9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE4220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeIRIV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:21:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeIRIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:21:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8I2moCg130093;
        Tue, 18 Sep 2018 02:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=+dw1qINo9M+j4CL94HOeABDxI0pzKgeEddO2PNVGj08=;
 b=CEZkdp9AoUK/BbvnIBUdGN4gKGWL1Ozj3Ii5jEhy2PmWYOdUmrqZ/zI66gjh/0drSm2j
 64JXaVduChn/p17e8zcvIAGCvwG1FiMmCSvqUVg8ZGCLxnS4gadjknllROvl6NKQcXSX
 +FkrrxT3aBPUs91dlttkUxZqx370zoCyfmd46+KJVJWu012IkTI/5kBcmIFMVC55AZFw
 uS6SCrkPLMMOkt6CRvC+a5GPAYYTGtQq59ms18jStHSrpIUSMN8cfg7dAuGEcjCO0O+o
 dFU0fCW9iiVYldbx8RZV502Vv66HshdEmd8WUBGcnFpDvRbsS+1iQiGW2jo/QtrxDMHv dA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mgt1phn6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 02:51:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8I2pGvv005672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 02:51:17 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8I2pG1Q029956;
        Tue, 18 Sep 2018 02:51:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 19:51:16 -0700
Date:   Mon, 17 Sep 2018 19:51:15 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linux-xfs@vger.kernel.org, dchinner@redhat.com, bfoster@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: remove duplicated include from alloc.c
Message-ID: <20180918025114.GB20086@magnolia>
References: <20180918020734.23180-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918020734.23180-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 10:07:34AM +0800, YueHaibing wrote:
> Remove duplicated include xfs_alloc.h
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/scrub/alloc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/alloc.c b/fs/xfs/scrub/alloc.c
> index 036b5c7..376bcb5 100644
> --- a/fs/xfs/scrub/alloc.c
> +++ b/fs/xfs/scrub/alloc.c
> @@ -17,7 +17,6 @@
>  #include "xfs_sb.h"
>  #include "xfs_alloc.h"
>  #include "xfs_rmap.h"
> -#include "xfs_alloc.h"
>  #include "scrub/xfs_scrub.h"
>  #include "scrub/scrub.h"
>  #include "scrub/common.h"
> -- 
> 2.7.0
> 
> 
