Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C829CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7BD214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qIWeXFq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7BD214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeHVMd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:33:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58022 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeHVMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:33:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7M8xDRb169243;
        Wed, 22 Aug 2018 09:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=j1DfNoQRaxDjNwEb8W13966dnIjj8JR3AyfzrVwW6Zo=;
 b=qIWeXFq+8YlQ7+z9L3fYWt0OJTLe5LpYqSyqrRqAhWsCZ2RsTPWxxNT37IKA+UVOJxj2
 arM307f3FmCMZwFjXIxmtNeOM5UZooPzVo/ExIYisRTzak9uqsJzuM9eODV+25OJS24Y
 eOiZsekRJNtxzsXqXoQOQup3FspkyJPOr58FbN59kAnfk9wnQhxj+UV+GIRqaYJ6ytCa
 kc9UW9Ei+iSOQCtcY6uPwqXd35jsoyxnAATyzx7aZSXZvLdrJWoQFAsiqJk3spuxrK0R
 JDsVlh6WXW1UZYcBlFApcleDNv6qAXCOMPHoH9xhNAYtFHmkpaKuN3oxqO7gfNJmYmuK Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kxbdq15ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 09:09:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7M99jLk004444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 09:09:45 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7M99i3t022679;
        Wed, 22 Aug 2018 09:09:44 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Aug 2018 02:09:43 -0700
Date:   Wed, 22 Aug 2018 12:09:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Joe Perches <joe@perches.com>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <20180822090935.eod5oyodo3xchaxw@mwanda>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 02:04:55PM +0530, Nishad Kamdar wrote:
> This patch fixes the debug macro N_MSG. Replaces printk with
> dev_<level> without __func__ or __LINE__ or current->comm and
> current->pid. Removes the do {} while(0) loop for the single
> statement macro. Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/dbg.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> index 2f2c56b73987..c56fb896617a 100644
> --- a/drivers/staging/mt7621-mmc/dbg.h
> +++ b/drivers/staging/mt7621-mmc/dbg.h
> @@ -104,13 +104,10 @@ do { \
>  
>  #define N_MSG(evt, fmt, args...)
>  /*
> -do {    \
> -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> -    } \
> -} while(0)
> -*/
> + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> + *}
> + */

I don't understand what you're trying to do here.  You just commented
out the macro and turned it into a no-op.  That's not what the patch
description says.

To me the original code seems fine.

regards,
dan carpenter

