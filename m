Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83172C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CFC205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXbZJYec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CFC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeHCRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:15:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbeHCRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:15:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w73F9SSn154998;
        Fri, 3 Aug 2018 15:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=47WKTJRSyFBaUHkoqMjXlV3EqvvBIfSQldPN+QqIKuM=;
 b=MXbZJYecr/qchJ9ldO1YaLsNJF/b2j6c4XwUZiUxQO1GjzD+mJvxw+egvzE3TOX2fzKh
 HlV6VNg17kh4ZEFhcrn6dEPier27R/HApADybKUvypoxbB99vTCvtwkmxTha/lvTOehM
 b7anaEGHTSPwB+oWHL1B2qW3LwUxmJ1f8Y90n7R+t4wm3gOpOQCWH3nmk/A1TcAwrUoQ
 qefqBnOBDaisOHLLPq97PT74TndrlPUo3D3o4Ke0TfTd3riRV40nB7Arcc9knLOnfLjR
 0XfSqPXvt1BGDvbrqcZsmjFiuyC+W20CbGpqmkkygy+n+w0uKCNZrYjBpInGHM1xkSjp OA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kma04jssw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Aug 2018 15:18:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w73FIWEc015530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Aug 2018 15:18:32 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w73FIVLa027522;
        Fri, 3 Aug 2018 15:18:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Aug 2018 08:18:31 -0700
Date:   Fri, 3 Aug 2018 08:18:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Huang Chong <huang.chong@zte.com.cn>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
Subject: Re: [PATCH] xfs: fix a comment in xfs_log_reserve
Message-ID: <20180803151830.GW30972@magnolia>
References: <1533285093-193140-1-git-send-email-huang.chong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533285093-193140-1-git-send-email-huang.chong@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8973 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=6 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=563
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808030168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2018 at 04:31:33PM +0800, Huang Chong wrote:
> From: "Huang Chong" <huang.chong@zte.com.cn>
> 
> Fix the comment in xfs_log_reserve to avoid confusing.
> 
> Signed-of-by: Huang Chong <huang.chong@zte.com.cn>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index 5e56f3b..891ffb1 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -410,7 +410,7 @@
>  }
>  
>  /*
> - * Reserve log space and return a ticket corresponding the reservation.
> + * Reserve log space and return a ticket corresponding to the reservation.
>   *
>   * Each reservation is going to reserve extra space for a log record header.
>   * When writes happen to the on-disk log, we don't subtract the length of the
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
