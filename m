Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A400C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBC6218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p07Z1RO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfBRIMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:12:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:12:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1I89LEx133886;
        Mon, 18 Feb 2019 08:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=tg0iUNhXRNq8Ygnl4Lw6BXr0Lrjm5aFIIFYjgxxhzig=;
 b=p07Z1RO2daTAZhuviKUh3iNf6bmvq56FMXh9RbkopkGipvuWqbKYSMvkESOCnp3+At4Y
 e/LLDp3mHakgmESfCBHHJaNmyhnS6yxiZjli+3T+6u6NruIEve4Srt/z53EiB+XOSWPj
 ZN8figJK+El3wh/m3ivrFl+ri9DKw6HuCqKZzPQ3fKEJeuT1dmWuessMlIv2Q2rYmZty
 1+dxdLN3iyOPlsLY95civ/mFWrW0hWCw6qfZShGKI++uwtxRoXFtbcY4wbFVbJk4LLh4
 97Flbzf9RViB7+5pvdbFCkAt4Kq4wBxuZx14T+Ha7k0/tvPO1RbobC2qy64vHqJt8fZm rg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xtmtqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 08:12:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1I8CPqo013094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 08:12:25 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1I8CPHb000635;
        Mon, 18 Feb 2019 08:12:25 GMT
Received: from kadam (/197.157.0.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Feb 2019 00:12:24 -0800
Date:   Mon, 18 Feb 2019 11:12:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V3] regulator: axp20x: remove a redundant null check on
 rdev
Message-ID: <20190218081217.GA17104@kadam>
References: <20190215094554.28593-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215094554.28593-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9170 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=835 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902180065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 09:45:54AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently rdev is dereferenced when assigning desc before rdev is null
> checked, this is leading to static analysis warnings.  However, rdev
> can never be null, so the null check is redundant and can be removed.
> 
> Detected by CoverityScan, CID#1476031 ("Dereference before null check")
> 
> Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> --

We need a third '-' character on the cut off marker.

> 
> V2: Fix 2nd occurrance of this thinko
> V3: Remove null check, Dan Carpenter noted that rdev can never be null.
> ---

regards,
dan carpenter

