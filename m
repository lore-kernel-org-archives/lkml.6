Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BED80C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746B8208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oaBcYQU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746B8208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935131AbeFMJWg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:22:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933657AbeFMJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:22:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D9LEV7152972;
        Wed, 13 Jun 2018 09:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=z5WAZp8w2kMzXNdZtQ26HwU4V+hvfGXhlYPok0EqPXI=;
 b=oaBcYQU+XMYEUndVLBl1ubiFkWF+DUt2nSGW4rKkmG1IuB8hk+DznHnatJpzX5HPvJFK
 iUv0xPe53vePQkWdvK3MVvYVRLNPVYHaKSF555RLf0QQE5t3ZZeffpSsM3pDcBCYappA
 /yBwXd19mFH8KPh8khTdZ0891wVDW9YVgMkM3FDKZA7BzMRi7H50VTpbYfEMi/hmeY7/
 KHULLL+2jqg/ngf46x2eQ4GQNum8YmO5YX+rAS0Wq2aq/Uur+HWp0KTqlGemA8s5bZqI
 IExZ2LahzpE8d8nTJp58c/XA0hRl8eBs+DpHI5vowa5SC88owqw528UJGO27R13R1Mku aA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jjp6bskjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:22:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D9MU97015813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 09:22:30 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D9MTCS025765;
        Wed, 13 Jun 2018 09:22:29 GMT
Received: from mwanda (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 02:22:28 -0700
Date:   Wed, 13 Jun 2018 12:22:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] WAN: LMC: ensure lmc_trace is reporting return from
 lmc_proto_type
Message-ID: <20180613092218.cy3r4ugr2logvs3h@mwanda>
References: <20180613060410.735-1-colin.king@canonical.com>
 <20180613060410.735-2-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613060410.735-2-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 07:04:10AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the lmc tracing is not reporting the return from function
> lmc_proto_type and this tracing statement is never executed. Fix
> this by returning through the end of the function.  Also fix a typo
> in the function name lmc_proto_type in the trace message.
> 
> Detected by CoverityScan, CID#710539 ("Structurally dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wan/lmc/lmc_proto.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wan/lmc/lmc_proto.c b/drivers/net/wan/lmc/lmc_proto.c
> index 5a6c87bce1bf..b98c1ee860de 100644
> --- a/drivers/net/wan/lmc/lmc_proto.c
> +++ b/drivers/net/wan/lmc/lmc_proto.c
> @@ -99,23 +99,27 @@ void lmc_proto_close(lmc_softc_t *sc)
>  
>  __be16 lmc_proto_type(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
>  {
> +	__be16 ret;
> +
>  	lmc_trace(sc->lmc_device, "lmc_proto_type in");

Did you take a look at lmc_trace()?  It's total garbage.  It's better
to just delete it.

regards,
dan carpenter

