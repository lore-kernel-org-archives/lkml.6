Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D9AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1EF20897
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pCb1ZH6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1EF20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeHYGlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 02:41:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbeHYGlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 02:41:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7P33UMi004998;
        Sat, 25 Aug 2018 03:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ocxw4+wdP8a6Mp90gPqoJVtBn/VB0nzrkG1jEQCFP4s=;
 b=pCb1ZH6Un7TsOEtR4Pg/gZWbR9yCSK/Ggw/7xwc90OuJJ/FO+R6RnWEEQMCBwIWvJDMh
 +hCMIYJqx9EAEjPrbGjG9KF/P/Lt7bm28t0DJofY20sEj4cAKcgMKR6JzN/4USE1ZuYf
 LKHpN3ETBOI5QZUXF7rRtMbIT46vTy2Z8/4o0VikG35ungLRqnE6XHlVouaGbpN9SX9L
 SJ5DbB3zjvOxEN+idwDIZqh1kfTHeGZfDH4RwyI5AxdV+bRZXixhj5X9oAnAoVcqPFHZ
 oux1zzyxbgH5uCf0HeyjFyX5ovwWAOAKUsBtwsEuEje2lJxVxtKNRN7XGkmdOgbSpERl 3Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kxbdqjtta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Aug 2018 03:03:57 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7P33ujN003918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Aug 2018 03:03:56 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7P33tnH019099;
        Sat, 25 Aug 2018 03:03:55 GMT
Received: from santoshs-mbp.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 20:03:54 -0700
Subject: Re: [PATCH] uapi: Fix linux/rds.h userspace compilation errors.
To:     Vinson Lee <vlee@freedesktop.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Willem de Bruijn <willemb@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-kernel@vger.kernel.org
References: <20180825012656.12443-1-vlee@freedesktop.org>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <65dc4fe6-5363-3456-994e-166cb77a90cd@oracle.com>
Date:   Fri, 24 Aug 2018 20:03:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180825012656.12443-1-vlee@freedesktop.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808250030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/18 6:26 PM, Vinson Lee wrote:
> Include linux/in6.h for struct in6_addr.
> 
> /usr/include/linux/rds.h:156:18: error: field ‘laddr’ has incomplete type
>    struct in6_addr laddr;
>                    ^~~~~
> /usr/include/linux/rds.h:157:18: error: field ‘faddr’ has incomplete type
>    struct in6_addr faddr;
>                    ^~~~~
> /usr/include/linux/rds.h:178:18: error: field ‘laddr’ has incomplete type
>    struct in6_addr laddr;
>                    ^~~~~
> /usr/include/linux/rds.h:179:18: error: field ‘faddr’ has incomplete type
>    struct in6_addr faddr;
>                    ^~~~~
> /usr/include/linux/rds.h:198:18: error: field ‘bound_addr’ has incomplete type
>    struct in6_addr bound_addr;
>                    ^~~~~~~~~~
> /usr/include/linux/rds.h:199:18: error: field ‘connected_addr’ has incomplete type
>    struct in6_addr connected_addr;
>                    ^~~~~~~~~~~~~~
> /usr/include/linux/rds.h:219:18: error: field ‘local_addr’ has incomplete type
>    struct in6_addr local_addr;
>                    ^~~~~~~~~~
> /usr/include/linux/rds.h:221:18: error: field ‘peer_addr’ has incomplete type
>    struct in6_addr peer_addr;
>                    ^~~~~~~~~
> /usr/include/linux/rds.h:245:18: error: field ‘src_addr’ has incomplete type
>    struct in6_addr src_addr;
>                    ^~~~~~~~
> /usr/include/linux/rds.h:246:18: error: field ‘dst_addr’ has incomplete type
>    struct in6_addr dst_addr;
>                    ^~~~~~~~
> 
> Fixes: b7ff8b1036f0 ("rds: Extend RDS API for IPv6 support")
> Signed-off-by: Vinson Lee <vlee@freedesktop.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
