Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17263C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C729D2403B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kzoq5zTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C729D2403B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753638AbeGEJwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:52:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52592 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:52:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w659mgsV015173;
        Thu, 5 Jul 2018 09:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=X+kvDEa0m52LfEZoCEGhsYxX8Hmxb/6tplJJLtz62r4=;
 b=Kzoq5zTzn+0PTFgu0ehDjczA0YIUVOSB7wZgQdv1fHa5ZcsU/2zu2JTSSjU3qtF2Uvjh
 kgWWMi2mjwXnTORvWR0YLUfwqqJp9GRChbW+M/H0dG7rrhMRpTCb+hnnzH+9xc5OrP/A
 En4BoPTVnfTjbAHbRMiMLdzZ/Z60yeY4IP/TjRrF6XZCtSm/cswyPchj0Cb87Jpjce6/
 HHoXaXAs0Zo1nVEzUJdo3lcDJe0LXRadpkXSL2K4OoYJg2Mh7b4Zpj4uSay8VwHV3yC3
 vmK383WRzf/udb0h6OVGXpqVfS1IU+TjzURDLFqMt5Ps6p4GQT2KldCRVQBhM6kNGE7s Eg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k0dnjn733-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 09:52:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w659qMZY002968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 09:52:22 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w659qLOe005984;
        Thu, 5 Jul 2018 09:52:21 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 02:52:21 -0700
Date:   Thu, 5 Jul 2018 12:52:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun: remove redundant variables adv and
 lpa
Message-ID: <20180705095207.3dldyjgqivp5drhc@mwanda>
References: <20180705093732.21650-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705093732.21650-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=756
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:37:32AM +0100, Colin King wrote:
> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> index 88c12474a0c3..2d6b62c6d9ab 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -1225,17 +1225,13 @@ static int link_status_1g_rgmii(struct niu *np, int *link_up_p)
>  
>  	bmsr = err;
>  	if (bmsr & BMSR_LSTATUS) {
> -		u16 adv, lpa;
> -
>  		err = mii_read(np, np->phy_addr, MII_ADVERTISE);
>  		if (err < 0)
>  			goto out;
> -		adv = err;
>  
>  		err = mii_read(np, np->phy_addr, MII_LPA);
>  		if (err < 0)
>  			goto out;
> -		lpa = err;

I'm fairly sure we could get rid of the mii_read() calls as well.

regards,
dan carpenter

