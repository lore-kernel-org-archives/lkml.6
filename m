Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00CE21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u52yKdU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeLRNjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:39:48 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50606 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:39:47 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIDXsqd130068;
        Tue, 18 Dec 2018 13:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=rZ1ND0HpYiAESWE3ARIIBKUSfLx5sSYLpCmPIjuBRHU=;
 b=u52yKdU5fmJ1W4LLLfwR52xmtIIe4PP5/OsDci2x5gIxuNHb6OoVTd/LWPCasAd8Sksd
 i5Wdxq8Suo/YkO/sgOwMDCe2nCBY9TnS3erm8BKoLvs90MJE1CO+orovmX7rhfUnNgLW
 OKctqGko1fSyo3LasXprTR3ElboTcHu2bpuvlCtJfKUAN8Nszf2PSe/9Xs7fb6jyo8uG
 0xlqtRPKjOqA/pFbym6NtOVxLksLMqn/pnDDZwvojYofpoBJvbu8jCmrwR1TkWITupHb
 aDjrPtm8vDtIlShoz503yTprTxLlK1AJtWY9GHaGK+Wyk8UXi/qluOhkz7REKCbRIPwz mQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pcq4dukvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 13:37:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIDbcV9013415
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 13:37:38 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBIDbciw011076;
        Tue, 18 Dec 2018 13:37:38 GMT
Received: from kadam (/197.157.0.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 05:37:37 -0800
Date:   Tue, 18 Dec 2018 16:37:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        leobras.c@gmail.co, radek.dostal@streamunlimited.co,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 -next] staging: fbtft: use strcmp() instead of
 strncmp() for
Message-ID: <20181218133747.GG15451@kadam>
References: <20181218132508.18672-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218132508.18672-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:25:08PM +0800, YueHaibing wrote:
> strncmp() stops comparing when either the end of one of the first two 
> arguments is reached or when 'n' characters have been compared, whichever
> comes first.That means that strncmp(s1, s2, n) is equivalent to 
> strcmp(s1, s2) if n exceeds the length of s1 or the length of s2.
> 
> This patch avoids that the following warning is reported by smatch:
> 
> drivers/staging/fbtft/fbtft_device.c:1458
>  fbtft_device_init() error: strncmp() '"list"' too small (5 vs 32)
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: fix patch title

v2 is worse than v1...

v1 is a little long but I wouldn't have complained about it.

Please assume that the subject and the commit message are separate
things.  Take a look how the patch description reads on marc.info:

https://marc.info/?l=linux-driver-devel&m=154513957719226&w=2

regards,
dan carpenter

