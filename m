Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F2FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1562221741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QPrTIm1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfA1O3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:29:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1O3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:29:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SEJg9r136377;
        Mon, 28 Jan 2019 14:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=KcwwYad5BdZaG7q7tf3Q7/DzOiF/Gm/uowxT2r9gOpY=;
 b=QPrTIm1X0BG5tmIhf1nclJWlhsqxlMHts/ZbvFGkFhha166rekwYklbNbRtCjzcGtinK
 FbsVJ+/WaYFzfU4mAaM7pFuHrs3WiWn3Dpj0qjj7J2CtUfr+Iuva5I7dG0ZsH8IWpFa9
 AUfLv2WG7+74Q+6q2FrE2MznchWENuCIDgeCYdkI0D/2kBgt4KSK2Ucvw6OVqM8uYek2
 3+7JY7FLH+BD0sGHmhZrHrojctBDuXrlSA5F5ecKZ3MTWVtjeFwGs8qk/xap6R+pTWsi
 hIt+NORFNUEgRzV0blspFFoAL1/7rHewiwN4kx7HIx+WZKw3Rze1g5DkCK3S+yrqMBeE +w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2q8g6qxb48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 14:28:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0SESlSv017443
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 14:28:47 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0SESkf1019681;
        Mon, 28 Jan 2019 14:28:47 GMT
Received: from kadam (/197.157.34.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 06:28:46 -0800
Date:   Mon, 28 Jan 2019 17:28:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Fang Wei <fangwei1@huawei.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
Message-ID: <20190128142837.GJ1795@kadam>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
 <20190128133302.GI1795@kadam>
 <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1fd2c69-0c5b-c655-3712-48169e87fff8@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=737
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The point is, that people shouldn't recreate core code that already
exists.  At least try it out and have an explanation why the other code
doesn't work.

In other projects, the default is to keep code around once it has been
written but in staging the default choice is to delete the code unless
there is an explanation.

regards,
dan carpenter

