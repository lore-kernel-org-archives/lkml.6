Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B37ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E58A208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pr6O7mUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E58A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeGPQ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:57:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40386 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeGPQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:57:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GGSqkE109055;
        Mon, 16 Jul 2018 16:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vkc629QQggIRBzvgCirpRsXxyjWGkN4xtT1J2IiXO8g=;
 b=Pr6O7mUwNlTsXPcEqYA4IgbcyhF1iynWVoWljlTkOB4hka06QvMMmJbfW1GV226s0Z/a
 gWWDKaACr1AZR+XeJnPO018gVeMaT6otpui6VJS2cDcYyQb/SAPg5GizuWtrwibCZkuk
 laKxjQidkmczCBGwRCNgp45FNQSGXAuXAyE80Ckp8ZKcyeE7znckploMAlxEdcnJr9ZG
 kKoUH7fJN6iJhMbsc0siQCXSfPhG/0Nxj6xuWXE/p53tbx6ZzmnUWqFvxJXSpSYefkgD
 7j26Mm2ypl2XPPNelvo0ELS/+Hl4h1LRXdHwsYmUPcZXFQ60MzVibS2apIq5mg5ryk2H Uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k7a3t585v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 16:29:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GGT59F003770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 16:29:05 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6GGT4Yk023683;
        Mon, 16 Jul 2018 16:29:04 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 09:29:04 -0700
Subject: Re: [PATCH] net/rds: void function cannot return -1
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <Haakon.Bugge@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20180716130009.1591379-1-Haakon.Bugge@oracle.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <df82aa42-133c-9381-ca97-1d80c8c3e3cc@oracle.com>
Date:   Mon, 16 Jul 2018 09:29:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716130009.1591379-1-Haakon.Bugge@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/2018 6:00 AM, Håkon Bugge wrote:
> Commit b6fb0df12db6 ("RDS/IB: Make ib_recv_refill return void") did
> not change the comment accordingly.
> 
> Fixes: b6fb0df12db6 ("RDS/IB: Make ib_recv_refill return void")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>   net/rds/ib_recv.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
> index b4e421aa9727..e5ce93419263 100644
> --- a/net/rds/ib_recv.c
> +++ b/net/rds/ib_recv.c
> @@ -376,8 +376,6 @@ static void release_refill(struct rds_connection *conn)
>    * This tries to allocate and post unused work requests after making sure that
>    * they have all the allocations they need to queue received fragments into
>    * sockets.
> - *
> - * -1 is returned if posting fails due to temporary resource exhaustion.
>    */
>   void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
>   {
> 
Yep. Thanks !!

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.ccom>
