Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E1C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40992238E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKF30kF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40992238E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeHIWNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:13:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58934 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeHIWNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:13:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w79Jhc5o140082;
        Thu, 9 Aug 2018 19:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jKeLnM5cnlyD1sa7wBnYl4ooxJWN73XSi/aITBfHnc8=;
 b=DKF30kF+wmLv1EUzAuvJligncIJk8GPz+dC9K3mCaMCl/DB+V1+mQXtRSiDRb8p6htlL
 Xv8ag4tURg4gBmkohrerJfQuKx3Lnuvu8cxNFVJRG2wWNJk8w3FePxGqcQuLn/cIW2+l
 nKPHbn4hUcANAu3vKhOqf6XIZ4rrSgVawSajLzePxSRRpCZt+VI1OSyDS+WnP07UebyF
 l5J4DdwZ95hSYmeRSjPwfT+4NoPcUJWL/xoq0WGoNIHq2j1nbFzK7A5licab/6oDT0cN
 QyRsjq532zBM2z4NXMrzcF8H+6v5nVuYtJmDdvyKP+bZuyeXsNwP4spvGVAWbw6pAB90 Iw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kn1ndctts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Aug 2018 19:46:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w79JknD7011911
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Aug 2018 19:46:50 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w79JknhB002016;
        Thu, 9 Aug 2018 19:46:49 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Aug 2018 12:46:49 -0700
Date:   Thu, 9 Aug 2018 22:46:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] staging: rtl8188eu: use is_multicast_ether_addr in
 rtw_xmit.c
Message-ID: <20180809194642.p7ruiwap5fufno35@mwanda>
References: <20180809170131.29279-1-straube.linux@gmail.com>
 <20180809170131.29279-3-straube.linux@gmail.com>
 <e1c49e8a5c93b07542899f1e8b238a70ec89801b.camel@perches.com>
 <d1f2ab32-ff10-9575-ad61-0286ee3811ae@gmail.com>
 <cf3e257702a93e4fcfab666e42e49f363eb447f7.camel@perches.com>
 <6da72965-8228-46bf-9c5b-981d761836bb@gmail.com>
 <a640bab5-af3e-6d65-e34c-1dbcdaa9851a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a640bab5-af3e-6d65-e34c-1dbcdaa9851a@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8980 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=449
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808090198
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 09:44:54PM +0200, Michael Straube wrote:
> Is the memory pointed to by sk_buff->data (always) __aligned(2) ?

Yes.

regards,
dan carpenter

