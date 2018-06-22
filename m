Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84EC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745C62406D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VSQy1EX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745C62406D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbeFVKke (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:40:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbeFVKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:40:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5MAdLWG194478;
        Fri, 22 Jun 2018 10:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=VCDYMYChfKuiw6A2zeL6w48HD27y3BWoj/YP/76RlwM=;
 b=VSQy1EX8vksrHr1+1bnXECt274lXCSoVoA0DBgy/xrAPLlveDsAaQLng14MU6ySnLpLi
 /n9BfsB22Sp82gux6seNxffiLZTJNnn6CSzxSBPmnSQqsJvDvUhpEFCUmlw71rdUB73s
 w9n12hR2rL6bP1jeQKi5sR5UBM+F59FaFTqbmk5cj5ndyHydTqRM/FsWfNrywyMYscii
 VWwIhjTKEkS5b93o3k6A0ASJCaCpwp5EC3D0ENj+LuUqbsexeLaS4ugrh1/Mkox9YQ3+
 HAMGalICiF2OuJzI/nwgHXtrsymbkQpYK7XL85X+StJ0PF+horbBK97NW3s+aqpBBWIW pA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jrp8hset9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:40:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5MAeJmg025046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 10:40:19 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5MAeJhZ001273;
        Fri, 22 Jun 2018 10:40:19 GMT
Received: from mwanda (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 03:40:18 -0700
Date:   Fri, 22 Jun 2018 13:40:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <michael.straube@posteo.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: do not use assignment in if condition
Message-ID: <20180622104007.ob5nt2rip2fu436h@mwanda>
References: <20180621182230.27823-1-michael.straube@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621182230.27823-1-michael.straube@posteo.de>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 08:22:30PM +0200, Michael Straube wrote:
> Fix checkpatch error 'do not use assignment in if condition'.
> 
> Signed-off-by: Michael Straube <michael.straube@posteo.de>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index e55895632921..87a4ced41028 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -1181,9 +1181,8 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
>  	     (mac[3] == 0xff) && (mac[4] == 0xff) && (mac[5] == 0xff)) ||
>  	    ((mac[0] == 0x00) && (mac[1] == 0x00) && (mac[2] == 0x00) &&
>  	     (mac[3] == 0x00) && (mac[4] == 0x00) && (mac[5] == 0x00))) {
> -		if (np &&
> -		    (addr = of_get_property(np, "local-mac-address", &len)) &&
> -		    len == ETH_ALEN) {
> +		addr = of_get_property(np, "local-mac-address", &len);
> +		if (np && addr && len == ETH_ALEN) {

You can remove the "np" check.

		if (addr && len == ETH_ALEN) {

regards,
dan carpenter

