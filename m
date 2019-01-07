Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63843C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305DD2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3D3A4GJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfAGNJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:09:09 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35554 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfAGNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:09:07 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x07D4KwK190555;
        Mon, 7 Jan 2019 13:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MTZrVfQOAidzA172Ezzqs/m+aQRFiP6VTQ159ozl+Ko=;
 b=3D3A4GJLPjT8y7kX6hXr5NAeV21lRLMOPTDEpPCj/7e/1cSaq11tUo4K/f39ZWYChVis
 3DOg25+PQuA5eJzAURK2dI6nQVkN7/kipJnyB+kceV8znbDEGriJ539yZJJrt4CBeIaf
 4SnRBF81PNGJPS7USaI0KzYmWZa8x45y0cl0xmvzOGD7+n2Fs33UqsKS05i3Nl6IuOwI
 4HgcS33R75Xnfl5uwcvaSoiErilzA526ojrtrS4czeC7UdkUmDXNS9byB2c8c/n0JpST
 E50RCgIklbqDJBvWAGX1hJXdjEyMRJfAl8uRt9+ET8WI8WQ7mdIzCemiH3OGpbQpV1kQ +Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3dnucf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jan 2019 13:09:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x07D90Tf015975
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jan 2019 13:09:01 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x07D90A3026711;
        Mon, 7 Jan 2019 13:09:00 GMT
Received: from kadam (/197.157.0.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Jan 2019 05:08:59 -0800
Date:   Mon, 7 Jan 2019 16:08:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:
 linux-5.0-rc1/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c:412]:
 (style) Expression is always false
Message-ID: <20190107130802.GE3200@kadam>
References: <DB7PR08MB3801DE2E52BE7BF2E0D7D0129C890@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3801DE2E52BE7BF2E0D7D0129C890@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9128 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=856
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901070116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:40:08AM +0000, David Binderman wrote:
> 
> Hello there,
> 
> linux-5.0-rc1/drivers/staging/rtl8188eu/hal/hal8188e_rate_adaptive.c:412]: (style) Expression is always false because 'else if' condition matches previous condition at line 410.
> 
> Source code is
> 
>         else if (pRaInfo->HighestRate > 0x0b)
>                 pRaInfo->PTModeSS = 2;
>         else if (pRaInfo->HighestRate > 0x0b)
>                 pRaInfo->PTModeSS = 1;
> 

That's true, but that's how to the code was originally when it was
committed 5 years ago so it's hard to tell what the fix should be...

regards,
dan carpenter

