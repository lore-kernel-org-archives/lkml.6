Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8438BECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD902085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M+/o/z3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD902085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJ0DDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:03:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56756 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeJ0DDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:03:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9QINV4J116442;
        Fri, 26 Oct 2018 18:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=X0Dz1fe1YdsPrCArtkPORj/PqrYFLoLIEA9NTGfjCNg=;
 b=M+/o/z3zAgZ8EJTsOZzSnjJUsooVuWIAj5FIIqAyEciysDTrBw3C3w5aI7P38S3LeXi7
 1zpydtzoQfzuv6As9QPFNsRzHXqCuR95YpnGWRAmlXsyzWZceCcgv0Krpf1KE1ORfMRr
 4Mx3sZasGIIrfhK4dzJ7cCZQSwvsjrKhc77XVBWtQ89smN9JV7Pa2SgjgtBl9tcXd4fL
 wMci32kbFuDvrQuUP4rwMp5F4JCeDaZrMMR8+krpERIh+FvB2bOCjtC9/Pqy2MUxq4s7
 t0d+Cb892Jrd0dgKEXk5wt5DN5BbHgBuWO0vZ9ZB7lNCTU+J6goUpsBuCVlGZ1hihWjo dQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n7usurrw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 18:24:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9QIOhIs021363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 18:24:44 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9QIOh1Y000827;
        Fri, 26 Oct 2018 18:24:43 GMT
Received: from [192.168.1.93] (/99.156.91.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 11:24:43 -0700
Subject: Re: [PATCH] jfs: fix spelling mistake, EACCESS -> EACCES
To:     Colin King <colin.king@canonical.com>,
        jfs-discussion@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181026180909.5249-1-colin.king@canonical.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Openpgp: preference=signencrypt
Message-ID: <a7bc3873-8558-94b0-470b-3458f87a2aa8@oracle.com>
Date:   Fri, 26 Oct 2018 13:24:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181026180909.5249-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9058 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 1:09 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to a spelling mistake of the error access name EACCESS,
> rename to EACCES
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks. Pulled into the jfs tree.

Shaggy

> ---
>  fs/jfs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> index 14528c0ffe63..fa719a1553b6 100644
> --- a/fs/jfs/namei.c
> +++ b/fs/jfs/namei.c
> @@ -203,7 +203,7 @@ static int jfs_create(struct inode *dip, struct dentry *dentry, umode_t mode,
>   * RETURN:	Errors from subroutines
>   *
>   * note:
> - * EACCESS: user needs search+write permission on the parent directory
> + * EACCES: user needs search+write permission on the parent directory
>   */
>  static int jfs_mkdir(struct inode *dip, struct dentry *dentry, umode_t mode)
>  {
> 
