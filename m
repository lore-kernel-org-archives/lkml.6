Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C86C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFEE208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0OrwRskv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFEE208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeHBBHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:07:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37692 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHBBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:07:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w71NIX1c135280;
        Wed, 1 Aug 2018 23:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qEQMAOjS7gGfB3X84vtLSRNDKsaZRLFXLj0qzwAFR+Y=;
 b=0OrwRskvLxpkWQWZhXat5JgC0567UXme5+rGPPxvGIqbPIYlRCbeFstUdYRm3h6MVzzX
 yGMQyVtZ7driz2nkSTfviG5VV0cJF7cluSCu7w4rSUPY2TS94tfdb+OOvVGuhfBw5AM3
 Aa9Grl7cbbOMG5HwWUoDITfQ/0CgW7Pyw2OYvhMXao/9cB51N6oRQ5UJUH/Hkj75ryiU
 /jMoUCVlAuXH9snWmrPjA+vPz1qusSKQpfkeRB1YAVZwTawAerKliSB3/CsjNlHKh/hg
 +ApRmo5KROs+f1jAQQVTc/B+zUA4ZOUcDRe6ua0/95Zd8unKo7rFL1ywiqO/4SeK1PxP Dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kgh4q7sub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Aug 2018 23:19:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w71NJMNj004901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Aug 2018 23:19:23 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w71NJMlh003729;
        Wed, 1 Aug 2018 23:19:22 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 16:19:22 -0700
Date:   Wed, 1 Aug 2018 16:19:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Thomas Bianchi <thomas.bianchi8@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: substitute spaces with tabs
Message-ID: <20180801231921.GM30972@magnolia>
References: <1533140611-23467-1-git-send-email-thomas.bianchi8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533140611-23467-1-git-send-email-thomas.bianchi8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=582
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808010236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:22:25PM +0200, Thomas Bianchi wrote:
> Inside xfs_attr_shortform_list removes spaces at the beginnig of the line
> and replaces with tabs.
> Issue found by checkpatch.
> 
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Thomas Bianchi <thomas.bianchi8@gmail.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_attr_list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> index f9ca801..a580340 100644
> --- a/fs/xfs/xfs_attr_list.c
> +++ b/fs/xfs/xfs_attr_list.c
> @@ -87,7 +87,7 @@
>  	 */
>  	if (context->bufsize == 0 ||
>  	    (XFS_ISRESET_CURSOR(cursor) &&
> -             (dp->i_afp->if_bytes + sf->hdr.count * 16) < context->bufsize)) {
> +	     (dp->i_afp->if_bytes + sf->hdr.count * 16) < context->bufsize)) {
>  		for (i = 0, sfe = &sf->list[0]; i < sf->hdr.count; i++) {
>  			context->put_listent(context,
>  					     sfe->flags,
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
