Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE93C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B482405B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SnRm4brB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B482405B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeFVK20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:28:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeFVK2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:28:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5MANYK2182997;
        Fri, 22 Jun 2018 10:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=kO2DwAIjd7sD3UMMFr1UA7WHDt1XRjJrUuW/vraYC4U=;
 b=SnRm4brBNgbBxfODumR71z0SJREdIbMAy6PpjHbFqsdcT0A+XWT8gIaVk2PdtO/TpP/6
 Fh2iR75O8gEVNp8agHc7Wjkh+KwA7L9vyqh8SQG6OBQ8kOyk4r7SegwNyQGDn4XYUp8n
 gveUbx9TBXfingRwy4OSpcA/uiXHHWJTvxqn9GNuzXWqhGcwNa544Jdv1mLp1fIb9SMX
 YFB0ssEuFvGKXXjJ5T8rV+G/8jKcHBE7CizKfSBR183Q38AbJs6E8RErqvRt/7ffNkw9
 qMsq/rqT16WSp988Q5oIsJ82ZiMSXcE8/ZmdXCH+k3QAm1HDGtjGX8wKX0Wd/scWJP3M yQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jrp8hsdrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:28:13 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5MASDg1020251
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:28:13 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5MAS8aq009475;
        Fri, 22 Jun 2018 10:28:08 GMT
Received: from mwanda (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 03:28:07 -0700
Date:   Fri, 22 Jun 2018 13:28:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <michael.straube@posteo.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix brace coding style issues
Message-ID: <20180622102800.4p6wabmte4yf4rtp@mwanda>
References: <20180621182155.27769-1-michael.straube@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621182155.27769-1-michael.straube@posteo.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:21:55PM +0200, Michael Straube wrote:
> Remove braces from single line if statements.
> Also fix a comparsion to NULL in one of the conditions.
> Issues found by checkpatch.
> 
> Signed-off-by: Michael Straube <michael.straube@posteo.de>
> ---
>  drivers/staging/rtl8723bs/core/rtw_debug.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> index f852fde47350..2244ed72ab9c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
> @@ -618,9 +618,8 @@ ssize_t proc_set_wait_hiq_empty(struct file *file, const char __user *buffer, si
>  	if (count < 1)
>  		return -EFAULT;
>  
> -	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
> +	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp)))
>  		sscanf(tmp, "%u", &g_wait_hiq_empty);
> -	}


The original code is kind of bad.  The NULL check isn't required.
The sscanf call should have error checking.  The error code is wrong if
the copy from user fails.  The tmp buffer isn't NUL terminated.

	if (copy_from_user(tmp, buffer, sizeof(tmp)))
		return -EFAULT;
	tmp[sizeof(tmp) - 1] = '\0';

	if (sscanf(tmp, "%u", &g_wait_hiq_empty) != 1)
		return -EINVAL;

	return count;

regards,
dan carpenter
