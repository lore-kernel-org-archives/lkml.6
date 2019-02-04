Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA05C4151A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A0720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fK7wbDtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfBDVho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:37:44 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:36842 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBDVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:37:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x14LY9iH033345;
        Mon, 4 Feb 2019 21:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MZCFGZ9Pq9RQh+463hNZjwnHlZH5BeiIyNy7KKzey4U=;
 b=fK7wbDtmvmTakRq2Qh+HA2SQ6W2mYzeFMPkF/0aQOCPIX5iQScX+0y1Bb7hNkjXq+Mx/
 k0dDVlb4nA8JyMD7J3qgqWQ5zP3bQ0ejM42PwL9yvxUl7qLKW13QJqGp0fo3i0SA9Dp8
 FtUk+aa8iW6A3knsZDfsw7CTYKse00HHgSRrxXL8HAtAs9dZhdc8FFqn7ROtq2GfIz8A
 optLZPX22MUCVbYBfMaTxT+X4Aet0Bi8cRNrvfHOoO2PIGYmjfwCAUHgQMsMkj+Dark2
 5Buwf9RDsVJusnyx2pWrSsQk3uuN6TDLT3/bzkitmOoIzUzGnDBMbkDIXO2wJFGTKfZZ VQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qd97eqrj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Feb 2019 21:37:41 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x14LbdDw031736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Feb 2019 21:37:40 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x14LbdPZ008952;
        Mon, 4 Feb 2019 21:37:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Feb 2019 21:37:39 +0000
Date:   Mon, 4 Feb 2019 13:37:38 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: allow disabling xfs tracepoints via Kconfig
Message-ID: <20190204213738.GB7991@magnolia>
References: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204212035.9919-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9157 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902040163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:20:35PM +0100, Rasmus Villemoes wrote:
> linux/tracepoints.h allows individual subsystems to disable their
> tracepoints. Add such a knob for xfs. Disabling XFS_TRACEPOINTS
> reduces the resident size of xfs.ko by about a third, or ~350 KiB.

LOL. :)

> $ size /tmp/xfs/{a,b}/xfs.ko
>    text    data     bss     dec     hex filename
>  671726    4129     632  676487   a5287 /tmp/xfs/a/xfs.ko
>  893192  166737     632 1060561  102ed1 /tmp/xfs/b/xfs.ko
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  fs/xfs/Kconfig     | 9 +++++++++
>  fs/xfs/xfs_trace.h | 4 ++++

I think a similar thing ought to apply to fs/xfs/scrub/trace.h, right?

More general questions:

(a) Do we want to be doing this on a per-subsystem basis?

(b) Since xfs_scrub is a separate trace domain, do we want a separate
Kconfig item for toggling scrub trace, or is one big one enough?

(I can't think of why I'd want one on and the other off.)

--D

>  2 files changed, 13 insertions(+)
> 
> diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
> index 457ac9f97377..d099e6d9f6c5 100644
> --- a/fs/xfs/Kconfig
> +++ b/fs/xfs/Kconfig
> @@ -141,3 +141,12 @@ config XFS_ASSERT_FATAL
>  	  result in warnings.
>  
>  	  This behavior can be modified at runtime via sysfs.
> +
> +config XFS_TRACEPOINTS
> +	bool "XFS tracepoints"
> +	default y
> +	depends on XFS_FS && TRACEPOINTS
> +	help
> +	  Say Y here to build XFS with tracepoints.
> +
> +	  You can say N here to reduce the size of the kernel image.
> diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
> index 6fcc893dfc91..5fb3d5c0483e 100644
> --- a/fs/xfs/xfs_trace.h
> +++ b/fs/xfs/xfs_trace.h
> @@ -6,6 +6,10 @@
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM xfs
>  
> +#ifndef CONFIG_XFS_TRACEPOINTS
> +#define NOTRACE
> +#endif
> +
>  #if !defined(_TRACE_XFS_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_XFS_H
>  
> -- 
> 2.20.1
> 
