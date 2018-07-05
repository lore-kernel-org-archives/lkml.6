Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36766C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48FE23F9F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jELVKY+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48FE23F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeGEKBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:01:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbeGEKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:01:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w659x9u7053266;
        Thu, 5 Jul 2018 10:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=CFZ427aOiX5nFQCq8UKzBfzw4KtuZSng/17FACuWfS8=;
 b=jELVKY+N+IiWQKwLkf/PG+CAmAvU21gBdU0jmkpUoCcdh+EnK3SToJ5qhUsABvkvleOn
 Js787njwlWzhMWe677mUGUEWGz+yUDglkyhAELgSeTX7whayYqnEgG75TF296u1jQHCJ
 Eo7PQX0UOJNKVNF1zZFQpSlVSfeL5OeEKHaC5+UOC++u96sy+2FQNRwXjFALqmjC/5wD
 aMnjgjMmknkDezsgkUj7rk3tQ91wpNruzdHHu4+z+qGLCzu2tt9CSksKXFhLoK2ttRmJ
 EFIRbI22K9vTQx+qM7mqiRgfAnlmS5gPBIdOPzO49yJGKKt4E1ohR1/Q3oYjhOOCj7S4 bg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k0dnt57xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jul 2018 10:01:36 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w65A1ZTj007737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jul 2018 10:01:35 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w65A1Zot006379;
        Thu, 5 Jul 2018 10:01:35 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Jul 2018 03:01:34 -0700
Date:   Thu, 5 Jul 2018 13:01:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: sun: remove redundant variables adv and
 lpa
Message-ID: <20180705100125.blngjkgmzt334fza@mwanda>
References: <20180705093732.21650-1-colin.king@canonical.com>
 <20180705095207.3dldyjgqivp5drhc@mwanda>
 <22739fd9-1538-9abf-bfbe-5467196b4acf@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22739fd9-1538-9abf-bfbe-5467196b4acf@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8944 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=985
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807050119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:54:51AM +0100, Colin Ian King wrote:
> On 05/07/18 10:52, Dan Carpenter wrote:
> > On Thu, Jul 05, 2018 at 10:37:32AM +0100, Colin King wrote:
> >> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
> >> index 88c12474a0c3..2d6b62c6d9ab 100644
> >> --- a/drivers/net/ethernet/sun/niu.c
> >> +++ b/drivers/net/ethernet/sun/niu.c
> >> @@ -1225,17 +1225,13 @@ static int link_status_1g_rgmii(struct niu *np, int *link_up_p)
> >>  
> >>  	bmsr = err;
> >>  	if (bmsr & BMSR_LSTATUS) {
> >> -		u16 adv, lpa;
> >> -
> >>  		err = mii_read(np, np->phy_addr, MII_ADVERTISE);
> >>  		if (err < 0)
> >>  			goto out;
> >> -		adv = err;
> >>  
> >>  		err = mii_read(np, np->phy_addr, MII_LPA);
> >>  		if (err < 0)
> >>  			goto out;
> >> -		lpa = err;
> > 
> > I'm fairly sure we could get rid of the mii_read() calls as well.
> 
> I'm always concerned that removing the reads of H/W registers can affect
> the behavior, so I left those in.

Yeah...  That's true sometimes.  Hence my "fairly sure" equivocation.  I
looked to see if any of the original devs are around and it's been a
while since anyone worked on this driver.

When we remove these warnings it means that there is no chance that
someone will look at the code again and remove the unneeded mii_read()
calls.  I'm 90% sure the reads are unnecessary.

regards,
dan carpenter
