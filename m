Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE2C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC3921760
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cxJjqHVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC3921760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeHMPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:22:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMPWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:22:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DCcc6M100838;
        Mon, 13 Aug 2018 12:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=pYOYZuqyH8aLf1g+VzrK2J8wcLndT55xh90yhSNrpJw=;
 b=cxJjqHVMnugsY0nJXiW1KfKgffFkd9MrLqsid3LJ9bD1C5pZzbxFaICOOMg7mltjmi0W
 CCkcHF6PRufmvVD/D40W3+4jsjYnZtFPqil8/yMcJa0FH5GPJd/n8uk9bpzHGIppqd1p
 0OeF2kbF2NrYS2Qi/zYRLrlRpVHWHcQ17y2T2gcDSY81jhc8XKjFNnjnGc9RvIXkKRnW
 qOptr4AgWK7ZARa72ohiJNksSeJRlc/PnWOzTx/7sLLYEG6YwyMD/OSCCIipeFbbI1bK
 xPUOyytJrLoD4zLDtHPSJZOSfj/9xFfphVTORdms01ehb4EidlEUlr92DA9ie3/gMQK2 Ig== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ksrepux0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:40:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7DCeNYe028703
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 12:40:23 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DCeMjT022749;
        Mon, 13 Aug 2018 12:40:22 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 05:40:22 -0700
Date:   Mon, 13 Aug 2018 15:40:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Chao Yu <chao@kernel.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, Chao Yu <yuchao0@huawei.com>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
Message-ID: <20180813124014.iivbtjrsdv5odnuu@mwanda>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=725
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 08:17:27PM +0800, Gao Xiang wrote:
> >> @@ -294,8 +322,11 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
> >>  		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
> >>  		if (ret >= 0)
> >>  			break;
> >> +
> >> +		if (unlikely(ret != -ENOATTR))	/* -ENOMEM, -EIO, etc. */
> > 
> > I have held off commenting on all the likely/unlikely annotations we
> > are adding because I don't know what the fast paths are in this code.
> > However, this is clearly an error path here, not on a fast path.
> > 
> > Generally the rule on likely/unlikely is that they hurt readability so
> > we should only add them if it makes a difference in benchmarking.
> > 
> 
> In my opinion, return values other than 0 and ENOATTR(ENODATA) rarely happens,
> it should be in the slow path...
> 

What I'm trying to say is please stop adding so many likely/unlikely
annotations.  You should only add them if you have the benchmark data to
show the it really is required.


regards,
dan carpenter

