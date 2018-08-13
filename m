Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA4421781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3v3zn+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA4421781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeHMQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:33:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53132 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbeHMQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:33:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DDnGle164153;
        Mon, 13 Aug 2018 13:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bMnEHOeOI9+BWZtKMBlCjO7w1rW0hGcxHrJHi5L4h4Q=;
 b=K3v3zn+AIJv50p24OsU+6vj9ZNjTezqvSp0g6/8B8H1Qncfno79pVj22SGHKyzrHDl0P
 bm8gkdZ7v7To1ZENNxpPot6gEI/io1vBwiO0ofj6khf78J0IY9arCv9BawpAKTvaotQP
 JJowWbCGcCXLTsV3YOzbJffXhlzaSkwDRy5b+bFlTBrpE0c62N+z7BShUHXQhU8a3D+K
 QLMUYGcuSX72nwqcUrzf72dqJS4iyqNTNVGDknntGjlWVGS9F3Iquz7u5Qp76pVHgY7N
 n0FR79GkT9rDdd1Mfifu9d1IMehnYlCi2/p+B9STa1PpuzgWR1WxpckGraEipM06Hnd+ wQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2ksq7t49jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 13:51:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7DDp8Rv001987
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 13:51:08 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DDp7Ta026924;
        Mon, 13 Aug 2018 13:51:07 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 06:51:07 -0700
Date:   Mon, 13 Aug 2018 16:50:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, Chao Yu <yuchao0@huawei.com>,
        gregkh@linuxfoundation.org, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
Message-ID: <20180813135059.lwiws3ld2tdpp4s4@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
 <20180813114725.kgoupvppcwsw2vyj@mwanda>
 <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
 <20180813122553.jlavb6inwz3qad6x@mwanda>
 <dbb44f60-1d1c-81fd-845c-5d38f1d16ea3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb44f60-1d1c-81fd-845c-5d38f1d16ea3@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=486
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But it is better to fix them in an independent patch. :)

Yah.  Of course.  This was completely unrelated.

regards,
dan carpenter
