Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1262206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VUVZHsFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1262206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeK2GwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:52:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2GwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:52:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wASJiS6J182605;
        Wed, 28 Nov 2018 19:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vGyt3ctAdDhWLj95mrYwXHTC0z4zzuwkjgF8N7eSOyQ=;
 b=VUVZHsFFL6YCdUOddH6a+GvjbIV8AmpcZpLXcFcoFajbeoB5KkjQ+ocLmopzb2QQkxqN
 kUBQlP99WP95IEVJhrFxrFQW5qW3iMRBZalNTW3AgqRmbEmlOv2TS0pW0vJXcTZEzuVQ
 I7QocHChlqxJee05REk08ZS3RhjOpcw3xVvyOaPCG6MJ72hJlxjWS/OEY0TXo71lxPtZ
 xavcWmJHv4f3jro+AkYU2I+/FE/KVXc22ubELHdKiWwhFDwP3zQ0yVKOLfUkRFBZpLEP
 mFVAgXfwprDZRF3XV2T+x8+v9mBQGFAnz+P8p9zyzrFgD6LBU9e+wcIE3oCIAyPG9noh Nw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nxy9rcawv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 19:49:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wASJnEii031302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 19:49:14 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wASJnD9J020694;
        Wed, 28 Nov 2018 19:49:14 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Nov 2018 11:49:13 -0800
Date:   Wed, 28 Nov 2018 22:49:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] staging: rtl8188eu: use __func__ in
 hal8188e_rate_adaptive.c
Message-ID: <20181128194905.GE3095@unbuntlaptop>
References: <20181128172906.1694-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128172906.1694-1-straube.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 06:29:01PM +0100, Michael Straube wrote:
> Use __func__ instead of hardcoded function names.
> Reported by checkpatch.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  .../rtl8188eu/hal/hal8188e_rate_adaptive.c    | 36 ++++++++++---------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
> index 6dbd7d261f1e..02f423accee8 100644
> --- a/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
> +++ b/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c
> @@ -127,10 +127,10 @@ static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm,
>  	u8 i;
>  
>  	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
> -			ODM_DBG_TRACE, ("=====>odm_RateDown_8188E()\n"));
> +			ODM_DBG_TRACE, ("=====>%s()\n", __func__));

This printk has no information that you couldn't get using ftrace.

>  	if (!pRaInfo) {
>  		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
> -				("odm_RateDown_8188E(): pRaInfo is NULL\n"));
> +				("%s(): pRaInfo is NULL\n", __func__));

It pRaInfo is never NULL so this is dead code.  A lot of this trace
output could just be deleted.

regards,
dan carpenter
