Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CC8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FD32083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WNujjurJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FD32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965814AbeFSHh7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:37:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59098 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937104AbeFSHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:37:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J7Xrbj077195;
        Tue, 19 Jun 2018 07:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=oLmrTfFF5ibT/EKby+VelNTtxCNFqbuff6j6ZbTJ4lw=;
 b=WNujjurJALhfNvVcyK5ffWsKLxm11VuEHBE+PKiiWmnCEL4ZgzDoPc8kMqV0YlO8Q0u+
 +4R0581aVNWlE9G1hl6i3eY/fu99+lhKCPDSjkQJVAlOYLoUhvnHNgtsLIZ8Jt9qhCb5
 gYxshEd4REQwAaweCHUzFe2+HelgXFMV8zryLXfq5fO9WNj96MP99HRNEzULQLcUYY00
 Pj+pHqw8ji+YuNwkH325HOJlEJGsbUzgklXTR0U27gGfYliCFj9mpIsTY5zF02kA40Gv
 YbWSdbaXwfFCtBkX9lvEd+5IGHf1zYGXrUYvJJIvPZSWQzLB1jvU+DvI9GR8niLvwECj Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgwpvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 07:37:25 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5J7bOr0008217
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 07:37:24 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5J7bMkR032168;
        Tue, 19 Jun 2018 07:37:23 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 00:37:21 -0700
Date:   Tue, 19 Jun 2018 10:37:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] staging: board: drop refcount in success case
Message-ID: <20180619073709.schatjhjoitfc3fs@mwanda>
References: <1529347999-9316-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529347999-9316-1-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 08:53:19PM +0200, Nicholas Mc Guire wrote:
>  The call to of_find_compatible_node() returns irqc_node with refcount
> incremented thus it must be explicitly decremented here after it was
> checked for non-NULL.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 72ee8626eeb1 ("staging: board: Add support for translating hwirq to virq numbers")
> ---
> 
> Problem located with an experimental coccinelle script
> 
> Patch was compile-tested with: x86_64_defconfig + STAGING=y, STAGING_BOARD=y
> 
> Patch is against 4.18-rc1 (localversion-next is next-20180618)
> 
>  drivers/staging/board/board.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index cb6feb3..8ee48e5 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -64,12 +64,13 @@ int __init board_staging_gic_setup_xlate(const char *gic_match,
>  	irqc_node = of_find_compatible_node(NULL, NULL, gic_match);
>  
>  	WARN_ON(!irqc_node);
>  	if (!irqc_node)
>  		return -ENOENT;
>  
> +	of_node_put(irqc_node);

I don't feel like this is the right thing...  We should keep the
reference until we're done with it.  Which apparently is never?

But I don't know the code at all so I could be wrong.

regards,
dan carpenter

