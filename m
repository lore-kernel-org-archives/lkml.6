Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D40C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C506217C6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mckfq9YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C506217C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeHMPIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:08:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbeHMPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:08:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DCO3dT133725;
        Mon, 13 Aug 2018 12:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=MsiRFVcm/jFlkP2Z37NKv7Rn3HJ7wA0NobHDKy5NR6k=;
 b=Mckfq9YKXLwMWtNZvtlwI3wAT8N9M3RFlcNLTPXZyNRbtcl+tKYdaCW4iHnRtHy43j5/
 z3p0kAZ9n9ADTstyyQpe9AjDdOOAlP+LuGJToaWKCAdYZViwHE9sGrmkIcutiFDmiucm
 6sF3uD87mODrN19Q/L/0vyEfGj0o/AcXTQA9yVPQqbAhFBGhiGa3WkqEr+yVQWxIvCdM
 627WXgMJujvUTkNuQJkaeG2il6YlHjvy5ZKWOrD6M6PqkWkkOXRrO0+yE3ccj9XdthRN
 L1K4OP5+mdLDwPW+Pc5Sx7yyGoDzKcYUhqT67E3BoGqhRZfA0x82Co2fjDJeDTH82pGc jA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ksqrp3y3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:26:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7DCQ2GL013138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:26:02 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DCQ237029570;
        Mon, 13 Aug 2018 12:26:02 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 05:26:01 -0700
Date:   Mon, 13 Aug 2018 15:25:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, Chao Yu <yuchao0@huawei.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
Message-ID: <20180813122553.jlavb6inwz3qad6x@mwanda>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
 <20180813114725.kgoupvppcwsw2vyj@mwanda>
 <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14184af-6378-fd96-3b9b-52c9a7da8463@huawei.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8983 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=579
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 08:17:27PM +0800, Gao Xiang wrote:
> > 	/* we assume that ofs is aligned with 4 bytes */
> > 	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
> > 	return err;
> > 

This might be cleaner if we wrote:

	return (err < 0) ? error : 0;

The callers all treate zero and one the same so there isn't any reason
to propogate the 1 back.

regards,
dan carpenter

