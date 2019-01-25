Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCC1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA3F218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lQPfiXuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfAYNbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:31:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:31:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0PDStLg144917;
        Fri, 25 Jan 2019 13:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=w+Tbrak8NRSq80u8Gl2lHN7PCgbvb6uW2B8p1WKzfbM=;
 b=lQPfiXuQwmiM1Lq54zneOmbrRsgtSQJgp2w1F/0eLx/ubLFZl5BU9mWo6pCIYN+qkEsj
 Gs6IU1QBk/msupsJDvS0u+fp5ZjFmuWec5PuN4xWTofeyWkz1qvTYbrSgHJdJJNJTuy1
 ugOzR0pAaBknc9NroUhCwFCfhoLtcR3/0RUsLa5bclWWam7VS9M7Uazoujw1BsS+mT9T
 zv5fBw/FcpkDG+wQyGrH7mljgRrscHTIjFoiR4X17NoPjYu4mUqQJuFndJXfW7oNhS42
 JjLjE2YKnp+07Q2F9OW7fhm8OGqW85lqVHeXdwIhd0BW+u/p2KviiW3f02eJMj6N8HDW SQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2q3uav5urm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 13:30:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0PDUsvB010029
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jan 2019 13:30:55 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0PDUstd019793;
        Fri, 25 Jan 2019 13:30:54 GMT
Received: from kadam (/41.202.241.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jan 2019 05:30:53 -0800
Date:   Fri, 25 Jan 2019 16:30:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 2/2] staging: erofs: complete POSIX ACL support
Message-ID: <20190125133044.GC1795@kadam>
References: <20190125115103.47250-1-gaoxiang25@huawei.com>
 <20190125120104.15604-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125120104.15604-1-gaoxiang25@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9146 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901250111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 08:01:04PM +0800, Gao Xiang wrote:
> Let's add .get_acl() to read the file's acl
> from its xattrs to make POSIX ACL usable.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  This [PATCH 2/2] currently hasn't tested, please ignore temporarily...
>  I will test it asap...

This is an awkward thing.

Just don't send it until after you test it.  We also ignore RFC patches
so if you mark it as RFC that will be ignored if you want.

regards,
dan carpenter

