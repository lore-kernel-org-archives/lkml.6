Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B77C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD08D20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wEk/RSY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfAWOZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:25:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35574 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfAWOZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:25:33 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NEO4mQ058302;
        Wed, 23 Jan 2019 14:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8SJ/AdlUE+Lj8JQ2P4ZqUftJ4Yv93XPw6/EyTigYxLk=;
 b=wEk/RSY92XSc4oeAdLto8TjvvHkXbAsGHHuCVv8Rgo6PUcUB0MjdhBgoVcN2bJ4vrKws
 zzJBJTbgYUU84SFC3pnH36Jv/nttM94CDV1w/9Ym+cexzYCiHIhxKsfy2mC3fZiQ7dT9
 LuAuSXrmvUZ0plICnq75rGsj4PPah8fWQS3MVVnwOubTq1RXvoLXniOF5P/tPypoeUBz
 9WfAnzWT033QJFBr9Iv5sLgfOWQKkZg5PKSTpyntE8CPpY2aFYUxeA1/65L1i1rKfRDx
 LM2Fs4xo4WH+DtxW+/LKYAvhHwvzRNuXIKGNEMlWN0MmM1iX77xuZtqfd13zojCjkS1+ jA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2q3sdej9gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:25:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEPUKO006861
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:25:30 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NEPUj8014896;
        Wed, 23 Jan 2019 14:25:30 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 06:25:30 -0800
Date:   Wed, 23 Jan 2019 09:25:07 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: cleancache: no need to check return value of
 debugfs_create functions
Message-ID: <20190123142504.GA19985@Konrads-MacBook-Pro.local>
References: <20190122152151.16139-12-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-12-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:11PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

OK.

Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

or I can push it through my tree but it may be just easier for Andrew
too do it
> Cc: linux-mm@kvack.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  mm/cleancache.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/cleancache.c b/mm/cleancache.c
> index 2bf12da9baa0..082fdda7aaa6 100644
> --- a/mm/cleancache.c
> +++ b/mm/cleancache.c
> @@ -305,8 +305,7 @@ static int __init init_cleancache(void)
>  {
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *root = debugfs_create_dir("cleancache", NULL);
> -	if (root == NULL)
> -		return -ENXIO;
> +
>  	debugfs_create_u64("succ_gets", 0444, root, &cleancache_succ_gets);
>  	debugfs_create_u64("failed_gets", 0444, root, &cleancache_failed_gets);
>  	debugfs_create_u64("puts", 0444, root, &cleancache_puts);
> -- 
> 2.20.1
> 
